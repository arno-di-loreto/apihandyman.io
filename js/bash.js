const bashBootstrapCols = {
  xs: '68',
  sm: '68',
  md: '68',
  lg: '104',
  xl: '125'
}

function getBashPlayer(element) {
  return $(element).parents('.card-bash').find('#player')
}

function getBashPlayerPlayPauseButton(element) {
  return $(element).parents('.card-bash').find('#play')
}

function getBashPlayerPlayPauseButtonIcon(element) {
  return getBashPlayerPlayPauseButton(element).find(':first-child')
}

function bashPlayerIsPlaying(element) {
  return getBashPlayerPlayPauseButtonIcon(element).hasClass('fa-play')
}

function updateBashPlayerPlayPauseButtonIcon(element, event) {
  const icon = getBashPlayerPlayPauseButtonIcon(element)
  if(event.localeCompare('play') === 0){
    console.log('play icon')
    icon.removeClass('fa-pause')
    icon.addClass('fa-play')
  }
  else {
    console.log('pause icon')
    icon.removeClass('fa-play')
    icon.addClass('fa-pause')
  }
}

function resizePlayers() {
  const size = getBootstrapDeviceSize()
  const expectedCols = bashBootstrapCols[size]
  let resized = false
  $('.bash-player').each(function(index){
    const playerDiv = $(this)
    const player = getBashPlayer(playerDiv)
    const playerCols = player.attr('cols')
    if(playerCols !== expectedCols) {
      resized = true
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
      const playerIsPlaying = bashPlayerIsPlaying(player)
      const playerCurrentTime = player.currentTime
      playerDiv.html(html)
      const newPlayer = getBashPlayer(playerDiv)
      console.log(newPlayer)
      newPlayer.currentTime = playerCurrentTime
      updateBashPlayerPlayPauseButtonIcon(playerDiv, 'play')
      addEventListenersToBashPlayer(newPlayer)
    }
  })
  return resized
}

function bashPlayPause(button) {
  const player = getBashPlayer(button)
  if(bashPlayerIsPlaying(player)){
    player[0].play()
  }
  else {
    player[0].pause()
  }
}

function addEventListenersToBashPlayer(player) {
  player[0].addEventListener('pause', function(e) {
    updateBashPlayerPlayPauseButtonIcon(this, 'play')
  })
  player[0].addEventListener('play', function(e) {
    updateBashPlayerPlayPauseButtonIcon(this, 'pause')
  })
}

function addEventListenerToBashPlayer() {
  $('.card-bash').find('#player').each(function(index) {
    addEventListenersToBashPlayer(this)
  })
}

$(document).ready(function() {
  if(!resizePlayers()) {
    addEventListenerToBashPlayer()
  }
  $(window).on('resize', resizePlayers)
})