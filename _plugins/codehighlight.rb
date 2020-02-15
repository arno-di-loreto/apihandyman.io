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
      # <i class="fas fa-compress"></i>
      # <i class="fas fa-expand"></i>
      # <i class="fas fa-expand-alt"></i>
      # <i class="fas fa-compress-alt"></i>
      if code.lines.count > codeblocksize 
        collapsed_style = " code-collapsed"
        collapsed_button = "<li class=\"nav-item\"><a class=\"btn code-expandcollapse-btn\" onclick=\"expandCollapseCode(this)\"><i class=\"fas fa-expand-alt\"></i></a></li>"
      end
      
      if @title
        code_title = @title
      end

      # Reminder: ClipboardJS does not work with hidden elements. Just put them out of sight.
      # https://github.com/zenorocha/clipboard.js/issues/353

      <<-HTML
<div class="card card-code text-white bg-dark border-dark">
  <pre class="copy-hidden">#{code_copy}</pre>
  <div class="card-header">
    <nav class="navbar navbar-expand-md">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <span class="navbar-text text-white small font-weight-bold">#{code_title}</span>
          </li>
        </ul>
        <ul class="navbar-nav ml-md-auto">
          <li class="nav-item"><a class="btn code-copy-btn"><i class="far fa-copy"></i></a></li>
          #{collapsed_button}
        </ul>
    </nav>
  </div>
  <div class="card-body">
    <pre class="language-#{@language}#{@linenumbers}#{collapsed_style}"#{@highlight}><code>#{code}</code></pre>
  </div>
</div>
      HTML
    end
  end

end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)