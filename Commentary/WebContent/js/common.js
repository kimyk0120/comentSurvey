$(document).ready(function(){
	/* layout */
	function winResize() {
		$windowSize = $(document);
		$container = $('#container');
		$lnb = $('#lnb');

		if($windowSize.width() > 1440) $container.width($windowSize.width() - 200);
		else $container.width(1240);
		$lnb.height($windowSize.height());
		$container.height($windowSize.height());
	};

	$(window).load(winResize);
	$(window).resize(function(){
		winResize();
		$lnb.height($windowSize.height());
		$container.height($windowSize.height());
	});

	/* input clear */
	var i_text = $('.i_label').next('.input_text');
	i_text
		.focus(function(){
			$(this).prev('.i_label').css('visibility','hidden');
			$(this).addClass('focus');
		})
		.blur(function(){
			if($(this).val() == ''){
				$(this).prev('.i_label').css('visibility','visible');
			} else {
				$(this).prev('.i_label').css('visibility','hidden');
			}
			$(this).removeClass('focus');
		})
		.change(function(){
			if($(this).val() == ''){
				$(this).prev('.i_label').css('visibility','visible');
			} else {
				$(this).prev('.i_label').css('visibility','hidden');
			}
		})
		.blur();

	/* search */
	var headerSearch={
		init:function(){
			$searchOption = $('.searchBox .searchOption');
			this.create();
		},
		create:function(){
			(function(t){
				$searchOption.bind('click',function(){
					$(this).find('.defaultTxt').toggleClass('active');
					$(this).find('ul').toggle();
				});
			})(this);
		},
		toggleMotion:function(){
			var _width1 = (isSearchOpen)?193:0,
				_width2 = (isSearchOpen)?149:0;

			$searchField.stop().animate({'width':_width1},600,'easeInOutExpo',function(){
				if(!isSearchOpen){
					$searchInput.hide();
					$searchWrap.removeClass('active');
				} else {
					$searchInput.focus().select();
				}
			});
			$searchInput.stop().animate({'width':_width2},600,'easeInOutExpo');
		}
	}
	headerSearch.init();
});
