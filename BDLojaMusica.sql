go
USE MASTER

GO
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'LojaMusica')
DROP DATABASE LojaMusica

CREATE DATABASE LojaMusica

go
USE LojaMusica

--Criando tabelas sem as chaves prim·rias e estrangeiras
--IDTabela = chave prim·rias
--ID_Tabela = chave estrangeira

go
CREATE TABLE tblCliente(
	IDCliente INT IDENTITY(1,1),
	nome VARCHAR(70) NOT NULL,
	tel1 CHAR(17) NOT NULL,
	tel2 CHAR(17),
	email VARCHAR(70) UNIQUE NOT NULL,
	senha VARCHAR(40) NOT NULL,
	CPF CHAR(14) UNIQUE NOT NULL,
	endereco VARCHAR(70) NOT NULL,
	CEP CHAR(9),
	genero CHAR(1)
)

--genero de acordo com a ISO/IEC 5218:
-- 0 = outros, 1 = masculino, 2 = feminino, 9 = n„o quero identificar

go
CREATE TABLE tblFuncionario(
	IDFuncionario INT IDENTITY(1,1),
	nivel_acesso CHAR(1),
	nome VARCHAR(70) NOT NULL,
	CPF CHAR(15) UNIQUE NOT NULL,
	tel1 VARCHAR(17) NOT NULL,
	email VARCHAR(70) UNIQUE NOT NULL,
	--caminho_imagem VARCHAR(70),
	genero CHAR(1),
	usuario VARCHAR(45) UNIQUE NOT NULL,
	senha VARCHAR(40) NOT NULL
)
--nivel de acesso:
--0 = root;1 = gerente;2 = funcionario

go
CREATE TABLE tblTransportadora(
	IDTransportadora INT IDENTITY(1,1),
	nome VARCHAR(70) NOT NULL,
	CNPJ CHAR(18) UNIQUE NOT NULL,
	tel1 CHAR(17) NOT NULL,
	email VARCHAR(70) UNIQUE NOT NULL,
	endereco VARCHAR(70) NOT NULL,
	--cidade VARCHAR(45) NOT NULL,
	--estado CHAR(2) NOT NULL,
	CEP CHAR(9),
	--caminho_imagem VARCHAR(70)
)

go
CREATE TABLE tblFornecedor(
	IDFornecedor INT IDENTITY(1,1),
	nome VARCHAR(70),
	CNPJ CHAR(18) UNIQUE NOT NULL,
	tel1 CHAR(17) NOT NULL,
	email VARCHAR(70) UNIQUE NOT NULL,
	endereco VARCHAR(70) NOT NULL,
	--cidade VARCHAR(45) NOT NULL,
	--estado CHAR(2) NOT NULL,
	CEP CHAR(9),
	--caminho_imagem VARCHAR(70)
)

go
CREATE TABLE tblPromocao(
	IDPromocao INT IDENTITY(1,1),
	data_inicio DATE DEFAULT GETDATE() NOT NULL,
	data_fim DATE NOT NULL,
	taxa DECIMAL(3,2) default 1,
	desconto INT default 0,
	descricao VARCHAR(50)
)

go
CREATE TABLE tblSecao(
	IDSecao INT IDENTITY(1,1),
	nome VARCHAR(70) NOT NULL,
	descricao VARCHAR(100)
)

go
CREATE TABLE tblCategoria(
	IDCategoria INT IDENTITY(1,1),
	ID_Secao INT,
	nome VARCHAR(70) NOT NULL,
	descricao VARCHAR(100)
)

go
CREATE TABLE tblPedido(
	IDPedido INT IDENTITY(1,1),
	ID_Transportadora INT,
	ID_Funcionario INT,
	ID_Cliente INT,
	ID_TipoPedido INT,
	ID_Status INT
)

go
CREATE TABLE tblStatusPedido(
	IDStatus INT IDENTITY(1,1),
	descricao VARCHAR(100)
)

go
CREATE TABLE tblTipoPedido(
	IDTipoPedido INT IDENTITY(1,1),
	descricao VARCHAR(50)
)

go
CREATE TABLE tblTipoProduto(
	IDTipoProduto INT IDENTITY(1,1),
	ID_Promocao INT,
	ID_Fornecedor INT,
	ID_Categoria INT,
	nome VARCHAR(70) NOT NULL,
	preco_unitario MONEY NOT NULL,
	descricao VARCHAR(100) NOT NULL,
	imagem VARBINARY(max)
)

go
CREATE TABLE tblProduto(
	IDProduto INT IDENTITY(1,1),
	ID_TipoProduto INT,
	ID_Pedido INT,
	ID_Cliente INT
)

--Adicionando Constraints(chaves prim·rias e chaves estrangeiras)

go
ALTER TABLE tblCliente
	ADD CONSTRAINT pk_cliente
		PRIMARY KEY(IDCliente)
	
go
ALTER TABLE tblFuncionario
	ADD CONSTRAINT pk_funcionario
		PRIMARY KEY(IDFuncionario)
		
go
ALTER TABLE tblStatusPedido
	ADD CONSTRAINT pk_statuspedido
		PRIMARY KEY(IDStatus)

go
ALTER TABLE tblTransportadora
	ADD CONSTRAINT pk_transportadora
		PRIMARY KEY(IDTransportadora)
		
go
ALTER TABLE tblFornecedor
	ADD CONSTRAINT pk_fornecedor
		PRIMARY KEY(IDFornecedor)

go
ALTER TABLE tblPromocao
	ADD CONSTRAINT pk_promocao
		PRIMARY KEY(IDPromocao)

go
ALTER TABLE tblSecao
	ADD CONSTRAINT pk_secao
		PRIMARY KEY(IDSecao)
		
go
ALTER TABLE tblCategoria
	ADD CONSTRAINT pk_categoria
		PRIMARY KEY(IDCategoria)
		
go
ALTER TABLE tblTipoPedido
	ADD CONSTRAINT pk_tipoPedido
		PRIMARY KEY(IDTipoPedido)
		
go
ALTER TABLE tblTipoProduto
	ADD CONSTRAINT pk_tipoproduto
		PRIMARY KEY(IDTipoProduto)

go
ALTER TABLE tblProduto
	ADD CONSTRAINT pk_produto
		PRIMARY KEY(IDProduto)
		
--fk_tabelaPK_tabelaFK		
		
go
ALTER TABLE tblCategoria
	ADD CONSTRAINT fk_secao_categoria
		FOREIGN KEY(ID_Secao) REFERENCES tblSecao(IDSecao)
		
go
ALTER TABLE tblPedido
	ADD CONSTRAINT pk_pedido
		PRIMARY KEY(IDPedido)
		
go
ALTER TABLE tblPedido
	ADD CONSTRAINT fk_cliente_pedido
		FOREIGN KEY(ID_Cliente) REFERENCES tblCliente(IDCliente)

go
ALTER TABLE tblPedido
	ADD CONSTRAINT fk_transportadora_pedido
		FOREIGN KEY(ID_Transportadora) REFERENCES tblTransportadora(IDTransportadora)
		
go
ALTER TABLE tblPedido
	ADD CONSTRAINT fk_funcionario_pedido
		FOREIGN KEY(ID_Funcionario) REFERENCES tblFuncionario(IDFuncionario)
		
go
ALTER TABLE tblPedido
	ADD CONSTRAINT fk_tipoPedido_Pedido
		FOREIGN KEY(ID_TipoPedido) REFERENCES tblTipoPedido(IDTipoPedido)	
		
go
ALTER TABLE tblTipoProduto
	ADD CONSTRAINT fk_promocao_produto
	 FOREIGN KEY(ID_Promocao) REFERENCES tblPromocao(IDPromocao)
	 
go
ALTER TABLE tblTipoProduto
	ADD CONSTRAINT fk_fornecedor_tipoproduto
	 FOREIGN KEY(ID_Fornecedor) REFERENCES tblFornecedor(IDFornecedor)

go
ALTER TABLE tblTipoProduto
	ADD CONSTRAINT fk_categoria_tipoproduto
		FOREIGN KEY(ID_Categoria) REFERENCES tblCategoria(IDCategoria)

go
ALTER TABLE tblProduto
	ADD CONSTRAINT fk_produto_produto
		FOREIGN KEY(ID_TipoProduto) REFERENCES tblTipoProduto(IDTipoProduto)
		
go
ALTER TABLE tblProduto
	ADD CONSTRAINT fk_pedido_produto
		FOREIGN KEY(ID_Pedido) REFERENCES tblPedido(IDPedido)

go
ALTER TABLE tblProduto
	ADD CONSTRAINT fk_cliente_produto
		FOREIGN KEY(ID_Cliente) REFERENCES tblCliente(IDCliente)

go
ALTER TABLE tblPedido
	ADD CONSTRAINT fk_status_pedido
		FOREIGN KEY(ID_Status) REFERENCES tblStatusPedido(IDStatus)
		
--Constraints de check
go
ALTER TABLE tblCliente
	ADD CONSTRAINT ck_genero_cliente
		CHECK(genero IN(0,1,2,9))
		
go
ALTER TABLE tblFuncionario
	ADD CONSTRAINT ck_genero_funcionario
		CHECK(genero IN(0,1,2,9))

go
ALTER TABLE tblFuncionario
	ADD CONSTRAINT ck_nivelacesso_funcionario
		CHECK(nivel_acesso IN(0,1,2))
		
--Adicionando Index nas tabelas
go
CREATE INDEX XCliente ON tblCliente(IDCliente)

go
CREATE INDEX XFuncionario ON tblFuncionario(IDFuncionario)

go
CREATE INDEX XTransportadora ON tblTransportadora(IDTransportadora)

go
CREATE INDEX XFornecedor ON tblFornecedor(IDFornecedor)

go
CREATE INDEX XPromocao ON tblPromocao(IDPromocao)

go
CREATE INDEX XPedido ON tblPedido(IDPedido)

go
CREATE INDEX XProduto ON tblProduto(IDProduto)

go
CREATE INDEX XTipoProduto ON tblTipoProduto(IDTipoProduto)

go
CREATE INDEX XSecao ON tblSecao(IDSecao)

go
CREATE INDEX XCategoria ON tblCategoria(IDCategoria)


 --INSERT


go
insert into tblFornecedor(nome,CNPJ, tel1, email,endereco, CEP) values
	('Jean-Luc Caminhıes', '123456789012345678', '11963510115','miguel.velasques@gmail.com', 'Av. Tiradentes, 3174','04195715')

go
insert into tblSecao(nome, descricao) values ('Cordas','Instrumentos de Cordas'), ('Percuss„o','Instrumentos de Percuss„o')

go
insert into tblCategoria(ID_Secao,nome, descricao) values (1,'Violıes','Guitarras Ac˙sticas'), (2,'Cajons','Parte de Baterias'),
	(2,'Baterias','Grupos de Cajons')

go
insert into tblTipoProduto(ID_Fornecedor, ID_Categoria, nome, preco_unitario, descricao, imagem) values
	(1,1,'Viol„o Fender Listrado', 2999.99, 'Um viol„o top', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao1.jpg', SINGLE_BLOB) AS img_data)),
	(1,1,'Viol„o Takamine de Boca Oval', 3499.99, 'Boca meio estranha, mas okay', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao2.jpg', SINGLE_BLOB) AS img_data)),
	(1,1,'Viol„o Tagima Pastoral', 999.99, 'O mais padr„ozinho', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao3.jpg', SINGLE_BLOB) AS img_data)),
	(1,1,'Viol„o Tagima Claro', 1399.99, 'Deitado clarinho', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao4.jpg', SINGLE_BLOB) AS img_data)),
	(1,1,'Viol„o Fender Madeira Desenhada', 1749.99, 'Parece um mapa', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao5.jpg', SINGLE_BLOB) AS img_data)),
	(1,1,'Viol„o Tagima Preto', 1299.99, 'Tipo o seu fino, mas grosso', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\violao6.jpg', SINGLE_BLOB) AS img_data))
	
go
insert into tblTipoProduto(ID_Fornecedor, ID_Categoria, nome, preco_unitario, descricao, imagem) values
	(1,2,'Cajon Rosa dos Ventos', 4963, 'N„o se perca no ritmo', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\cajon1.jpg', SINGLE_BLOB) AS img_data)),
	(1,2,'Cajon Fundo Preto', 4963, 'Parece feito em css', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\cajon2.png', SINGLE_BLOB) AS img_data)),
	(1,2,'Cajon Todo Preto', 4963, 'Acompanha cabos de festa', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\cajon3.jpg', SINGLE_BLOB) AS img_data)),
	(1,2,'Cajon Indicativo', 4963, 'Mostre o caminho', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\cajon4.jpg', SINGLE_BLOB) AS img_data))


go
insert into tblTipoProduto(ID_Fornecedor, ID_Categoria, nome, preco_unitario, descricao, imagem) values
	(1,3,'Bateria Azul', 1649.99, 'T· tudo bem', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\bateria1.jpg', SINGLE_BLOB) AS img_data)),
	(1,3,'Bateria Clara', 749.99, 'Claramente boa', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\bateria2.jpg', SINGLE_BLOB) AS img_data)),
	(1,3,'Bateria Marrom', 1249.99, 'Braum', 
	(SELECT * FROM OPENROWSET(BULK N'C:\Users\Public\Pictures\TesteSQL\bateria3.jpg', SINGLE_BLOB) AS img_data))

go
insert into tblProduto(ID_TipoProduto) values(1),(1),(2),(2),(2),(3),(4),(5),(5),(5),(6),(6),(6),(6),(7),(8),(8),(9),(10),(10),(11),(12),(12),(12),(13),(13)

go
insert into tblCliente(nome,tel1, email, senha, cpf, endereco, cep, genero) values
	('Miguel Velasques', '11 96351-0115', 'miguel.velasques@gmail.com', 'salve1234', '820.591.720-55', '615 ', '01101-010', 9)

-- PROCEDURES

-- go
-- drop procedure readProductData

go
create procedure readProductData
@IDTipo int
as
begin
	select
		(select nome from tblCategoria c where tp.ID_Categoria = c.IDCategoria) Categoria_name,
			(select s.nome from tblSecao s where s.IDSecao = 
				(select c.ID_Secao from tblCategoria c where tp.ID_Categoria = c.IDCategoria)) as Secao_name,
					nome, preco_unitario, descricao, imagem
						from tblTipoProduto tp where tp.IDTipoProduto = @IDTipo
end

exec readProductData 12


select * from tblProduto

select *,
	(select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) as ammouht
		from tblTipoProduto tp	
			where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0
				and LOWER(tp.nome) like '%%'
					and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c 
						where c.nome like '%vi%' or c.nome like '%ca%' or c.nome like '%%')
							order by tp.preco_unitario desc
							
select *, (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) as ammount from tblTipoProduto tp where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0 and tp.nome like '%%' and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c where c.nome like '%vi%' or c.nome like '%ca%' or c.nome like '%%') order by tp.preco_unitario desc

select nome,preco_unitario, descricao, (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) as ammount
	 from tblTipoProduto tp where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0 
		and tp.nome like '%%' and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c 
			where c.nome like '%Baterias%' or c.nome like '%%' or c.nome like '%%') order by tp.preco_unitario desc

			select count(*) from tblTipoProduto tp where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0 and lower(tp.nome) like '%[a·‡„‰‚]%' and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c where c.nome like '%%' or c.nome like '%%' or c.nome like '%%')
select imagem from tblTipoProduto
	where IDTipoProduto = 1

select top 3 nome from tblCategoria
	where lower(nome) like '%v%'

select count(*) from tblProduto
	where ID_TipoProduto = 2

	select IDTipoProduto, nome, preco_unitario from tblTipoProduto where IDTipoProduto in (12,8)



select * from tblCliente

exec readProductData 3