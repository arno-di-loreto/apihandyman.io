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

    def render(context)
      code = h(super).strip

      <<-HTML
<div>
  <div class="code-toolbar">
    <div class="btn-group" role="group" aria-label="...">
      <button type="button" class="btn btn-default btn-copy"><i class="fa fa-clipboard" aria-hidden="true"></i></button>
    </div>
  </div>
  <pre class="language-#{@language}#{@linenumbers}"#{@highlight}><code>#{code}</code></pre>
</div>
      HTML
    end
  end

end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)