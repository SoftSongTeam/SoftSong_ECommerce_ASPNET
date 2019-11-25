var save = []

function addImageToSave(img) {
	save.push(img);
}


function handleFileSelect(evt) {
	evt.stopPropagation();
	evt.preventDefault();

	var files = evt.originalEvent.dataTransfer.files; // FileList object.

	var codes = [];

	console.log(files);
	for (var i = 0, f; f = files[i]; i++) {
		if (!f.type.match('image.*')) {
			continue;
		}

		var reader = new FileReader();

		var n = escape(f.name);
		var ty = f.type;

		reader.onloadend = function () {
			addImageToSave({
				code: reader.result,
				name: n,
				type: ty
			});
		}

		reader.readAsDataURL(files[0]);
	}
}

function handleDragOver(evt) {
	evt.stopPropagation();
	evt.preventDefault();
	// console.log(evt);
	evt.originalEvent.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
}

$('.img-dropper').on('dragover', handleDragOver);
$('.img-dropper').on('drop', handleFileSelect);

function onSaveImageSuccess(a) {
	console.log(a);
}

function loadBtnClick(e) {
	e.preventDefault();

	for (var si = 0, se; se = save[si]; si++) {
		var byteArray = Base64Binary.decode(se.code);
		Utilities.saveImage(byteArray, onSaveImageSuccess);
	}
}