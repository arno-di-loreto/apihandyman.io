function getCodeBlockCard(element) {
  return $(element).parents('.card-code')[0]
}

function getCodeBlockCopy(element) {
  return $(getCodeBlockCard(element)).find('.code-copy')[0]
}

function getCodeBlockPreCode(element) {
  return $(getCodeBlockCard(element)).find('.code-block').parent()[0]
}

function getCodeBlockCardHeader(element) {
  return $(getCodeBlockCard(element)).find('.card-header')[0]
}

function expandCollapseCode(button) {
  const code = getCodeBlockPreCode(button)
  const cardHeader = getCodeBlockCardHeader(button)
   
  if($(code).hasClass('code-collapsed')) {
    $(code).removeClass('code-collapsed')
    $(cardHeader).addClass('sticky-top')
    $(cardHeader).addClass('close-to-main-navbar')
    $(button).html('<img class="btn-icon" src="/images/commons/icons/minimize.svg">')
    $(button).blur()

  }
  else {
    const beforeCardHeaderOffsetTop = $(cardHeader)[0].offsetTop
    $(code).addClass('code-collapsed')
    $(cardHeader).removeClass('sticky-top')
    $(cardHeader).removeClass('close-to-main-navbar')
    $(button).html('<img class="btn-icon" src="/images/commons/icons/maximize.svg">')
    $(button).blur()
    window.scrollBy(0, -beforeCardHeaderOffsetTop)
  }
}

$( document ).ready(function() {
  const clipboard = new ClipboardJS('.code-copy-btn', {
    target: function(trigger) {
      const target = getCodeBlockCopy(trigger)
      return target
    }
  })

  clipboard.on('success', function(e) {
    e.clearSelection()
    $(e.trigger).html('<img class="btn-icon" src="/images/commons/icons/copy-check.svg">')
    window.setTimeout(function() {
        $(e.trigger).html('<img class="btn-icon" src="/images/commons/icons/copy.svg">')
        $(e.trigger).blur()
    }, 1000)
  })

  clipboard.on('error', function(e) {
    console.error('🙇🏻‍♂️ something unexpectedly went wrong while copying with ClipboardJS 🙇🏻‍♂️')
    console.error('Action:', e.action)
    console.error('Trigger:', e.trigger)
  })
})