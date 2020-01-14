class Asciinema < Liquid::Tag
  def initialize(tagName, markup, tokens)
    super

    @attributes = {}
    markup.scan(::Liquid::TagAttributes) do |key, value|
      @attributes[key] = value.gsub("\"", "")
    end

    if @attributes['file']
      @filename =  @attributes['file']
    else
      raise SyntaxError.new("Syntax Error in 'asciiname' - file is mandatory")
    end

    if @attributes['title']
      @title =  @attributes['title']
    end

    if @attributes['script']
      @scriptfilename =  @attributes['script']
    end

    if @attributes['poster']
      @poster =  @attributes['poster']
    end

  end

  def lookup(context, name)
    lookup = context
    name.split(".").each { |value| lookup = lookup[value] }
    lookup
  end

  def render(context)
    coderoot = context.registers[:site].config['coderoot']
    baseurl = context.registers[:site].config['baseurl']

    if @filename.start_with?(coderoot)
      path = @filename
    else
      customcodefolder = lookup(context, 'page.codefiles')
      if customcodefolder
        codefolder = customcodefolder
      else
        codefolder = lookup(context, 'page.permalink')
      end
      filepath = File.join(coderoot, codefolder, @filename)
    end
    fileurl = "#{baseurl}/#{filepath}"

    if @scriptfilaname
      if @scriptfilaname.start_with?(coderoot)
        path = @scriptfilaname
      else
        customcodefolder = lookup(context, 'page.codefiles')
        if customcodefolder
          codefolder = customcodefolder
        else
          codefolder = lookup(context, 'page.permalink')
        end
        scriptpath = File.join(coderoot, codefolder, @scriptfilaname)
      end
      scripturl = "#{baseurl}/#{scriptpath}"
    end

    if @title
      toolbarcss = "code-toolbar-for-title"
      title = @title
      sessiontitle = "<div class=\"bash-title\"><button type=\"button\" class=\"btn btn-default btn-block\">"+title+"</button></div>"
    else
      toolbarcss = "code-toolbar"
    end

    <<-HTML
<div class="bash-session">
  #{sessiontitle}
  <div class="#{toolbarcss}">
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default"><a target="_blank" href="#{scripturl}"><i class="fas fa-file-code"></i></a></button>
    </div>
  </div>
  <asciinema-player poster="npt:1:20" title="#{@title}" author="Arnaud Lauret" rows="24" width="80" src="#{fileurl}"></asciinema-player>
</div>
      HTML
  end

  Liquid::Template.register_tag "asciinema", self
end