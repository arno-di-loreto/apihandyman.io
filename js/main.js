---
---
function offset(el) {
  var rect = el.getBoundingClientRect(),
  scrollLeft = window.pageXOffset || document.documentElement.scrollLeft,
  scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  return { top: rect.top + scrollTop, left: rect.left + scrollLeft }
}

$(window).scroll(function(){
  if($('.row-banner').length > 0) {
    $('.main-navbar').toggleClass('scrolled', $(this).scrollTop() > $('.row-banner').height()-55)
  }
});

/***********/
/* Privacy */
/***********/

{% for page in site.pages %}
  {% if page.title == 'Privacy Policy' %}
    {% assign privacy_date = page.date %}
    {% assign privacy_local_storage = page.privacy_local_storage %}
  {% endif %}
{% endfor %}

const privacyPolicyLocalStorage = '{{privacy_local_storage}}'
const privacyPolicyEffectiveDate = '{{privacy_date}}'
const showThirdPartyLocalStorage = 'showThirdParty'

function showPrivacyMessage() {
  if(privacyPolicyEffectiveDate.localeCompare(localStorage.getItem(privacyPolicyLocalStorage)) != 0) {
    $('.privacy-message').toggleClass('d-none')
  }
}

function acceptPrivacyPolicy() {
  localStorage.setItem(privacyPolicyLocalStorage, privacyPolicyEffectiveDate)
  $('.privacy-message').toggleClass('d-none')
  loadPrivacySettings()
}

function thirdPartyConsent(id, source) {
  const parent = $('#'+id)
  const remember =$(parent).find('.third-party-content-remember').is(':checked')
  if(remember) {
    storeThirdPartyConsent(source, true)
    showAcceptedThirdParty()
  }
  else {
    showThirdParty(parent)
  }
}

function storeThirdPartyConsent(source, consent) {
  const key = showThirdPartyLocalStorage + '.' + source
  if(consent) {
    localStorage.setItem(key, true)
  }
  else {
    localStorage.removeItem(key)
  }
}

function showThirdParty(element) {
  if($(element).find('.third-party-content-iframe-disabled')) {
    const warning = $(element).find('.third-party-content-warning')
    const iframeContainter = $(element).find('.third-party-content-iframe')
    const iframe = iframeContainter.find('iframe')
    $(iframe).attr('src', $(iframe).attr('data-src'))
    $(iframeContainter).removeClass('third-party-content-iframe-disabled')
    $(warning).addClass('third-party-content-warning-disabled')
  }
}

function showAcceptedThirdParty() {
  keys = Object.keys(localStorage)
  for( const keyIndex in keys) {
    const key = keys[keyIndex]
    const showTirdPartyRegex = new RegExp("^"+showThirdPartyLocalStorage);
    if ( showTirdPartyRegex.test(key) && localStorage.getItem(key) === "true") {
      const thirdParty = key.replace('showThirdParty.', '')
      const thirdPartyElements = $('.third-party-content-'+thirdParty)
      for(let i=0;i< thirdPartyElements.length;i++) {
        showThirdParty(thirdPartyElements[i])
      }
    }
  }
}

function loadPrivacySettings() {
  const privacySettings = $('#privacy-settings-configuration')
  if(privacySettings.length > 0) {
    $(privacySettings.find('.privacy-setting')).each(function (index) {
      const checkbox = this
      const id = $(checkbox).attr('id')
      const value = localStorage.getItem(id)
      if(value && value !== "false") {
        $(checkbox).prop("checked", true)
      } else {
        $(checkbox).prop("checked", false)
      }
    })
  }
}

function onReadyPrivacy() {
  showPrivacyMessage()
  showAcceptedThirdParty()
  loadPrivacySettings()

  $('.privacy-setting').click(function(){
    const id = $(this).attr('id')
    if ($(this).is(':checked')){
      if(id.localeCompare(privacyPolicyLocalStorage) === 0) {
        acceptPrivacyPolicy()
      }
      else {
        localStorage.setItem(id, true)
      }
    } 
    else {
      localStorage.removeItem(id)
      if(id.localeCompare(privacyPolicyLocalStorage) === 0) {
        showPrivacyMessage()
      }
    }
  })
}

/**************/
/* Pagination */
/**************/

function goToPage(input) {
  const targetPage = input.value
  const maxPage = input.dataset.last
  const currentPage = input.dataset.current
  if( targetPage && 
      targetPage > 0 &&
      targetPage <= maxPage &&
      targetPage != currentPage )
    {
        let targetUrl
        if(targetPage != 1) {
          targetUrl = input.dataset.url.replace('NUMBER', targetPage)
        }
        else {
          targetUrl = input.dataset.firsturl
        }
        window.location = targetUrl
    }
    else {
      input.value = ""
    }
}

/************/
/* Tooltips */
/************/

//Enabling tooltip everywhere
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
  $("[data-toggle='tooltip']").click(function(){
    $("[data-toggle='tooltip']").tooltip('hide');
  });
})

/***********************/
/* Page initialization */
/***********************/

$( document ).ready(function() {

  onReadyPrivacy()

  const clipboardTextCopy = new ClipboardJS('.text-copy', {
    target: function(trigger) {
      return trigger
    }
  })

  clipboardTextCopy.on('success', function(e) {
    //console.log('copied from ', e)
  });

  clipboardTextCopy.on('error', function(e) {
    console.error('🙇🏻‍♂️ something unexpectedly went wrong while copying with ClipboardJS 🙇🏻‍♂️')
    console.error('Action:', e.action)
    console.error('Trigger:', e.trigger)
  })

  // Execute a function when the user releases a key on the keyboard
  const navPageInput = document.getElementById("nav-page-input");
  if(navPageInput){
    navPageInput.addEventListener("keyup", function(event) {
      if (event.keyCode === 13) {
        event.preventDefault()
        goToPage(event.srcElement)
      }
    });
    navPageInput.addEventListener("focusout", function(event){
      goToPage(event.srcElement)
    });
  }
  
})