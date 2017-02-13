function bark(s){
    console.log(s);
};
var clientbeforeaction=function(){};
/***************************************************************************************************

    체크박스 제어
 
***************************************************************************************************/

var check = {
    
    defChecks: function() {
        
        $('.checkbox').off('click');
        $('.checkbox').on('click', function(e) {           
            check.toggle(e);
        });
        
        $('.checkbox').children('input').on('focus', function(e) {
            check.focus(e);  
        }).on('blur', function(e) {
            check.blur(e);  
        });
           
    },

    toggle: function(e) {

        e.preventDefault();
        
        var t = $(e.currentTarget); 
        var tt = $(e.target);
        
        if (t === t) {
            t.toggleClass('on');
        } else {
            t.toggleClass('on');
            tt.toggleClass('on');     
        };
        
        t.addClass('focus'); 
        t.children('input').focus();
		//2014-06-25 
		if (t.hasClass('on'))	{
			t.children('input').attr('checked', true );
		} else {
			t.children('input').attr('checked', false );
		}


    },
    
    focus: function(e) {
        
        var t = $(e.currentTarget);
        t.parent().addClass('focus');
    },
    
    blur: function(e) {
        
        var t = $(e.currentTarget);
        t.parent().removeClass('focus');
    },
    
    // 2014-02-23
    
    disable: function() {
        
        var cl = '';
        arguments[arguments.length-1] === true ? cl = 'on' : cl = '';
         
        $(arguments).each(function(i){
            
            $(this).css({'pointer-events':'none'}).attr('disabled','disabled').addClass(cl);
        
            $(this).on('click', function(e){
                return false;    
            });
                
            $(this).find('input').on('click', function(e){
                return false;   
            });
            
        });    
        
    }

};

/***************************************************************************************************

    라디오버튼 제어
 
***************************************************************************************************/

var radio = {
    
    
    // 라디오 버튼들에 이벤트 적용
    
    defRadios: function() {
        
        $('.radio').children().on('click', function(e) {
            
            var n = $(this).attr('name');

            radio.toggle(e, n);
            
        }).on('focus', function(e) {
            
            var n = $(this).attr('name');
            
            radio.focus(e, n);
            
        }).on('blur', function(e) {
            
            radio.blur(e);  
        });     
    },
    
    // 라디오 버튼 네임값 추출
    
    patchName: function() {
        
        if ($('body .raidoValue').length > 0) {
            $('body').find('.raidoValue').remove(); 
        };

        $('body').append('<div class="raidoValue" style="opacity:0; display:none; width:1px"></div>');
        
        var tobeDel = [];
        
        $('.radio').each(function(i){
            
            var len = $('.radio').length-1;   
            var $name = $(this).children('input').attr('name');
           
            $('.raidoValue').append('<div class="'+$name+'"></div>');
            
            if (i > 0) {
                
                if($('.raidoValue').children('div').eq(i-1).attr('class') == 
                    $('.raidoValue').children('div').eq(i).attr('class')) {
                    
                    tobeDel.push(i); 
                };  
            };
           
            if (i == len) {
                
                trimDiv();
            };
            
        });
        
        function trimDiv() {
    
            var len = tobeDel.length;
    
            for (var i = len; i > -1; i--) {
                
                $('.raidoValue').find('div').eq(tobeDel[i]).remove();    
            };
        }; 
        
    },
    
    // 라디오 버튼 클릭
    
    toggle: function(e, n) {

        e.preventDefault();

        var nt = $('input[name*="'+n+'"]');
        var t = $(e.currentTarget);
        
        
        //t.addClass('on');
        //t.addClass('focus');
        t.focus();

        
        /*
        if ($('div.'+n).length == 0) {
            $('.raidoValue').append('<div class="'+n+'"></div>');    
        };
        
        
        */

    },
    
    focus: function(e, n) {
        
        var nt = $('input[name*="'+n+'"]');
        var t = $(e.currentTarget);
        var id = nt.index(e.target);
        
        nt.parent().removeClass('on');
        nt.parent().removeClass('focus');
        t.parent().addClass('on');
        t.parent().addClass('focus');
        
        if ($('div.'+n).length != 0) {

            $('div.'+n).empty().text(id);   
        };
		//2014-06-25
		 nt.attr('checked', false );
		  var ck = t.attr('checked');
		  if (ck === undefined)
		  {
		   t.attr('checked', true );
		  } else {
		   t.attr('checked', false );
		  }

    },
    
    blur: function(e) {
        
        var t = $(e.currentTarget);
        t.parent().removeClass('on');
        t.parent().removeClass('focus');
    }

};


$(function() {

    /***********************************************************************************************
        라디오버튼 제어
    ***********************************************************************************************/
     // Span Child 클릭 처리

    $('.radio').click(function(e){
        if (e.target.nodeName.toLowerCase() !== 'input') {
            $(this).children('input').trigger('click');
            e.stopPropagation();
            e.preventDefault();
       };
    });
    
    
    /***********************************************************************************************
        체크박스 제어
    ***********************************************************************************************/
    
    // Span Child 클릭 처리

    $('.checkbox').click(function(e){
        if (e.target.nodeName.toLowerCase() !== 'input') {
            $(this).children('input').trigger('click');
            e.stopPropagation();
            e.preventDefault();
       };
    });


    /***********************************************************************************************
        라디오버튼/ 체크박스/ 약관에 이벤트 적용
    ***********************************************************************************************/    
    
    // 체크박스에 이벤트 처리    
    check.defChecks();
    
    // 라디오 버튼에 이벤트 처리  
    radio.defRadios();
    
    // 라디오 버튼 이름 및 인덱스 저장
    radio.patchName();  



    
});


/*
 * jQuery doTimeout: Like setTimeout, but better! - v1.0 - 3/3/2010
 * http://benalman.com/projects/jquery-dotimeout-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
(function($){var a={},c="doTimeout",d=Array.prototype.slice;$[c]=function(){return b.apply(window,[0].concat(d.call(arguments)))};$.fn[c]=function(){var f=d.call(arguments),e=b.apply(this,[c+f[0]].concat(f));return typeof f[0]==="number"||typeof f[1]==="number"?this:e};function b(l){var m=this,h,k={},g=l?$.fn:$,n=arguments,i=4,f=n[1],j=n[2],p=n[3];if(typeof f!=="string"){i--;f=l=0;j=n[1];p=n[2]}if(l){h=m.eq(0);h.data(l,k=h.data(l)||{})}else{if(f){k=a[f]||(a[f]={})}}k.id&&clearTimeout(k.id);delete k.id;function e(){if(l){h.removeData(l)}else{if(f){delete a[f]}}}function o(){k.id=setTimeout(function(){k.fn()},j)}if(p){k.fn=function(q){if(typeof p==="string"){p=g[p]}p.apply(m,d.call(n,i))===true&&!q?o():e()};o()}else{if(k.fn){j===undefined?e():k.fn(j===false);return true}else{e()}}}})(jQuery);


/*
 * jQuery resize event - v1.1 - 3/14/2010
 * http://benalman.com/projects/jquery-resize-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
(function($,h,c){var a=$([]),e=$.resize=$.extend($.resize,{}),i,k="setTimeout",j="resize",d=j+"-special-event",b="delay",f="throttleWindow";e[b]=250;e[f]=true;$.event.special[j]={setup:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.add(l);$.data(this,d,{w:l.width(),h:l.height()});if(a.length===1){g()}},teardown:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.not(l);l.removeData(d);if(!a.length){clearTimeout(i)}},add:function(l){if(!e[f]&&this[k]){return false}var n;function m(s,o,p){var q=$(this),r=$.data(this,d);r.w=o!==c?o:q.width();r.h=p!==c?p:q.height();n.apply(this,arguments)}if($.isFunction(l)){n=l;return m}else{n=l.handler;l.handler=m}}};function g(){i=h[k](function(){a.each(function(){var n=$(this),m=n.width(),l=n.height(),o=$.data(this,d);if(m!==o.w||l!==o.h){n.trigger(j,[o.w=m,o.h=l])}});g()},e[b])}})(jQuery,this);


jQuery.fn.contentScroll = function(options) {
	var _options = $.extend({
			minHeight : 0,
			offsetBottom : 0
		}, options||{});
	
	var $that = $(this),
			containerTop = $that.position().top;
		
		var height = $(window).height() - containerTop - _options.offsetBottom;
		$that.css("overflow", "auto")
			.height(_options.minHeight > height ? _options.minHeight : height);
		
		$(window).resize(function() {
			var height = $(window).height() - containerTop - _options.offsetBottom;
			$that.height(_options.minHeight > height ? _options.minHeight : height);
		});
};

function showModalDialogUrl(url) {
	$.get(url)
		.done(function(html) {
			var $dialog = $(html).appendTo(document.body);
			dialogInitPos($dialog);
			$dialog.fadeIn();
			
			$dialog.draggable({handler:"div.layerInner > h2"})
				.before('<div class="dimWarp"><img src="../image/dim.png" width="100%" height="100%" alt="" /></div>');
			
			$("div.close > a", $dialog).one("click", function(event) {
				$dialog.add($dialog.prev("div.dimWarp")).remove();
			});
		});
}

function showModalDialog($dialog) {
	dialogInitPos($dialog);
	$dialog.fadeIn();
	
	$dialog.draggable({handle:"div.layerInner > h2"})
		.before('<div class="dimWarp"><img src="../image/dim.png" width="100%" height="100%" alt="" /></div>');
	
	$("div.close > a", $dialog).one("click", function(event) {
		$dialog.hide()
			.prev("div.dimWarp").remove();
	});
}

function dialogInitPos($dialog) {
	var left = Math.floor(($(window).width() - $dialog.width()) / 2),
		top = Math.floor(($(window).height() - $dialog.height()) / 2);
	$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
}

$(function() {

    var wHeight = $(window).height();
	var containerTop = $("#gnb").height()+40;
	$("#container").css("min-height",(wHeight-containerTop));
	
	$(window).resize(function() {
		var wHeight = $(window).height();
		var containerTop = $("#gnb").height()+40;
		$("#container").css("min-height",(wHeight-containerTop));
	});
    
});