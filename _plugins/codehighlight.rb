module Jekyll

  class CodeBlock < Liquid::Block
    include Liquid::StandardFilters

    OPTIONS_SYNTAX = %r{^([a-zA-Z0-9.+#-]+)((\s+\w+(=[0-9,-]+)?)*)$}

    def initialize(tag_name, markup, tokens)
      super

      @attributes = {}
      markup.scan(::Liquid::TagAttributes) do |key, value|
        @attributes[key] = value.gsub("\"", "")
      end

      if @attributes['title']
        @title = @attributes['title']
      end

      if @attributes['language']
        @language =  @attributes['language']
      else
        raise SyntaxError.new("Syntax Error in 'code' - language is mandatory")
      end

      if @attributes['numbers'] == "false"
        @linenumbers = ""
      else
        @linenumbers = " line-numbers"
      end

      if @attributes['highlight']
        @highlight = " data-line=\"#{@attributes['highlight']}\""
      else
        @highlight = ""
      end

    end

    def lookup(context, name)
      lookup = context
      name.split(".").each { |value| lookup = lookup[value] }
      lookup
    end

    def render(context)
      code = h(super)
      # [0] == version to show
      # [1] == version to copy (optional)
      split_code = code.split(lookup(context,"site.codeblock_hidden_copy_separator"))
      code = split_code[0]
      code = code.gsub("<","&#60;")
      code = code.gsub(">","&#62;")
      if split_code.length() > 1
        code_copy = split_code[1].lstrip #lstrip necessary to avoid new lines at beginnin
                                         # {% code %}  <- new line here
                                         # some code
                                         # Also useful to keep ending new line fo bash 
      else
        code_copy = code.lstrip
      end
      code = code.strip

      if @title=="debug"
        print "\ncode:\n#{code}\n"
        print "\ncode_copy:#{code_copy}\n"
      end

      codeblocksize = lookup(context, 'site.codeblocksize')
      if code.lines.count > codeblocksize 
        collapsed = " code-collapsed"
        collabpedbutton = "<button type=\"button\" class=\"btn btn-default\" onclick=\"toggle(this, this.parentElement.parentElement.parentElement.children[2], this.parentElement.parentElement.parentElement.children[3].children[0])\"><i class=\"fa fa-expand\" aria-hidden=\"true\"></i></button>"
        collapsedbottombutton = "<div class=\"code-bottom-toolbar\"><button type=\"button\" class=\"btn btn-default btn-block\" onclick=\"toggle(this, this.parentElement.parentElement.children[2], this.parentElement.parentElement.children[0].children[0].children[0], true)\"><i class=\"fa fa-expand\" aria-hidden=\"true\"></i></button></div>"
      end
      
      if @title
        toolbarcss = "code-toolbar-for-title"
        codetitle = "<div class=\"code-title\"><button type=\"button\" class=\"btn btn-default btn-block\">"+@title+"</button></div>"
      else
        toolbarcss = "code-toolbar"
      end

      # Reminder: ClipboardJS does not work with hidden elements. Just put them out of sight.
      # https://github.com/zenorocha/clipboard.js/issues/353

      <<-HTML
<div>
  <pre class="copy-hidden">#{code_copy}</pre>
  #{codetitle}
  <div class="#{toolbarcss}">
    <div class="btn-group" role="group" aria-label="...">
      #{collabpedbutton}
      <button type="button" class="btn btn-default copy-btn"><i class="fas fa-paste"></i></button>
    </div>
  </div>
  <pre class="language-#{@language}#{@linenumbers}#{collapsed}"#{@highlight}><code>#{code}</code></pre>
  #{collapsedbottombutton}
</div>
      HTML
    end
  end

end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)