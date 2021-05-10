/*---Placeholders ie9---*/
( function ( global ) {

  'use strict';

  //
  // Test for support. We do this as early as possible to optimise for browsers
  // that have native support for the attribute.
  //

  var test = document.createElement('input');
  var nativeSupport = test.placeholder !== void 0;

  global.Placeholders = {
    nativeSupport: nativeSupport,
    disable: nativeSupport ? noop : disablePlaceholders,
    enable: nativeSupport ? noop : enablePlaceholders
  };

  if ( nativeSupport ) {
    return;
  }

  //
  // If we reach this point then the browser does not have native support for
  // the attribute.
  //

  // The list of input element types that support the placeholder attribute.
  var validTypes = [
    'text',
    'search',
    'url',
    'tel',
    'email',
    'password',
    'number',
    'textarea'
  ];

  // The list of keycodes that are not allowed when the polyfill is configured
  // to hide-on-input.
  var badKeys = [

    // The following keys all cause the caret to jump to the end of the input
    // value.

    27, // Escape
    33, // Page up
    34, // Page down
    35, // End
    36, // Home

    // Arrow keys allow you to move the caret manually, which should be
    // prevented when the placeholder is visible.

    37, // Left
    38, // Up
    39, // Right
    40, // Down

    // The following keys allow you to modify the placeholder text by removing
    // characters, which should be prevented when the placeholder is visible.

    8, // Backspace
    46 // Delete
  ];

  // Styling variables.
  var placeholderStyleColor = '#ccc';
  var placeholderClassName = 'placeholdersjs';
  var classNameRegExp = new RegExp('(?:^|\\s)' + placeholderClassName + '(?!\\S)');

  // The various data-* attributes used by the polyfill.
  var ATTR_CURRENT_VAL = 'data-placeholder-value';
  var ATTR_ACTIVE = 'data-placeholder-active';
  var ATTR_INPUT_TYPE = 'data-placeholder-type';
  var ATTR_FORM_HANDLED = 'data-placeholder-submit';
  var ATTR_EVENTS_BOUND = 'data-placeholder-bound';
  var ATTR_OPTION_FOCUS = 'data-placeholder-focus';
  var ATTR_OPTION_LIVE = 'data-placeholder-live';
  var ATTR_MAXLENGTH = 'data-placeholder-maxlength';

  // Various other variables used throughout the rest of the script.
  var UPDATE_INTERVAL = 100;
  var head = document.getElementsByTagName('head')[ 0 ];
  var root = document.documentElement;
  var Placeholders = global.Placeholders;
  var keydownVal;

  // Get references to all the input and textarea elements currently in the DOM
  // (live NodeList objects to we only need to do this once).
  var inputs = document.getElementsByTagName('input');
  var textareas = document.getElementsByTagName('textarea');

  // Get any settings declared as data-* attributes on the root element.
  // Currently the only options are whether to hide the placeholder on focus
  // or input and whether to auto-update.
  var hideOnInput = root.getAttribute(ATTR_OPTION_FOCUS) === 'false';
  var liveUpdates = root.getAttribute(ATTR_OPTION_LIVE) !== 'false';

  // Create style element for placeholder styles (instead of directly setting
  // style properties on elements - allows for better flexibility alongside
  // user-defined styles).
  var styleElem = document.createElement('style');
  styleElem.type = 'text/css';

  // Create style rules as text node.
  var styleRules = document.createTextNode(
    '.' + placeholderClassName + ' {' +
      'color:' + placeholderStyleColor + ';' +
    '}'
  );

  // Append style rules to newly created stylesheet.
  if ( styleElem.styleSheet ) {
    styleElem.styleSheet.cssText = styleRules.nodeValue;
  } else {
    styleElem.appendChild(styleRules);
  }

  // Prepend new style element to the head (before any existing stylesheets,
  // so user-defined rules take precedence).
  head.insertBefore(styleElem, head.firstChild);

  // Set up the placeholders.
  var placeholder;
  var elem;

  for ( var i = 0, len = inputs.length + textareas.length; i < len; i++ ) {

    // Find the next element. If we've already done all the inputs we move on
    // to the textareas.
    elem = i < inputs.length ? inputs[ i ] : textareas[ i - inputs.length ];

    // Get the value of the placeholder attribute, if any. IE10 emulating IE7
    // fails with getAttribute, hence the use of the attributes node.
    placeholder = elem.attributes.placeholder;

    // If the element has a placeholder attribute we need to modify it.
    if ( placeholder ) {

      // IE returns an empty object instead of undefined if the attribute is
      // not present.
      placeholder = placeholder.nodeValue;

      // Only apply the polyfill if this element is of a type that supports
      // placeholders and has a placeholder attribute with a non-empty value.
      if ( placeholder && inArray(validTypes, elem.type) ) {
        newElement(elem);
      }
    }
  }

  // If enabled, the polyfill will repeatedly check for changed/added elements
  // and apply to those as well.
  var timer = setInterval(function () {
    for ( var i = 0, len = inputs.length + textareas.length; i < len; i++ ) {
      elem = i < inputs.length ? inputs[ i ] : textareas[ i - inputs.length ];

      // Only apply the polyfill if this element is of a type that supports
      // placeholders, and has a placeholder attribute with a non-empty value.
      placeholder = elem.attributes.placeholder;

      if ( placeholder ) {

        placeholder = placeholder.nodeValue;

        if ( placeholder && inArray(validTypes, elem.type) ) {

          // If the element hasn't had event handlers bound to it then add
          // them.
          if ( !elem.getAttribute(ATTR_EVENTS_BOUND) ) {
            newElement(elem);
          }

          // If the placeholder value has changed or not been initialised yet
          // we need to update the display.
          if (
            placeholder !== elem.getAttribute(ATTR_CURRENT_VAL) ||
            ( elem.type === 'password' && !elem.getAttribute(ATTR_INPUT_TYPE) )
          ) {

            // Attempt to change the type of password inputs (fails in IE < 9).
            if (
              elem.type === 'password' &&
              !elem.getAttribute(ATTR_INPUT_TYPE) &&
              changeType(elem, 'text')
            ) {
              elem.setAttribute(ATTR_INPUT_TYPE, 'password');
            }

            // If the placeholder value has changed and the placeholder is
            // currently on display we need to change it.
            if ( elem.value === elem.getAttribute(ATTR_CURRENT_VAL) ) {
              elem.value = placeholder;
            }

            // Keep a reference to the current placeholder value in case it
            // changes via another script.
            elem.setAttribute(ATTR_CURRENT_VAL, placeholder);
          }
        }
      } else if ( elem.getAttribute(ATTR_ACTIVE) ) {
        hidePlaceholder(elem);
        elem.removeAttribute(ATTR_CURRENT_VAL);
      }
    }

    // If live updates are not enabled cancel the timer.
    if ( !liveUpdates ) {
      clearInterval(timer);
    }
  }, UPDATE_INTERVAL);

  // Disabling placeholders before unloading the page prevents flash of
  // unstyled placeholders on load if the page was refreshed.
  addEventListener(global, 'beforeunload', function () {
    Placeholders.disable();
  });

  //
  // Utility functions
  //

  // No-op (used in place of public methods when native support is detected).
  function noop() {}

  // Avoid IE9 activeElement of death when an iframe is used.
  //
  // More info:
  //  - http://bugs.jquery.com/ticket/13393
  //  - https://github.com/jquery/jquery/commit/85fc5878b3c6af73f42d61eedf73013e7faae408
  function safeActiveElement() {
    try {
      return document.activeElement;
    } catch ( err ) {}
  }

  // Check whether an item is in an array. We don't use Array.prototype.indexOf
  // so we don't clobber any existing polyfills. This is a really simple
  // alternative.
  function inArray( arr, item ) {
    for ( var i = 0, len = arr.length; i < len; i++ ) {
      if ( arr[ i ] === item ) {
        return true;
      }
    }
    return false;
  }

  // Cross-browser DOM event binding
  function addEventListener( elem, event, fn ) {
    if ( elem.addEventListener ) {
      return elem.addEventListener(event, fn, false);
    }
    if ( elem.attachEvent ) {
      return elem.attachEvent('on' + event, fn);
    }
  }

  // Move the caret to the index position specified. Assumes that the element
  // has focus.
  function moveCaret( elem, index ) {
    var range;
    if ( elem.createTextRange ) {
      range = elem.createTextRange();
      range.move('character', index);
      range.select();
    } else if ( elem.selectionStart ) {
      elem.focus();
      elem.setSelectionRange(index, index);
    }
  }

  // Attempt to change the type property of an input element.
  function changeType( elem, type ) {
    try {
      elem.type = type;
      return true;
    } catch ( e ) {
      // You can't change input type in IE8 and below.
      return false;
    }
  }

  function handleElem( node, callback ) {

    // Check if the passed in node is an input/textarea (in which case it can't
    // have any affected descendants).
    if ( node && node.getAttribute(ATTR_CURRENT_VAL) ) {
      callback(node);
    } else {

      // If an element was passed in, get all affected descendants. Otherwise,
      // get all affected elements in document.
      var handleInputs = node ? node.getElementsByTagName('input') : inputs;
      var handleTextareas = node ? node.getElementsByTagName('textarea') : textareas;

      var handleInputsLength = handleInputs ? handleInputs.length : 0;
      var handleTextareasLength = handleTextareas ? handleTextareas.length : 0;

      // Run the callback for each element.
      var len = handleInputsLength + handleTextareasLength;
      var elem;
      for ( var i = 0; i < len; i++ ) {

        elem = i < handleInputsLength ?
          handleInputs[ i ] :
          handleTextareas[ i - handleInputsLength ];

        callback(elem);
      }
    }
  }

  // Return all affected elements to their normal state (remove placeholder
  // value if present).
  function disablePlaceholders( node ) {
    handleElem(node, hidePlaceholder);
  }

  // Show the placeholder value on all appropriate elements.
  function enablePlaceholders( node ) {
    handleElem(node, showPlaceholder);
  }

  // Hide the placeholder value on a single element. Returns true if the
  // placeholder was hidden and false if it was not (because it wasn't visible
  // in the first place).
  function hidePlaceholder( elem, keydownValue ) {

    var valueChanged = !!keydownValue && elem.value !== keydownValue;
    var isPlaceholderValue = elem.value === elem.getAttribute(ATTR_CURRENT_VAL);

    if (
      ( valueChanged || isPlaceholderValue ) &&
      elem.getAttribute(ATTR_ACTIVE) === 'true'
    ) {

      elem.removeAttribute(ATTR_ACTIVE);
      elem.value = elem.value.replace(elem.getAttribute(ATTR_CURRENT_VAL), '');
      elem.className = elem.className.replace(classNameRegExp, '');

      // Restore the maxlength value. Old FF returns -1 if attribute not set.
      // See GH-56.
      var maxLength = elem.getAttribute(ATTR_MAXLENGTH);
      if ( parseInt(maxLength, 10) >= 0 ) {
        elem.setAttribute('maxLength', maxLength);
        elem.removeAttribute(ATTR_MAXLENGTH);
      }

      // If the polyfill has changed the type of the element we need to change
      // it back.
      var type = elem.getAttribute(ATTR_INPUT_TYPE);
      if ( type ) {
        elem.type = type;
      }

      return true;
    }

    return false;
  }

  // Show the placeholder value on a single element. Returns true if the
  // placeholder was shown and false if it was not (because it was already
  // visible).
  function showPlaceholder( elem ) {

    var val = elem.getAttribute(ATTR_CURRENT_VAL);

    if ( elem.value === '' && val ) {

      elem.setAttribute(ATTR_ACTIVE, 'true');
      elem.value = val;
      elem.className += ' ' + placeholderClassName;

      // Store and remove the maxlength value.
      var maxLength = elem.getAttribute(ATTR_MAXLENGTH);
      if ( !maxLength ) {
        elem.setAttribute(ATTR_MAXLENGTH, elem.maxLength);
        elem.removeAttribute('maxLength');
      }

      // If the type of element needs to change, change it (e.g. password
      // inputs).
      var type = elem.getAttribute(ATTR_INPUT_TYPE);
      if ( type ) {
        elem.type = 'text';
      } else if ( elem.type === 'password' && changeType(elem, 'text') ) {
        elem.setAttribute(ATTR_INPUT_TYPE, 'password');
      }

      return true;
    }

    return false;
  }

  // Returns a function that is used as a focus event handler.
  function makeFocusHandler( elem ) {
    return function () {

      // Only hide the placeholder value if the (default) hide-on-focus
      // behaviour is enabled.
      if (
        hideOnInput &&
        elem.value === elem.getAttribute(ATTR_CURRENT_VAL) &&
        elem.getAttribute(ATTR_ACTIVE) === 'true'
      ) {

        // Move the caret to the start of the input (this mimics the behaviour
        // of all browsers that do not hide the placeholder on focus).
        moveCaret(elem, 0);
      } else {

        // Remove the placeholder.
        hidePlaceholder(elem);
      }
    };
  }

  // Returns a function that is used as a blur event handler.
  function makeBlurHandler( elem ) {
    return function () {
      showPlaceholder(elem);
    };
  }

  // Returns a function that is used as a submit event handler on form elements
  // that have children affected by this polyfill.
  function makeSubmitHandler( form ) {
    return function () {

        // Turn off placeholders on all appropriate descendant elements.
        disablePlaceholders(form);
    };
  }

  // Functions that are used as a event handlers when the hide-on-input
  // behaviour has been activated - very basic implementation of the 'input'
  // event.
  function makeKeydownHandler( elem ) {
    return function ( e ) {
      keydownVal = elem.value;

      // Prevent the use of the arrow keys (try to keep the cursor before the
      // placeholder).
      if (
        elem.getAttribute(ATTR_ACTIVE) === 'true' &&
        keydownVal === elem.getAttribute(ATTR_CURRENT_VAL) &&
        inArray(badKeys, e.keyCode)
      ) {
        if ( e.preventDefault ) {
            e.preventDefault();
        }
        return false;
      }
    };
  }

  function makeKeyupHandler(elem) {
    return function () {
      hidePlaceholder(elem, keydownVal);

      // If the element is now empty we need to show the placeholder
      if ( elem.value === '' ) {
        elem.blur();
        moveCaret(elem, 0);
      }
    };
  }

  function makeClickHandler(elem) {
    return function () {
      if (
        elem === safeActiveElement() &&
        elem.value === elem.getAttribute(ATTR_CURRENT_VAL) &&
        elem.getAttribute(ATTR_ACTIVE) === 'true'
      ) {
        moveCaret(elem, 0);
      }
    };
  }

  // Bind event handlers to an element that we need to affect with the
  // polyfill.
  function newElement( elem ) {

    // If the element is part of a form, make sure the placeholder string is
    // not submitted as a value.
    var form = elem.form;
    if ( form && typeof form === 'string' ) {

      // Get the real form.
      form = document.getElementById(form);

      // Set a flag on the form so we know it's been handled (forms can contain
      // multiple inputs).
      if ( !form.getAttribute(ATTR_FORM_HANDLED) ) {
        addEventListener(form, 'submit', makeSubmitHandler(form));
        form.setAttribute(ATTR_FORM_HANDLED, 'true');
      }
    }

    // Bind event handlers to the element so we can hide/show the placeholder
    // as appropriate.
    addEventListener(elem, 'focus', makeFocusHandler(elem));
    addEventListener(elem, 'blur', makeBlurHandler(elem));

    // If the placeholder should hide on input rather than on focus we need
    // additional event handlers
    if (hideOnInput) {
      addEventListener(elem, 'keydown', makeKeydownHandler(elem));
      addEventListener(elem, 'keyup', makeKeyupHandler(elem));
      addEventListener(elem, 'click', makeClickHandler(elem));
    }

    // Remember that we've bound event handlers to this element.
    elem.setAttribute(ATTR_EVENTS_BOUND, 'true');
    elem.setAttribute(ATTR_CURRENT_VAL, placeholder);

    // If the element doesn't have a value and is not focussed, set it to the
    // placeholder string.
    if ( hideOnInput || elem !== safeActiveElement() ) {
      showPlaceholder(elem);
    }
  }

}(this) );


/*---//Placeholders ie9---*/

/*판넬레이어*/
$(document).ready(function() {
    $('#home').on('click', function() {
        $('div.panel').animate({
            'width': 'show'
        }, 700, function() {
            $('div.home').fadeIn(300);
        });
    });
    $('span.close').on('click', function() {
        $('div.home').fadeOut(300, function() {
            $('div.panel').animate({
                'width': 'hide'
            }, 700);
        });
    });
});

/*인트로메인중앙배너*/
$(document).ready(function(){ 
  $(".rightBn").on("mouseenter",function(){ 
    $("#rightBn").attr("src",'images/introBn2_on.png'); 
    $("#leftBn").attr("src",'images/introBn1_off.png');
    $("#rightBn").addClass("bnMotion");
 });      
 $(".rightBn").on("mouseleave",function(){ 
   $("#rightBn").attr("src","images/introBn2_off.png"); 
    $("#leftBn").attr("src",'images/introBn1_on.png'); 
     $("#rightBn").addClass("bnMotion");
 });  

  $(".leftBn").on("mouseenter",function(){ 
      $("#leftBn").addClass("bnMotion");
      
 });      
 $(".leftBn").on("mouseleave",function(){ 
     $("#leftBn").addClass("bnMotion_none");
 }); 
}); 


/*하단메뉴열고닫기*/

//whole 메뉴 열고닫기
//function quickBox(i){
// var div = $("#quickOpneBox");
// var div2 = $("#quickBox");
// if(i == 1){
//   div.show().animate({bottom:0},0)
//   div2.hide()
//   document.frm.click.value = "1";
//   $('#sliderContainer').slick({
//	  slidesToShow: 5,
//	  slidesToScroll: 1,
//	  autoplay: true,
//	  autoplaySpeed: 2000,
//	});
// }else{
//   div.animate({bottom:0},0,function(){
//   div.hide();
//   div2.show().animate(0,0)
//   document.frm.click.value = "2";
//  })
// }
//}

/*메인메뉴열고닫기 */
$(function($){
		$('#gnb').mouseover(function(){
			$('*').stop();
			$('#scrollmenu').hide().slideDown("slow")	
		}) 
		$('#scrollmenu').mouseleave(function(){
			$('*').stop();
			$('#scrollmenu').slideUp(1000)	
		})
	})


/*메인상단예약*/
$(function(){
	var $layer = $(".divSelectText");
	var $current = $(".selectboxUl");
	var $curli = $(".selectboxUl li");
	
	$layer.on('click',function(){
		$current.slideToggle("fast");    
	});
	
	
	 if($current){
		 
		 if(!$curli.hasClass("selected"))
			 $curli.first().addClass("selected");
		 
		 $curli.click(function(e){
			var inx = parseInt($(this).index()) +1 ;
			//console.log(inx,$(this).text());
			
			$('.divSelectText').text($(this).text());
			
			$(e.currentTarget).addClass("selected").siblings().removeClass("selected");
			$current.hide();
		 });
		 
	 }//end if
	
});

/*main_minicalendar* - 2019.01.29추가*/
$(document).ready(function() {
     $("#show_hide").click(function () {
     $(".monthBox").slideToggle();
  });
});
/*modalpopup_minicalendar - 2019.01.30*/
//$(document).ready(function() {
//     $("#show_hideSub").click(function () {
//     $(".SubMonthBox").slideToggle();
//  });
//});
//$(document).ready(function() {
//     $("#show_hideSub1").click(function () {
//     $(".SubMonthBox1").slideToggle();
//  });
//});


/* myzone 미니달력 내장,위약,스코어 현황 subMonthBox2,3 190208 */

//$(document).ready(function() {
//     $("#show_hide").click(function () {
//     $(".monthBox").slideToggle();
//  });
//});
/*modalpopup_minicalendar - 2019.01.30*/
$(document).ready(function() {
     $("#show_hideSub2").click(function () {
     $(".SubMonthBox2").slideToggle();
  });
});
$(document).ready(function() {
     $("#show_hideSub3").click(function () {
     $(".SubMonthBox3").slideToggle();
  });
});

/* myzone 미니달력 쿠폰,예약확인 subMonthBox4,5 190208 */

//$(document).ready(function() {
//     $("#show_hide").click(function () {
//     $(".monthBox").slideToggle();
//  });
//});
/*modalpopup_minicalendar - 2019.01.30*/
$(document).ready(function() {
     $("#show_hideSub4").click(function () {
     $(".SubMonthBox4").slideToggle();
     $(".SubMonthBox5").slideUp();
  });
});
$(document).ready(function() {
     $("#show_hideSub5").click(function () {
     $(".SubMonthBox5").slideToggle();
     $(".SubMonthBox4").slideUp();
  });
});



/* scroll top script  190129 */ 

$(document).ready(function(){ 

// hide first 
$("#topArrow").hide(); 

// fade in 
$(function () { 
	$(window).scroll(function () { 
		if ($(this).scrollTop() > 100) { 
		$('#topArrow').fadeIn(); 
		} else { 
		$('#topArrow').fadeOut(); 
		} 
	}); 

	// scroll body to 0px on click 
	$('topArrow').click(function () { 
		$('body,html').animate({ 
		scrollTop: 0 
		}, 800); 
		return false; 
		}); 
	}); 

});


/*floating_TopMenu - 2019.01.30추가*/
jQuery(document).ready(function($) {
        $(".f_scroll").click(function(event){            
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
        });
});

/*시설안내over - 2019.02.08일추가*/
 $(function() {

    var $container	= $('.rightGuide'),
        $articles	= $container.children('.article'),
        timeout;

    $articles.on( 'mouseenter', function( event ) {
        var $article	= $(this);
        clearTimeout( timeout );
        timeout = setTimeout( function() {
            if( $article.hasClass('active') ) return false;						
            $articles.not( $article.removeClass('blur').addClass('active') )
                     .removeClass('active')
                     .addClass('blur');
        }, 65 );					
    });				
    $container.on( 'mouseleave', function( event ) {					
        clearTimeout( timeout );
        $articles.removeClass('active blur');		
    });			
});


/*고정 레이드 pannel*/
function openNav() {
  document.getElementById("mySidenav").style.width = "257px";
}
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

function LopenNav() {
  document.getElementById("mySidenav1").style.width = "250px";
}
function LcloseNav() {
  document.getElementById("mySidenav1").style.width = "0";
}

/*아트리움*/
$(function(){
		$('.accordion li:nth-child(1)').mouseover(function(){
			$('#atrText1').hide()
            $('.link1').show()
		}) 
		$('.accordion li:nth-child(1)').mouseleave(function(){
			$('#atrText1').show()
            $('.link1').hide()
		})
        $('.accordion li:nth-child(2)').mouseover(function(){
			$('#atrText2').hide()
            $('.link2').show()
		}) 
		$('.accordion li:nth-child(2)').mouseleave(function(){
            $('#atrText2').show()
            $('.link2').hide()
		})
        $('.accordion li:nth-child(3)').mouseover(function(){
			$('#atrText3').hide()
            $('.link3').show()
		}) 
		$('.accordion li:nth-child(3)').mouseleave(function(){
            $('#atrText3').show()
            $('.link3').hide()
		})
	})

	
/* course */
function courseTab(hole) {
		if (hole == "1") {
			$(".course1").attr("style",'display:block'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month on'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		} else if (hole == "2") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:block'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month on'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		} else if (hole == "3") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:block');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month on'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		}
         else if (hole == "4") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:block'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month on'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		}
		 else if (hole == "5") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:block'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month on'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		}
		 else if (hole == "6") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:block'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month on'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		}
		 else if (hole == "7") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:block'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month on'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month'); 
		}
		 else if (hole == "8") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:block'); 
			$(".course9").attr("style",'display:none'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month on'); 
			$("#9hole").attr("class",'month'); 
		}
		 else if (hole == "9") {
			$(".course1").attr("style",'display:none'); 
			$(".course2").attr("style",'display:none'); 
			$(".course3").attr("style",'display:none');
            $(".course4").attr("style",'display:none'); 
			$(".course5").attr("style",'display:none'); 
			$(".course6").attr("style",'display:none'); 
			$(".course7").attr("style",'display:none'); 
			$(".course8").attr("style",'display:none'); 
			$(".course9").attr("style",'display:block'); 
			$("#1hole").attr("class",'month'); 
			$("#2hole").attr("class",'month'); 
			$("#3hole").attr("class",'month'); 
			$("#4hole").attr("class",'month'); 
			$("#5hole").attr("class",'month'); 
			$("#6hole").attr("class",'month'); 
			$("#7hole").attr("class",'month'); 
			$("#8hole").attr("class",'month'); 
			$("#9hole").attr("class",'month on'); 
		}
	}
/* history */
function historyTab(tab) {
		if (tab == "1") {
			$(".history1").attr("style",'display:block'); 
			$(".history2").attr("style",'display:none'); 
			$(".history3").attr("style",'display:none');
            $(".history4").attr("style",'display:none'); 
			$("#history1").attr("class",'on'); 
			$("#history2").attr("class",''); 
			$("#history3").attr("class",''); 
			$("#history4").attr("class",''); 
		} else if (tab == "2") {
			$(".history1").attr("style",'display:none'); 
			$(".history2").attr("style",'display:block'); 
			$(".history3").attr("style",'display:none');
            $(".history4").attr("style",'display:none'); 
			$("#history1").attr("class",''); 
			$("#history2").attr("class",'on'); 
			$("#history3").attr("class",''); 
			$("#history4").attr("class",'');
		} else if (tab == "3") {
			$(".history1").attr("style",'display:none'); 
			$(".history2").attr("style",'display:none'); 
			$(".history3").attr("style",'display:block');
            $(".history4").attr("style",'display:none'); 
			$("#history1").attr("class",''); 
			$("#history2").attr("class",''); 
			$("#history3").attr("class",'on'); 
			$("#history4").attr("class",'');
		} else if (tab == "4") {
			$(".history1").attr("style",'display:none'); 
			$(".history2").attr("style",'display:none'); 
			$(".history3").attr("style",'display:none');
            $(".history4").attr("style",'display:block'); 
			$("#history1").attr("class",''); 
			$("#history2").attr("class",''); 
			$("#history3").attr("class",''); 
			$("#history4").attr("class",'on');
		}
}


/*map*/
function mapTab(gubun) {
		if (gubun == "1") {
			$("#map1").attr("style",'display:block'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:none');
		} else if (gubun == "2") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:block'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:none'); 
		} else if (gubun == "3") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:block');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:none'); 
		} else if (gubun == "4") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:block');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:none'); 
		} else if (gubun == "5") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:block');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:none'); 
		} else if (gubun == "6") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:block');
			$("#map7").attr("style",'display:none'); 
		} else if (gubun == "7") {
			$("#map1").attr("style",'display:none'); 
			$("#map2").attr("style",'display:none'); 
			$("#map3").attr("style",'display:none');
			$("#map4").attr("style",'display:none');
			$("#map5").attr("style",'display:none');
			$("#map6").attr("style",'display:none');
			$("#map7").attr("style",'display:block'); 
		} 
	}

function facilTab(gubun) {
	if (gubun == "1") {
		$("#facil1").attr("style",'display:block'); 
		$("#facil2").attr("style",'display:none'); 
		$("#facil3").attr("style",'display:none');
	} else if (gubun == "2") {
		$("#facil1").attr("style",'display:none'); 
		$("#facil2").attr("style",'display:block');
		$("#facil3").attr("style",'display:none');
	} else if (gubun == "3") {
		$("#facil1").attr("style",'display:none'); 
		$("#facil2").attr("style",'display:none');
		$("#facil3").attr("style",'display:block');
	}
 
}