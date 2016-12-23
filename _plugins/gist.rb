class Gist < Liquid::Tag
  def initialize(tagName, markup, tokens)
    super
    @attributes = {}
    markup.scan(::Liquid::TagAttributes) do |key, value|
      @attributes[key] = value.gsub("\"", "")
    end
    @markup = markup
    
    @id = "data-gist-id=\"#{@attributes['id']}\""
    
    if @attributes['file']
      @file =  " data-gist-file=\"#{@attributes['file']}\""
    else
      @file = ""
    end

    if @attributes['lines']
      @lines = " data-gist-line=\"#{@attributes['lines']}\""
    else
      @lines = ""
    end

    if @attributes['highlight']
      @highlight = " data-gist-highlight-line=\"#{@attributes['highlight']}\""
    else
      @highlight = ""
    end 
    
    if @attributes['footer']
      @footer = " data-gist-footer=\"#{@attributes['footer']}\""
    else
      @footer = ""
    end
    
  end

  def render(context)
    "<code #{@id}#{@file}#{@lines}#{@highlight}#{@footer} gist-enable-cache=\"true\"></code>"
  end

  Liquid::Template.register_tag "gist", self
end

