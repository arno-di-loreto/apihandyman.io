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
  let result = elementBottom < scrollableParentBottom && elementTop > scrollableParentTop  
  return result
}

let lastHtmlScrollTop;
$(document).ready(function(){
  // Scroll TOC when needed in order to keep active element visible
  $(window).on('activate.bs.scrollspy', function () {
    const currentHtmlScrollTop = $('html')[0].scrollTop

    const tocScrollableParent = $('#toc')[0].parentElement
    const scrollableParentHeight = tocScrollableParent.offsetHeight
    const activeLevel1 = $("#toc .toc-level-1.active")
    if(activeLevel1.length > 0) {
      const level1Top = activeLevel1[0].offsetTop - tocScrollableParent.offsetTop - 8;//To show separator
      const level1Height = activeLevel1[0].offsetHeight
      const activeLevel2 = $("#toc .toc-level-2.active")
      if(activeLevel2.length > 0) {
        const level2Top =  activeLevel2[0].offsetTop - tocScrollableParent.offsetTop;
        const level2Height = activeLevel2[0].offsetHeight

        if(currentHtmlScrollTop < lastHtmlScrollTop){
          // Going up
          if(!(isVisible(tocScrollableParent, activeLevel2[0]) && isVisible(tocScrollableParent, activeLevel1[0]))){
            tocScrollableParent.scrollTo({
              top: level2Top - (scrollableParentHeight - level2Height),
              behavior: 'smooth'
            });
          }
        }
        else {
          //Going down
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
          //Going ip
          if(!isVisible(tocScrollableParent, activeLevel1[0])){
            tocScrollableParent.scrollTo({
              top: level1Top - (scrollableParentHeight - level1Height),
              behavior: 'smooth'
            });
          }
        }
        else {
          //Going down
          tocScrollableParent.scrollTo({
            top: level1Top,
            behavior: 'smooth'
          });
        }
      }
      lastHtmlScrollTop = $('html')[0].scrollTop
    }
  })

  $('.left-column-toggler').on('click', function(){
    $('.left-column').toggleClass('left-column-shown')
    $('.left-menu-modal').toggleClass('show')
  })

  $('.left-column-hider').on('click', function(){
    $('.left-column').removeClass('left-column-shown')
    $('.left-menu-modal').removeClass('show')
  })

  $('.back-to-top').on('click', function() {
    document.body.scrollTop = 0
    document.documentElement.scrollTop = 0
    $('#toc')[0].parentElement.scrollTop = 0
  })

  $(window).scroll(toggleBackToTop)
  toggleBackToTop()

})