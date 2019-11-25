function signInError(ci, t = 'inv') {
	let ca = ["Name", "Cpf", "Tel", "Cep", "Num", "Com", "Email", "Pass", "RepPass"];
	let showName = ['Nome', 'CPF', 'Telefone', 'CEP', 'Número', 'Complemento', 'E-mail', 'Senha', 'Repetição de senha'];
	let art = ['o', 'o', 'o', 'o', 'o', 'o', 'o', 'a', 'a'];
	let basis = "cphBody_txtCad";
	console.log(basis + ca[ci]);
	$('#' + basis + ca[ci]).addClass('is-invalid');
	$('#' + basis + ca[ci]).parent().find('.invalid-feedback').html(showName[ci] +
		(t == 'inv' ? (' inválid' + art[ci]) :
			t == 'len' ? (' muito curt' + art[ci]) :
			t == 'dif' ? ' não bate' : ''));
	$('script.error').remove();
	$('#signupModal').modal('show');
}

function loginError() {
	$('#cphBody_txtLogEmail').addClass('is-invalid');
	$('#cphBody_txtLogPass').addClass('is-invalid').parent().find('.invalid-feedback').html('Login ou Senha inválidos');
	$('script.error').remove();
	$('#loginModal').modal('show');
}