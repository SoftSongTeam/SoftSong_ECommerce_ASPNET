function ArrayCount(a) {
	var c = 0;
	for (b in a) c++;
	return c;
}

var old = alert;

alert = function () {
    console.log(new Error().stack);
    old.apply(window, arguments);
};

function goDarkMode() {
	$('[data-dark-mode]').each(function () {
		// console.log(this);
		$(this).addClass($(this).data('dark-mode'));
		$(this).removeClass($(this).data('dark-mode-reverse'));

		if ($(this).data('vanish-toggle-dark-remove')) {
			var remove = $(this).data('vanish-toggle-dark-remove').split(' ');
			var originalToggleData = $(this).data('vanish-toggle');
			for (ri in remove) {
				originalToggleData = originalToggleData.replace(remove[ri] + '', '');
			}
			// console.log(originalToggleData);
			$(this).data('vanish-toggle', originalToggleData);
		}
	});
}

function goLightMode() {
	$('[data-dark-mode]').each(function () {
		// console.log(this);
		$(this).removeClass($(this).data('dark-mode'));
		$(this).addClass($(this).data('dark-mode-reverse'));

		if ($(this).data('vanish-toggle-dark-remove')) {
			$(this).data('vanish-toggle', $(this).data('vanish-toggle') + ' ' + $(this).data('vanish-toggle-dark-remove'));
		}
	});
}

var darkMode = false

function updateColorMode() {
	if (!darkMode) goLightMode();
	else goDarkMode();
}

function toggleDarkMode() {
	if (darkMode) goLightMode();
	else goDarkMode();
	darkMode = !darkMode;
}

activateVanish();

$('[data-toggle="tooltip"]').tooltip();

$('.asp-image-remove').remove();


var SPMaskBehavior = function (val) {
	return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
},
	spOptions = {
		onKeyPress: function (val, e, field, options) {
			field.mask(SPMaskBehavior.apply({}, arguments), options);
		}
	};

$(document).ready(function (e) {
	$('[data-mask]').each(function (e) {
		let mask = $(this).data("mask");
		if (typeof mask != 'string') mask = mask.mask;
		if (mask == 'spCelphone') $(this).mask(SPMaskBehavior, spOptions);
		else $(this).mask(mask);
	});
	$('.modal').on('shown.bs.modal', function (e) {
		$('this').modal('handleUpdate');
	});
	$('[data-toggle="tooltip"]').tooltip();
	$('#cphBody_txtCadCep').keyup((e) => {
		let cep = $('#cphBody_txtCadCep').val();
		let len = ArrayCount(cep);
		$('#cphBody_txtCadCep').removeClass('is-invalid');
		$('#cepReturnBox').addClass('d-none');
		if (len == 9) {
			Utilities.AddressFromCep(cep, addressReturn);
		}
		else console.log(cep);
	});
});

function addressReturn(s) {
	let cep = $('#cphBody_txtCadCep').val();
	if (s == 'CEP não encontrado') {
		$('#cphBody_txtCadCep').addClass('is-invalid');
		$('#cepReturnBox').addClass('d-none');
	}
	else if (s.indexOf(cep) != -1) {
		$('#cepReturnBox .cepReturnText').html(s.replace(cep, ''));
		$('#cepReturnBox').removeClass('d-none')
	}
	else $('#cepReturnBox').addClass('d-none');
}

function loadingModal(e, t) {
	$(t).closest('.modal').modal('hide');
	$('#loadingModal').modal('show');
}

var t;
function productAlert(text) {
	clearInterval(t);
	$('.alert-box').remove();
	let el = $('<div class="alert-box bg-white border rounded shadow-dynamic-lg p-3"><div class="row h-100 align-items-center"><div class="col-4"><img src="../img/logo.png" alt="" class="img-fluid"></div><div class="col"><p class="lead" id="lblAlert"></p></div></div></div>');
	el.find('#lblAlert').html(text);
	el.appendTo($('body'));
	t = setTimeout(() => {
		$('.alert-box').remove();
	}, 3000);
}