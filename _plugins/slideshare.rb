class SlideShare < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1
    else
      raise "No SlideShare key provided in the \"slideshare\" tag"
    end
  end

  def render(context)
    "<div class=\"embedpad center\"><iframe src=\"//www.slideshare.net/slideshow/embed_code/key/#{@id}\" width=\"595\" height=\"485\" frameborder=\"0\" marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\" style=\"border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;\" allowfullscreen> </iframe> <div style=\"margin-bottom:5px\"></div>"
  end

  Liquid::Template.register_tag "slideshare", self
end