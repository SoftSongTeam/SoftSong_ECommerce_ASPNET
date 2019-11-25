<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SoftSongLojaAsp.pages.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>SoftSong</title>
	<link href="../Offline%20Frameworks/FontAwesome/css/all.min.css" rel="stylesheet" />
	<link href="../Offline%20Frameworks/bootstrap/bootstrap.css" rel="stylesheet" />
	<link href="../Offline%20Frameworks/flexslider.css" rel="stylesheet" />
	<link href="../css/index.css" rel="stylesheet" />
</head>
<body>
	<form id="form1" runat="server">

		<div class="back-box bg-theme-gradient">
			<div class="front-box">
				<button class="btn btn-link icon-box">
					<img src="../img/logo.svg" alt="" class="logo-colors" />
					<img src="../img/logoWhite.svg" alt="" class="logo-white" />
				</button>
				<button class="search-button btn btn-link text-light" onclick="event.preventDefault();$('.right-products-box, .right-search-box').slideToggle();$('#txtRightSearch').focus()">
					<i class="fas fa-search fa-2x p-0"></i>
				</button>
				<img src="../img/indexGuitar.png" alt="" class="middle-guitar img-fluid">
				<div class="guitar-info-box text-light px-4 d-flex flex-column justify-content-center align-items-end">
					<h1 class="guitar-title display-4">Guitarra Epiphone
					</h1>
					<p class="guitar-price display-4 my-3">
						R$ 10 000,00
					</p>
					<%--<button class="btn-buy btn btn-outline-light btn-block my-4 w-75">
						Comprar Agora!
					</button>--%>
					<asp:Button ID="btnBuy" OnClick="btnBuy_Click" runat="server" Text="Comprar Agora!" CssClass="btn-buy btn btn-outline-light btn-block my-4 w-75"/>
				</div>
				<div class="right-info px-4 d-flex flex-column justify-content-center">
					<div class="right-search-box" style="display: none">
						<asp:Panel ID="pnlRightSearch" runat="server" CssClass="input-group" DefaultButton="btnSearchHidden">
							<asp:TextBox ID="txtRightSearch" runat="server" CssClass="form-control right-search-input" placeholder="Pesquise aqui"></asp:TextBox>
							<div class="input-group-append">
								<button class="btn btn-outline-light px-3 rounded-right" type="button" onclick="$('#btnSearchHidden').click();">
									<i class="fas fa-search"></i>
								</button>
							</div>
							<asp:Button ID="btnSearchHidden" runat="server" Text="Sai daq Fudido" CssClass="d-none" OnClick="btnSearchHidden_Click"/>
						</asp:Panel>
					</div>

					<div class="right-products-box d-flex-weak flex-column">
						<p class="lead text-light">
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iste voluptas amet facilis. Earum, laboriosam consectetur rerum atque vel veritatis et magnam voluptatem facere nihil veniam. Pariatur rerum veritatis similique ab.
                        </p>
					</div>
				</div>
			</div>
		</div>



	</form>

	<script src="../Offline%20Frameworks/jquery-3.3.1.min.js"></script>
	<script src="../Offline%20Frameworks/vue.min.js"></script>
	<script src="../Offline%20Frameworks/jquery.flexslider-min.js"></script>
	<script src="../Offline%20Frameworks/popper.min.js"></script>
	<script src="../Offline Frameworks/bootstrap/bootstrap.min.js"></script>
	<%--<script src="../js/jquery.mask.js"></script>--%>
	<%--<script src="../js/vanish.js"></script>--%>
	<script src="../Offline%20Frameworks/base64Binary.js"></script>
	<script src="../js/index.js"></script>
</body>
</html>
