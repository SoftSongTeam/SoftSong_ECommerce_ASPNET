
var vmPayment = new Vue({
	el: '#app',
	data: {
		prods: [],
		enderecoReturn: '',
		paymentMethods: [{
			n: 'visa',
			i: 'visa.png'
		},
		{
			n: 'master',
			i: 'mastercard.jpg'
		},
		{
			n: 'paypal',
			i: 'paypal.jpg'
		},
		{
			n: 'boleto',
			i: 'boleto.png'
		},
		],
		payMethod: '',
		timeMark: 5
	},
	computed: {
		total: function () {
			let t = 0;
			this.prods.forEach(pe => {
				t += pe.p * pe.q;
			});
			return Math.round(t * 100) / 100;
		}
	},
	methods: {
		displayPrice: function (p) {
			p = "R$: " + p;
			p = p.replace('.', ',');
			return p;
		},
		removeItem: function (pi) {
			console.log(pi);
		},
		setProductImage: function (i, s) {
			this.prods[i].img = 'data:image/png;base64, ' + s;
		},
	},
	watch: {
		timeMark: function (n) {
			if (n == 0) window.location.href = "index.aspx";
		}
	}
});

function avancarClick(e) {
	e.preventDefault();
	$($('.pages-indicator i').get(0)).removeClass('active');
	$($('.pages-indicator i').get(1)).addClass('active');
	$('#prodsList').slideUp();
	$('#payment-methods').slideDown();
}

function retornarClick(e) {
	e.preventDefault();
	$($('.pages-indicator i').get(1)).removeClass('active');
	$($('.pages-indicator i').get(0)).addClass('active');
	$('#prodsList').slideDown();
	$('#payment-methods').slideUp();
}

function finalizarClick(e) {
	e.preventDefault();
	if ($("#cphBody_cphBody_txtCEP").val() != '' && $("#txtNumero").val() != '' && $("#txtComplemento").val() != '') {
		alert("Comprado");
	}
	else alert('Arruma ai');
}

$(document).ready(function (e) {
	$('[data-toggle="tooltip"]').tooltip();

	for (pi in vmPayment.prods) {
		let pe = vmPayment
		console.log(pi);
	}

	$('#cphBody_cphBody_txtCEP').keyup(function (e) {
		let cep = $(this).val();
		let len = ArrayCount(cep);
		vmPayment.enderecoReturn = '';
		if (len == 9) {
			Utilities.AddressFromCep(cep, addressReturn);
		}
		else console.log(len);
	});

	if (vmPayment.prods[0] == undefined) var t = setInterval(() => {
		vmPayment.timeMark--;
	}, 1000);

});

function addressReturn(s) {
	let cep = $('#cphBody_cphBody_txtCEP').val();
	if (s.indexOf(cep) != -1) vmPayment.enderecoReturn = s.replace(cep, '');		
	else vmPayment.enderecoReturn = ''
}

var index = -1;
function getNextImage() {
	try {
		index++;
		Utilities.getProductImage(vmPayment.prods[index].id, getNextImageReturn);
	}
	catch {
		vmPayment.$forceUpdate();
	}
}

function getNextImageReturn(img) {
	vmPayment.setProductImage(index, img);
	getNextImage();
}

function emptyCart() {
	vmPayment.prods = [];
}

activateVanish();

