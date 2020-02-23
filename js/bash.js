const bashBootstrapCols = {
  xs: '68',
  sm: '68',
  md: '68',
  lg: '104',
  xl: '125'
}

function getCodeBlockCard(element) {
  return $(element).parents('.card-code')[0]
}

function resizePlayers() {
  const size = getBootstrapDeviceSize()
  const expectedCols = bashBootstrapCols[size]
  $('.bash-player').each(function(index){
    const playerDiv = $(this)
    const player = playerDiv.find('#player')
    const playerCols = player.attr('cols')
    if(playerCols !== expectedCols) {
      const cols = expectedCols
      const rows = player.attr('rows')
      const title = player.attr('title')
      const author = player.attr('author')
      let poster = player.attr('poster')
      if(poster === undefined) {
        poster = ""
      }
      else {
        poster = ' poster="'+poster+'"'
      }
      const src = player.attr('src')
      const html = '<asciinema-player id="player" title="'+title+'" author="'+author+'" rows="'+rows+'" cols="'+cols+'" src="'+src+poster+'"></asciinema-player>'
      playerDiv.html(html)
    }
  });
}


function bashPlayPause(button) {

}

$(document).ready(function() {
  resizePlayers()
  $(window).on('resize', resizePlayers)
})