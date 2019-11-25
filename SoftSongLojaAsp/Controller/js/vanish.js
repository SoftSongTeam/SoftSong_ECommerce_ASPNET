var t;

function activateVanish() {
	$(document).ready(function () {
		$('.vanish-box').each(function () {
			$(this).addClass('vanish-measuring');

			$(this).find(".vanish").each(function () {
				$(this).attr("data-width", $(this).width());
			});
		});


		$('.vanish-box').each(function () {
			$(this).find('.vanish').each(function () {
				// console.log(this);
				// console.log($(this).width());

				if ($(this).width() == 0) {
					// alert($(this).attr('class'));
					t = $(this);
				} else $(this).css('width', $(this).width());
			});

			$(this).addClass($(this).data('vanish-toggle-op'));

			$(this).find('[data-vanish-toggle-op]').each(function () {
				// console.log($(this));
				$(this).addClass($(this).data('vanish-toggle-op'));
				// $(this).addClass('rounded');
			});

			$(this).removeClass('vanish-measuring');

		});
		$('[data-vanish-wait]').removeAttr('data-vanish-wait').addClass('vanish-measured');
		var t = setTimeout(function () {
			$('.vanish-measured').removeClass('vanish-measured');
		}, 1200);
	});

	$('.vanish-box').each(function () {

		$(this).bind('mouseenter', function () {
			var t = $(this).css('transition');
			$(this).css('transition', '.' + ($(this).hasClass('vanish-fast') ? '2' : '3') + 's ease-in-out');
			$(this).addClass($(this).data('vanish-toggle'));
			$(this).removeClass($(this).data('vanish-toggle-op'));

			$(this).find('[data-vanish-toggle-op]').each(function () {
				$(this).removeClass($(this).data('vanish-toggle-op'));
			});

			$(this).find('[data-vanish-toggle]').each(function () {
				$(this).addClass($(this).data('vanish-toggle'));
			});

			$(this).bind('mouseleave', function () {
				$(this).removeClass($(this).data('vanish-toggle'));
				$(this).addClass($(this).data('vanish-toggle-op'));
				$(this).css('transition', t);


				$(this).find('[data-vanish-toggle-op]').each(function () {
					$(this).addClass($(this).data('vanish-toggle-op'));
				});

				$(this).find('[data-vanish-toggle]').each(function () {
					$(this).removeClass($(this).data('vanish-toggle'));
				});
			});
		});

		$(this).bind('focusin', function () {
			var t = $(this).css('transition');
			$(this).css('transition', '.' + ($(this).hasClass('vanish-fast') ? '2' : '3') + 's ease-in-out');
			$(this).addClass($(this).data('vanish-toggle'));
			$(this).removeClass($(this).data('vanish-toggle-op'));
			// console.log('a');

			$(this).find('[data-vanish-toggle-op]').each(function () {
				$(this).removeClass($(this).data('vanish-toggle-op'));
			});

			$(this).find('[data-vanish-toggle]').each(function () {
				$(this).addClass($(this).data('vanish-toggle'));
			});

			$(this).bind('focusout', function () {
				$(this).removeClass($(this).data('vanish-toggle'));
				$(this).addClass($(this).data('vanish-toggle-op'));
				$(this).css('transition', t);


				$(this).find('[data-vanish-toggle-op]').each(function () {
					$(this).addClass($(this).data('vanish-toggle-op'));
				});

				$(this).find('[data-vanish-toggle]').each(function () {
					$(this).removeClass($(this).data('vanish-toggle'));
				});
			});
		});

	});
}