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
			minHeight : 72,
			offsetBottom : 0
		}, options||{});
	
	var $that = $(this),
			containerTop = $that.position().top + 245;
	
		
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

/*$(function() {

    var wHeight = $(document).height();
	var containerTop = $("#gnb").height()+40;
	$("#container").css("height",(wHeight-containerTop));

	var multiWidth = $("#multi-table").width();
	var scrollWidth = $("#scroll-area").width();
	$("#item-area").css("width",multiWidth-scrollWidth);

	
	$(window).resize(function() {
		var wHeight = $(document).height();
		var containerTop = $("#gnb").height()+40;
		$("#container").css("height",(wHeight-containerTop));

		var multiWidth = $("#multi-table").width();
		var scrollWidth = $("#scroll-area").width();
		$("#item-area").css("width",multiWidth-scrollWidth);
	});
    
});*/

$(document).ready(function(){
	$menu =$("#gnb > ul > li");

	  $menu.click(function(){
		if("#gnb > ul > li > ul:hidden"){
			$(this).addClass("on");
			$(this).siblings().removeClass("on");
		}
	  });

	  $menu.mouseenter(function(){
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
		$("#gnb > ul > li.on").addClass("temp");
		if($(this).hasClass("temp")){
			$(this).removeClass("temp");
		}
	  });

	  $menu.mouseleave(function(){
		$(this).removeClass("active");
		$("#gnb > ul > li.on").removeClass("temp");
	  });

	});