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

    def lookup(context, name)
      lookup = context
      name.split(".").each { |value| lookup = lookup[value] }
      lookup
    end

    def render(context)
      code = h(super).strip
      
      codeblocksize = lookup(context, 'site.codeblocksize')
      if code.lines.count > codeblocksize 
        collapsed = " code-collapsed"
        collabpedbutton = "<button type=\"button\" class=\"btn btn-default\" onclick=\"toggle(this, this.parentElement.parentElement.parentElement.children[1], this.parentElement.parentElement.parentElement.children[2].children[0])\"><i class=\"fa fa-expand\" aria-hidden=\"true\"></i></button>"
        collapsedbottombutton = "<div class=\"code-bottom-toolbar\"><button type=\"button\" class=\"btn btn-default btn-block\" onclick=\"toggle(this, this.parentElement.parentElement.children[1], this.parentElement.parentElement.children[0].children[0].children[0], true)\"><i class=\"fa fa-expand\" aria-hidden=\"true\"></i></button></div>"
      end
      
      <<-HTML
<div>
  <div class="code-toolbar">
    <div class="btn-group" role="group" aria-label="...">
      #{collabpedbutton}
      <button type="button" class="btn btn-default btn-copy"><i class="fa fa-clipboard" aria-hidden="true"></i></button>
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