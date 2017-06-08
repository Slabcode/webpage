$(document).ready(function(){
	$('#services .services-content').slick({
		arrows: true,
		dots: false,
		fade: true,
		focusOnSelect: true,
		infinite: true,
		prevArrow: '<button type="button" data-role="none" class="slick-prev" tabindex="0" role="button"><i class="fa fa-angle-left" aria-hidden="true"></i></button>',
		nextArrow: '<button type="button" data-role="none" class="slick-next" tabindex="0" role="button"><i class="fa fa-angle-right" aria-hidden="true"></i></button>',
		slidesToShow: 1,
		slidesToScroll: 1,
		speed: 800,
	});

	$(window).scroll(function(event) {
		var scroll = $(window).scrollTop();
		var menu_height = $('.wrapper-menu').height();
		var height = $(window).height();

		var active_light = height - menu_height;
		
		if (scroll == 0){
			$('.wrapper-content .wrapper-menu').removeClass('menu-light menu-dark');
		}
		if (scroll > 1 && scroll <= active_light){
			$('.wrapper-content .wrapper-menu').addClass('menu-dark').removeClass('menu-light');
		}
		if (scroll > active_light){
			$('.wrapper-content .wrapper-menu').removeClass('menu-dark').addClass('menu-light');
		}	
	});
});