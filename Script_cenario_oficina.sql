/****** Script do comando SelectTopNRows de SSMS  ******/

-- Criar tabela cliente
create table [7829].[dbo].[teste_cliente](
	idCliente int identity primary key not null,
	nome varchar(45) not null,
	endereco varchar(45),
	telefone varchar(45),
	cpf char(11) not null,
	constraint unique_cpf_cliente unique(cpf))



-- Criar tabela veiculo
create table [7829].[dbo].[teste_veiculo](
	idVeiculo int identity primary key not null,
	marca varchar(45) not null,
	modelo varchar(45),
	ano char(4),
	placa char(7) not null,
	renavam varchar(45),
	idCliente int not null,
	constraint fk_veiculo_cliente foreign key(idCliente) references teste_cliente(idCliente)
	)	

-- Criar tabela mao_de_obra
create table [7829].[dbo].[teste_mao_de_obra](
	idMaodeobra int identity primary key not null,
	especialidade varchar(45),
	valorHora float	)	

-- Criar tabela equipe
create table [7829].[dbo].[teste_equipe](
	idEquipe int identity primary key not null,
	responsavel varchar(45))

-- Criar tabela mecanico
create table [7829].[dbo].[teste_mecanico](
	idMecanico int identity primary key not null,
	nome varchar(45) not null,
	endereco varchar(45) not null,
	contato int not null,
	cpf char(11) not null,
	idMaodeobra int not null,
	idEquipe int not null,
	constraint unique_cpf_mecanico unique(cpf),
	constraint fk_mecanico_maodeobra foreign key (idMaodeobra) references [teste_mao_de_obra](idMaodeobra),
	constraint fk_mecanico_equipe foreign key (idEquipe) references [teste_equipe](idEquipe))

-- Criar tabela peça
create table [7829].[dbo].[teste_peca](
	idPeca int identity primary key not null,
	nomePeca varchar(45) not null,
	descricao varchar(100),
	valor float)

-- Criar tabela Ordem de Serviço
create table [7829].[dbo].[teste_os](
	idOS int identity primary key not null,
	tipoServico varchar(45) not null,
	dtConclusao date,
	dtInicio date not null,
	valor float not null, 
	status varchar(12) check (status in('Em espera','Em andamento','Concluído')) default 'Em espera',
	idVeiculo int not null,
	idEquipe int not null,
	constraint fk_os_veiculo foreign key (idVeiculo) references [teste_veiculo](idVeiculo),
	constraint fk_os_equipe foreign key (idEquipe) references [teste_equipe](idEquipe))

-- Criar tabela demanda de mão de obra
create table [7829].[dbo].[teste_demanda_maodeobra](
	idOS int not null,
	idMaodeobra int not null,
	horasTrabalhadas int not null,
	primary key (idOS,idMaodeobra),
    constraint fk_demanda_maodeobra foreign key (idMaodeobra) references [teste_mao_de_obra](idMaodeobra),
    constraint fk_demanda_OS foreign key (idOS) references [teste_os](idOS))

-- Criar tabela demanda de peças
create table [7829].[dbo].[teste_demanda_pecas](
	idPeca int not null,
	idOS int not null,
	quantidade int not null,
	primary key (idOS,idPeca),
    constraint fk_demandapeca_peca foreign key (idPeca) references [teste_peca](idPeca),
    constraint fk_demandapeca_OS foreign key (idOS) references [teste_os](idOS))

-- Inserir dados nas tabelas
 INSERT INTO [7829].[dbo].[teste_cliente](
	   [nome]
      ,[endereco]
      ,[telefone]
      ,[cpf])
  VALUES ('Vanessa Moura da Rocha', null, null, 06325526627),
		 ('Marcos Augusto de Melo', null, null, 99931642289),
		 ('Joana Darc Moura', null, null, 23979097668),
		 ('Divina Maria de Jesus', null, null, 23945689214),
		 ('Adelina Maria de Rezende',null,null, 52674589611)

  INSERT INTO [7829].[dbo].[teste_veiculo] (
       [marca]
      ,[modelo]
      ,[ano]
      ,[placa]
      ,[renavam]
      ,[idCliente])
  VALUES ('Honda', null, null, 'QPH1I39',null,1),
		 ('VW',null,null,'SOP1P56',null,2),
		 ('Fiat',null,null,'ERT5P84',null,3),
		 ('Mercedes',null,null,'RTU5U42',null,4),
		 ('BMW',null,null,'XOT9L43',null,1)

  INSERT INTO [7829].[dbo].[teste_peca](
	   [nomePeca]
      ,[descricao]
      ,[valor])
  VALUES ('parafuso', null, 5.00),
         ('pneu',null, 400),
		 ('motor',null, 10000),
		 ('vidro traseiro',null, 5620.10)

  INSERT INTO [7829].[dbo].[teste_equipe](
      [responsavel])
  VALUES('Pedro'),
        ('André'),
		('Ricardo'),
		('Júlio')

 INSERT INTO [7829].[dbo].[teste_mao_de_obra](
       [especialidade]
      ,[valorHora])
 VALUES ('motor', 50),
	   ('cambio',30),
	   ('pequenas pecas', 20),
	   ('assoalho', 40)

 INSERT INTO [7829].[dbo].[teste_mecanico](
       [nome]
      ,[endereco]
      ,[contato]
      ,[cpf]
      ,[idMaodeobra]
      ,[idEquipe])
 VALUES ('Joaquim','Av. Jardin, 54', 988215675, 05314896547, 5, 1),
        ('Ronaldo', 'Rua das Américas, 859', 995462158, 14523685369, 6, 2),
    	('Licurgo', 'Av. das Acácias, 52', 985261453, 01236514825, 6, 1),
		('Luciano', 'Rua Três Lagoas, 10', 988142535, 01236514578, 7,4)

  INSERT INTO [7829].[dbo].[teste_os](
       [tipoServico]
      ,[dtConclusao]
      ,[dtInicio]
      ,[valor]
      ,[status]
      ,[idVeiculo]
      ,[idEquipe])
  VALUES ('retificação do motor', null, '2022-11-04',5000,default,1,1),
		 ('limpeza da ignição',null, '2022-10-02', 500, 'Em andamento',2,3),
		 ('troca das válvulas', null, '2022-11-01', 1000, 'Concluído',3,2)

  INSERT INTO [7829].[dbo].[teste_demanda_maodeobra](
	   [idOS]
      ,[idMaodeobra]
      ,[horasTrabalhadas])
  VALUES (1, 5, 20),
         (1, 6, 10),
		 (2, 7, 5),
		 (3, 7, 15) 

  INSERT INTO [7829].[dbo].[teste_demanda_pecas] (
       [idPeca]
      ,[idOS]
      ,[quantidade])
  VALUES (1, 1, 1),
	     (3, 1, 5),
		 (2, 2, 1),
		 (3, 3, 10)


-- Visualizar todos os clientes da oficina
SELECT * FROM [7829].[dbo].[teste_cliente]

-- Contar a quantidade de clientes
SELECT COUNT(*) FROM [7829].[dbo].[teste_cliente]

-- Visualizar as ordens de serviço que estão 'em andamento'
SELECT * FROM [7829].[dbo].[teste_os] where status = 'Em andamento'

--Visualizar as informações dos clientes e veículos das ordens de serviço existentes
SELECT c.nome, c.cpf, v.marca, v.placa, idOS, os.tipoServico, os.valor, os.status FROM [7829].[dbo].[teste_cliente] c, teste_veiculo v, teste_os os where c.idCliente = v.idCliente and v.idVeiculo = os.idVeiculo

--Visualizar todos os mecânicos da Equipe 1
select e.idEquipe, e.responsavel, m.nome from teste_equipe e join teste_mecanico m on e.idEquipe = m.idEquipe
where idEquipe = 1

--Visualisar as peças demandadas por ordem de serviço
select os.tipoServico, os.dtInicio, os.valor, os.status, p.nomePeca from teste_demanda_pecas d join teste_os os on os.idOS = d.idOS
			  join teste_peca p on p.idPeca = d.idPeca


