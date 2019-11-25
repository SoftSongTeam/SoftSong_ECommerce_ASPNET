<%@ Page Title="" Language="C#" MasterPageFile="../masters/Unlogged.master" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="SoftSongLojaAsp.pages.payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">

    <div class="container">
        <div class="pages-indicator my-4 d-flex justify-content-center align-items-center text-secondary" v-if="prods[0] != undefined">
            <i class="fas fa-shopping-cart fa-4x active"></i>
            <div class="pages-indicator-bar"></div>
            <i class="far fa-credit-card fa-4x"></i>
        </div>

        <div class="row my-3" id="prodsList" v-if="prods[0] != undefined">
            <div class="col-12 p-3 bg-theme-gradient mb-0" data-dark-mode-reverse="bg-theme-gradient" data-dark-mode="border border-light">
                <h1 class="display-4 text-light ml-3">
                    Finalização da compra
                </h1>
            </div>
            <div class="col-12 border border-secondary products-box mb-5" data-dark-mode-reverse="" data-dark-mode="border border-light text-light">
                <div class="products--header d-flex align-items-center">
                    <div class="col-2 text-center">
                        <p class="lead border-bottom border-secondary d-inline">
                            Imagem
                        </p>
                    </div>
                    <div class="product-name text-center col-3">
                        <p class="lead border-bottom border-secondary d-inline">
                            Nome
                        </p>
                    </div>
                    <div class="product-name text-center col-2">
                        <p class="lead border-bottom border-secondary d-inline">
                            Quantidade
                        </p>
                    </div>
                    <div class="product-price text-center col-3">
                        <p class="lead border-bottom border-secondary d-inline">
                            Preço Unitário
                        </p>
                    </div>
                </div>
                <div class="product d-flex align-items-center" v-for="(p, i) in prods">
                    <div class="product-image-box col-2">
                        <img :src="p.img" alt="" class="img-fluid">
                    </div>
                    <div class="product-name lead col-3">
                        <p class="m-0">
                            {{p.n}}
                        </p>
                    </div>
                    <div class="product-name lead col-2">
                        <p class="m-0">
                            {{ p.q }}
                        </p>
                    </div>
                    <div class="product-price lead col-3">
                        <p class="m-0">
                            {{ displayPrice(p.p) }}
                        </p>
                    </div>
                    <div class="col">
                        <button class="btn btn-outline-danger btn-block" @click="removeItem(i)"  data-dark-mode-reverse="btn-outline-danger" data-dark-mode="btn-outline-light">
                            Remover
                        </button>
                    </div>
                </div>
                <div class="product d-flex align-items-center">
                    <div class="lead offset-2 col-3">
                        Total
                    </div>
                    <div class="product-price lead col-3 offset-2">
                        {{ displayPrice(total) }}
                    </div>
                    <div class="col">
                        <button class="btn btn-success btn-block" onclick="avancarClick(event)">
                            Avançar
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row my-3" id="payment-methods" style="display: none" v-if="prods[0] != undefined">
            <div class="col-12 py-4">
                <button class="btn btn-outline-primary" onclick="retornarClick(event)" data-dark-mode-reverse="btn-outline-primary" data-dark-mode="btn-outline-light">
                    Retornar à tela anterior
                </button>
            </div>
            <div class="col-4">
                <div class="card border border-secondary bg-transparent" data-dark-mode="text-light">
                    <div class="card-body">
                        <p class="lead">
                            Insira seu endereço para entrega
                        </p>
                        <asp:TextBox ID="txtCEP" runat="server" CssClass="form-control" placeholder="CEP" data-mask="00000-000" data-dark-mode="bg-transparent border border-light text-light"></asp:TextBox>
                        <%--<input type="text" class="form-control" id="txtCep" placeholder="CEP" data-mask="00000-000">--%>
						<div class="text-muted" data-dark-mode="text-light" data-dark-mode-reverse="text-muted">
							<p class="lead mt-3" style="font-size: 1.2rem" :class="{'d-none': enderecoReturn == ''}" data-toggle="tooltip" data-placement="right" title="Esse endereço foi buscado automaticamente baseado no seu CEP. Em caso de erro, revise o CEP inserido.">
								{{ enderecoReturn }}.
								<span class="text-danger font-weight-bold">Esse endereço está errado?</span>
							</p>
						</div>
                        <asp:TextBox ID="txtNum" runat="server" CssClass="form-control my-3" placeholder="Número" data-mask="0000000" data-dark-mode="bg-transparent border border-light text-light"></asp:TextBox>
                        <asp:TextBox ID="txtComp" runat="server" CssClass="form-control my-3" placeholder="Complemento" data-dark-mode="bg-transparent border border-light text-light"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-6 offset-2">
                <div class="card border border-secondary bg-transparent" data-dark-mode="text-light">
                    <div class="card-body">
                        <p class="lead border-bottom border-secondary pb-3" style="font-size: 1.4rem">
                            <span class="font-weight-bold">Total:</span> {{ displayPrice(total) }}
                        </p>
                        <p class="lead">
                            Selecione um método de pagamento
                        </p>
                        <div class="payment-methods-box d-flex justify-content-around align-items-stretch">
                            <div class="payment-method mx-2" v-for="p in paymentMethods" @click="payMethod = p.n" :class="{'active': payMethod == p.n}">
                                <div class="h-100 d-flex align-items-center">
                                    <img :src="'../img/payment-methods/' + p.i" alt="" class="img-fluid bg-white">
                                </div>
                            </div>
                        </div>
                        <button class="btn btn-success btn-block mt-5" onclick="finalizarClick(event)">
                            Finalizar compra
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="my-3" v-else>
            <h1 class="display-3 text-center mt-4">
                Seu carrinho está vazio
            </h1>
            <p class="display-4 mt-5 text-center" style="font-size: 2.5em">
                Você será redirecionado(a) para a tela inicial em
                <span class="font-weight-bold">{{ timeMark }}</span>
                segundos
            </p>
        </div>
    </div>

	<asp:Image ID="Image2" runat="server" CssClass="asp-image-remove" ImageUrl="~/img/payment-methods/boleto.png" />
	<asp:Image ID="Image3" runat="server" CssClass="asp-image-remove" ImageUrl="~/img/payment-methods/mastercard.jpg" />
	<asp:Image ID="Image4" runat="server" CssClass="asp-image-remove" ImageUrl="~/img/payment-methods/paypal.jpg" />
	<asp:Image ID="Image5" runat="server" CssClass="asp-image-remove" ImageUrl="~/img/payment-methods/visa.png" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBottomBody" runat="server">
    <script src="../Offline%20Frameworks/jquery.mask.js"></script>
    <script src="../js/payment.js"></script>
</asp:Content>