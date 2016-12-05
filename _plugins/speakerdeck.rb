class SpeackerDeck < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1
    else
      raise "No Speaker Deck data id provided in the \"speakerdeck\" tag"
    end
  end

  def render(context)
    "<div class=\"speackerdeck embeded\"><script async class=\"speakerdeck-embed\" data-id=\"#{@id}\" data-ratio=\"1.77777777777778\" src=\"//speakerdeck.com/assets/embed.js\"></script><div>"
  end

  Liquid::Template.register_tag "speakerdeck", self
end