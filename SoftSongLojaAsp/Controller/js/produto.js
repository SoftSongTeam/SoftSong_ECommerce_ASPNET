
function alertUndefinedProd() {
   $('[data-undefined-revove]').remove();

   $('<div class="my-5 mx-3" data-vanish-wait> <h1 class="display-3 text-center text-secondary" data-dark-mode="text-light" data-dark-mode-reverse="text-secondary"> Produto não encontrado </h1> <div class="animated-icon mx-auto" data-dark-mode="animated-icon--dark-mode"> <div class="animated-icon-content animated-icon-content-1"> <div class="animated-icon-shadow"></div> <div class="animated-icon-moon animated-icon-moon-2"></div> </div> <div class="animated-icon-content animated-icon-content-2"> <img src="img/loading-logos/logo1.svg" alt="" class="img-fluid animated-icon-img"> <img src="img/loading-logos/logo2.svg" alt="" class="img-fluid animated-icon-img"> <img src="img/loading-logos/logo3.svg" alt="" class="img-fluid animated-icon-img"> <img src="img/loading-logos/logo4.svg" alt="" class="img-fluid animated-icon-img"> <img src="img/loading-logos/logo5.svg" alt="" class="img-fluid animated-icon-img"> </div> </div> </div>').appendTo('body')
}
var maxAmmount = 10;
function addToAmmount(n) {
	let a = $('#lblAmmount').html();
	a = isNaN(a) ? 1 : parseInt(a);
	a += n;
	if (a == maxAmmount) {
		$('#btnAmmountPlus').attr('disabled', 'true');
		$('#lblAmmount').tooltip('show');
		let t = setTimeout(() => {
			$('#lblAmmount').tooltip('hide');
		}, 500);
	} else {
		$('#btnAmmountPlus').removeAttr('disabled');
		$('#lblAmmount').tooltip('hide');
	}
	if (a == 1) {
		$('#btnAmmountMinus').attr('disabled', 'true');
	} else {
		$('#btnAmmountMinus').removeAttr('disabled');
	}
	$('#lblAmmount').html(a);
}

function unavailableProduct() {
	$('#availableBox').html('');
	$('<h1></h1>').addClass('display-4 mb-3 text-secondary').html('Produto Indisponível').appendTo($('#availableBox'));
}

var maxAmmount = 10;
function addToAmmount(n) {
	let a = $('#lblAmmount').html();
	a = isNaN(a) ? 1 : parseInt(a);
	a += n;
	if (a == maxAmmount) {
		$('#btnAmmountPlus').attr('disabled', 'true');
		$('#lblAmmount').tooltip('show');
		let t = setTimeout(() => {
			$('#lblAmmount').tooltip('hide');
		}, 500);
	} else {
		$('#btnAmmountPlus').removeAttr('disabled');
		$('#lblAmmount').tooltip('hide');
	}
	if (a == 1) {
		$('#btnAmmountMinus').attr('disabled', 'true');
	} else {
		$('#btnAmmountMinus').removeAttr('disabled');
	}
	$('#lblAmmount').html(a);
	$('#cphBody_cphBody_txtAmmount').val(a);
}

function unavailableProduct() {
	$('#availableBox').html('');
	$('<h1></h1>').addClass('display-4 mb-3 text-secondary').html('Produto Indisponível').appendTo($('#availableBox'));
}
