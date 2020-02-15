var clipboard = new ClipboardJS('.code-copy-btn', {
  target: function(trigger) {
    var target = trigger.parentElement.parentElement.parentElement.parentElement.parentElement.children[0];
    console.log(target)
    return target;
  }
});

clipboard.on('success', function(e) {
  console.log('copied!')
  console.log(e.text);
  e.clearSelection();
  $(e.trigger).html('<i class="fas fa-check"></i>');
  window.setTimeout(function() {
      $(e.trigger).html('<i class="far fa-copy"></i>');
      $(e.trigger).blur();
  }, 1000);
});

clipboard.on('error', function(e) {
  console.error('Action:', e.action);
  console.error('Trigger:', e.trigger);
});


function expandCollapseCode(button) {
  var code = button.parentElement.parentElement.parentElement.parentElement.parentElement.children[2].children[0]
  //var secondarybutton = this.parentElement.parentElement.parentElement.children[3].children[0] 
  var beforecodeheight = $(code).height(); 
  // <i class="fas fa-expand-alt"></i>
  // <i class="fas fa-compress-alt"></i>
  if($(code).hasClass('code-collapsed')) {
    $(code).removeClass('code-collapsed');
    $(button).html('<i class="fas fa-compress-alt"></i>');
    //$(secondarybutton).html('<i class="fa fa-compress"></i>');
    $(button).blur();
  }
  else {
    $(code).addClass('code-collapsed');
    $(button).html('<i class="fas fa-expand-alt"></i>');
    //$(secondarybutton).html('<i class="fa fa-expand"></i>');
    $(button).blur();
    if(true) {
      var aftercodeheight = $(code).height();
      var afterscroll = $('body').scrollTop();
      var delta = beforecodeheight - aftercodeheight;
      $('body').scrollTop(afterscroll - delta);
    }
  }
}