
-- Script para inserir informações padrão na base Concentrador

-- Variaveis utilizadas no Script:
SET @pdv = 1;
SET @ipPdv = '127.0.0.2';
SET @ipMatriz = '127.0.0.1';
SET @ipTef = '162.168.0.135';

-- Configuracao Importação Tabela-- 
INSERT INTO configuracao_importacao_tabela VALUES (1,2,0,100),(1,3,0,100),(1,4,0,100),(1,5,0,100),(1,6,0,100),(1,9,0,100),(1,178,0,100),(1,179,0,100);

-- Secao Grupo Subgrupo -- 
INSERT INTO secao_grupo_subgrupo VALUES (1,0,0,0,'SECAO 1','',0.00,0,0,0,0,0),(1,1,0,0,'GRUPO 1','',0.00,0,0,0,0,0),(1,1,1,0,'SUBGRUPO 1','',0.00,0,0,0,0,0);

-- Natureza Fiscal Estado -- 
INSERT INTO natureza_fiscal_estado VALUES ('F','AC'),('I','AC'),('N','AC'),('T07','AC'),('T12','AC'),('T17','AC'),('T18','AC'),('T25','AC'),('F','AL'),('I','AL'),('N','AL'),('T07','AL'),('T12','AL'),('T17','AL'),('T18','AL'),('T25','AL'),('F','AM'),('I','AM'),('N','AM'),('T07','AM'),('T12','AM'),('T17','AM'),('T18','AM'),('T25','AM'),('F','AP'),('I','AP'),('N','AP'),('T07','AP'),('T12','AP'),('T17','AP'),('T18','AP'),('T25','AP'),('F','BA'),('I','BA'),('N','BA'),('T07','BA'),('T12','BA'),('T17','BA'),('T18','BA'),('T25','BA'),('F','CE'),('I','CE'),('N','CE'),('T07','CE'),('T12','CE'),('T17','CE'),('T18','CE'),('T25','CE'),('F','DF'),('I','DF'),('N','DF'),('T07','DF'),('T12','DF'),('T17','DF'),('T18','DF'),('T25','DF'),('F','ES'),('I','ES'),('N','ES'),('T07','ES'),('T12','ES'),('T17','ES'),('T18','ES'),('T25','ES'),('F','GO'),('I','GO'),('N','GO'),('T07','GO'),('T12','GO'),('T17','GO'),('T18','GO'),('T25','GO'),('F','MA'),('I','MA'),('N','MA'),('T07','MA'),('T12','MA'),('T17','MA'),('T18','MA'),('T25','MA'),('F','MG'),('I','MG'),('N','MG'),('T07','MG'),('T12','MG'),('T17','MG'),('T18','MG'),('T25','MG'),('F','MS'),('I','MS'),('N','MS'),('T07','MS'),('T12','MS'),('T17','MS'),('T18','MS'),('T25','MS'),('F','MT'),('I','MT'),('N','MT'),('T07','MT'),('T12','MT'),('T17','MT'),('T18','MT'),('T25','MT'),('F','PA'),('I','PA'),('N','PA'),('T07','PA'),('T12','PA'),('T17','PA'),('T18','PA'),('T25','PA'),('F','PB'),('I','PB'),('N','PB'),('T07','PB'),('T12','PB'),('T17','PB'),('T18','PB'),('T25','PB'),('F','PE'),('I','PE'),('N','PE'),('T07','PE'),('T12','PE'),('T17','PE'),('T18','PE'),('T25','PE'),('F','PI'),('I','PI'),('N','PI'),('T07','PI'),('T12','PI'),('T17','PI'),('T18','PI'),('T25','PI'),('F','PR'),('I','PR'),('N','PR'),('T07','PR'),('T12','PR'),('T17','PR'),('T18','PR'),('T25','PR'),('F','RJ'),('I','RJ'),('N','RJ'),('T07','RJ'),('T12','RJ'),('T17','RJ'),('T18','RJ'),('T25','RJ'),('F','RN'),('I','RN'),('N','RN'),('T07','RN'),('T12','RN'),('T17','RN'),('T18','RN'),('T25','RN'),('F','RO'),('I','RO'),('N','RO'),('T07','RO'),('T12','RO'),('T17','RO'),('T18','RO'),('T25','RO'),('F','RR'),('I','RR'),('N','RR'),('T07','RR'),('T12','RR'),('T17','RR'),('T18','RR'),('T25','RR'),('F','RS'),('I','RS'),('N','RS'),('T07','RS'),('T12','RS'),('T17','RS'),('T18','RS'),('T25','RS'),('F','SC'),('I','SC'),('N','SC'),('T07','SC'),('T12','SC'),('T17','SC'),('T18','SC'),('T25','SC'),('F','SE'),('I','SE'),('N','SE'),('T07','SE'),('T12','SE'),('T17','SE'),('T18','SE'),('T25','SE'),('F','SP'),('I','SP'),('N','SP'),('T07','SP'),('T12','SP'),('T17','SP'),('T18','SP'),('T25','SP'),('F','TO'),('I','TO'),('N','TO'),('T07','TO'),('T12','TO'),('T17','TO'),('T18','TO'),('T25','TO');

-- Produto -- 
INSERT INTO produto VALUES (1,0,0,1,0,0,'F','Produto Teste 001','Produto Teste 001','UN',0,'SP',0,0,0,0.000,0,0.00,0,0,0,'','2019-01-31',NULL,NULL,0,0,0,'','',0,0,0,0,0,0,0,0,0,'Produto Teste 001','','T',0,0,0.000,0.00,0,0,0,'SNsz43etZyUyPdewxSql8ZWTQW52PVWQPNJCGRsJP454Erhsk6NzCtWT0koCSkZXhzGnwBIQcPIN2TJcDuY0CBREP67xpx+29JefRIX3sm1H4EHk',''),(2,0,0,1,0,0,'F','Produto Teste 002','Produto Teste 002','UN',0,'SP',0,0,0,0.000,0,0.00,0,0,0,'','2019-01-31',NULL,NULL,0,0,0,'','',0,0,0,0,0,0,0,0,0,'Produto Teste 002','','T',0,0,0.000,0.00,0,0,0,'SNsz43etZyUyPdewxSql8ZWTQW52PVWQPNJCGRgJP454Erhsk6NzCtWT0koCSkZXhzGnwBIQcPIN2TJcDuY0CBREP67xpx+29JefRIX3sm1E4EHk','');

-- EAN -- 
INSERT INTO ean VALUES (1,1,1.000,'UN',0,'2019-02-07',1.000,0,'',0,0,0.000),(2,2,1.000,'UN',0,'2019-02-07',1.000,0,'',0,0,0.000),(7896036090244,2,1.000,'UN',0,'2019-02-08',1.000,0,'',0,0,0.000),(7896290300011,1,1.000,'UN',0,'2019-02-08',1.000,0,'',0,0,0.000);

-- Nivel Preço Produto --
INSERT INTO nivel_preco_produto VALUES (1,1,'2019-02-07',1.00,'2019-02-07',0.000,0.00,'SNst+G6sfgEveo6ktzul8YmAQRw+KROVOtgDTAgfLJBq'),(1,2,'2019-02-07',2.00,'2019-02-07',0.000,0.00,'SNst+G6sfgEveo6ktzul8YmAQRw+KROVOtgDTAgfL5Bq');

-- NCM Produto 1 e 2
INSERT INTO cfg_ncm VALUES (1,0,0,0,22021000,'2019-02-08', 0);
 
-- Cest Produtos 1 e 2
INSERT INTO cad_mnc_cod_cest VALUES (1,0,0,0,'0300700','2019-02-08');

-- CFOP Produtos 1 e 2
INSERT INTO cad_cfop_prd VALUES (1,0,0,0,5102,'2019-02-08');

-- Origem Produtos 1 e 2
INSERT INTO cad_ori_prd VALUES (1,0,0,0,0,'2019-02-08');

-- Finalizadoras -- 
INSERT INTO finalizadora VALUES (2,4,'CREDITO',1, 3, 0, 0, 0, 0, 0,'CR',''),(3,4,'DEBITO',1,2,0,0,0,0,0,'DB',''),(4,4,'CARTEIRA ELETRONICA',1,13,0,0,0,0,0,'CE','');

-- Finalizadora Loja -- 
INSERT INTO finalizadora_loja VALUES (1,1,1,0.00,0.00,0.00,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,'2019-01-31',0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,'','','','','',0,0,0,0,0,NULL,NULL,0.00,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0),(1,2,2,0.00,0.00,0.00,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,'2019-02-04',0,0,0,0,0,1,0,0,0,0,0,0,0.00,0,0,0,0,'','','','','',0,0,0,0,0,NULL,NULL,0.00,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0),(1,3,3,0.00,0.00,0.00,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,'2019-01-31',0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,'','','','','',0,0,0,0,0,NULL,NULL,0.00,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0),(1,4,4,0.00,0.00,0.00,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,'2019-02-04',0,0,0,0,0,1,0,0,0,0,0,0,0.00,0,0,0,0,'','','','','',0,0,0,0,0,NULL,NULL,0.00,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0);

-- PDV -- 
update pdv set ip_pdv = @ipPdv , desativa_contr_abert_fecham = 1, situacao_pdv = 1 WHERE codigo_pdv = @pdv;

-- Configuração Loja -- 
update configuracao_loja set codigo_nivel = 1, ip_matriz = @ipMatriz, ip_tef = @ipTef, codigo_empresa_sitef = '00000000', codigo_nivel = 1, codigo_nivel_padrao = 1 where codigo_loja = 1;  
 
-- Carga Loja -- 
INSERT INTO cfg_carga_prc_loj VALUES (1,1);
 
-- Hardware Pdv --  
 UPDATE hardware_pdv SET codigo_hardware = 0 WHERE codigo_hardware <> 21 AND codigo_pdv = @pdv;
 INSERT INTO hardware_pdv VALUES (@pdv,21,'NENHUM',0,0,'',0,0,0,0,0,0,0,1,'SOCIN',0,0,0,0,0,0,'',0,0,0);

 -- Usuário -- 
INSERT INTO usuario_perfil VALUES (1,1),(1,2),(1,4);
