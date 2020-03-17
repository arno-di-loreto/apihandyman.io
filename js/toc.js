function toggleToc() {
  $('.left-column').toggleClass('left-column-shown')
}

function toggleBackToTop() {
  const titleBottom = offset($('.card-page-title .card-title')[0]).top
  $('.navbar-bottom .back-to-top').toggleClass('d-none', $(this).scrollTop() < titleBottom)
}

function isVisible(scrollableParent, element) {
  const elementTop = element.offsetTop - scrollableParent.offsetTop
  const elementBottom = elementTop + element.offsetHeight
  const scrollableParentTop = scrollableParent.scrollTop
  const scrollableParentBottom = scrollableParent.scrollTop + scrollableParent.offsetHeight
  console.log('element top', elementTop)
  console.log('element bottom', elementBottom)
  console.log('parent top', scrollableParentTop)
  console.log('parent bottom', scrollableParentBottom)
  let result = false
  
  if(elementBottom >= scrollableParentBottom) {
    console.log('element below')
  }
  else if(elementTop <= scrollableParentTop) {
    console.log('element below')
  }
  else {
    result = true
    console.log('element visible')
  }
  return result
}

let lastHtmlScrollTop;
$(document).ready(function(){
  // Scroll TOC when needed in order to keep active element visible
  $(window).on('activate.bs.scrollspy', function () {
    const currentHtmlScrollTop = $('html')[0].scrollTop

    const tocScrollableParent = $('#toc')[0].parentElement
    const scrollableParentTop = tocScrollableParent.scrollTop
    const scrollableParentBottom = tocScrollableParent.scrollTop + tocScrollableParent.offsetHeight
    const scrollableParentHeight = tocScrollableParent.offsetHeight

    console.log('parent scrollTop', tocScrollableParent.scrollTop)
    console.log('parent offsetTop', tocScrollableParent.offsetTop)
    const activeLevel1 = $("#toc .toc-level-1.active")
    if(activeLevel1.length > 0) {
      console.log('level 1 active', activeLevel1[0].innerText)
      console.log('level 1 active, offsetTop', activeLevel1[0].offsetTop)
      console.log('level 1 active, offsetHeight', activeLevel1[0].offsetHeight)
      const level1Top = activeLevel1[0].offsetTop - tocScrollableParent.offsetTop - 8;//To show separator
      const level1Height = activeLevel1[0].offsetHeight
      const activeLevel2 = $("#toc .toc-level-2.active")
      let targetTop
      if(activeLevel2.length > 0) {
        console.log('level 2 active', activeLevel2[0].innerText)
        console.log('level 2 active, offsetTop', activeLevel2[0].offsetTop)
        console.log('level 2 active, offsetHeight', activeLevel2[0].offsetHeight)
        const level2Top =  activeLevel2[0].offsetTop - tocScrollableParent.offsetTop;
        const level2Bottom = level2Top + activeLevel2[0].offsetHeight
        const level2Height = activeLevel2[0].offsetHeight

        console.log('level 1 and level 2 active,  move to level2 top', level2Top)

        if(currentHtmlScrollTop < lastHtmlScrollTop){
          console.log('going up')
          if(!(isVisible(tocScrollableParent, activeLevel2[0]) && isVisible(tocScrollableParent, activeLevel1[0]))){
            tocScrollableParent.scrollTo({
              top: level2Top - (scrollableParentHeight - level2Height),
              behavior: 'smooth'
            });
          }
        }
        else {
          console.log('going down')
          if(!isVisible(tocScrollableParent, activeLevel2[0])){
            tocScrollableParent.scrollTo({
              top: level2Top - (scrollableParentHeight - level2Height),
              behavior: 'smooth'
            });
          }
        }
      }
      else {        
        if(currentHtmlScrollTop < lastHtmlScrollTop){
          console.log('going up')
          if(!isVisible(tocScrollableParent, activeLevel1[0])){
            tocScrollableParent.scrollTo({
              top: level1Top - (scrollableParentHeight - level1Height),
              behavior: 'smooth'
            });
          }
        }
        else {
          console.log('going down')
          // Move level 1 to top
          console.log('only level 1 active, move to', level1Top)
          tocScrollableParent.scrollTo({
            top: level1Top,
            behavior: 'smooth'
          });
        }
      }
      lastHtmlScrollTop = $('html')[0].scrollTop
    }

    /*
    let activeItems = $("#toc .active")
    let lastActiveItem = activeItems[activeItems.length-1]
    // DIV around the #TOC
    let toc = $("#scrollable-toc")[0]
    let tocScroll = toc.scrollTop
    let itemTopInsideToc = lastActiveItem.offsetTop
    let itemBottomInsideToc = lastActiveItem.offsetTop + lastActiveItem.offsetHeight
    tocVisibleTop = toc.scrollTop
    tocVisibleBottom = tocScroll + toc.offsetHeight
    if (itemTopInsideToc <= tocVisibleTop){
      delta = itemTopInsideToc - tocVisibleTop
      toc.scrollTop = toc.scrollTop + delta
    }
    if(itemBottomInsideToc >= tocVisibleBottom){
      delta = itemBottomInsideToc - tocVisibleBottom
      toc.scrollTop = toc.scrollTop + delta
    }
    */
  })

  $('.left-column-toggler').on('click', function(){
    $('.left-column').toggleClass('left-column-shown')
  })

  $('.left-column-hider').on('click', function(){
    $('.left-column').removeClass('left-column-shown')
  })

  $('.back-to-top').on('click', function() {
    document.body.scrollTop = 0
    document.documentElement.scrollTop = 0
  })

  $(window).scroll(toggleBackToTop)
  toggleBackToTop()
})