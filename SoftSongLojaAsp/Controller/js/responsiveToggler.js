function ArrayCount(a) {
	var c = 0;
	for (b in a) c++;
	return c;
}

function findMediaRange() {
	var w = $(window).width();
	return w < 576 ? 0 :
		w < 768 ? 1 :
			w < 992 ? 2 :
				w < 1200 ? 3 : 4;
}

function mediaRangeName(i) {
	var names = ['xs', 'sm', 'md', 'lg', 'xl'];
	return names[i];
}

function mediaRangeIndex(n) {
	var names = ['xs', 'sm', 'md', 'lg', 'xl'];
	return names.indexOf(n);
}

function adjustClasses() {
	var size = findMediaRange();
	$('[data-responsive-class]').each(function () {
		var config = JSON.parse($(this).data('responsive-class').replace(/'/g, '"'));
		for (ck in config) {
			var ce = config[ck];
			var mediaIndex = mediaRangeIndex(ck.slice(0, 2));
			if (ArrayCount(ck) == 3) {
				if (ck.slice(-1) == 'u') {
					if (size >= mediaIndex) $(this).addClass(ce);
					else $(this).removeClass(ce);
				} else if (ck.slice(-1) == 'd') {
					if (size <= mediaIndex) $(this).addClass(ce);
					else $(this).removeClass(ce);
				}
			} else {
				if (mediaIndex == size) $(this).addClass(ce);
				else $(this).removeClass(ce);
			}
		}
	});
}

var teste;

function adjustStyles() {
	var size = findMediaRange();
	$('[data-responsive-style]').each(function () {
		var config = JSON.parse($(this).data('responsive-style').replace(/'/g, '"'));
		teste = config;
		for (pk in config) {
			var action = '';
			var pe = config[pk];
			var pv = '';

			for (ck in pe) {
				var ce = pe[ck];
				var mediaIndex = mediaRangeIndex(ck.slice(0, 2));

				if (ArrayCount(ck) == 3) {
					if (ck.slice(-1) == 'u' && size >= mediaIndex) {
						pv = ce;
						break;
					}
					else if (ck.slice(-1) == 'd' && size <= mediaIndex) {
						pv = ce;
						break;
					}
				}
			}
			$(this).css(pk, pv);
		}
	});
}

function activateResponsiveToggler() {
	$(window).on('resize', function () {
		adjustClasses();
		adjustStyles();
	});
	adjustClasses();
	adjustStyles();
}