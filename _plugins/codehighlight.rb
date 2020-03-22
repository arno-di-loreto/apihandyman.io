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
        hidden_code_copy = split_code[1].lstrip #lstrip necessary to avoid new lines at beginnin
                                         # {% code %}  <- new line here
                                         # some code
                                         # Also useful to keep ending new line fo bash
        hidden_code_copy =   "<pre class=\"copy-hidden code-copy\">"+hidden_code_copy+"</pre>" 
      else
        visible_code_copy_class = " code-copy"
      end
      code = code.strip

      if @title=="debug"
        print "\ncode:\n#{code}\n"
        print "\nhidden_code_copy:#{hidden_code_copy}\n"
      end

      codeblocksize = lookup(context, 'site.codeblocksize')
      # <i class="fas fa-compress"></i>
      # <i class="fas fa-expand"></i>
      # <i class="fas fa-expand-alt"></i>
      # <i class="fas fa-compress-alt"></i>
      if code.lines.count > codeblocksize 
        collapsed_style = " code-collapsed"
        collapsed_button = "<a role=\"button\" class=\"btn btn-secondary border-0 rounded-0 code-expandcollapse-btn\"  aria-label=\"expand or shrink\" onclick=\"expandCollapseCode(this)\"  data-toggle=\"tooltip\" data-placement=\"top\" title=\"Expand/Shrink\"><img class=\"btn-icon\" src=\"/images/commons/icons/maximize.svg\"></a>"

      end
      
      if @title
        code_title = @title
      end

      # Reminder: ClipboardJS does not work with hidden elements. Just put them out of sight.
      # https://github.com/zenorocha/clipboard.js/issues/353

      <<-HTML
<div class="card card-code text-white bg-dark border-dark">
  #{hidden_code_copy}
  <div class="card-header">
    <div class="row m-0">
      <div class="col align-self-center">
        <p class="m-0 title">#{code_title}</p>
      </div>
      <div class="col col-auto pr-0">
        <div class="btn-group" role="group" aria-label="code snippet control">
          <a role="button" class="btn btn-secondary code-copy-btn border-0 rounded-0" aria-label="copy"  data-toggle="tooltip" data-placement="top" title="Copy"><img class="btn-icon" src="/images/commons/icons/copy.svg"></a>
          #{collapsed_button}
        </div>
      </div>
    </div>
  </div>
  <div class="card-body">
    <pre class="language-#{@language}#{@linenumbers}#{collapsed_style}#{visible_code_copy_class}"#{@highlight}><code class="code-block">#{code}</code></pre>
  </div>
</div>
      HTML
    end
  end

end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)