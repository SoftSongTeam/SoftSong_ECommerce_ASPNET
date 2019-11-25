let vmSearch = new Vue({
	el: '#app',
	data: {
		searchString: '',
		categorieSearchString: '',
		categorieSearchResults: [],
		categoriesSelected: [],
		selectedCategory: -1,
		displayColumns: 3,
		loading: false,
		pageNumber: 1,
		isLastPage: false,
		order: 'valCres',
		products: 'emptyString'
	},
	computed: {
		displayProducts: function () {
			if (this.products == 'emptyString') return 'emptyString'; 
			let pa = JSON.parse(JSON.stringify(this.products));
			let pn = ArrayCount(pa);
			if (pn == 0) return 'empty';
			return pa;
		},
	},
	methods: {
		roundNumber: function (n, aprox) {
			n = n * 100 + '';
			return n.slice(0, -aprox) + ',' + n.slice(-aprox);
		},
		getLoadingStyleObject: function (i, j) {
			return {
				'animation-delay': (6 - i - j) * -0.5 + 's'
			}
		},
		catStringKey: function (e) {
			switch (e.code) {
				case 'ArrowUp':
					if (this.selectedCategory >= -1) this.selectedCategory--;
					else this.selectedCategory = -1;
					break;
				case 'ArrowDown':
					if (this.categorieSearchResults[this.selectedCategory + 1] != undefined) this.selectedCategory++;
					break;
				case 'Enter':
					this.selectSearchedCategory(this.selectedCategory);
					break;
			}
		},
		selectSearchedCategory: function (ci) {
			let cse = this.categorieSearchResults[ci];
			if (cse == undefined) return false;
			let ca = this.categoriesSelected;
			if (ca.indexOf(cse) == -1) this.categoriesSelected.push(cse);
			this.categorieSearchString = '';
			updateProductsSearch(this.searchString, this.order, this.categoriesSelected, this.pageNumber);
		},
		removeSelectedCategory: function (i) {
			this.categoriesSelected.splice(i, 1);
			updateProductsSearch(this.searchString, this.order, this.categoriesSelected, this.pageNumber);
		},
		goToPage: function (i) {
			this.pageNumber = i;
		},
		setProductImage: function (i, s) {
			this.products[i].img = s;
		}
	},
	watch: {
		searchString: function (n) {
			updateProductsSearch(n, this.order, this.categoriesSelected, this.pageNumber);
		},
		pageNumber: function (s) {
			updateProductsSearch(this.searchString, this.order, this.categoriesSelected, s);
		},
		order: function (o) {
			updateProductsSearch(this.searchString, o, this.categoriesSelected, this.pageNumber);
		},
		categorieSearchString: function (cs) {
			this.selectedCategory = -1;
			this.categorieSearchResults = [];
			if (cs != '') Utilities.searchCategories(cs, searchCategoriesReturn);
		}
	},
	updated: function () {
		updateColorMode();
		adjustClasses();
		adjustStyles();
	}
});

function alignMenu() {
	var el = $("#subMenu");
	if ($(window).width() > 576) {
		var top = ($(window).scrollTop() + el.height() >= el.parent().height() ? el.parent().height() - el.height() : $(window).scrollTop());
		el.css({
			position: 'relative',
			top: top
		});
	} else {
		el.css({
			position: 'unset'
		})
	}
}
$(window).on('scroll', function (e) {
	alignMenu();
});
$(window).on('resize', function () {
	alignMenu();
});
$('.collapse').on('show.bs.collapse', function () {
	alignMenu();
}).on('hide.bs.collapse', function () {
	alignMenu();
});
alignMenu();
$('.input-check').click(function () {
	$(this).parent().find('input').click();
});


activateVanish();
activateResponsiveToggler();


let args = window.location.href.split('?')[1];
let aa = args.split('&');
let params = {
	's': '',
	'c': '',
	'o': 'valCres'
};
for (ai in aa) {
	let ae = aa[ai].split('=');
	params[ae[0]] = decodeURIComponent(ae[1]);
}
console.log(params);	
vmSearch.searchString = params.s;
if (params.c != '') vmSearch.categoriesSelected = params.c.split(";");
Utilities.searchProducts(params.s, params.o, params.c, 1, searchProductsReturn);
console.log(params);

function updateProductsSearch(n, ord, cats, pag) {
	if (n == '' && cats[0] == undefined) {
		vmSearch.products = 'emptyString';
	}
	else if (cats[0] != undefined) {
		vmSearch.loading = true;
		Utilities.searchProducts(n, ord, cats.reduce(function (t, e) {
			return t + ';' + e;
		}), pag, searchProductsReturn);
	}
	else {
		vmSearch.loading = true;
		Utilities.searchProducts(n, ord, ';;', pag, searchProductsReturn);
	}
}


function searchProductsReturn(se) {
	console.log(se);
	se = JSON.parse(se);
	console.log(se);
	if (se.p[0] == undefined) {
		vmSearch.products = 'empty';
		vmSearch.loading = false;
	}
	else if (se.s == vmSearch.searchString && se.o == vmSearch.order && se.page == vmSearch.pageNumber) {
		vmSearch.products = se.p.map(function (pe) {
			pe.price = parseFloat(pe.price);
			return pe;
		});
		vmSearch.isLastPage = (se.next == "True");
		vmSearch.loading = false;
		imageGottenIndex = 0;
		getNextProductImage();
	} else {
		console.log(se.s + ' != ' + vmSearch.searchString);
	}
}

function searchCategoriesReturn(se) {
	//console.log(se);
	se = JSON.parse(se);
	if (vmSearch.categorieSearchString == se.s) {
		vmSearch.categorieSearchResults = se.ret;
	}
	console.log(se);
}

var imageGottenIndex;
var keep;
function getNextProductImage() {
	console.log(vmSearch.products[imageGottenIndex]);
	if (vmSearch.products[imageGottenIndex] != undefined && vmSearch.products[imageGottenIndex].id != undefined) {
		Utilities.getProductImage(vmSearch.products[imageGottenIndex].id + "", getNextProductImageReturn);
	}
}

function getNextProductImageReturn(s) {
	//$('[data-product-index="' + imageGottenIndex + '"] img').attr('src', 'data:image/png;base64, ' + s);
	vmSearch.setProductImage(imageGottenIndex, 'data:image/png;base64, ' + s);
	imageGottenIndex++;
	getNextProductImage();
}
