<%@ Page Title="" Language="C#" MasterPageFile="../masters/Unlogged.master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="SoftSongLojaAsp.pages.search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/search.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <div class="container my-3">
        <div class="row align-items-center">
            <div class="col-md-5">
                <h1 class="display-4 m-0 p-0" data-responsive-style="{'font-size': {'mdu': '2.5rem', 'smd': '2rem'}}" data-dark-mode="text-light"> Resultados da busca por: </h1>
            </div>
            <div class="col p-3" data-responsive-class="{'mdu': 'offset-1'}">
                <!-- <h1 class="display-4 my-0 p-0" style="font-size: 2rem">
                     Resultados da busca por 'ler '
                  </h1> -->

                <div class="shadow-dynamic-lg p-3" data-dark-mode="border border-light">

                    <div class="input-group">

                        <input type="text" class="form-control text-right ml-auto" data-dark-mode="border border-light" placeholder="Pesquise aqui" v-model="searchString">
                        <div class="input-group-append">
                            <button class="btn btn-outline-primary" data-dark-mode-reverse="btn-outline-primary" data-dark-mode="btn-outline-light">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 px-3">
                <div class="m-0 d-flex flex-column mt-3" data-dark-mode="border border-light" id="subMenu">
                    <div class="p-3 submenu-item shadow-dynamic-lg mt-0 mb-3" data-dark-mode="text-light" data-dark-mode-reverse="shadow-dynamic-lg">
                        <a href="#collapse1" data-toggle="collapse" class="decoration-none" data-dark-mode="text-light">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="h5 m-0">
                                    Ordenar por:
                                </div>
                                <i class="fas fa-2x fa-angle-down" data-dark-mode-reverse="text-primary" data-dark-mode="text-light"></i>
                            </div>
                        </a>

                        <div id="collapse1" class="collapse">
                            <div class="mt-3">
                                <div class="form-check my-2">
                                    <input class="form-check-input my-input-check" type="radio" name="orderRatios" id="orderRatiosValCres" value="valCres" v-model="order">
                                    <div class="input-check"></div>
                                    <label class="form-check-label" for="orderRatiosValCres" data-dark-mode="text-light">
                                        Valor - Crescente
                                    </label>
                                </div>
                                <div class="form-check my-2">
                                    <input class="form-check-input" type="radio" name="orderRatios" id="orderRatiosValDecres" value="valDecres" v-model="order">
                                    <div class="input-check"></div>
                                    <label class="form-check-label" for="orderRatiosValDecres" data-dark-mode="text-light">
                                        Valor - Decrescente
                                    </label>
                                </div>
                                <div class="form-check my-2">
                                    <input class="form-check-input" type="radio" name="orderRatios" id="orderRatiosRelev" value="relev" v-model="order">
                                    <div class="input-check"></div>
                                    <label class="form-check-label" for="orderRatiosRelev" data-dark-mode="text-light">
                                        Relevância
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="p-3 submenu-item shadow-dynamic-lg mt-3 mb-0" data-dark-mode="text-light" data-dark-mode-reverse="shadow-dynamic-lg">
                        <a href="#collapse2" data-toggle="collapse" class="decoration-none" data-dark-mode="text-light">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="h5 m-0">
                                    Categorias:
                                </div>
                                <i class="fas fa-2x fa-angle-down" data-dark-mode-reverse="text-primary" data-dark-mode="text-light"></i>
                            </div>
                        </a>
                        <div id="collapse2" class="collapse">
                            <div class="mt-3">
                                <div class="search-box search-box--showing">
                                    <input type="text" v-model="categorieSearchString" onkeypress="if (event.charCode == 13) event.preventDefault()" @keyup="catStringKey($event)" class="form-control" :class="{'rounded': categorieSearchResults[0] == undefined}" placeholder="Pesquise Categorias">
                                    <div class="search-results" v-if="categorieSearchResults[0] != undefined">
                                        <p class="search-result lead m-0 p-1 px-2" :class="{'search-result--selected': i == selectedCategory}" @click="selectSearchedCategory(i)" :data-index="i" v-for="(r,i) in categorieSearchResults">
                                            {{ r }}
                                        </p>
                                    </div>
                                </div>
                                <div class="d-flex flex-column mt-1">
                                    <div v-for="(c,i) in categoriesSelected" class="d-flex px-2 py-2 align-items-center">
                                        <p class="lead p-0 m-0">
                                            <i class="fas fa-check text-success mr-2"></i>
                                            {{ c }}
                                        </p>
                                        <p class="lead p-0 m-0 ml-auto cursor-pointer" @click="removeSelectedCategory(i)">
                                            <i class="fas fa-times text-secondary" data-dark-mode="text-light"></i>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col p-3">
                <div class="h-100 shadow-dynamic-lg p-3" data-dark-mode="border border-light" :class="{'d-none': !loading}">
                    <div class="card-deck my-3 align-items-center" v-for="i in 2">
                        <div class="card card-loading" data-dark-mode="bg-transparent border border-light text-light card-loading--dark" v-for="j in 3" :style="getLoadingStyleObject(i,j)">
                            <div class="card-img-top" :style="getLoadingStyleObject(i,j)"></div>
                            <div class="card-body">
                                <div class="loading-fill loading-fill-1" :style="getLoadingStyleObject(i,j)"></div>
                                <div class="loading-fill loading-fill-2" :style="getLoadingStyleObject(i,j)"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="h-100 shadow-dynamic-lg p-3" data-dark-mode="border border-light" :class="{'d-none': loading || displayProducts === 'empty' || displayProducts === 'emptyString'}">
                    <div class="row my-3 align-items-center">
                        <div class="p-3" v-for="(p, i) in displayProducts" data-responsive-class="{'lgu': 'col-4', 'md': 'col-6', 'smd': 'col-12'}">
                            <div class="card shadow-liftable" data-dark-mode="bg-transparent border border-light text-light" v-if="!p.empty">
                                <img class="card-img-top img-fluid" :src="p.img" alt="">
                                <div class="card-body">
                                    <h4 class="card-title">{{ p.name }} </h4>
                                    <h4 class="card-title" style="font-size: 1.2rem">R$ {{ roundNumber(p.price, 2) }}</h4>
                                    <p class="card-text">{{ p.desc }}</p>
                                    <a :href="'produto.aspx?id=' + p.id" class="btn btn-block btn-primary">
                                        Navegar
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="h-100 shadow-dynamic-lg p-3 align-items-center justify-content-center" data-dark-mode="border border-light" :class="{'d-none':  loading || displayProducts !== 'empty', 'd-flex':  !loading && displayProducts === 'empty'}">
                    <h1 class="display-4 text-secondary text-center">
                        Pesquisa não retornou nada :/
                    </h1>
                </div>
                <div class="h-100 shadow-dynamic-lg p-3 align-items-center justify-content-center" data-dark-mode="border border-light" :class="{'d-none':  loading || displayProducts !== 'emptyString', 'd-flex':  !loading && displayProducts === 'emptyString'}">
                    <h1 class="display-4 text-secondary text-center">
                        Digite algo para iniciar pesquisa!
                    </h1>
                </div>
            </div>
        </div>

        <div class="pagination justify-content-center mt-4 mb-5" v-if="!loading" data-dark-mode="paginantion-dark">
            <div class="page-item" :class="{'disabled': pageNumber <= 1}" @click="pageNumber -= (pageNumber <= 1? 0 : 1)">
                <a class="page-link">
                    <i class="fas fa-angle-double-left"></i>
                </a>
            </div>
            <div class="page-item" :class="{'active': pageNumber == 1}" @click="goToPage(pageNumber == 1 ? 1 : isLastPage ? (pageNumber - 2) : (pageNumber - 1))">
                <a class="page-link" href="#">{{ pageNumber == 1 ? 1 : isLastPage ? (pageNumber - 2) : (pageNumber - 1) }}</a>
            </div>
            <div class="page-item" :class="{'active': pageNumber != 1 && !isLastPage}" @click="goToPage(pageNumber == 1 ? 2 :  isLastPage ? (pageNumber - 1) : pageNumber)">
                <a class="page-link" href="#">{{ pageNumber == 1 ? 2 :  isLastPage ? (pageNumber - 1) : pageNumber }}</a>
            </div>
            <div class="page-item" :class="{'active': isLastPage}" @click="goToPage(pageNumber == 1 ? 3 :  isLastPage ? pageNumber : (pageNumber + 1))">
                <a class="page-link" href="#">{{ pageNumber == 1 ? 3 :  isLastPage ? pageNumber : (pageNumber + 1)}}</a>
            </div>
            <div class="page-item" :class="{'disabled': isLastPage}" @click="pageNumber += (isLastPage ? 0 : 1)">
                <a class="page-link">
                    <i class="fas fa-angle-double-right"></i>
                </a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBottomBody" runat="server">
	<script src="../js/responsiveToggler.js"></script>
    <script src="../js/search.js"></script>
</asp:Content>