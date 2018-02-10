class Image < Liquid::Tag
  def initialize(tagName, markup, tokens)
    super
    attributes = {}
    markup.scan(::Liquid::TagAttributes) do |key, value|
      attributes[key] = value.gsub("\"", "")
    end

    if attributes['file']
      @file = attributes['file']
    else
      raise "No file provided in the \"img\" tag"
    end

    if attributes['label']
      @label = attributes['label']
      if attributes['source']
        @source = attributes['source']
      else
        @source = ""
      end
    else
      @label = ""
    end
  
  end

  def lookup(context, name)
    lookup = context
    name.split(".").each { |value| lookup = lookup[value] }
    lookup
  end

  def render(context)
    baseurl = context.registers[:site].config['baseurl'];
    
    if @file.start_with?('/images')
      src = "#{baseurl}#{@file}"
    else
      permalink = lookup(context, 'page.permalink')
      src = "#{baseurl}/images#{permalink}#{@file}"
    end

    if @source == ""
      img = "<img src=\"#{src}\">"
    else
      img = "<a href=\"#{@source}\"><img src=\"#{src}\"></a>"
    end

    if @label != ""
      if @source == ""
        plabel = "<p class=\"img-label\">#{@label}</p>"
      else
        plabel = "<p class=\"img-label\"><a href=\"#{@source}\">#{@label}</a></p>"
      end
    end

    <<-MARKUP.strip
    <div>
      #{img}
      #{plabel}
    </div>
    MARKUP
  end

  Liquid::Template.register_tag "img", self
end