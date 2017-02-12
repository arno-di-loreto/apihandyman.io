class CodeFile < Liquid::Tag
  def initialize(tagName, markup, tokens)
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

    if @attributes['filename']
      @filename =  @attributes['filename']
    else
      raise SyntaxError.new("Syntax Error in 'codefile' - filename is mandatory")
    end
    @path = File.join('code', @filename);
    @url = "/" + @path
    @id = @path + "-" + rand(1000).to_s
    @id = @id.gsub("/", "-").gsub(".","-")
    if File.exists?(@path)
      if @attributes['lines']
        lines = File.readlines(@path)
        # lines can be a single line "3" or a range "3-6"
        params = @attributes['lines'].split('-')
        first = params[0].to_i
        if params[1]
          last = params[1].to_i
        else
          last = first
        end
        @code = ""
        for index in first-1 ... last
          @code = @code + lines[index]
        end
        # line numbers are modified if range do not start at line 1
        if first > 1
          @datastart = " data-start=\"#{first}\""
        end
      else
        @code = File.read(@path)
      end  
    else
      raise SyntaxError.new("Syntax Error in 'codefile' - file #{@path} do not exists")
    end
  end

  def render(context)
    <<-HTML
<div>
  <div class="code-toolbar">
    <div class="btn-group" role="group" aria-label="...">
      <button type="button" class="btn btn-default"><a target="_blank" href="#{@url}"><i class="fa fa-file-text-o" aria-hidden="true"></i></a></button>
      <button type="button" class="btn btn-default btn-copy"><i class="fa fa-clipboard" aria-hidden="true"></i></button>
    </div>
  </div>
  <pre class="language-#{@language}#{@linenumbers}"#{@highlight}#{@datastart}><code>#{@code}</code></pre>
</div>
      HTML
  end

  Liquid::Template.register_tag "codefile", self
end