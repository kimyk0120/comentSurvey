jQuery(function($){
	var tree_menu = $('#tree_menu');
	var tree_menu2 = $('#tree_menu2');
	var icon_open = 'images/tree_open.gif';
	var icon_close = 'images/tree_close.gif';
	
	tree_menu.find('li:has("ul")').prepend('<a href="#" class="control"><img src="images/' + icon_close + '" /></a> ');
	tree_menu.find('li:last-child').addClass('end');
	tree_menu2.find('li:has("ul")').prepend('<a href="#" class="control"><img src="images/' + icon_close + '" /></a> ');
	tree_menu2.find('li:last-child').addClass('end');
	
	$('.control').click(function(){
		var temp_el = $(this).parent().find('>ul');
		if (temp_el.css('display') == 'none'){
			temp_el.slideDown(100);
			$(this).find('img').attr('src', icon_close);
			return false;
		} else {
			temp_el.slideUp(100);
			$(this).find('img').attr('src', icon_open);
			return false;
		}
	});
	
	function tree_init(status){
		if (status == 'close'){
			tree_menu.find('ul').hide();
			tree_menu2.find('ul').hide();
			$('a.control').find('img').attr('src', icon_open);
		} else if (status == 'open'){
			tree_menu.find('ul').show();
			tree_menu2.find('ul').show();
			$('a.control').find('img').attr('src', icon_close);
		}
	}
	tree_init('close');
	
	/* CSS �좉�踰꾪듉 */
	$('#css_use').toggle(function(){
		$('link').attr('href', '');
		$(this).text('CSS (O)');
	},function(){
		$('link').attr('href', '../css/tree.css');
		$(this).text('CSS (X)');
	});
	/* OPEN & CLOSE */
	$('#all').toggle(function(){
		tree_init('open');
		$(this).text('ALL CLOSE');
	},function(){
		tree_init('close');
		$(this).text('ALL OPEN');
	});
	
});