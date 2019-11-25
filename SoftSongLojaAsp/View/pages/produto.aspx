<%@ Page Title="" Language="C#" MasterPageFile="../masters/Unlogged.master" AutoEventWireup="true" CodeBehind="produto.aspx.cs" Inherits="SoftSongLojaAsp.pages.produto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/produto.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">

    <div class="container my-2 py-3 border-left border-primary" data-dark-mode="border-light" data-undefined-revove>
        <div class="row">
            <div class="col-lg-4 col-md-6 align-items-center d-flex">
                <%--<img src="img/violao.png" alt="" class="img-fluid" data-dark-mode="bg-light rounded">--%>
                <asp:Image ID="imgProduto" runat="server" CssClass="img-fluid" data-dark-mode="bg-light rounded" />
            </div>
            <div class="col d-flex align-items-center px-0">
                <div class="shadow p-3 shadow-liftable bg-white w-100" data-dark-mode="rounded bg-transparent border border-light text-light">
                    <asp:Label ID="lblNome" runat="server" Text="" CssClass="display-3 border-bottom border-primary px-3" data-dark-mode="border-light">
                        Violão
                    </asp:Label>
                    <asp:Label ID="lblPreco" runat="server" Text="" CssClass="h2 font-weight-light text-secondary my-3 d-block" data-dark-mode="text-light" data-dark-mode-reverse="text-secondary">
                        R$: 1199,99
                    </asp:Label>
                    <p class="lead my-3 text-secondary" style="font-size: 1.75rem">
                        <asp:HyperLink ID="lnkCategoria" runat="server" style="font-size: 1.5rem" data-dark-mode="text-light" NavigateUrl="~/pages/produto.aspx"></asp:HyperLink>
                    </p>
                    <div class="d-flex flex-row row-hl" id="availableBox">
                        <div class="ammount-selector d-flex align-items-center px-3 border border-dark">
                            <button id="btnAmmountMinus" disabled class="btn btn-danger mr-3" onclick="event.preventDefault();addToAmmount(-1);"><i class="fas fa-minus"></i></button>
                            <p class="lead m-0 p-0" id="lblAmmount" data-toggle="tooltip" data-placement="top" title="Valor Máximo" data-trigger="manual" data-offset="10">
                                1
                            </p>
                            <button id="btnAmmountPlus" class="btn btn-success ml-3" onclick="event.preventDefault();addToAmmount(1);"><i class="fas fa-plus"></i></button>
							<asp:TextBox ID="txtAmmount" runat="server" Text="1"></asp:TextBox>
						</div>
                        <div onclick="event.preventDefault();$('#cphBody_cphBody_btnBackAddCart').click();" class="item-hl align-items-center d-inline-flex p-3 border border-dark bg-transparent vanish-box" data-vanish-toggle="bg-theme-gradient-left text-light cursor-pointer" data-vanish-toggle-dark-remove="text-light" data-dark-mode="text-light border-light" data-dark-mode-reverse="border-dark">
                            <p class="d-inline m-0 vanish mr-3">
                                Adicionar ao Carrinho
                            </p>
                            <i class="fas fa-cart-plus fa-2x"></i>
                        </div>
                        <asp:Button ID="btnBackAddCart" runat="server" Text="" CssClass="btn-vanish-hidden" OnClick="btnBackAddCart_Click" />

                        <button class="item-hl align-items-center d-inline-flex p-3 border border-dark bg-transparent vanish-box" data-vanish-toggle="bg-theme-gradient-left text-light cursor-pointer" data-vanish-toggle-dark-remove="text-light" data-dark-mode="text-light border-light" data-dark-mode-reverse="border-dark">
                            <p class="d-inline m-0 vanish mr-3">
                                Comprar Agora
                            </p>
                            <i class="fas fa-shopping-cart fa-2x"></i>
                            <asp:Button ID="btnBackBuyNow" runat="server" Text="" OnClick="btnBackBuyNow_Click"
								CssClass="btn-vanish-hidden" />
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container my-3 shadow shadow-liftable bg-white p-3 px-4" data-dark-mode="rounded border border-light text-light" data-dark-mode-reverse="bg-white" data-undefined-revove>
        <h1 class="display-4 border-left border-primary px-3 py-1" data-dark-mode="border-light" data-dark-mode-reverse="border-primary">
            Descrição
        </h1>
        <%--<p class="lead">
        </p>--%>
		<asp:Button ID="btnShow" runat="server" CssClass="d-block btn btn-outline-primary" Text="Gimme that sweet sweet val" OnClick="btnShow_Click" />
		<asp:Button ID="btnClear" runat="server" CssClass="d-block btn btn-outline-primary" Text="CLEAR THAT SHIT MY MAN" OnClick="Button1_Click" />
        <asp:Label ID="lblDesc" runat="server" Text="Label"></asp:Label>
    </div>
	<asp:Image ID="Image1" runat="server" ImageUrl="~/img/logo.png" CssClass="d-none asp-image-remove"/>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBottomBody" runat="server">
    <script src="../js/produto.js"></script>
</asp:Content>