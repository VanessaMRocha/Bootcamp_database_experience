-- Criação do Banco de Dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
	idClient int auto_increment primary key,
    nomeRazao varchar(45) not null,
    cpfCnpj varchar(14) not null,
	endereco varchar(45),
    tipo enum('PJ','PF') not null,
    dataNacimentoAbertura date,
    telefone int not null,
    constraint unique_cpfcnpj_cliente unique(cpfCnpj)
    );

alter table cliente auto_increment=1;
   
-- criar tabela produto
create table produto(
	idProduto int auto_increment primary key,
    produtoDescricao varchar(255),
    valor float not null,
    categoria enum('Alimentação', 'Casa', 'Brinquedo', 'Vestuário', 'Pet', 'Eletronicos') default 'Casa',
    pNome varchar(10) not null,
    avaliacao float,
    constraint unique_pNome unique(pNome)
    );
    
-- criar tabela pedido
create table pedido(
	idPedido int auto_increment primary key,
    idCliente int not null,
    pedidoDescricao varchar(255),
    statusPedido enum('Em andamento', 'Processando', 'Enviado', 'Entregue', 'Cancelado') default 'Processando',
    frete float default 10,
    constraint fk_pedido_cliente foreign key (idCliente) references cliente(idCliente)
    );
    
-- criar tabela cartao
create table cartao(
	idCartao int auto_increment primary key,
    cartaoNum char(16) not null,
    bandeira enum('Elo', 'Visa', 'Master', 'Amex', 'Outros') default 'Outros',
    vencimento date not null,
    idCliente int not null,
    constraint fk_cartao_cliente foreign key (idCliente) references cliente(idCliente)
    );

-- criar tabela estoque
create table estoque(
	idEstoque int auto_increment primary key,
    localidade varchar(45),
    );
    
-- criar tabela fornecedor
create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoFornecedor varchar(45) not null,
    cnpjFornecedor char(14) not null,
    endereco varchar(45),
    contato char(11) not null,
    constraint unique_cnpj_fornecedor unique(cnpjFornecedor)
    );
    
-- criar tabela vendedor
create table vendedor(
	idVendedor int auto_increment primary key,
    razaoVendedor varchar(45) not null,
    cpfCnpj char(14) not null,
    endereco varchar(45),
    contato char(11) not null,
    nomeFantasia varchar(45),
    tipo enum('PJ','PF') not null,
    constraint unique_cpfCnpj_vendedor unique(cpfCnpj)
    );
    
-- criar tabela entrega
create table entrega(
	idEntrega int auto_increment primary key,
    idPedido int not null,
    statusEntrega enum('Em transporte', 'Entregue', 'Cancelada', 'Não entregue') default 'Em transporte',
    rastreio varchar(45),
    formaDeEntrega varchar(45),
    constraint fk_entrega_pedido foreign key (idPedido) references pedido(idPedido)
    );
    
-- criar tabela produto_vendedor
create table produto_vendedor(
	idVendedor int not null,
    idProduto int not null,
    quantidade int default 1,
    constraint primary key (idVendedor,idProduto),
    constraint fk_produtovend_vendedor foreign key (idVendedor) references vendedor(idVendedor),
    constraint fk_produtovend_produto foreign key (idProduto) references produto(idProduto)
    );
    
-- criar tabela produto_fornecedor
create table produto_fornecedor(
	idFornecedor int not null,
    idProduto int not null,
    quantidade int default 1,
    constraint primary key (idFornecedor,idProduto),
    constraint fk_produtofornec_fornecedor foreign key (idFornecedor) references fornecedor(idFornecedor),
    constraint fk_produtofornec_produto foreign key (idProduto) references produto(idProduto)
    );

-- criar tabela produto_pedido
create table produto_pedido(
	idPedido int not null,
    idProduto int not null,
    quantidade int default 1,
    statusPPedido enum('Disponível', 'Sem estoque') default 'Disponível',
    constraint primary key (idPedido,idProduto),
    constraint fk_produtoped_pedido foreign key (idPedido) references pedido(idPedido),
    constraint fk_produtoped_produto foreign key (idProduto) references produto(idProduto)
    );

-- criar tabela produto_estoque
create table produto_estoque(
	idEstoque int not null,
    idProduto int not null,
    quantidade int default 1,
    constraint primary key (idEstoque,idProduto),
    constraint fk_produtoest_estoque foreign key (idEstoque) references pedido(idEStoque),
    constraint fk_produtoest_produto foreign key (idProduto) references produto(idProduto)
    );

show tables;
    
insert into cliente (nomeRazao,cpfCnpj,endereco,tipo,dataNacimentoAbertura,telefone)
	  values('Maria Melo Silva',12345678966,'Av das Flores 24, Segismundo - Uberlandia/MG','PF','10-07-2000',34988080709),
			('Vanessa Moura Rocha',06325526627,'Av Prof José Inácio Souza 645, Brasil - Uberlandia/MG','PF','01-11-1982',34988080500),
            ('Marcos Augusto de Melo',99987065412,'Av Rondon Pacheco 11, Centro - Uberlandia/MG','PF','02-10-1973',34999121261),
            ('Joana Darc Moura',23979097000112,'Av Nosso Lar 23, Copacabana - Rio de Janeiro/MG','PJ','10-07-1982',3432322595);
            
insert into produto(produtoDescricao, valor, categoria, pNome, avaliacao)
values('Nootebook Dell', 2000, 'Eletronicos', 'Nootebook Dell', 4.5),
	  ('Tênis de corrida', 500, 'Vestuário', 'Nike Pegasus', 4),
      ('Boneca', 300, 'Brinquedos', 'Baby Alive', 4.9);
    
insert into pedido(idCliente, pedidoDescricao, statusPedido, frete)
values(1, 'Nootebook e tenis de corrida', default, default),
      (2, 'Boneca', 'Em andamento', 30);

insert into cartao( cartaoNum, bandeira, vencimento, idCliente)
values(1243567809873468, 'Visa', 2023-10-31, 1),
	  (0976172456098234, 'Master', 2030-11-01, 2),
      (8383838383838213, default, 2022-12-25, 4);
      
insert into estoque(localidade)
values('Uberlândia'),
	  ('Caldas Novas'),
      ('São Paulo'),
      ('Rio de Janeiro');
      
insert into fornecedor(razaoFornecedo, cnpjFornecedor, endereco, contato)
values('Farm Vestuário',09123789000180, null, 3432322595),
('Dell Computers',67234908000123, null, 67990897645),
('Nike', 34567987000245, null, 2167895434);

insert into vendedor( razaoVendedor, cpfCnpj, endereco, contato, nomeFantasia, tipo)
values('Farm Vestuário',09123789000180, null, 3432322595,null, 'PJ'),
('Dell Computers',67234908000123, null, 67990897645, null, 'PJ'),
('Nike', 34567987000245, null, 2167895434, null, 'PJ'),
('Vanessa Moura da Rocha', 06325526627, null, 34988080500, null, 'PF');

insert into entrega(idPedido, statusEntrega, rastreio, formaDeEntrega)
values(1, default, null, null),
      (2,'Cancelada', null, null);
      
insert into produto_vendedor(idVendedor, idProduto, quantidade)
values(2,1,default),
	  (3,2,10),
      (4,3,2);
    
insert into produto_fornecedor(idFornecedor, idProduto, quantidade)
values(2,1,10),
	  (3,2,5);

insert into produto_pedido(idProduto, idPedido, quantidade, statusPPedido)
values(1,2,default, default),
      (1,1,default,default),
      (2,3,2,'Sem estoque');

insert into produto_estoque( idEstoque,idProduto,quantidade)
values(1,1,10),
	  (2,3,5);

-- Ver os dados da tabela produto_vendedor      
select * from produto_vendedor;

-- Contar a quantidade de clientess
select count(*) from cliente;

-- Visualizar os clientes e seus respectivos pedidos 
select * from cliente c, pedido p where c.idCliente = p.idCliente;

-- Visualizar dados específicos dos clientes e seus pedidos 
select nomeRazao, idPedido, statusPedido from cliente c, pedido p where c.idCliente = p.idCliente;

-- Ver quantidade de pedidos que foram realizados pelos clientes
select count(*) from cliente c, pedido p 
where c.idCliente = p.idCliente;

-- Recuperar quantos pedidos foram realizados por cada cliente
select c.idCliente, c.nomeRazao, count(*) from cliente c left outer join pedido p on c.idCliente = p.idCliente
					  inner join produto_pedido pp on pp.idPedido = p.idPedido
                      group by idCliente;
