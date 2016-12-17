# Inspired by https://gist.github.com/joelverhagen/1805814
# {% youtube oHg5SJYRHA0 500 400 %}
# {% youtube oHg5SJYRHA0%}
class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 740
          @height = 416
      else
          @width = $2.to_i
          @height = $3.to_i
      end
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)
    "<div class=\"embedpad\"><div class=\"youtube embedded embed-responsive embed-responsive-16by9\"><iframe width=\"#{@width}\" height=\"#{@height}\" src=\"//www.youtube.com/embed/#{@id}?color=white&theme=light\" frameborder=\"0\" allowfullscreen></iframe></div></div>"
  end

  Liquid::Template.register_tag "youtube", self
end