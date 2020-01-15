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
    else
      @label = ""
    end

    if attributes['source']
      @source = attributes['source']
      if attributes['target']
        @target = attributes['target']
      else
        @target = ""
      end
    else
      @source = ""
    end
  
  end

  def lookup(context, name)
    lookup = context
    name.split(".").each { |value| lookup = lookup[value] }
    lookup
  end

  # if name is like site.something or page.something it returns the actual value
  # else it returns the original value (name)
  def errorLessLookup(context, name)
    if name != ""
      begin
        lookup = context
        name.split(".").each { |value| lookup = lookup[value] }
        if lookup
          result = lookup
        else
          result = name
        end
      rescue
        result = name
      end
    else
      result = name
    end
    result
  end

  def render(context)
    baseurl = context.registers[:site].config['baseurl'];
    
    @file = errorLessLookup(context, @file)
    @source = errorLessLookup(context, @source)
    @target = errorLessLookup(context, @target)
    @label = errorLessLookup(context, @label)

    if @file.start_with?('/images')
      src = "#{baseurl}#{@file}"
    else
      permalink = lookup(context, 'page.permalink')
      src = "#{baseurl}/images#{permalink}#{@file}"
    end

    if @target != ""
      target = " target=\"#{@target}\""
    else
      target = ""
    end

    if @source == ""
      img = "<img src=\"#{src}\">"
    else
      img = "<a href=\"#{@source}\"#{target}><img src=\"#{src}\"></a>"
    end

    if @label != ""
      if @source == ""
        plabel = "<p class=\"img-label\">#{@label}</p>"
      else
        plabel = "<p class=\"img-label\"><a href=\"#{@source}\"#{target}>#{@label}</a></p>"
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