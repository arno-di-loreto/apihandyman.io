class CodeFile < Liquid::Tag
  def initialize(tagName, markup, tokens)
    super

    @attributes = {}
    markup.scan(::Liquid::TagAttributes) do |key, value|
      @attributes[key] = value.gsub("\"", "")
    end

    if @attributes['numbers'] == "false"
      @linenumbers = ""
    else
      @linenumbers = " line-numbers"
    end

    if @attributes['highlight']
      @highlight = @attributes['highlight']
    end

    if @attributes['file']
      @filename =  @attributes['file']
    else
      raise SyntaxError.new("Syntax Error in 'codefile' - file is mandatory")
    end

    if @attributes['title']
      @title = @attributes['title']
    end

    if @attributes['language']
      @language =  @attributes['language']
    else
      @language = @filename.split(".").last
      if ! @language 
        raise SyntaxError.new("Syntax Error in 'code' - language or file extension is mandatory")
      end
    end
    
    if @attributes['lines']
      @linerange = @attributes['lines']
    end

  end

  def lookup(context, name)
    lookup = context
    name.split(".").each { |value| lookup = lookup[value] }
    lookup
  end

  def render(context)
    coderoot = context.registers[:site].config['coderoot']
    if @filename.start_with?(coderoot)
      path = @filename
    else
      customcodefolder = lookup(context, 'page.codefiles')
      if customcodefolder
        codefolder = customcodefolder
      else
        codefolder = lookup(context, 'page.permalink')
      end
      path = File.join(coderoot, codefolder, @filename)
    end
    baseurl = context.registers[:site].config['baseurl']
    url = "#{baseurl}/#{path}"
    if File.exists?(path)
      if @linerange
        lines = File.readlines(path)
        # lines can be a single line "3" or a range "3-6"
        params = @linerange.split('-')
        first = params[0].to_i
        if params[1]
          last = params[1].to_i
        else
          last = first
        end
        code = ""
        for index in first-1 ... last
          code = code + lines[index]
        end
        if first > 1
          # line numbers are modified if range do not start at line 1
          datastart = " data-start=\"#{first}\""
          # highligh must also be modified
          firstitem = true
          if @highlight
            modhighlight = ""
            @highlight.split(",").each { |range| 
               values = range.split("-")
               firstvalue = values[0].to_i - first + 1
               if values[1]
                secondvalue = values[1].to_i - first + 1
                updateditem = "#{firstvalue}-#{secondvalue}"
               else
                updateditem = firstvalue
               end 
               if firstitem
                 modhighlight = "#{updateditem}"
                 firstitem = false
               else
                 modhighlight = "#{modhighlight},#{updateditem}"
               end
            }
          end    
        end
      else
        code = File.read(path)
        modhighlight = @highlight
      end
      if @highlight
        highlighttag = " data-line=\"#{modhighlight}\""
      end  
    else
      raise SyntaxError.new("Syntax Error in 'codefile' - file #{path} do not exists")
    end

    code = code.gsub("<","&#60;")
    code = code.gsub(">","&#62;")

    codeblocksize = lookup(context, 'site.codeblocksize')
    if code.lines.count > codeblocksize 
      collapsed_style = " code-collapsed"
      collapsed_button = "<li class=\"nav-item\"><a class=\"btn code-expandcollapse-btn\" onclick=\"expandCollapseCode(this)\"><i class=\"fas fa-expand-alt\"></i></a></li>"
    end

    if @title
      code_title = @title
      code_title = code_title.gsub("\$filename",@filename)
    end

    <<-HTML

<div class="card card-code text-white bg-dark border-dark">
  <div class="card-header">
    <nav class="navbar navbar-expand-md">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <span class="navbar-text text-white small font-weight-bold">#{code_title}</span>
          </li>
        </ul>
        <ul class="navbar-nav ml-md-auto">
          <li class="nav-item"><a class="btn text-white" target="_blank" href="#{url}"><i class="far fa-file-code"></i></a></li>
          <li class="nav-item"><a class="btn text-white code-copy-btn"><i class="far fa-copy"></i></a></li>
          #{collapsed_button}
        </ul>
    </nav>
  </div>
  <div class="card-body">
    <pre class="language-#{@language}#{@linenumbers}#{collapsed_style} code-copy"#{highlighttag}#{datastart}><code class="code-block">#{code}</code></pre>
  </div>
</div>
      HTML
  end

  Liquid::Template.register_tag "codefile", self
end