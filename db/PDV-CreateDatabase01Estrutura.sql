DROP DATABASE IF EXISTS pdv;

CREATE DATABASE IF NOT EXISTS pdv;

USE pdv;

create table controle_versao_bd (
  id integer not null,
  versao VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
) ENGINE = INNODB;


create table gerenciador_keycode_funcao (
	cod_loj integer not null,
	id integer not null,
	id_gerenciador integer not null,
	key_code integer not null,
	id_funcao integer not null,
	id_modifier integer not null,
	primary key (cod_loj, id, id_gerenciador, key_code, id_modifier)
) ENGINE = innodb;

create table pdv (
	numero_pdv integer not null,
	primary key (numero_pdv)
) ENGINE = innodb;

CREATE TABLE configuracao_pesquisa_produto (
  codigo_loja integer not null,
  pesquisar_codigo tinyint(1) not null default 1,
  pesquisar_descricao tinyint(1) not null default 1,
  pesquisar_titulo tinyint(1) not null default 0,
  pesquisar_autor tinyint(1) not null default 0,
  pesquisar_assunto tinyint(1) not null default 0,
  pesquisar_editora tinyint(1) not null default 0,
  pesquisar_palavrachave tinyint(1) not null default 0,  
  exibir_codigo_interno tinyint(1) not null default 1,
  exibir_codigo_ean tinyint(1) not null default 1,
  exibir_descricao tinyint(1) not null default 1,
  exibir_preco tinyint(1) not null default 1,
  exibir_preco_moeda tinyint(1) not null default 0,
  exibir_secao tinyint(1) not null default 0,
  exibir_grupo tinyint(1) not null default 0,
  exibir_subgrupo tinyint(1) not null default 0,
  exibir_autor tinyint(1) not null default 0,
  exibir_editora tinyint(1) not null default 0,
  mostrar_somente_teclado tinyint(1) not null default 0,
  qtd_gegistro_pesq integer not null default 100,
  pesq_somente_codigo_interno tinyint(1) not null default 0,
  numero_maximo_pesquisa integer not null default 0,
  venda_bloquear_pesq_prod tinyint(1) not null default 0,
  ordem_visualizacao integer not null default 0,
  pesquisar_somente_iniciais tinyint(1) not null default 0,
  exibir_preco_nao_contribuinte tinyint(1) not null default 0,
  dif_ean tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = INNODB;

CREATE TABLE configuracao_posicao_operador (
  codigo_loja integer not null,
  listar_venda1 tinyint(1) not null default 0,
  listar_venda3 tinyint(1) not null default 0,
  listar_receb_cartao_riach tinyint(1) not null default 0,
  listar_novacao_divida tinyint(1) not null default 0,
  listar_produto_financeiro tinyint(1) not null default 0,
  listar_outros_recebimentos tinyint(1) not null default 0,
  listar_pagamentos_tef tinyint(1) not null default 0,
  listar_entrada_cartao tinyint(1) not null default 0,
  listar_venda_cartao_presente tinyint(1) not null default 0,
  listar_cobre_cheque tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = INNODB;

create table hardware_pdv (
  numero_pdv integer not null,
  tipo_hardware integer not null,
  codigo_hardware integer not null,
  fabricante varchar(20) not null,
  versao varchar(20) not null,
  device_tipo_hw integer not null,
  device_versao_hw integer not null,
  porta_serial varchar(20),
  velocidade integer,
  tamanho integer,
  paridade varchar(1),
  bits_parada integer,
  cmc7_externo tinyint(1) default 0, 
  cmc7_imprime_cheque tinyint(1) default 0,
  cmc7_aceita_digitar tinyint(1) default 0,
  teclado_usa_visor tinyint(1) default 0,
  teclado_delay integer,
  teclado_timeout integer,
  pin_pad_compartilhado tinyint(1) default 0, 
  msg_padrao_pin_pad varchar(16) not null,
  scanner_com_balanca tinyint(1) default 0,
  ecf_truncar tinyint(1) default 0,
  ecf_subtrair_posicao_finalizadora tinyint(1) default 0,
  modo_impr_paralela integer,
  timeout_impr_paralela integer,
  timeout_impr_serial integer,
  tipo_device integer not null default 0,
  teclado_sleep integer,
  habilitar_bip_scanner tinyint(1) not null default 0,
  primary key(numero_pdv, tipo_hardware)
) ENGINE = innodb;

CREATE TABLE numero_serie_ecf_loja (
  numero_serie varchar(128) not null,
  PRIMARY KEY(numero_serie)
) ENGINE = INNODB;

CREATE TABLE liberacao_pdv (
  numero_pdv integer not null,
  data_instalacao BLOB not null,
  data_expiracao BLOB not null,
  PRIMARY KEY(numero_pdv)
) ENGINE = INNODB;

create table natureza_fiscal (
  codigo_natureza varchar(3) not null,
  descricao varchar(20) not null,
  icm double(16,2) not null,
  percentual_acrescimo double(16,2) not null,
  mensagem varchar(120) not null, 
  seq_totalizador_ecf integer not null, 
  percentual_acrescimo_atacado double(16,2) not null,	
  cripto varchar(255),
  iss TINYINT NOT NULL DEFAULT 0 ,
  primary key(codigo_natureza)
) ENGINE = innodb;

create table tributacao_ecf (
  codigo_hardware integer not null,
  codigo_natureza varchar(3) not null,
  codigo_tributacao varchar(3) not null,
  codigo_tributacao_ret varchar(20) not null default '',
  primary key(codigo_hardware,codigo_natureza)
) ENGINE = innodb;

create table finalizadora (
  codigo_finalizadora integer not null,
  codigo_finalizadora_ecf integer not null,
  tipo_finalizadora integer not null,
  descricao varchar(20) not null,
  tef tinyint(1) not null default 0,
  tipo_transacao integer,  
  limite_troco double(16,2) not null,
  minimo_venda double(16,2) not null,
  maximo_venda double(16,2) not null,
  autentica tinyint(1) not null default 0,
  abre_gaveta tinyint(1) not null default 0,
  limite_sangria double(16,2) not null,
  cupom_vinculado tinyint(1) not null default 0,
  acumula_diversos tinyint(1) not null default 0,
  utiliza_corban tinyint(1) not null default 0,
  aceita_pagamento_infocard  tinyint(1) not null default 0,  
  tipo_autorizacao integer not null,  
  servico_autorizacao integer not null,  
  comprovante_nao_fiscal integer not null,
  solicita_data_promissoria tinyint(1) not null default 0,  
  juros_tipo integer not null,
  juros_mes double(16,2) not null,  
  juros_nao_tributado tinyint(1) not null default 0,
  juros_fora_dia tinyint(1) not null default 0,
  juros_partir_vencimento tinyint(1) not null default 0,
  juros_barrar_acima tinyint(1) not null default 0,
  juros_dias_vencimento integer not null,
  juros_data_fixa date,
  controle_limite tinyint(1) not null default 0,
  consulta_local_off_line tinyint(1) not null default 0,
  capturar_cpf_tel_cliente tinyint(1) not null default 0,
  moeda_estrangeira integer not null,
  indaga_dinheiro tinyint(1) not null default 0,
  correspondente_batimento integer not null default 0,
  utilizar_fidelizacao tinyint(1) not null default 0,
  aceitar_digitacao tinyint(1) not null default 0,
  exclusiva_pbm tinyint(1) not null default 0,
  aceita_pag_fatura_superus tinyint(1) not null default 0,
  cartao_private tinyint(1) not null default 0,
  imprimir_demonstrativo_juros tinyint(1) not null default 0,
  solicita_autoriz_cliente_bloq tinyint(1) not null default 0,
  codigo_fin_chave_grupo integer not null,
  bloqueia_venda tinyint(1) not null default 0,
  percentual_venda_bloqueio double(16,2) not null,
  permissao_finalizadora tinyint(1) not null default 0,
  agrupar_valores tinyint(1) not null default 0,
  imprime_limite_saldo tinyint(1) not null default 0,
  cons_tef_clien_restr tinyint(1) not null default 0,
  linha_promissoria_1 varchar(40) not null,
  linha_promissoria_2 varchar(40) not null,
  linha_promissoria_3 varchar(40) not null,
  linha_promissoria_4 varchar(40) not null,
  linha_promissoria_5 varchar(40) not null,
  utilizar_parcelamento_adm tinyint(1) not null default 0,
  validar_bin tinyint(1) not null default 0,
  solicitar_bin_pos tinyint(1) not null default 0,
  permite_trocar_finalizadora tinyint(1) not null default 0,
  utilizar_vale_compra tinyint(1) not null default 0,
  dt_inicio_vale_compra date,
  dt_final_vale_compra date,
  valor_vale_compra double(16,2) not null, 
  utiliza_troca_mercadoria_conc tinyint(1) not null default 0,
  controla_tipo_ticket tinyint(1) not null default 0,
  validar_cpf_cnpj tinyint(1) not null default 0,	
  juros_barrar_abaixo tinyint(1) not null default 0,
  informar_qtde_fin_sangria tinyint(1) not null default 0,
  bloquear_cheque_nao_cadastrado tinyint(1) not null default 0,
  solicita_numero_autorizacao_pos tinyint(1) not null default 0,
  percentual_desconto double(16,2) not null default 0,
  calcular_juros_autorizador tinyint(1) not null default 0,
  liberar_consulta_autorizador tinyint(1) not null default 0,
  utiliza_vale_alimentacao_magnetico_papel tinyint(1) not null default 0,
  funcao_finalizadora integer not null default 0,
  solicita_bandeira tinyint(1) not null default 0,
  obriga_informar_bandeira tinyint(1) not null default 0,
  abrir_gaveta_somente_troco tinyint(1) not null default 0,
  encerrar_pagto_automatico tinyint(1) not null default 0,
  solicitar_qtd_parcelas tinyint(1) not null default 0,
  imprimir_declarativo_aceite_juros tinyint(1) not null default 0,
  sig_fin varchar(20) not null ,
  blq_vda_bin_nao_cad tinyint(1) not null default 0 ,
  num_cv tinyint(1) not null default 0  ,
  tip_trn tinyint(1) not null default 0  ,
  for_dat_vnc_jur tinyint(1) not null default 0 ,
  exi_men_tef_par_cre tinyint(1) not null default 0 ,
  vrf_cmc_tef tinyint(1) not null default 0 ,
  imp_cpv_pos tinyint(1) NOT NULL DEFAULT 0 ,
  tam_min_cod_aut integer not null default 0 ,
  tam_max_cod_aut integer not null default 0 ,
  tam_min_bin integer not null default 0 ,
  tam_max_bin integer not null default 0 ,
  sol_sup_acm TINYINT NOT NULL DEFAULT 0 ,
  blq_vnc_abx_dia integer not null default 0 ,
  mte_dad_trc TINYINT NOT NULL DEFAULT 0 ,
  blq_vda_bin_nao_cad_pos TINYINT NOT NULL DEFAULT 0 ,
  nao_pmt_prl_tef TINYINT(1) NOT NULL DEFAULT 0 ,
  sol_ult_num_ctr_pos TINYINT(1) NOT NULL DEFAULT 0 ,
  utl_mtc TINYINT(1) NOT NULL DEFAULT 0 ,
  sol_mqt TINYINT(1) NOT NULL DEFAULT 0 ,
  blq_dsc_sbt TINYINT(1) NOT NULL DEFAULT 0 ,
  vlr_min_pgt_fin DOUBLE(16,2) ,
  utl_trc_pdv tinyint(1) not null default 0 ,
  nao_exi_fin_grp TINYINT(1) NOT NULL DEFAULT 0,
  utl_doa_tco TINYINT(1) NOT NULL DEFAULT 0,
  pga_doa_tco TINYINT(1) NOT NULL DEFAULT 0,
  act_chq_tcr TINYINT(1) NOT NULL DEFAULT 0,
  nao_act_cnv_cvd_pgt TINYINT(1) NOT NULL DEFAULT 0,
  pmt_rgt_cbk TINYINT(1) NOT NULL DEFAULT 0,
  pgt_ftr_red_deb TINYINT(1) NOT NULL DEFAULT 0,
  inf_vlr_doa TINYINT(1) NOT NULL DEFAULT 0,
  frase_carteira_digital varchar(20) not null,
  primary key(codigo_finalizadora)
) ENGINE = innodb;

create table usuario (
  id integer not null,
  login integer not null,
  senha varchar(100) not null,
  nome varchar(100) not null,
  codigo_identificacao varchar(40) not null,
  validacao_senha integer not null default 0,
  percentual_desc double(16,2) not null default 0,
  dias_para_aviso integer  default 0,
  dias_para_expiracao integer DEFAULT -1,
  data_expiracao date DEFAULT NULL,
  data_ultima_atualizacao date DEFAULT NULL,
  utilizar_vale_compra tinyint(1) not null default 0,
  digito_identificacao integer not null default 0,
  tentativas_id_senha integer not null default 0,
  dha_usu tinyint(1) not null default 0,
  mtc INTEGER not null default 0,
  vlr_des_max DOUBLE(16,2) not null default 0,
  cpf bigint not null default 0,
  per_cms double not null default 0,
  primary key(id),
  constraint unique constr_login (login)
) ENGINE = innodb;

CREATE INDEX index_usuario_ident ON usuario (codigo_identificacao(40));

create table permissao (
  id integer not null,
  nome varchar(45) not null,
  descricao varchar(200) not null,
  supervisor tinyint(1) not null default 0,
  controla_permissao_status tinyint(1) not null default 0,
  nova_descricao varchar(100) null,
  primary key(id)
) ENGINE = innodb;

create table permissao_usuario (
  id_usuario integer not null,
  id_permissao integer not null,
  primary key(id_usuario, id_permissao)
) ENGINE = innodb;

CREATE TABLE usuario_fir (
  login integer not null,
  codigo_hardware integer not null,
  digital BLOB,
  PRIMARY KEY (login, codigo_hardware)
) ENGINE = INNODB;

CREATE TABLE permissao_menu_pdv (
  id_permissao integer not null,
  desc_menu varchar(30) not null,
  desc_teclado varchar(8) not null,
  codigo_funcao integer not null,
  voltar_tela_venda tinyint(1) not null default 0,
  cliente_especifico integer not null,
  voltar_tela_venda_bloqueio tinyint(1) not null default 0,
  PRIMARY KEY(id_permissao)
) ENGINE = innodb;

CREATE TABLE servico (
  codigo_servico integer not null,
  descricao varchar(30) not null,
  habilitar_validar_senha tinyint(1) not null default 0,
  habilitar_digitar_cartao tinyint(1) not null default 0,
  wsv tinyint(1) not null default 0,
  hab_cdt_sha tinyint(1) not null default 0,
  hab_dig_cpf tinyint(1) not null default 0,
  PRIMARY KEY(codigo_servico)
) ENGINE = innodb;

create table servico_ip_porta (
  codigo_servico integer not null,
  tipo_servico integer not null,
  ip varchar(16) not null,
  porta_consulta integer not null,
  porta_cancelamento integer not null,
  porta_efetivacao integer not null,
  exibir_menu_servico tinyint(1) not null default 0,
  validar_senha tinyint(1) not null default 0,
  digitar_cartao tinyint(1) not null default 0,
  capturar_codigo_barras tinyint(1) not null default 0,
  tim integer default 0,
  trc_asn tinyint(1) not null default 0,
  cod_sev_wsv integer default 0 ,
  cdt_sha tinyint(1) not null default 0,
  dig_cpf tinyint(1) not null default 0,
  primary key(codigo_servico)
) ENGINE = innodb;

create table transacao_habilitada (
   codigo_finalizadora integer not null,
   transacao integer not null,
   primary key(codigo_finalizadora, transacao)
) ENGINE = innodb;

CREATE TABLE secao_grupo_subgrupo (
  codigo_secao integer not null,
  codigo_grupo integer not null,
  codigo_sub_grupo integer not null,
  codigo_nivel integer,
  descricao varchar(80) not null,
  imagem varchar(50) not null,
  percentual_desconto double(16,2) not null default 0,
  produto_generico tinyint(1) not null default 0,
  permite_multiplicar tinyint(1) not null default 0,
  aceitar_parcelamento tinyint(1) not null default 0,
  solicita_supervisor_multiplic tinyint(1) not null default 0,
  modalidade integer not null default 0,
  PRIMARY KEY(codigo_secao, codigo_grupo, codigo_sub_grupo)
) ENGINE = INNODB;

create table produto (
  codigo_produto bigint not null,
  codigo_associado bigint not null,
  codigo_nivel integer,
  codigo_secao integer not null,
  codigo_grupo integer not null,
  codigo_sub_grupo integer not null,
  codigo_natureza varchar(3) not null,
  descricao varchar(60) not null,
  descricao_reduzida varchar(20) not null,
  embalagem varchar(2) not null default 'UN',
  pesavel tinyint(1) not null default 0,
  estado_origem varchar(2) not null,
  maximo_multiplicacao integer not null,
  fracao tinyint(1) not null default 0,
  vende_peso_padrao tinyint(1) not null default 0,
  peso_padrao double(16,3) not null,
  tipo_desconto integer not null,
  desconto double(16,2) not null,
  diferenciado integer not null,
  pesquisa tinyint(1) not null default 0,
  conjunto_produto tinyint(1) not null default 0,
  imagem varchar(50) not null,
  data_atualizacao date not null,
  data_inicial_liberacao date,
  data_final_liberacao date, 
  modalidade integer not null default 0, 
  etiqueta_anti_furto tinyint(1) not null default 0,
  refcalorias integer default 0,
  porcao varchar(40),
  unidade_ref varchar(40),
  solicita_supervisor tinyint(1) not null default 0,
  aceitar_parcelamento tinyint(1) not null default 0,
  qtde_maxima_cupom integer not null,
  prazo_validade integer not null,
  tecla_associada integer not null,
  unidade_porcao integer not null,
  parte_inteira_mc integer not null,
  parte_decimal_mc integer not null,
  medida_caseira integer not null,
  descricao_etiqueta varchar(40) not null default '',
  descricao_diferenciada varchar(60) default '',
  indicador_producao varchar(1) default '',
  utilizar_preferencia_consumo tinyint(1) not null default 0,
  codigo_laboratorio integer default 0,  
  percentual_fabrica double(16,3) not null,
  preco_custo double(16,2),
  bebida_alcoolica tinyint(1) not null default 0,
  forcar_desconto_pbm tinyint(1) not null default 0,
  forcar_subsidio_pbm tinyint(1) not null default 0, 
  cripto varchar(255),
  codigo_produto_erp varchar(40) not null,
  primary key(codigo_produto)
) ENGINE = innodb;

CREATE INDEX index_produto_descricao ON produto (descricao(60));
CREATE INDEX idx_produto_codigo_secao ON produto (codigo_produto, codigo_secao);

CREATE TABLE remocao_preco_produto (
  codigo_produto bigint not null,
  PRIMARY KEY(codigo_produto)
) ENGINE = innodb;

CREATE TABLE produto_livraria (
  codigo_produto bigint not null,
  titulo varchar(60) not null,
  autor varchar(60) not null,
  editora varchar(60) not null,
  assunto varchar(60) not null,
  palavra_chave varchar(60) not null,
  isbn varchar(40) not null,
  data_atualizacao date not null,
  PRIMARY KEY(codigo_produto),
  FOREIGN KEY(codigo_produto) REFERENCES produto (codigo_produto)
) ENGINE = INNODB;

CREATE INDEX index_produto_livraria_titulo ON produto_livraria (titulo(60));
CREATE INDEX index_produto_livraria_autor ON produto_livraria (autor(60));
CREATE INDEX index_produto_livraria_editora ON produto_livraria (editora(60));
CREATE INDEX index_produto_livraria_assunto ON produto_livraria (assunto(60));
CREATE INDEX index_produto_livraria_palavrachave ON produto_livraria (palavra_chave(60));

create table ean (
  codigo_ean bigint not null,
  codigo_produto bigint not null,
  quantidade double(16,3),
  embalagem varchar(2),
  divisao tinyint(1) not null default 0,
  data_atualizacao date not null,
  qtd_embalagem double(16,3),
  tipo_embalagem integer not null default 0,
  descricao varchar(40) not null default '',
  pesavel tinyint(1) not null default 0,
  fracao tinyint(1) not null default 0,
  qtd_acima_de double(16,3),
  primary key(codigo_ean)
) ENGINE = innodb;

CREATE INDEX index_ean_codigo_produto ON ean (codigo_produto);

create table nivel_preco_produto (
  codigo_nivel integer not null,
  codigo_produto bigint not null,
  data_preco date not null,
  preco double(16,2) not null,
  data_atualizacao date not null,
  qtd_atacado double(16,3) not null default 0,
  preco_atacado double(16,2) not null default 0,
  cripto varchar(255),
  primary key(codigo_nivel, codigo_produto, data_preco)
) ENGINE = innodb;

-- indice para pesquisa por data_preco para melhorar performance da consulta de preco
CREATE INDEX index_nivel_preco_produto_atu_preco ON nivel_preco_produto (data_atualizacao, data_preco);
CREATE INDEX index_nivel_preco_produto_preco ON nivel_preco_produto (data_preco);

CREATE TABLE conjunto_produto (
  codigo_conj_prod bigint not null,
  codigo_produto bigint not null,
  codigo_loja integer not null,
  quantidade double(16,3) not null,
  codigo_nivel integer,
  desconto double(16,2) not null,
  preco double(16,2) not null,
  PRIMARY KEY(codigo_conj_prod, codigo_produto, codigo_loja)
) ENGINE = innodb;


CREATE TABLE promocao_mix (
  codigo_mix integer not null,
  codigo_loja integer not null default 0,
  descricao varchar(20) not null,
  tipo_prom_mix integer not null,
  data_inicial date not null,
  data_final date not null,
  forcar_desc_item tinyint(1) not null default 0,
  codigo_finalizadora integer not null default 0, 
  ratear_desc_produto tinyint(1) not null default 0,
  cal_dsc_ite tinyint(1) not null default 0,
  ctr_emb_vda_prd_psv TINYINT(1) NOT NULL default 0,
  tipo_combinacao integer (5) not null default 0,
  PRIMARY KEY(codigo_mix, codigo_loja)
) ENGINE = innodb;

CREATE TABLE produto_promocao_mix (
  codigo_produto bigint not null,  
  codigo_mix integer not null,
  codigo_loja integer not null default 0, 
  descricao_produto varchar(20) not null,
  quantidade double(16,3),
  desc_percentual double(16,2) not null,
  desc_preco double(16,2) not null,     
  executar_desconto tinyint(1) not null default 0,
  desc_valor double(16,2) not null,
  controlar_subgrupo tinyint(1) not null default 0,
  controlar_familia tinyint(1) not null default 0,
  PRIMARY KEY(codigo_produto, codigo_mix, codigo_loja)
) ENGINE = innodb;

CREATE TABLE promocao (
  codigo_produto bigint not null,  
  data_inicial date not null,
  data_final date not null,
  codigo_loja integer not null,
  tipo_promocao integer not null,
  nivel_preco integer,
  preco double(16,2),
  qtd_limitada double(16,3),
  qtd_minima double(16,3),
  qtd_maxima double(16,3),
  leve double(16,3),
  pague double(16,3),
  codigo_mix integer,
  desconto double(16,2),
  hora_inicial TIME,
  hora_final TIME,
  sequencia integer not null,
  PRIMARY KEY(codigo_produto, data_inicial, data_final, codigo_loja, sequencia)
) ENGINE = innodb;

CREATE TABLE promocao_fidelidade (
  codigo_produto bigint not null,  
  data_inicial date not null,
  data_final date not null,
  codigo_loja integer not null,
  codigo_bin bigint not null,
  nivel_preco integer,
  desconto double(16,2),
  tip_idt int not null default 0 ,
  por tinyint(1) not null default 0 ,
  PRIMARY KEY(codigo_produto, data_inicial, data_final, codigo_loja, codigo_bin)
) ENGINE = innodb;
    
CREATE TABLE promocao_secao_grupo_subgrupo (
  codigo_secao integer not null,
  codigo_grupo integer not null,
  codigo_sub_grupo integer not null,
  data_inicial date not null,
  data_final date not null,
  codigo_loja integer not null,
  desconto double(16,2) not null,
  PRIMARY KEY(codigo_secao, codigo_grupo, codigo_sub_grupo, data_inicial, data_final, codigo_loja)
) ENGINE = INNODB;

create table cliente (
   codigo_cliente bigint not null,
   cpf bigint not null,
   insc_estadual varchar(14) not null,
   situacao int not null,
   tipo_cliente int not null,   	
   nome varchar(40) not null,
   endereco varchar(40) not null,
   cidade varchar(80) not null,
   bairro varchar(20) not null,   
   estado varchar(2) not null,
   cep varchar(9) not null,
   limite double(16,2) not null,
   acumulado double(16,2) not null,	
   nivel_preco int not null,  
   data_atualizacao date not null, 
   lista_negra tinyint(1) not null default 0,
   exibe_msg tinyint(1) not null default 0,
   mensagem varchar(50) not null,
   consulta_serasa tinyint(1) not null default 0,
   informacoes_credito varchar(820) not null,
   num varchar(10) not null default '',
   complemento varchar(40),
   telefone varchar(30),
   email varchar(60),
   tip_blq varchar(1),
   primary key(cpf)
) ENGINE = innodb;

CREATE INDEX index_cliente_codigo ON cliente (codigo_cliente);

create table empresa_convenio (
   codigo_convenio varchar(16) not null,
   nome varchar(40) not null,
   situacao int not null,
   limite double(16,2) not null,
   acumulado double(16,2) not null,
   tipo_convenio int not null,
   data_atualizacao date not null,
   utiliza_parcelamento tinyint(1) not null default 0,
   eft_val_bio tinyint(1) not null default 0,
   dia_fch INTEGER NOT NULL DEFAULT 0,
   dia_vnc INTEGER NOT NULL DEFAULT 0,
   primary key(codigo_convenio)
) ENGINE = innodb;

CREATE TABLE convenio_secao_grupo_subgrupo (
  codigo_convenio varchar(16) not null,
  codigo_loja integer not null,
  codigo_secao integer not null,
  codigo_grupo integer not null,
  codigo_sub_grupo integer not null,
  desconto double(16,2) not null,
  bloqueado tinyint(1) not null default 0,
  PRIMARY KEY(codigo_convenio, codigo_loja, codigo_secao, codigo_grupo, codigo_sub_grupo)
) ENGINE = innodb;

create table conveniado (
   empresa_convenio varchar(16) not null,
   codigo_conveniado varchar(20) not null,
   situacao int not null,
   nome varchar(40) not null,
   endereco varchar(40) not null,
   limite double(16,2) not null,
   acumulado double(16,2) not null,
   desconto double(16,2) not null,
   senha varchar(8) not null,
   data_atualizacao date not null,
   cod_cli INTEGER NOT NULL DEFAULT 0,
   eft_val_bio tinyint(1) not null default 0,
   primary key(empresa_convenio, codigo_conveniado)
) ENGINE = innodb;

CREATE TABLE troca_mercadoria (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   sequencia integer not null,
   operador integer not null,
   vendedor integer not null,
   cliente varchar(20),
   motivo_troca integer not null,   
   data_origem date not null,
   loja_origem integer not null,	   
   caixa_origem integer not null,  
   numero_cupom_origem integer not null, 
   vendedor_origem integer not null,
   numero_boleto integer not null,
   codigo_ean bigint not null,
   codigo_produto bigint not null,
   descricao varchar(20), 
   quantidade double(16,3) not null,
   preco double(16,2) not null,
   desconto double(16,2) not null,
   total double(16,2) not null,
   cancelada tinyint(1) not null default 0,
   tipo_desconto integer not null,
   horario_troca time not null,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = INNODB;

CREATE TABLE elementos_nutricionais (
  id integer,
  descricao varchar(40) not null,
  med tinyint(1) default 0,
  PRIMARY KEY(id)
) ENGINE = innodb;

CREATE TABLE tabela_nutricional (
  codigo_loja integer,
  codigo_produto integer,
  id_elementos integer,
  quantidade double(16,3),
  percentual_dia double(16,2),
  unidade varchar(40)  
) ENGINE = innodb;

-- TABELAS DE MOVIMENTO

CREATE TABLE capa_cupom_venda (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   hora_venda datetime not null,
   situacao_capa integer not null,
   total_liquido double(16,2) not null,
   total_bruto double(16,2) not null,
   total_desconto double(16,2) not null,
   total_desconto_item double(16,2) not null,
   total_acrescimo double(16,2) not null,   
   total_cancelado double(16,2) not null,
   total_juros double(16,2) not null,
   codigo_operador int not null,
   usuario_cancelou int not null,
   motivo_cancelamento int not null,
   numero_cartao varchar(16),
   numero_cpf_cnpj varchar(16),
   codigo_convenio varchar(16),
   codigo_conveniado varchar(20),
   tipo_capa integer not null,
   tipo_recebimento integer not null,
   codigo_cliente bigint not null,
   forma_recebimento integer not null,
   algoritimo integer not null,
   data_vencimento date,
   valor_minimo double(16,2) not null,
   valor_total_fatura double(16,2) not null,
   valor_multa double(16,2) not null,
   valor_encargo double(16,2) not null,
   dias_atraso integer not null,
   numero_recibo integer not null,
   tipo_registro integer not null,
   numero_contrato integer not null,
   parcela integer not null,
   valor_iof double(16,2) not null,
   string_retorno varchar(256),
   situacao integer not null,
   nroDocumento long not null,
   valorDocumento double(16,2) not null,
   cnpj_cpf_consumidor varchar(20),
   nome_consumidor varchar(30),
   endereco_hum_consumidor varchar(40),
   endereco_dois_consumidor varchar(40),   
   data_hora_fim_venda datetime not null,  
   socio tinyint(1) not null default 0,
   valor_desconto_sacola double(16,2) not null default 0,
   utiliza_desconto_sacola tinyint(1) not null default 0,
   valor_fidelidade double(16,2) not null default 0,
   ccf integer not null default 0,
   nota_fiscal tinyint(1) not null default 0,
   resgate tinyint(1) not null default 0,
   total_acrescimo_item double(16,2) not null default 0,
   desconto_campanha double(16,2) default 0,
   cripto varchar(600),
   sequencia_operador integer,
   PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom)
) ENGINE = innodb;
   
create table capa_cupom_venda_tmp (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   hora_venda datetime not null,
   situacao_capa integer not null,
   total_bruto double(16,2) not null,
   codigo_operador int not null,
   numero_cartao varchar(16) not null,
   numero_cpf_cnpj varchar(16) not null,
   codigo_convenio varchar(16) not null,
   codigo_conveniado varchar(20) not null,
   tipo_capa integer not null,
   tipo_recebimento integer not null,
   codigo_cliente bigint not null,
   forma_recebimento integer not null,
   algoritimo integer not null,
   data_vencimento date,
   valor_minimo double(16,2) not null,
   valor_total_fatura double(16,2) not null,
   valor_multa double(16,2) not null,
   valor_encargo double(16,2) not null,
   dias_atraso integer not null,
   valor_desconto double(16,2) not null,
   numero_recibo integer not null,
   tipo_registro integer not null,
   numero_contrato integer not null,
   parcela integer not null,
   valor_iof double(16,2) not null,
   string_retorno varchar(256) not null,  
   situacao integer not null,
   nroDocumento long not null,
   valorDocumento double(16,2) not null, 
   cnpj_cpf_consumidor varchar(20),
   nome_consumidor varchar(30),
   endereco_hum_consumidor varchar(40),
   endereco_dois_consumidor varchar(40),   
   motivo_cancelamento int not null,
   resgate tinyint(1) not null default 0,
   primary key(data_venda, numero_loja, numero_pdv, numero_cupom )
) ENGINE = innodb;

CREATE TABLE detalhe_cupom_venda (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   sequencia integer not null,
   situacao_detalhe integer not null,
   codigo_ean bigint not null,
   codigo_produto bigint not null,
   descricao varchar(20), 
   quantidade double(16,3) not null,
   preco double(16,2) not null,
   desconto double(16,2) not null,
   total double(16,2) not null,   
   ajuste_positivo double(16,2) not null,
   ajuste_negativo double(16,2) not null,   
   vendedor integer not null,
   usuario_cancelou int not null,
   motivo_cancelamento int not null,
   cartao_presente tinyint(1) default 0,
   tipo_desconto int not null,
   motivo_desconto int not null,
   preco_no_sistema double(16,2) not null,
   indice_medicamento_1011 integer not null,
   codigo_medicamento_1012 bigint not null,
   quantidade_autorizada_1013 integer not null,
   preco_maximo_1014 double(16,2) not null,
   preco_recomendado_1015 double(16,2) not null,
   preco_venda_farmacia_1016 double(16,2) not null,
   valor_reembolso_farmacia_1017 double(16,2) not null,
   valor_reposicao_farmacia_1018 double(16,2) not null,
   valor_subsidio_convenio_1019 double(16,2) not null,
   desconto_pbm double(16,2) not null,
   codigo_natureza varchar(3),
   percentual_desconto double(16,2) not null default 0,
   dados_complementar_produto_pbm varchar(300),
   tipo_embalagem_pbm varchar(10),
   desconto_retornado_pbm double(16,2) not null default 0,
   status_produto_pbm integer not null default 0,
   codigo_conjunto_produto bigint not null,
   sequencia_conjunto integer not null,
   codigo_pre_venda bigint not null,
   quantidade_conjunto double(16,2) not null default 0,
   codigo_prom_mix int not null,
   acrescimo double(16,2) not null default 0,
   tipo_acrescimo int not null,
   motivo_acrescimo int not null,
   preco_custo double(16,2),
   valor_desconto_van double(16,2),
   valor_subsidio_van double(16,2),   
   embalagem varchar(6),
   pesavel tinyint(1),
   truncar tinyint(1),
   icms double(16,2),
   seqTotalizadorEcf integer,
   cripto varchar(255),
   tipo_orcamento integer,
   PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;
   
create table detalhe_cupom_venda_tmp (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   sequencia integer not null,
   situacao_detalhe integer not null,
   codigo_produto bigint not null,
   descricao varchar(20) not null, 
   quantidade double(16,3) not null,
   preco double(16,2) not null,
   total double(16,2) not null,   
   vendedor integer not null,
   usuario_cancelou int not null,
   motivo_cancelamento int not null,
   cartao_presente tinyint(1) default 0,
   codigo_pre_venda bigint not null ,
   primary key(data_venda, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;

CREATE TABLE movimento_finalizadora (
   data_movimento date not null,
   codigo_operador int not null,
   numero_loja integer not null,
   numero_pdv int not null,
   tipo_movimento int not null,
   numero_cupom int not null,
   sequencia int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),
   valor double(16,2) not null,
   troco double(16,2) not null,
   tipo_troco varchar(1),
   numero_conta varchar(10),
   numero_cheque varchar(10),
   codigo_agencia int,
   codigo_banco int,
   data_deposito date,
   autentica tinyint(1) default 0,
   numero_cartao varchar(16),
   numero_cpf_cnpj varchar(16),
   codigo_convenio varchar(16),
   codigo_conveniado varchar(20),
   codigo_restricao varchar(6),
   usuario_autorizou int not null,
   valor_juros double(16,2) not null,
   comprovante_nao_fiscal int not null,
   cmc7_cheque varchar(35),
   codigo_bin_tef int not null,
   telefone_cliente varchar(14),
   pagamento_acumulado tinyint(1) default 0, 
   tipo_entrada tinyint(1) default 0,
   possibilita_estorno tinyint(1) default 0,
   utilizacao int not null,
   rg_cliente varchar(20),
   ramal_cliente int not null,
   tipo_telefone int not null,
   numero_caixa_op int not null,
   numero_loja_op int not null,
   numero_op bigint not null,
   cotacao_moeda_estrangeira double(16,2) default 0,
   motivo_sangria int not null,
   juros_nao_tributado tinyint(1) not null default 0,
   codigo_instituicao integer default 0,
   valor_doacao double(16,2) default 0,
   codigo_grupo_finalizadora int not null,
   codigo_finalizadora_ecf int not null,
   numero_autorizacao varchar(40),
   qtd_parcelas_tef int not null,   
   codigo_bandeira int not null,
   codigo_administradora int not null,
   operador_informou_administradora int not null,
   tipo_cartao varchar(1),
   codigo_troca_mercadoria_conc bigint not null,
   valor_digitado double(16,2) not null,
   numero_envelope bigint,
   hora_sangria datetime,
   trans_tef_cancelada tinyint(1) not null default 0,
   numero_documento varchar(40),
   codigo_plano int not null,
   codigo_vale_troca varchar(20),
   codigo_retaguarda integer default 0,
   num_cv bigint default 0 ,
   ccf integer,
   gnf integer,
   cripto varchar(255),
   sequencia_operador integer,
   PRIMARY KEY(data_movimento, codigo_operador, numero_loja, numero_pdv, tipo_movimento, numero_cupom, sequencia)
) ENGINE = innodb;

create table movimento_finalizadora_tmp (
   data_movimento date not null,
   codigo_operador int not null,
   numero_loja integer not null,
   numero_pdv int not null,
   tipo_movimento int not null,
   numero_cupom int not null,
   sequencia int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20) not null,
   valor double(16,2) not null,
   troco double(16,2) not null,
   tipo_troco varchar(1) not null,
   numero_conta varchar(10),
   numero_cheque varchar(10),
   codigo_agencia int,
   codigo_banco int,
   data_deposito date,
   autentica tinyint(1) default 0,
   numero_cartao varchar(16) not null,
   numero_cpf_cnpj varchar(16) not null,
   codigo_convenio varchar(16) not null,
   codigo_conveniado varchar(20) not null,
   codigo_restricao varchar(6) not null,
   usuario_autorizou int not null,
   comprovante_nao_fiscal int not null,
   cmc7_cheque varchar(35) not null,
   codigo_bin_tef int not null,
   telefone_cliente varchar(14),
   pagamento_acumulado tinyint(1) default 0,
   utilizacao int not null,
   rg_cliente varchar(20) not null,
   ramal_cliente int not null,
   tipo_telefone int not null,
   numero_caixa_op int not null,
   numero_loja_op int not null,
   numero_op bigint not null,
   cotacao_moeda_estrangeira double(16,2),
   codigo_troca_mercadoria_conc bigint not null,
   qtd_parcelas_tef int not null,
   codigo_bandeira int not null,
   tipo_cartao varchar(1),
   num_cv bigint default 0 ,
   numero_documento varchar(40),
   gnf int default 0,
   primary key (data_movimento, codigo_operador, numero_loja, numero_pdv, tipo_movimento, numero_cupom, sequencia)
) ENGINE = innodb;

CREATE TABLE movimento_operador (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   codigo_operador int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),
   situacao int not null,
   valor double(16,2) not null,
   troco double(16,2) not null,
   vale double(16,2) not null,
   juros double(16,2) not null,
   sangria double(16,2) not null,
   fundo_caixa double(16,2) not null,
   devolucao double(16,2) not null,
   quantidade int not null default 0,
   valor_doacao double not null default 0,
   saque_sitef double not null default 0,
   sequencia_operador integer,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, codigo_operador, codigo_finalizadora)
) ENGINE = innodb;

create table movimento_redes_cartao (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   codigo_operador int not null,
   codigo_finalizadora int not null,
   codigo_rede int not null default 0,
   valor double(16,2) not null,
   primary key (data_movimento, numero_loja, numero_pdv, codigo_operador, codigo_finalizadora, codigo_rede)
) ENGINE = innodb;

create table movimento_listagem_cheque_sangria (
   data_movimento date not null,
   codigo_operador int not null,
   numero_loja integer not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   codigo_banco int,
   codigo_agencia int,
   numero_conta varchar(10),
   numero_cheque varchar(10),
   valor double(16,2) not null,
   data_deposito date,
   situacao int not null,
   codigo_finalizadora int not null,
   primary key (data_movimento, codigo_operador, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;

CREATE TABLE movimento_sitef (
   data_movimento date not null,
   numero_loja int not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   situacao_transacao int not null,
   valor_transacao double(16,2) not null,
   codigo_modalidade_100 varchar(4),
   data_transacao_105 date,
   hora_transacao_105 datetime,
   codigo_rede_autorizada_131 int not null,
   codigo_bandeira_132 int not null,
   nsu_sitef_133 varchar(20),
   nsu_host_134 varchar(15),
   codigo_autorizacao_135 varchar(15),
   codigo_bin_136 int not null,
   tipo_transacao int not null,
   codigo_operador int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),  
   impresso_fechamento tinyint(1) not null default 0, 
   numero_parcelas int not null,
   vencimento_cartao varchar(20),
   numero_cartao varchar(60),  
   codigo_modalidade_cancelamento_110 varchar(20),
   operadora_recarga varchar(30),
   valor_recarga double(16,2) not null, 
   nro_celular_recarga varchar(10),
   cnpj_convenio_1020  varchar(30),
   cod_plano_desc_1021 varchar(30),
   numero_doc_1022 varchar(30),
   data_venda_canc_1023 varchar(30),
   cupom_original_1024  integer not null,
   cod_med_dev_1025  bigint not null,
   qtde_med_dev_1026  integer not null,
   vlr_unit_pag_vista_1033  double(16,2) not null, 
   vlr_uni_pag_folha_1034  double(16,2) not null, 
   perc_desc_conced_1035  double(16,2) not null, 
   perc_comissao_1036  double(16,2) not null, 
   campo_1037  varchar(30),
   cod_conveniado_1038  varchar(20),
   nome_conveniado_1039  varchar(50),
   codigo_autorizacao varchar(20),
   rede_da_transacao integer not null,
   codigo_retorno integer not null,
   codigo_operadora_pbm integer not null,
   tipo_captura_pbm integer not null,
   numero_cartao_pbm bigint not null,
   dados_complementar_operadora_pbm varchar(300),
   data_mov_origem date,
   num_loja_origem int,
   num_pdv_origem int,
   num_cupom_origem int,
   seq_fin_origem int,      
   valor_troco_130 double(16,2) not null,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;
   
CREATE TABLE movimento_corban (   
   data_movimento date not null, 
   numero_loja int not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   situacao int not null,
   data_vencto_600 date not null,
   valor_pago_601 double(16,2) not null,
   valor_original_602 double(16,2) not null,
   valor_acrescimo_603 double(16,2) not null,
   valor_abatimento_604 double(16,2) not null,
   valor_contabil_605 double(16,2) not null,
   nome_cedente_606 varchar(60),
   indice_docto_607 int not null,
   nsu_611 varchar(15),
   tipo_docto_612 int not null,
   dados_cheque_613 varchar(60),
   nsu_sitef_trnPagto_614 varchar(15),
   nsu_sitef_trnCancel_620 varchar(15),
   nsu_corban_trnCancl_621 varchar(15),
   valor_beneficio_622 double(16,2) not null,
   valor_troco_130 double(16,2) not null,
   codigo_rodape_623 varchar(15),
   titulo_624 varchar(60),
   tipo_transacao int not null,
   supervisor_autorizou int not null,
   tarja_documento varchar(60),
   codigo_operador int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),  
   impresso_fechamento tinyint(1) not null default 0, 
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;
 
CREATE TABLE mapa_resumo (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   venda_bruta double(16,2) not null,
   cancelado double(16,2) not null,
   desconto double(16,2) not null,
   substituicao double(16,2) not null,
   isento double(16,2) not null,
   nao_tributado double(16,2) not null,
   base_imposto_01 double(16,2) not null, 
   base_imposto_02 double(16,2) not null, 
   base_imposto_03 double(16,2) not null, 
   base_imposto_04 double(16,2) not null, 
   base_imposto_05 double(16,2) not null, 
   base_imposto_06 double(16,2) not null, 
   base_imposto_07 double(16,2) not null, 
   base_imposto_08 double(16,2) not null, 
   base_imposto_09 double(16,2) not null, 
   base_imposto_10 double(16,2) not null,
   aliquota_imposto_01 double(16,2) not null,
   aliquota_imposto_02 double(16,2) not null,
   aliquota_imposto_03 double(16,2) not null,
   aliquota_imposto_04 double(16,2) not null,
   aliquota_imposto_05 double(16,2) not null,
   aliquota_imposto_06 double(16,2) not null,
   aliquota_imposto_07 double(16,2) not null,
   aliquota_imposto_08 double(16,2) not null,
   aliquota_imposto_09 double(16,2) not null,
   aliquota_imposto_10 double(16,2) not null,                           
   valor_imposto_01 double(16,2) not null,
   valor_imposto_02 double(16,2) not null,
   valor_imposto_03 double(16,2) not null,
   valor_imposto_04 double(16,2) not null,
   valor_imposto_05 double(16,2) not null,
   valor_imposto_06 double(16,2) not null,
   valor_imposto_07 double(16,2) not null,
   valor_imposto_08 double(16,2) not null,
   valor_imposto_09 double(16,2) not null,
   valor_imposto_10 double(16,2) not null,
   contador_inicial int not null,
   contador_final int not null,
   contador_reducao int not null,
   contador_reinicio int not null,
   numero_relatorio int not null,
   grande_total_inicial double(16,2) not null,
   grande_total_final double(16,2) not null,
   perc_mfd_remanescente double(16,2) not null,
   versao_software_basico varchar(20),
   numero_serie_ecf varchar(60),
   emitido_fechamento tinyint(1) not null default 0,
   data_emissao date,
   hora_emissao datetime,
   opnf double(16,2),
   gnf int,
   ccf int,
   grg int,
   cfd int,
   acrescimo double(16,2),
   cripto varchar(600),
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv)
) ENGINE = innodb;

-- TABELAS DE CONTROLE PDV
 
 create table exp_imp_movimento (
   data_movimento date not null,
   numero_loja int not null,
   numero_pdv int not null,
   numero_cupom int not null,
   codigo_operador int not null,
   tipo_movimento int not null,
   sequencia int not null,
   situacao_movimento int not null,
   dat_hor_proc DATETIME,
   dat_hor_imp DATETIME,
   dat_hor_tms DATETIME,
   dat_hor_exp DATETIME,   
   primary key (data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_operador, tipo_movimento, sequencia)
) ENGINE = innodb;

CREATE TABLE controle_notificacao (
  origem_destino INTEGER NOT NULL,
  tipo_notificacao INTEGER NOT NULL,
  data_hora DATETIME NOT NULL,
  sequencia INTEGER NOT NULL,
  codigo_origem INTEGER NOT NULL,
  codigo_destino INTEGER NOT NULL,
  situacao INTEGER NOT NULL,
  obj_dado MEDIUMBLOB,
  ip varchar(16),
  porta INTEGER NOT NULL,
  operacao INTEGER NOT NULL,
  PRIMARY KEY(origem_destino, tipo_notificacao, data_hora, sequencia)
) ENGINE = innodb;

CREATE TABLE controle_carga_pdv (
  data_carga date not null,
  numero_loja integer not null,
  numero_pdv integer not null,  
  numero_carga integer not null,
  tipo_carga integer not null,
  hora_carga time not null,  
  carga_parcial tinyint(1) not null default 0,
  data_hora_parcial date not null,
  carga_agend_matriz tinyint(1) not null default 0,
  carga_agend_auto tinyint(1) not null default 0,
  hora_proc_carga datetime,
  data_instalacao blob,
  data_expiracao blob,
  situacao_carga integer not null,
  configuracao tinyint(1) not null default 0,
  natureza_tributacao tinyint(1) not null default 0,
  finalizadora tinyint(1) not null default 0,
  produto tinyint(1) not null default 0,
  usuario tinyint(1) not null default 0,
  cliente_empresa_conv tinyint(1) not null default 0,  
  cadastro_geral tinyint(1) not null default 0,
  cadastro_especifico tinyint(1) not null default 0,
  protecao_tela tinyint(1) not null default 0,
  sobrepor_pendentes tinyint(1) not null default 0,
  cancelar_pendentes tinyint(1) not null default 0,
  prioridade_agend int(1) not null default 0,
  prioridade_loja_pdv int(1) not null default 0,
  motivo_cancelamento int(1) not null default 0,
  modo_carga int(1) not null default 1,
  enviar_imediatamente tinyint(1) not null default 0,
  executar_funcao integer not null default 0,
  ip_remetente varchar(16),
  nro_tentativas integer not null default 0,
  otimizar_processo_carga tinyint(1) not null default 0,
  configurar_skin tinyint(1) default 0,
  carga_offline tinyint(1) not null default 0,
  versao_carga varchar(20),
  usuario_agendou integer not null default 0,
  data_backup_carga date,
  PRIMARY KEY(data_carga, numero_loja, numero_pdv, numero_carga)
) ENGINE = INNODB;
 
CREATE TABLE controle_versao_pdv (
  numero_loja integer not null,
  numero_pdv integer not null,
  versao_atualizacao VARCHAR(100) NOT NULL,
  versao_anterior VARCHAR(100) NOT NULL,
  situacao integer not null,
  barrar_envio_carga tinyint(1) not null default 0,
  barrar_retorno_movimento tinyint(1) not null default 0,
  codigo_erro integer not null,
  msg_erro VARCHAR(256),
  forcar_envio_pacote tinyint(1) not null default 0,
  dat_hor_atz timestamp not null,
  PRIMARY KEY(numero_loja, numero_pdv)
) ENGINE = INNODB;
 
create table controle_movimento (
   numero_loja int not null,
   numero_pdv int not null,
   codigo_operador int not null,
   situacao int not null,
   data_movimento date not null,
   coo_inicial_ecf int not null,
   mes_ultima_leitura_MF_automatica int not null,
   numero_cupom_inicial int not null,
   sequencia_operador int not null,
   mes_ultima_geracao_Mfd_Mf_auto int not null,
   numero_serie_ecf varchar(128) not null,   
   mes_ultima_geracao_Tdm_auto int not null,
   primary key (numero_loja, numero_pdv)
) ENGINE = innodb;
 
create table qtd_produto_promocao (
  codigo_produto bigint not null,
  quantidade double(16,3) not null,
  primary key(codigo_produto)  
) ENGINE = innodb;

CREATE TABLE promocao_desc_itens_cupom (
  tipo_desconto integer not null,
  codigo_secao integer not null,
  codigo_grupo integer not null,
  codigo_sub_grupo integer not null,
  percentual double(16,2) not null,
  PRIMARY KEY(tipo_desconto, codigo_secao, codigo_grupo, codigo_sub_grupo)
) ENGINE = INNODB;

create table situacao_ecf (
   numero_cupom int not null,
   situacao int not null,
   finalizadora int not null,
   valor double(16,2) not null,
   acrescimo tinyint(1) default 0,
   desconto tinyint(1) default 0,
   tipo_cupom int not null
) ENGINE = innodb;


create table ticket_sitef (
   data_movimento date not null,
   numero_loja int not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   linha_ticket varchar(42),
   tipo_comprovante int not null,
   via_comprovante int not null,
   impresso tinyint(1) default 0,
   primary key (data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;

create table controle_sequencia (
  codigo_loja integer not null,
  tipo_sequencia integer not null,
  sequencia integer not null,
  primary key(codigo_loja, tipo_sequencia)
) ENGINE = innodb;
  
create table controle_ecf_virtual (
	numero_cupom int not null,
	venda_liquida double(16,2) not null,
    total_recebido double(16,2) not null,
    data_mov date not null,
    hor_Verao tinyint(1) default 0,
    st_ativo tinyint(1) default 0,
    st_operFiscal tinyint(1) default 0,
    st_operNaoFiscal tinyint(1) default 0,
    st_cupomTotalizado tinyint(1) default 0,
    st_gavetaAberta tinyint(1) default 0,
    st_necessRedZ tinyint(1) default 0,
    st_docPres tinyint(1) default 0,
    st_papelPres tinyint(1) default 0,
    st_poucoPapel tinyint(1) default 0,
    st_tefPend tinyint(1) default 0,
    st_tampaAberta tinyint(1)
) ENGINE = innodb;

create table resposta_autorizador (
   numero_cupom integer not null,
   sequencia integer not null,
   tipo_transacao int not null,
   tipo_servico int not null,
   tipo_operacao int not null,
   retorno int not null,
   restricao int not null,
   autorizado int not null,
   situacao int not null,
   consulta_serasa integer not null,
   trava_venda varchar(1) not null,
   off_line tinyint(1) not null default 0,
   tem_retorno tinyint(1) not null, 
   trocar_senha tinyint(1) default 0,
   mensagem varchar(50) not null,
   acumulado double(16,2) not null,
   limite double(16,2) not null,
   sinal_limite varchar(1) not null, 
   data_vencimento date not null,
   data_compensacao date not null,
   sequencia_finalizadora integer not null,
   id_desconto integer not null,
   tipo_desconto integer not null,
   percentual_desconto integer not null,
   codigo_cliente varchar(20) not null,
   nome_cliente varchar(40) not null,
   codigo_empresa varchar(16) not null,
   nome_empresa varchar(40) not null,
   endereco varchar(40) not null,
   cidade varchar(30) not null,
   estado varchar(2) not null,
   preco_diferenciado tinyint(1) not null,
   nivel_preco int not null,
   tipo_convenio int not null,
   valor_entrada double(16,2) not null,
   valor_documento double(16,2) not null,
   valor_juros double(16,2) not null,
   valor_total_fatura double(16,2) not null,
   valor_desconto double(16,2) not null,
   numero_cheque integer not null,
   codigo_banco integer not null,
   agencia integer not null,
   conta_corrente integer not null,
   codigo_fatura long not null,
   numero_cartao varchar(40) not null,
   numero_autorizacao varchar(40) not null,
   qtd_vias_comprovante int not null,
   cpf bigint not null,
   linha_autenticacao varchar(40) not null,
   msg_ret_pag_fatura varchar(60),
   status int not null,
   obj BLOB ,
   primary key(numero_cupom, sequencia)
) ENGINE = innodb;
   
-- criacao do usuario econect para acesso a base de dados do pdv
GRANT ALL PRIVILEGES ON pdv.* TO 'econect'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
UPDATE mysql.user SET File_priv = 'Y' WHERE User = 'econect';
FLUSH PRIVILEGES;

-- CONTROLE CUPOM VINCULADO
CREATE TABLE controle_cupom_vinculado (
  numero_cupom integer not null,
  sequencia integer not null,
  codigo_finalizadora integer not null,
  descricao_finalizadora varchar(20) not null,
  valor_finalizadora double(16,2) not null,
  situacao_finalizadora integer not null,
  PRIMARY KEY(numero_cupom, sequencia)
) ENGINE = INNODB;

CREATE TABLE movimento_batimento_caixa(
   data_movimento date not null,
   hora_movimento time not null,
   codigo_operador int not null,
   numero_loja integer not null,
   numero_pdv int not null,
   numero_cupom int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),
   valor_sistema double(16,2) not null,
   valor_sangria double(16,2) not null,
   valor_digitado double(16,2) not null,
   valor_abertura double(16,2) not null,
   usuario_fechto_caixa int not null,   
   sequencia_operacao int not null,
   tipo_execucao int not null,
   qtd_tentativas int not null default 0,
   usuario_autorizador int not null default 0,
   codigo_rede integer not null default 0,
   justificativa varchar(200), 
   cod_mtv integer default 0 ,
   dif_cob tinyint(1) default 0 ,
   qtd_sis int not null default 0,
   qtd_dgd int not null default 0,
 PRIMARY KEY (data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_finalizadora, codigo_rede)
) ENGINE = INNODB;

-- Produtos Controlados
CREATE TABLE produto_controlado(
  codigo_produto bigint not null,
  descricao varchar(60) not null,
  descricao_reduzida varchar(20) not null,
  preco double(16,2) not null,
  codigo_associado bigint not null,
  inativo tinyint(1) not null default 0,
  supervisor_digitacao tinyint(1) not null default 0,
  validar_produto tinyint(1) not null default 0,
  imprime_cartao_comprovante tinyint(1) not null default 0,
  tipo_produto int not null,
  tipo_de_recebimento int not null,
  data_atualizacao date not null,
  recebimento_fatura_menor tinyint(1) not null default 0,
  solicita_convenio_conveniado tinyint(1) not null default 0,
  codigo_totalizador int not null,
  PRIMARY KEY(codigo_produto)
) ENGINE = INNODB;

-- Movimento de Produtos Controlados
CREATE TABLE movimento_produto_controlado (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  codigo_operador int not null,
  numero_cupom integer not null,
  sequencia integer not null,
  codigo_produto bigint not null,
  codigo_associado bigint not null,
  descricao varchar(60),
  quantidade double(16,3) not null,
  preco double(16,2) not null,
  tipo_movimento integer not null,
  situacao_movimento integer not null,
  situacao_fech_operador integer not null,
  usuario_cancelou int not null,
  hora_movimento time not null,
  primary key(data_movimento, numero_loja, numero_pdv, codigo_operador, numero_cupom, sequencia)
) ENGINE = innodb;

-- Movimento de Produtos Controlados Validados (Riachuelo)
CREATE TABLE movimento_produto_controlado_validos (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  codigo_operador int not null,
  numero_cupom integer not null,
  codigo_produto bigint not null,
  sequencia integer not null,
  codigo_validacao varchar(60) not null,
  situacao integer not null,
  numero_cupom_venda integer not null,  
  hora_movimento time not null,
  primary key(data_movimento, numero_loja, numero_pdv, codigo_operador, numero_cupom, codigo_produto, sequencia)
) ENGINE = innodb;

-- Movimento de Finalizadoras Acumuladas
CREATE TABLE movimento_finalizadora_acumulada (
  data_movimento date not null,
  hora_movimento time not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom_origem integer not null,
  codigo_operador int not null,
  valor_acumulado double(16,2) not null,
  situacao integer not null,
  tipo_cupom integer not null,
  tipo_recebimento integer not null,
  primary key(data_movimento, hora_movimento, numero_loja, numero_pdv, numero_cupom_origem)
) ENGINE = INNODB;

CREATE TABLE cesta_basica (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  situacao integer not null,
  codigo_operador int not null,
  tipo_operacao int not null,
  tipo_documento  int not null,
  numero_documento bigint not null,
  nsu_cesta int not null,
  nome_cliente varchar(50) not null,
  id_cesta varchar(15) DEFAULT '',
  primary key(data_movimento, numero_loja, numero_pdv, numero_cupom)
) ENGINE = INNODB;

CREATE TABLE produtos_cesta_basica (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  sequencia integer not null,
  codigo_produto varchar(15),
  quantidade integer not null,
  id_cesta varchar(15) DEFAULT '',
  primary key(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = INNODB;

-- Moeda Estrangeira
CREATE TABLE moeda_estrangeira(
  codigo bigint not null,
  descricao varchar(20) not null,
  valor double(16,2) not null,
  data date,
  PRIMARY KEY(codigo)
) ENGINE = INNODB;

-- Transacao Trafegada Socket
CREATE TABLE transacao_trafegada_socket(
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  sequencia integer not null,
  tipo_transacao integer not null,
  situacao_transacao integer not null,
  buffer_enviado varchar(256) not null,
  buffer_recebido varchar(256) not null,
  tipo_servico integer not null,
  servico integer not null,
  qtd_tentativas integer not null,
  porta integer not null,
  tamanho_buffer_enviado integer not null default 0,
  obj BLOB,
  PRIMARY KEY(data_movimento, numero_loja, numero_pdv, sequencia)
) ENGINE = INNODB;

CREATE TABLE finalizadora_autorizada (
  tipo_de_servico integer not null,
  codigo_finalizadora integer not null,
  percentual_minimo_pagamento double(16,2),
  vis_min_vlr tinyint(1) not null default 0,
  PRIMARY KEY(tipo_de_servico, codigo_finalizadora)
) ENGINE = INNODB;

CREATE TABLE juros_progressivos (
  codigo_loja integer not null,
  codigo_finalizadora integer not null,
  de integer not null,
  ate integer not null,
  juros double(16,2) not null,
  fxa_pdr tinyint(1) not null default 0 ,
  PRIMARY KEY (codigo_loja, codigo_finalizadora, de, ate)
) ENGINE = innodb;


-- Resposta Trasnsacao AA Riachuelo
CREATE TABLE resposta_transacao_aa(
  numero_cartao bigint not null,
  indicador_venda integer not null,
  situacao_cartao varchar(1) not null,
  situacao_conta varchar(1) not null,  
  valor_saldo_disponivel double(16,2) not null,
  tipo_cliente integer not null,
  nome_cliente varchar(30) not null,
  data_nascimento date not null,
  numero_controle_pedido integer not null,
  codigo_autorizacao integer not null,
  numero_vencimento integer not null,
  indicador_formalizacao integer not null,
  indicador_atualizacao integer not null,
  ddd_residencial integer not null,
  telefone_residencial integer not null,
  ddd_comercial integer not null,
  telefone_comercial integer not null,
  ramal_comercial integer not null,
  ddd_celular integer not null,
  telefone_celular integer not null,
  mensagem_indicador_venda varchar(20) not null,
  off_line tinyint(1) not null default 0,
  id_desconto integer not null,
  percentual_desconto integer not null,
  tipo_desconto integer not null,  
  PRIMARY KEY(numero_cartao)
) ENGINE = INNODB;

-- dados_plano_escolhido (Transacao Cartao Riachuelo B)
CREATE TABLE dados_plano_escolhido(
  numero_cupom int not null,
  numero_cartao bigint not null,
  numero_contrato integer not null,
  codigo_tabela_financiamento integer not null,
  finalizadora integer not null,
  quantidade_parcelas integer not null,
  valor_venda double(16,2) not null,
  valor_entrada double(16,2) not null,
  valor_parcela double(16,2) not null,
  valor_despesa double(16,2) not null,
  valor_financiar double(16,2) not null,
  valor_tac double(16,2) not null,
  valor_iof double(16,2) not null,
  primeiro_lancamento date not null,
  codigo_autorizacao integer not null,
  numero_controle integer not null,
  reaproveita_cupom integer not null,
  situacao integer not null,
  tipo_cliente integer not null,
  tipo_cartao integer not null,
  juros_mes double(16,2) not null,
  juros_ano double(16,2) not null,
  nome_cliente varchar(40),
  numero_comprovante int not null,
  codigo_versao int not null,
  PRIMARY KEY(numero_cupom)
) ENGINE = INNODB;

CREATE TABLE motivo (
  codigo_tipo_motivo integer not null,
  codigo_motivo integer not null,
  descricao varchar(100) not null,
    dha tinyint(1) not null default 0 ,
  PRIMARY KEY(codigo_tipo_motivo, codigo_motivo)
) ENGINE = innodb;

-- feriado
CREATE TABLE feriado(
  id integer not null,
  numero_loja integer not null,
  data_feriado date not null,
  tipo_feriado integer not null,
  descricao varchar(60) not null,
  PRIMARY KEY(id)
) ENGINE = INNODB;

-- recebimento
CREATE TABLE recebimento(
  id integer not null,
  descricao varchar(60) not null,
  multa double(16,2) not null,
  encargos double(16,2) not null,
  dias_atraso integer not null,
  codigo_atraso integer not null,
  inclui_dia tinyint(1) not null default 0,
  aceita_pagto_sem_juros tinyint(1) not null default 0,
  obriga_captura_pagto_minimo tinyint(1) not null default 0,
  aceita_desconto tinyint(1) not null default 0,
  PRIMARY KEY(id)
) ENGINE = INNODB;


-- recebimento_detalhe 
CREATE TABLE recebimento_detalhe(
  id_pai integer not null,
  id integer not null,
  descricao varchar(60) not null,
  planilha integer not null,
  PRIMARY KEY(id_pai, id)
) ENGINE = INNODB;


-- dia de corte
CREATE TABLE dia_corte (
  dia integer not null,
  dia_antecipacao integer not null,
  PRIMARY KEY(dia)
) ENGINE = INNODB;

-- cadastro de banco
CREATE TABLE banco (
  codigo_banco integer not null,
  nome varchar(50) not null,
  dgi INTEGER NOT NULL,
  PRIMARY KEY(codigo_banco)
) ENGINE = INNODB;

-- tabelas especificas riachuelo

CREATE TABLE riach_parametro (
  codigo_loja INTEGER NOT NULL,
  valor_min_cons_serasa double(16,2),
  codigo_padrao_vendedor INTEGER,
  msg_entrega_cartao VARCHAR(100),
  msg_validade_op VARCHAR(100),
  destaca_cupom tinyint(1) default 0,
  habilita_vendedor tinyint(1) default 0,
  msg_rodape_1 VARCHAR(40),
  msg_rodape_2 VARCHAR(40),
  msg_rodape_3 VARCHAR(40),
  msg_video VARCHAR(100),
  qtd_max_doc_gaveta INTEGER,
  nr_vias_recibo INTEGER,
  nr_meses_receb_atraso INTEGER,
  preco_maximo_venda double(16,2),
  dias_desbloq_desc_func INTEGER NOT NULL default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = INNODB;

CREATE TABLE riach_prior_transacoes (
  transacao INTEGER NOT NULL,
  prioridade VARCHAR(1) NOT NULL,
  PRIMARY KEY(transacao, prioridade)
) ENGINE = INNODB;

CREATE TABLE cadastro_redes_cartao (
  codigo int not null,
  descricao varchar (60) not null,
  PRIMARY KEY(codigo) 
) ENGINE = innodb;

CREATE TABLE riach_financ_terceiro (
  codigo_loja INTEGER NOT NULL,
  codigo_operacao INTEGER,
  descricao_operacao VARCHAR(100),
  numero_prestacoes INTEGER,
  codigo_plano_financiado INTEGER,
  limite_alcada double(16,2),
  contingencia double(16,2),
  tolerancia double(16,2),
  codigo_administradora INTEGER,
  valor_max_recebimento double(16,2),
  PRIMARY KEY(codigo_loja)
) ENGINE = INNODB;

CREATE TABLE riach_financiamento (
  codigo_tabela INTEGER NOT NULL,
  descricao VARCHAR(30) NOT NULL,
  sequencia_video INTEGER NOT NULL,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NOT NULL,
  carencia_dias INTEGER,
  mes_vencimento INTEGER,
  entrada_obrigatoria tinyint(1) not null default 0,
  entrada_minima double(16,2) DEFAULT '0',
  entrada_maxima double(16,2) DEFAULT '0',
  taxa_juros double(16,2) DEFAULT '0',
  taxa_iof double(16,2) DEFAULT '0',
  valor_tac double(16,2) DEFAULT '0',
  taxa_anual_juros double(16,2) DEFAULT '0',
  tipo_carencia INTEGER,
  valor_minimo_parcela double(16,2) DEFAULT '0',
  codigo_versao INTEGER,
  utilizar_prorata tinyint(1) not null default 0,
  ind_juros tinyint(1) not null default 0,
  ind_iof tinyint(1) not null default 0,
  taxa_juros_coeficiente double(16,2) DEFAULT '0',
  PRIMARY KEY(codigo_tabela)
) ENGINE = INNODB;

CREATE TABLE riach_financ_tipo_cliente (
  codigo_tabela INTEGER NOT NULL,
  codigo_tipo_cliente INTEGER NOT NULL,
  PRIMARY KEY(codigo_tabela, codigo_tipo_cliente),
  FOREIGN KEY(codigo_tabela) REFERENCES riach_financiamento (codigo_tabela)
) ENGINE = INNODB;

CREATE TABLE riach_financ_tipo_cartao (
  codigo_tabela INTEGER NOT NULL,
  codigo_tipo_cartao INTEGER NOT NULL,
  PRIMARY KEY(codigo_tabela, codigo_tipo_cartao),
  FOREIGN KEY(codigo_tabela) REFERENCES riach_financiamento (codigo_tabela)
) ENGINE = INNODB;

CREATE TABLE riach_financ_loja (
  codigo_tabela INTEGER NOT NULL,
  codigo_loja INTEGER NOT NULL,
  PRIMARY KEY(codigo_tabela, codigo_loja),
  FOREIGN KEY(codigo_tabela) REFERENCES riach_financiamento (codigo_tabela)
) ENGINE = INNODB;

CREATE TABLE riach_financ_parcelas (
  codigo_tabela INTEGER NOT NULL,
  qtd_parcelas INTEGER NOT NULL,
  PRIMARY KEY(codigo_tabela, qtd_parcelas),
  FOREIGN KEY(codigo_tabela) REFERENCES riach_financiamento (codigo_tabela)
) ENGINE = INNODB;

CREATE TABLE riach_resumo_caixa (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   codigo_operador int not null,
   sequencia int not null,
   tipo int not null,
   subtipo int not null,
   id int not null,
   qtde int not null,
   valor double(16,2) not null,
   codigo_finalizadora int not null,
   tipo_cartao_presente int not null,
   hora_movimento time not null,
   numero_cupom int not null,
   cliente bigint not null,
   numero_controle bigint not null,
   tipo_produto_financeiro int not null,
   situacao int not null,
   troco double(16,2) not null,
   PRIMARY KEY (data_movimento, numero_loja, numero_pdv, codigo_operador, sequencia)
) ENGINE = INNODB;

CREATE TABLE riach_saque_facil_loja (
  codigo_loja integer not null,  
  url_sipf varchar(100) not null,
  url_web_service_sipf varchar(100) not null,
  PRIMARY KEY(codigo_loja)
) ENGINE = INNODB;

CREATE TABLE riach_saque_facil_pdv (
  codigo_loja integer not null,  
  codigo_pdv integer not null,
  habilitado tinyint(1) not null default 0,
  suprimento_minimo float(8,2) default '0.00',
  suprimento_maximo float(8,2) default '0.00',
  saldo_minimo float(8,2) default '0.00',
  PRIMARY KEY(codigo_loja, codigo_pdv)
) ENGINE = INNODB;

-- tipo de produtos financeiros
CREATE TABLE tipo_produtos_financeiros (
  codigo integer not null,
  descricao varchar(100) not null,
  PRIMARY KEY(codigo)
) ENGINE = INNODB;

-- totalizadores nao fiscais
CREATE TABLE totalizadores_nao_fiscais (
  codigo_totalizador integer not null,
  descricao varchar(100) not null,
  PRIMARY KEY(codigo_totalizador)
) ENGINE = INNODB;


CREATE TABLE totalizadores_nao_fiscais_ecf(
  codigo_totalizador integer not null,
  codigo_hardware integer not null,
  codigo_totalizador_ecf varchar(30) not null,
  PRIMARY KEY(codigo_totalizador, codigo_hardware)
) ENGINE = INNODB;

-- tipo de produtos adesao
CREATE TABLE tipo_produtos_adesao (
  codigo integer not null,
  descricao varchar(100) not null,
  PRIMARY KEY(codigo)
) ENGINE = INNODB;

-- Tabela temporaria de planos & parcelas com varios modos de acesso
CREATE TABLE temp_plano_parcela (
  sequencia integer not null,
  tabela integer not null,
  plano integer not null,
  descricao varchar(30) not null,
  vigencia_inicio date not null,
  vigencia_fim date not null,
  carencia integer not null,
  mes_vencimento integer not null,
  tem_entrada tinyint(1) not null default 0,
  perc_entrada_minima double(16,2) not null,
  perc_entrada_maxima double(16,2) not null,
  taxa_juros_perc_mes double(16,2) not null,
  taxa_juros_perc_ano double(16,2) not null,
  taxa_iof_perc double(16,2) not null,
  valor_tac double(16,2) not null,
  tipo_carencia integer not null,
  valor_minimo_parcela double(16,2) not null,
  codigo_versao integer not null,
  utilizar_prorata tinyint(1) not null default 0,
  ind_juros tinyint(1) not null default 0,
  ind_iof tinyint(1) not null default 0,
  taxa_juros_coeficiente double(16,2) DEFAULT '0',
  PRIMARY KEY(sequencia)
) ENGINE = INNODB;

-- Tabela de configuracao da troca de Mercadorias
CREATE TABLE configuracao_troca_mercadoria (
  codigo_loja integer not null,
  solicitar_nro_boleto tinyint(1) not null default 0,
  validade_troca integer not null,
  solicitar_vendedor tinyint(1) not null default 0,
  exibir_descr_valor_produto tinyint(1) not null default 0,
  aceita_troca_merc_sem_cupom_fiscal tinyint(1) not null default 0,
  solicita_cartao tinyint(1) not null default 0,
  nao_aproveitar_icms_com_cupom tinyint(1) not null default 0,
  nao_aproveitar_icms_sem_cupom tinyint(1) not null default 0,
  dias_para_troca integer not null,
  solicita_cpf_cnpj tinyint(1) not null default 0,
  solicita_nome tinyint(1) not null default 0,
  solicita_telefone tinyint(1) not null default 0,
  solicita_endereco tinyint(1) not null default 0,
  solicita_rg tinyint(1) not null default 0,
  consultar_cupom_concentrador tinyint(1) not null default 0,
  nao_permite_digitar_preco_prod tinyint(1) not null default 0,
  devolver_valor tinyint(1) not null default 0,
  controla_item_ja_devolvido tinyint(1) not null default 0,
  gravar_dados_cliente tinyint(1) not null default 0,
  consultar_cliente_conc tinyint(1) not null default 0,
  nao_solicitar_info_cliente tinyint(1) not null default 0,
  ipm_nom_fan_loj tinyint(1) not null default 0,
  ipm_cnj_loj tinyint(1) not null default 0,
  utl_sel_loj tinyint(1) not null default 0,
  qtd_via integer(11) not null default 0,
  ipm_cfr tinyint(1) not null default 0,
  nao_pmt_rps tinyint(1) not null default 0,
  inf_atm_cnj_loj tinyint(1) not null default 0,
  utl_trc_mse tinyint(1) not null default 0,
  ger_trc_ccd tinyint(1) not null default 0,
  exp_ean_bse_cmu tinyint(1) not null default 0,
  bql_trc_ots_loj tinyint(1) not null default 0,
  blq_trc_cup_can_est tinyint(1) not null default 0,
  blq_cnc_etn_cup_tcd  tinyint(1) not null default 0,
  ipr_cod_bar tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE controle_carga_verificador_preco (
  numero_pdv integer not null,
  numero_carga integer not null,
  data_carga date not null,
  hora_carga time not null,
  carga_pendente tinyint(1) not null default 0,
  PRIMARY KEY(numero_pdv)
) ENGINE = INNODB;

-- consulta verificador precos gertec
CREATE TABLE cons_verificador_preco_gertec (
  codigo_ean bigint not null,
  descricao varchar(50) not null,
  preco double(16,2) not null,    
  x_descricao varchar(10) not null default '10',
  y_descricao varchar(10) not null default '10',
  x_preco varchar(10) not null default '50',
  y_preco varchar(10) not null default '10',
  cor_letra varchar(10) not null default 'black',
  background varchar(10) not null default 'white',
  img_principal varchar(255) not null default '',
  img_casada_1 varchar(255) not null default '',
  img_casada_2 varchar(255) not null default '',
  PRIMARY KEY(codigo_ean)
) ENGINE = INNODB;

CREATE TABLE cons_verificador_preco_tmp (
  codigo_produto bigint not null,
  descricao varchar(50) not null,
  preco double(16,2) not null,
  quantidade double(16,3) not null,
  PRIMARY KEY(codigo_produto)
) ENGINE = INNODB;

-- Tabela de configuracao posicionamento de cheques
CREATE TABLE posicionamento_cheques (
  codigo_banco integer not null,
  codigo_hardware_ecf integer not null,
  valor_linha integer not null,
  valor_coluna integer not null,
  extenso_1_linha integer not null,
  extenso_1_coluna integer not null,
  extenso_2_linha integer not null,
  extenso_2_coluna integer not null,
  favorecido_linha integer not null,
  favorecido_coluna integer not null,
  localidade_linha integer not null,
  localidade_coluna integer not null,
  dia_linha integer not null,
  dia_coluna integer not null,
  mes_linha integer not null,
  mes_coluna integer not null,
  ano_linha integer not null,
  ano_coluna integer not null,
  pre_datado_Linha integer not null,
  pre_datado_coluna integer not null,
  PRIMARY KEY(codigo_banco, codigo_hardware_ecf)
) ENGINE = INNODB;

CREATE TABLE configuracao_protecao_tela (
  codigo_loja integer not null,
  animacao_titulo tinyint(1) not null,
  transicao_imagens tinyint(1) not null,
  exibir_barra_inf tinyint(1) not null,
  tempo_transicao varchar(20) not null,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE configuracao_corban (
  codigo_loja integer not null,
  validar_documento tinyint(1) not null default 0,
  validar_cmc7 tinyint(1) not null default 0,
  limite_maximo  double(16,2) not null,
  desabilitar_captura_manual_cmc7 tinyint(1) not null default 0,
  capturar_cmc7_cabecalho tinyint(1) not null default 0,
  capturar_cmc7_rodape tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE configuracao_comprovante (
  codigo_loja integer not null,
  codigo_relatorio integer not null,
  mostrar_video tinyint(1) not null default 0, 
  remontar_cabecalho_rodape tinyint(1) not null default 0,
  omite_linhas_branco tinyint(1) not null default 0,
  imprime_leitura_x tinyint(1) not null default 0,
  validade_comprovante integer not null default 0,
  num_vias integer not null default 1,
  imprime_titulo_recebido tinyint(1) not null default 0,
  imp_vlr_tot_fin tinyint(1) not null default 0,
  imp_cam_asn tinyint(1) not null default 0,
  imp_vlr_cup_tef tinyint(1) not null default 0,
  imp_tot_ite_can TINYINT(1) NOT NULL DEFAULT 0,
  nao_imp_tef_etb TINYINT(1) NOT NULL DEFAULT 0,
  imp_car_sem_sha TINYINT(1) NOT NULL DEFAULT 0,
  ipm_tck_rdz TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (codigo_loja, codigo_relatorio)
) ENGINE = innodb;

-- Saque Facil

DROP TABLE IF EXISTS `riach_saquefacil`;
CREATE TABLE  `riach_saquefacil` (
  `numero_loja` decimal(3,0) NOT NULL default '0',
  `numero_pdv` decimal(3,0) NOT NULL default '0',
  `codigo_operador` int not null,
  `data` datetime NOT NULL default '0000-00-00 00:00:00',
  `numero_cupom` int(11) NOT NULL default '0',
  `codigo_cliente` decimal(14,0) default '0',
  `chave_transacao` varchar(32) default '',
  `numero_contrato` decimal(9,0) default '0',
  `valor_saque` float(8,2) default '0.00',
  `movimentoFechado` tinyint(1) not null default 0,
  PRIMARY KEY  (`numero_loja`,`numero_pdv`, `data`,`numero_cupom`),
  KEY `riach_saquefacil_FKIndex1` (`numero_loja`,`numero_pdv`,`data`,`numero_cupom`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `riach_suprimento_saquefacil`;
CREATE TABLE  `riach_suprimento_saquefacil` (
  `numero_loja` decimal(3,0) NOT NULL default '0',
  `numero_pdv` decimal(3,0) NOT NULL default '0',
  `codigo_operador` int not null,
  `data` datetime NOT NULL default '0000-00-00 00:00:00',
  `numero_cupom` int(11) NOT NULL default '0',
  `numero_operacao` decimal(6,0) default '0',
  `valor` float(8,2) default '0.00',
  `movimentoFechado` tinyint(1) not null default 0,
  PRIMARY KEY  (`numero_loja`,`numero_pdv`,`data`,`numero_cupom`),
  KEY `riach_suprimento_saquefacil_FKIndex1` (`numero_loja`,`numero_pdv`,`data`,`numero_cupom`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `riach_sangria_saquefacil`;
CREATE TABLE  `riach_sangria_saquefacil` (
  `numero_loja` decimal(3,0) NOT NULL default '0',
  `numero_pdv` decimal(3,0) NOT NULL default '0',
  `codigo_operador` int not null,
  `data` datetime NOT NULL default '0000-00-00 00:00:00',
  `numero_cupom` int(11) NOT NULL default '0',
  `numero_operacao` decimal(6,0) default '0',
  `valor` float(8,2) default '0.00',
  `movimentoFechado` tinyint(1) not null default 0,
  PRIMARY KEY  (`numero_loja`,`numero_pdv`,`data`,`numero_cupom`),
  KEY `riach_sangria_saquefacil_FKIndex1` (`numero_loja`,`numero_pdv`,`data`,`numero_cupom`)
) ENGINE=InnoDB;

CREATE TABLE configuracao_rodape (
  codigo_loja integer not null,
  comprovante_reduzido tinyint(1) not null default 0,
  qtde_max_linhas_cupom_reduzido integer not null,
  msg_rodape_1 varchar(150) not null,
  msg_rodape_2 varchar(150) not null,
  msg_rodape_3 varchar(150) not null,
  msg_rodape_4 varchar(150) not null,
  msg_rodape_5 varchar(150) not null,
  msg_rodape_6 varchar(150) not null,
  msg_rodape_7 varchar(150) not null,
  msg_rodape_8 varchar(150) not null,
  imprimir_operador_rodape tinyint(1) not null default 0,
  imprimir_supervisor_autoriz tinyint(1) not null default 0,
  destacar_icms_cupom tinyint(1) not null default 0,
  imprimir_gerente tinyint(1) not null default 0,
  imprimir_qtd_produtos tinyint(1) not null default 0,
  imprimir_telefone tinyint(1) not null default 0,
  imprimir_desc_cortesia tinyint(1) not null default 0,
  imprimir_nome_versao_sistema tinyint(1) not null default 0,
  imprimir_promocao_fidelidade tinyint(1) not null default 0,
  imprimir_promocao_mix tinyint(1) not null default 0,
  imprimir_demais_promocoes tinyint(1) not null default 0,
  imprimir_prom_fidelidade_nao_aplicados tinyint(1) not null default 0,
  imprimir_socio tinyint(1) not null default 0,
  imprimir_cliente_conveniado tinyint(1) not null default 0,
  imprimir_msg_pre_venda tinyint(1) not null default 0,
  imprimir_endereco_conveniado tinyint(1) not null default 0,
  imprimir_informacao_pontuacao tinyint(1) not null default 0,
  imprimir_codigo_gerente tinyint(1) not null default 0,
  imprimir_msg_campanha tinyint(1) not null default 0,
  imprimir_msg_taxa_entrega tinyint(1) not null default 0,
  imprimir_codigo_pre_venda tinyint(1) not null default 0,
  imprimir_md5 tinyint(1) not null default 0,
  imprimir_msg_resgate tinyint(1) not null default 0,
  imprimir_todos_descontos tinyint(1) not null default 0,
  imprimir_vendedor tinyint(1) not null default 0,
  imprimir_volume_itens tinyint(1) not null default 0,
  imprimir_msg_cartao_spacenet tinyint(1) not null default 0,
  imprimir_total_dum tinyint(1) not null default 0,
  imprimir_total_unidade tinyint(1) not null default 0,
  imprimir_total_pac tinyint(1) not null default 0,
  imprimir_divulgacao_oferta tinyint(1) not null default 0,
  qtd_linhas_mensagem_oferta integer,
  ipm_sha_ped tinyint(1) not null default 0 ,
  ipm_msg_cli_fid tinyint(1) not null default 0 ,
  ipm_msg_cli_nao_fid tinyint(1) not null default 0 ,
  ipm_msg_cph_mrc_cpe tinyint(1) not null default 0 ,
  ipm_idt_cli tinyint(1) not null default 0 ,
  ipm_idt_csr tinyint(1) not null default 0 ,
  ipm_brd tinyint(1) not null default 0,
  ipm_msg_prm_gbl tinyint(1) not null default 0,
  ipm_msg_prm_vch tinyint(1) not null default 0,
  ipm_msg_csr_nao_idt tinyint(1) not null default 0,
  ipm_num_ped_eco tinyint(1) not null default 0,
  ipm_cpf_zmb tinyint(1) not null default 0,
  ipm_fin_prl tinyint(1) not null default 0,
  ipm_tel_mlz tinyint(1) not null default 0,
  ipm_cod_cli tinyint(1) not null default 0,
  ipm_msg_dsc tinyint(1) not null default 0,
  ipm_dad_chq tinyint(1) not null default 0,
  ipm_som_nom_sup tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE item_rodape_prioridade (
  codigo_loja integer not null,
  codigo_item integer not null,
  prioridade integer not null,
  PRIMARY KEY(codigo_loja, codigo_item, prioridade)
) ENGINE = innodb;

CREATE TABLE configuracao_arquivo_clisitef (
  codigo_loja integer not null, 
  sequencia integer not null, 
  tag varchar(60) not null, 
  campo varchar(60) not null, 
  valor varchar(200) not null, 
  PRIMARY KEY(codigo_loja, sequencia) 
) ENGINE = innodb;

CREATE TABLE tabela_operadoras_sevenpdv_tmp (
  codigo varchar(3) not null,
  nome varchar(20) not null,
  PRIMARY KEY(codigo)
) ENGINE = INNODB;

CREATE TABLE configuracao_arquivo_cheque (
  codigo_loja integer not null, 
  sequencia integer not null, 
  tag varchar(60) not null, 
  campo varchar(60) not null, 
  valor varchar(60) not null, 
  PRIMARY KEY(codigo_loja, sequencia) 
) ENGINE = innodb; 

CREATE TABLE  e00_identificacao_software_house (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   mf_adicional varchar(1) not null,
   numero_usuario integer not null,
   tipo_ecf varchar(7) not null,
   marca_ecf varchar(20) not null,
   modelo_ecf varchar(20) not null,
   coo_operacao_troca_aplicativo integer not null,
   numero_aplicativo integer not null,
   cnpj_cpf_software_house bigint not null,
   ie_software_house bigint not null,
   im_software_house bigint not null,
   nome_software_house varchar(40) not null,
   nome_aplicativo varchar(40) not null,
   versao_aplicativo varchar (10) not null,
   dados_programa_aplicativo_linha1 varchar(42) not null,
   dados_programa_aplicativo_linha2 varchar(42) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo)
) ENGINE = innodb; 

CREATE TABLE  e01_identificacao_ecf (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   mf_adicional varchar(1) not null,
   tipo_ecf varchar(7) not null,
   marca_ecf varchar(20) not null,
   modelo_ecf varchar(20) not null,
   versao_sb varchar(10) not null,
   data_gravacao_sb date not null,
   hora_gravacao_sb time not null,
   numero_sequencial_ecf integer not null,
   cnpj_estabelecimento_usuario bigint not null,
   casas_decimais_quantidade integer not null,
   casas_decimais_valor_unitario integer not null,
   comando_geracao_arquivo varchar(3) not null,
   crz_inicial integer not null,
   crz_fiinal integer not null,
   data_inicial date not null,
   data_final date not null,
   versao_biblioteca_fabricante varchar(8),
   versao_ato_cotepe varchar(15),
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao)
) ENGINE = innodb; 

CREATE TABLE  e02_identificacao_contribuinte (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   cnpj_estabelecimento_usuario bigint not null,
   ie_estabelecimento varchar(14) not null,
   nome_contribuinte varchar(40) not null,
   endereco varchar(120) not null,
   data_cadastro_usuario date not null,
   hora_cadastro_usuario time not null,
   cro integer not null,
   gt double(16,2) not null,
   numero_usuario integer not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao)
) ENGINE = innodb; 

CREATE TABLE  e03_identificacao_prestadores_servico_cadastrados (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   numero_prestador integer not null,   
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   data_cadastro date not null,
   hora_cadastro time not null,
   cnpj bigint not null,
   ie varchar(14) not null,
   venda_bruta double(16,2) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, numero_prestador)
) ENGINE = innodb; 

CREATE TABLE  e04_relacao_usuarios_anteriores (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   numero_usuario integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   data_cadastro_usuario date not null,
   hora_cadastro_usuario time not null,
   cnpj bigint not null,
   ie varchar(14) not null,
   cro integer not null,
   gt double(16,2) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, numero_usuario)
) ENGINE = innodb; 

CREATE TABLE  e05_relacao_codificacoes_gt (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   cnpj bigint not null,
   data_gravacao_codificacao_gt date not null,
   hora_gravacao_codificacao_gt time not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   c0 varchar(1) not null,
   c1 varchar(1) not null,
   c2 varchar(1) not null,
   c3 varchar(1) not null,
   c4 varchar(1) not null,
   c5 varchar(1) not null,
   c6 varchar(1) not null,
   c7 varchar(1) not null,
   c8 varchar(1) not null,
   c9 varchar(1) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, cnpj, 
   data_gravacao_codificacao_gt, hora_gravacao_codificacao_gt)
) ENGINE = innodb; 
   
CREATE TABLE  e06_relacao_simbolos_moeda (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   cnpj bigint not null,
   data_gravacao_simbolo_moeda date not null,
   hora_gravacao_simbolo_moeda time not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   simbolo_moeda varchar(4) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, cnpj,
   data_gravacao_simbolo_moeda, hora_gravacao_simbolo_moeda)
) ENGINE = innodb;
   
CREATE TABLE  e07_relacao_alteracoes_versao_sb (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   versaoSB varchar(10) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   dataGravacaoSB date not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, versaoSB)
) ENGINE = innodb;
  
CREATE TABLE  e08_relacao_dispositivos_mfd (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   numero_serie_mfd varchar(30) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   cnpj long not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, numero_serie_mfd)
) ENGINE = innodb;
  
CREATE TABLE e09_relacao_intervencoes_tecnicas (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   cro integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   dataGravacaoCRO date not null,
   horaGravacaoCRO time not null,
   indicadorPerdaDados varchar(1) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, cro)
) ENGINE = innodb;

CREATE TABLE e10_relacao_fitas_detalhe_emitidas (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   contador_fita_detalhe integer not null,
   data_emissao_fita_detalhe date not null,
   coo_primeiro_doc_fita_detalhe integer not null,
   coo_ultimo_doc_fita_detalhe integer not null,
   cnpj bigint not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, contador_fita_detalhe)
) ENGINE = innodb;

CREATE TABLE e11_posicao_atual_contadores_totalizadores (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   contador_reducao_z integer not null,
   contador_reinicio_operacoes integer not null,
   contador_ordem_operacoes integer not null,
   contador_geral_operacoes_nao_fiscal integer not null,
   contador_cupom_fiscal integer not null,
   contador_nota_fiscal_venda_consumidor integer not null,
   contador_bilhete_passagem integer not null,
   contador_geral_relatorio_gerencial integer not null,
   contador_mapa_resumo_viagem integer not null,
   contador_fita_detalhe integer not null,
   valor_acumulado_totalizador_geral double(16,2) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao)
) ENGINE = innodb;

CREATE TABLE e12_relacao_reducoes_z (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   contador_reducao_z integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   contador_order_operacao integer not null,
   contador_reinicio_operacao integer not null,
   data_movimento date not null,
   data_emissao date not null,
   hora_emissao_reducao_z time not null,
   venda_bruta_diaria double(16,2) not null,
   incidencia_desconto_issqn varchar(1) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, contador_reducao_z)
) ENGINE = innodb;

CREATE TABLE e13_detalhe_reducao_z (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   contador_reducao_z integer not null,
   totalizador_parcial varchar(5) not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   valor_acumulado double(16,2) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, contador_reducao_z, totalizador_parcial)
) ENGINE = innodb;

CREATE TABLE e14_cupom_fiscal (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   coo integer not null,
   ccf_cvc_cbp integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   data_inicio_emissao date not null,
   valor_total_documento double(16,2) not null,
   desconto_subtotal double(16,2) not null,
   indicador_tipo_desconto varchar(1) not null,
   acrescimo_subtotal double(16,2) not null,
   indicador_tipo_acrescimo varchar(1) not null,
   total_liquido double(16,2) not null,
   indicador_cancelamento varchar(1) not null,
   valor_cancelamento_acrescimo_subtotal double(16,2) not null,
   ordem_aplicacao_desconto_acrescimo varchar(1) not null,
   nome_adquirente varchar(40) not null,
   cpf_cnpj_adquirente bigint not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, coo)
) ENGINE = innodb;

CREATE TABLE e15_detalhe_cupom_fiscal (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   coo integer not null,
   numero_item integer not null,   
   ccf_cvc_cbp integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   codigo_produto bigint not null,
   descricao_produto varchar(100) not null,
   quantidade double(16,3) not null,
   unidade varchar(3) not null,
   valor_unitario double(16,2) not null,
   desconto_item double(16,2) not null,
   acrescimo_item double(16,2) not null,
   valor_total_liquido double(16,2) not null,
   codigo_totalizador varchar(7) not null,
   indicador_cancelamento varchar(1) not null,
   quantidade_cancelada double(16,2) not null,
   valor_cancelado double(16,2) not null,
   cancelamento_acrescimo double(16,2) not null,
   indicador_arredondamento varchar(1) not null,
   casas_decimais_quantidade integer not null,
   casas_decimais_valor_unitario integer not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, coo, numero_item)
) ENGINE = innodb;
   
CREATE TABLE e16_demais_documentos_emitidos (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   coo integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   contador_geral_operacao_nao_fiscal integer not null,
   contador_geral_relatorio_gerencial integer not null,
   contador_comprov_credito_debito integer not null,
   contador_reducao_z integer not null,
   denominacao_documento_fiscal varchar(2) not null,
   data_final_emissao date not null,
   hora_final_emissao time not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, coo)
) ENGINE = innodb;
   
CREATE TABLE e21_detalhe_cupom_fiscal_meio_pagamento (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   numero_fabricacao varchar(30) not null,
   coo integer not null,
   seq integer not null,
   codigo_fin integer not null,
   ccf integer not null,
   mf_adicional varchar(1) not null,
   modelo_ecf varchar(20) not null,
   numero_usuario integer not null,
   meio_pagamento varchar(15) not null,
   valor_pago double(16,2) not null,
   indicador_estorno varchar(1) not null,
   valor_estornado double(16,2) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo, numero_fabricacao, coo, seq)
) ENGINE = innodb;

CREATE TABLE ead_assinatura_digital (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   tipo varchar(3) not null,
   assinatura_hash varchar(50) not null, 
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, tipo)
) ENGINE = innodb;

CREATE TABLE cat52_ecf (
   codigo_loja integer not null,
   numero_fabricacao varchar(30) not null,
   impressora_matricial tinyint(1) not null default 0,
   mf_adicional varchar(1) not null,
   numero_usuario integer not null,
   tipo_ecf varchar(7) not null,
   marca_ecf varchar(20) not null,
   modelo_ecf varchar(20) not null,
   identificacao_fabricante varchar(2) not null,
   codigo_modelo varchar(1) not null,
   coo_operacao_troca_aplicativo integer not null,
   numero_aplicativo integer not null,
   versao_sb varchar(10) not null,
   data_gravacao_sb date not null,
   hora_gravacao_sb time not null,
   numero_sequencial_ecf integer not null,
   casas_decimais_quantidade integer not null,
   casas_decimais_valor_unitario integer not null,
   comando_geracao_arquivo varchar(3) not null,
   versao_biblioteca_fabricante varchar(8) not null,
   versao_ato_cotepe varchar(15) not null,
   data_gravacao_codificacao_gt date not null,
   hora_gravacao_codificacao_gt time not null,
   c0_codificacoes_gt varchar(1) not null,
   c1_codificacoes_gt varchar(1) not null,
   c2_codificacoes_gt varchar(1) not null,
   c3_codificacoes_gt varchar(1) not null,
   c4_codificacoes_gt varchar(1) not null,
   c5_codificacoes_gt varchar(1) not null,
   c6_codificacoes_gt varchar(1) not null,
   c7_codificacoes_gt varchar(1) not null,
   c8_codificacoes_gt varchar(1) not null,
   c9_codificacoes_gt varchar(1) not null,
   data_gravacao_simbolo_moeda date not null,
   hora_gravacao_simbolo_moeda time not null,
   simbolo_moeda varchar(4) not null,
   cripto varchar(255),
  PRIMARY KEY(codigo_loja, numero_fabricacao)
) ENGINE = innodb;

CREATE TABLE cat52_software_house (
   cnpj_cpf_software_house bigint not null,
   ie_software_house bigint not null,
   im_software_house bigint not null,
   nome_software_house varchar(40) not null,
   nome_aplicativo varchar(40) not null,
   versao_aplicativo varchar (10) not null,
   dados_programa_aplicativo_linha1 varchar(42) not null,
   dados_programa_aplicativo_linha2 varchar(42) not null,
  PRIMARY KEY(cnpj_cpf_software_house)
) ENGINE = innodb;

CREATE TABLE cadastro_bins (
  codigo_bin integer not null,
  tipo_cartao varchar(1) not null,
  descricao varchar(100) not null,
  cartao_proprio tinyint(1) not null default 0,
  codigo_administradora integer not null,
  conv_cred_online  integer not null,
  conv_deb_online  integer not null,
  conv_cred_offline  integer not null,
  conv_deb_offline  integer not null,
  PRIMARY KEY(codigo_bin, tipo_cartao)
) ENGINE = innodb;

-- Obs: tipo_cartao (padrão já utilizado no Superus)
--   C = CRÉDITO
--   D = DÉBITO
--   T = TICKET
--   A = CRÉDITO/DÉBITO

CREATE TABLE taxa_entrega (
  codigo_loja integer not null,
  tipo_veiculo integer not null,
  codigo_regiao integer not null,
  descricao_regiao varchar(100) not null,
  valor double(16,2),
  pmt_dgr tinyint(1) default 0,
  PRIMARY KEY(codigo_loja, tipo_veiculo, codigo_regiao)
) ENGINE = innodb;

CREATE TABLE tipo_veiculo (
  codigo integer not null,
  descricao varchar(60) not null default 0,
  PRIMARY KEY(codigo)
) ENGINE = innodb;

CREATE TABLE empresa_sitef (
  codigo_empresa_sitef varchar(8) not null,
  descricao_empresa varchar(40) not null,
  midway tinyint(1) not null default 0,
  PRIMARY KEY(codigo_empresa_sitef)
) ENGINE = innodb;

CREATE TABLE totalizadores_gerenciais (
  codigo_totalizador integer not null,
  descricao varchar(100) not null,
  PRIMARY KEY(codigo_totalizador)
) ENGINE = innodb;

CREATE TABLE totalizadores_gerenciais_ecf(
  codigo_totalizador integer not null,
  codigo_hardware integer not null,
  codigo_totalizador_ecf varchar(30) not null,
  PRIMARY KEY(codigo_totalizador, codigo_hardware)
) ENGINE = INNODB;

CREATE TABLE pedido_transacao_tef (
  data_pedido datetime not null,
  numero_loja int not null,
  id_transacao int not null,
  numero_pedido bigint not null,
  valor_pedido double(16,2) not null,
  numero_parcelas int not null,
  numero_cartao varchar(100) not null,
  numero_seguranca varchar(100) not null,
  validade varchar(8) not null,
  numero_pdv int not null,
  situacao_pedido int not null,
  data_hora_solicitacao datetime default '0000-00-00 00:00:00',
  data_hora_retorno datetime default '0000-00-00 00:00:00',
  cod_retorno int not null,
  cod_autorizacao varchar(20) not null default '',
  PRIMARY KEY(data_pedido, numero_loja, id_transacao)
) ENGINE = innodb;

CREATE TABLE capa_nota_fiscal (
  data_venda date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_nota_fiscal integer not null,
  numero_cupom_fiscal integer not null,  -- id_transacao = numero_cupom_fiscal
  tipo_nota integer not null,            -- 1-Espelho Nota Fiscal, 2-Espelho Cupom, 3-Nota Fiscal PDV
  numero_pedido bigint not null,
  numero_volume integer not null,
  id_transacao integer not null,
  numero_cpf_cnpj bigint not null,
  razao_social varchar(60) not null,
  nome_fantasia varchar(40) not null,
  endereco varchar(100) not null,
  bairro varchar(100) not null,
  cidade varchar(40) not null,
  estado varchar(2) not null,
  cep varchar(9) not null,
  insc_estadual varchar(14) not null,
  data_emissao date not null,
  total_nota double(16,2) not null,
  despesas double(16,2) not null,
  desconto_cupom double(16,2) not null,
  desconto_item double(16,2) not null,
  acrescimo_cupom double(16,2) not null,
  acrescimo_item double(16,2) not null,
  total_isento double(16,2) not null,
  total_nao_tributado double(16,2) not null,
  total_substituicao double(16,2) not null,
  codigo_fiscal_operacao varchar(10) not null,
  qtde_aliquotas integer not null,
  emitida tinyint(1) not null default 0,
  codigo_operador integer not null,
  usuario_cancelou integer not null,
  motivo_cancelamento integer not null,
  tipo_pedido integer not null,
  codigo_filial_venda integer not null,
  natureza_operacao varchar(100) not null,
  tipo_pessoa varchar(1) not null,
  numero_fone_complemento varchar(30) not null,
  codigo_transportadora integer not null,
  nome_transportadora varchar(100) not null,
  tipo_frete integer not null,
  numero_cpf_cnpj_transport bigint not null,
  quantidade_volume integer not null,
  especie_volume varchar(100) not null,
  marca_volume varchar(100) not null,
  numero_vol varchar(30) not null,
  peso_bruto_volume varchar(30) not null,
  peso_liquido_volume varchar(30) not null,
  transacao_tef integer not null,
  tipo_pagamento integer not null,
  situacao_nota integer not null,
  data_hora_solicitacao datetime default '0000-00-00 00:00:00',
  data_hora_retorno datetime default '0000-00-00 00:00:00',
  numero_cpf_cnpj_filial bigint not null,
  insc_est_filial varchar(14) not null,
  insc_est_subst_filial varchar(14) not null,
  insc_municipal_filial varchar(14) not null,
  razao_social_filial varchar(60) not null,
  endereco_filial varchar(40) not null,
  bairro_filial varchar(20) not null,
  cidade_filial varchar(40) not null,
  estado_filial varchar(2) not null,
  cep_filial varchar(9) not null,
  fone_fax_filial varchar(30) not null,
  fone_fax varchar(30) not null,
  data_saida varchar(10) not null,
  hora_saida varchar(08) not null,
  valor_iss double(16,2) not null,
  total_servicos double(16,2) not null,
  base_icms double(16,2) not null,
  total_icms double(16,2) not null,
  base_substituicao double(16,2) not null,
  total_produtos double(16,2) not null,
  valor_frete double(16,2) not null,
  valor_seguro double(16,2) not null,
  valor_outras_despesas double(16,2) not null,
  valor_ipi double(16,2) not null,
  endereco_transp varchar(100) not null,
  cidade_transp varchar(40) not null,
  estado_transp varchar(02) not null,
  placa_veiculo varchar(20) not null,
  estado_veiculo varchar(02) not null,
  insc_est_transp varchar(14) not null,
  num_filial integer not null,
  num varchar(10) not null default '',
  chv_nfe varchar(60) default '',
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_nota_fiscal, numero_cupom_fiscal)
) ENGINE = innodb;

CREATE TABLE detalhe_nota_fiscal (
  data_venda date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_nota_fiscal integer not null,
  numero_cupom_fiscal integer not null,
  numero_seq integer not null,
  numero_pedido bigint not null,
  numero_volume integer not null,
  id_transacao integer not null,  
  codigo_produto bigint not null,
  descricao_completa varchar(60) not null,
  descricao_reduzida varchar(20) not null,
  natureza_fiscal varchar(3)  not null,
  codigo_sit_tributaria varchar(3) not null,
  qtde_itens double(16,3) not null,
  preco_unitario double(16,2) not null,
  valor_total double(16,2) not null,
  valor_desconto double(16,2) not null,
  valor_acrescimo double(16,2) not null,
  ajuste_positivo double(16,2) not null,
  ajuste_negativo double(16,2) not null,
  situacao integer not null,
  vendedor integer not null,
  usuario_cancelou integer not null,
  motivo_cancelamento integer not null,
  tipo_pedido integer not null,
  tipo_registro integer not null,
  codigo_fiscal_operacao varchar(10) not null,
  classif_fiscal varchar(10) not null,
  sit_tributaria varchar(30) not null,
  unidade varchar(10) not null,
  taxa_icms_iss double(16,2) not null,
  valor_icms_iss double(16,2) not null,
  valor_base_icms_iss double(16,2) not null,
  ean long not null,
  taxa_reducao_icms_iss double(16,2),
  cod_ncm VARCHAR(8),
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_nota_fiscal, numero_cupom_fiscal, numero_seq)
) ENGINE = innodb;

CREATE TABLE dados_adicionais_nota_fiscal (
  data_venda date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_nota_fiscal integer not null,
  numero_cupom_fiscal integer not null,
  numero_seq integer not null,
  numero_pedido bigint not null,
  numero_volume integer not null,
  id_transacao integer not null,  
  mensagem_adicional varchar(200) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_nota_fiscal, numero_cupom_fiscal, numero_seq)
) ENGINE = innodb;

CREATE TABLE complemento_capa_nota_fiscal (
  data_venda date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_nota_fiscal integer not null,
  numero_cupom_fiscal integer not null,
  natureza_fiscal varchar(3) not null,
  numero_pedido bigint not null,
  numero_volume integer not null,
  id_transacao integer not null,  
  base_calculo double(16,2) not null,
  aliquota double(16,2) not null,
  valor_apurado double(16,2) not null,
  observacao varchar(60) not null,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_nota_fiscal, numero_cupom_fiscal, natureza_fiscal)
) ENGINE = innodb;

CREATE TABLE pedido_etiqueta (
  data_pedido datetime not null,
  numero_loja int not null,
  id_transacao int not null,
  numero_pdv int not null,  
  numero_pedido bigint not null,
  codigo_transportadora int not null,
  numero_volume int not null,
  empresa varchar(30) not null,
  tipo_entrega varchar(20) not null,
  seqnf int not null,
  sigla_destino varchar(3) not null,
  cd_pedido_cliente varchar(100) not null,
  rota varchar(6) not null,
  codigo_rastreamento varchar(20) not null,
  codigo_barras varchar(20) not null,
  data_compra datetime not null,
  peso varchar(30) not null,
  item varchar(15) not null,
  numero_remessa varchar(15) not null,
  produto varchar(10) not null,
  data_evento datetime not null,
  valor_declarado double(16,2) not null,
  nome_cliente varchar(200) not null,
  endereco varchar(200) not null,
  endereco_numero varchar(10) not null,
  endereco_complem varchar(100) not null,
  bairro varchar(200) not null,  
  cidade varchar(100) not null,
  cep varchar(20) not null,
  estado varchar(2) not null,
  endereco_referencia varchar(100) not null,
  cb_cep varchar(20) not null,
  data_envio datetime not null,
  telefone varchar(8) not null,
  numero_nota_fiscal varchar(6) not null,    
  situacao_pedido int not null,
  data_hora_solicitacao datetime default '0000-00-00 00:00:00',
  data_hora_retorno datetime default '0000-00-00 00:00:00',
  PRIMARY KEY(data_pedido, numero_loja, id_transacao)
) ENGINE = innodb;

CREATE TABLE pedido_termo_garantia (
  data_pedido datetime not null,
  numero_loja integer not null,
  id_transacao int not null,
  numero_pdv int not null,
  numero_pedido bigint not null,
  codigo_cliente int not null,
  nome_cliente varchar(70) not null,  
  numero_cpf varchar(20) not null,  
  data_nascimento datetime not null, 
  tipo_doc varchar(10) not null,  
  numero_doc varchar(14) not null,  
  data_expedicao datetime not null,
  nome_orgao_exp varchar(10) not null,  
  endereco_completo varchar(120) not null,  
  bairro varchar(40) not null,  
  cidade varchar(40) not null,  
  sigla_uf varchar(2) not null,  
  cep varchar(20) not null,  
  numero_ddd_fone varchar(5) not null,  
  numero_fone varchar(30) not null,  
  codigo_produto varchar(13) not null,  
  nome_produto varchar(255) not null,  
  numero_nota_fiscal varchar(6) not null,  
  data_emissao datetime not null,
  valor_produto double(16,2) not null,
  nr_meses_fabric int not null,
  codigo_garantia varchar(13) not null,  
  codigo_servico varchar(20) not null,  
  numero_periodo int not null,
  data_aquisicao datetime not null,
  numero_apolice varchar(40) not null,  
  numero_certificado varchar(20) not null,  
  dt_inicio_vigencia datetime not null,
  dt_fim_vigencia datetime not null,
  vlr_pago double(16,2) not null,
  vlr_iof double(16,2) not null,
  codigo_filial int not null,
  nome_filial varchar(60) not null,  
  descr_forma_pagto varchar(100) not null,  
  nome_seguradora varchar(60) not null,  
  endereco_seguradora varchar(100) not null,  
  nr_cnpj_seguradora varchar(20) not null,  
  nr_proc_susep varchar(50) not null,  
  nome_fnac varchar(60) not null,  
  numero_cnpj_fnac varchar(20) not null,  
  nome_corretora varchar(60) not null,  
  nr_cnpj_corretora varchar(40) not null,
  nr_susep varchar(40) not null,  
  situacao_pedido int not null,
  data_hora_solicitacao datetime default '0000-00-00 00:00:00',
  data_hora_retorno datetime default '0000-00-00 00:00:00',
  PRIMARY KEY(data_pedido, numero_loja, id_transacao)
) ENGINE = innodb;

CREATE TABLE qtd_produto_promocao_mix (
  codigo_produto bigint not null,
  sequencia integer not null,
  codigo_sub_grupo integer not null,
  quantidade_total double(16,3) not null,
  quantidade_vendida double(16,3) not null,
  PRIMARY KEY(codigo_produto, sequencia)  
) ENGINE = innodb;

CREATE TABLE controle_ponto (
   data date not null,
   hora time not null,
   codigo_loja integer not null,
   codigo_pdv integer not null,
   sequencia integer not null,
   codigo_operador integer not null,
   cod_funcionario varchar(30),
   identificador varchar(2),   
   PRIMARY KEY(data, hora, codigo_loja, codigo_pdv, sequencia)
) ENGINE = innodb;

CREATE TABLE operadoras_pbms (
  codigo_operadora integer not null,
  nome varchar(20) not null,
  PRIMARY KEY(codigo_operadora)
) ENGINE = innodb;

CREATE TABLE operadoras_pbms_complemento (
  codigo_operadora integer not null,
  tipo_complemento integer not null,
  sequencia integer not null,
  msg_atendente varchar(80) not null,
  tipo_campo varchar(1) not null,
  tamanho_minimo integer not null,
  tamanho_maximo integer not null,
  nome_campo varchar(20) not null,
  PRIMARY KEY(codigo_operadora, tipo_complemento, sequencia)
) ENGINE = innodb;

CREATE TABLE cadastro_instituicoes (
  codigo_instituicao integer not null,
  nome_instituicao varchar(100) not null,
  PRIMARY KEY(codigo_instituicao)
) ENGINE = innodb;

CREATE TABLE mapa_teclado (
  codigo_grupo integer not null,
  descricao varchar(50) not null,
  texto_mapa text not null,
  posicao text not null,
  teclado_44_teclas tinyint(1) not null default 0, 
  PRIMARY KEY(codigo_grupo)
) ENGINE = innodb;

CREATE TABLE finalizadora_plano (
  codigo_loja integer not null,
  codigo_finalizadora integer not null,
  codigo_plano integer not null,
  descricao varchar(30) not null,
  sequencia_video integer not null,
  entrada_obrigatoria tinyint(1) not null default 0,
  qtde_parcelas integer not null,
  qtde_dias_entre_parcelas integer not null,
  tipo_juros integer not null,
  taxa_juros double(16,3) default '0',
  forcar_numero_parcelas tinyint(1) not null default 0,
  valor_minimo_parcela double(16,3) default '0',
  primeira_parcela_vista tinyint(1) not null default 0,
  aceita_alterar_vencimento tinyint(1) not null default 0,
  limite_alcada_alt_vencto integer not null default 0,
  fora_dia tinyint(1) not null default 0,
  fora_semana tinyint(1) not null default 0,
  qtd_dias_entrada integer not null default 0,
  codigo_retaguarda integer not null default 0,
  cpv_par integer not null default 0,
  exi_dat_vnc tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja, codigo_finalizadora, codigo_plano)
) ENGINE = innodb;

CREATE TABLE duplicatas_receber (
     numero_duplicata bigint not null,
     situacao int not null,
     nome_empresa varchar(30) not null,
     nome_cliente varchar(30) not null,
     valor_documento double(16,2) not null,
     data_vencimento date not null,
     codigo_cliente varchar(16) not null,
     codigo_empresa varchar(16) not null,
     percentual_juros_mes double(16,2) not null,
     tipo_calculo_juros int not null,
  PRIMARY KEY(numero_duplicata)
) ENGINE = innodb; 

CREATE TABLE movimento_duplicatas_receber (
     data_venda date not null,
     numero_loja integer not null,
     numero_pdv integer not null,
     numero_cupom integer not null,
     hora_venda time not null,
     codigo_operador int not null,
     sequencial int not null,
     situacao int not null,
     numero_duplicata bigint not null,
     nome_empresa varchar(30),
     nome_cliente varchar(30),
     valor_documento double(16,2) not null,
     data_vencimento date not null,
     valor_total_fatura double(16,2) not null,
     codigo_cliente varchar(16),
     codigo_empresa varchar(16),
     percentual_juros_mes double(16,2) not null,
     tipo_calculo_juros int not null,
     codigo_finalizadora int not null,
     status int not null default 0,
     off_line tinyint(1) not null default 0,
  PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom)
) ENGINE = innodb;
 
 CREATE TABLE log_troca_finalizadoras(
  data date not null,
  loja integer not null default 0,
  pdv integer not null default 0,
  numero_cupom integer not null default 0,
  ocorrencia integer not null,
  sequencia integer not null,
  codigo_finalizadora integer not null,
  operador integer not null default 0,
  impresso_fechamento tinyint(1) not null default 0, 
  PRIMARY KEY(data, loja, pdv, numero_cupom, ocorrencia, sequencia,codigo_finalizadora)
) ENGINE = INNODB;

CREATE TABLE secao_pdv (
  codigo_loja integer not null,
  codigo_pdv integer not null,
  codigo_secao integer not null,
  PRIMARY KEY(codigo_loja, codigo_pdv, codigo_secao)
) ENGINE = innodb;

CREATE TABLE cadastro_administradora_cartao (
  codigo integer not null,
  descricao varchar(100) not null,
  sigla_administradora varchar(2) not null,
  PRIMARY KEY(codigo)
) ENGINE = innodb;

-- Administradoras padrão do Documento de Integração Software Express

CREATE TABLE parcelamento_administradoras (
  codigo_loja integer not null,
  codigo_plano integer not null,
  codigo_administradora integer not null,
  valor_parcela_inicial double(16,2) not null,
  valor_parcela_final double(16,2) not null,
  qtde_parcelas integer not null,
  percentual_acrescimo double(16,2) not null,
  tipo_juros integer not null default 0,
  PRIMARY KEY(codigo_loja, codigo_plano, codigo_administradora, valor_parcela_inicial, valor_parcela_final)
) ENGINE = innodb;
 
CREATE TABLE juros_dias_agenda (
  codigo_loja integer not null,
  codigo_finalizadora integer not null,
  dias integer not null,
  juros double(16,2) not null,
  PRIMARY KEY (codigo_loja, codigo_finalizadora, dias)
) ENGINE = innodb;

CREATE TABLE movimento_vale_compra (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   codigo_funcionario int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),
   valor double(16,2) not null,
   codigo_operador int not null,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb; 

CREATE TABLE estorno_venda (
   data_estorno date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   total_estorno double(16,2) not null,
   codigo_operador int not null,
   motivo_estorno int not null,
   data_venda_origem date not null,
   loja_origem integer not null,
   numero_pdv_origem integer not null,
   numero_cupom_origem integer not null,
   PRIMARY KEY(data_estorno, numero_loja, numero_pdv, numero_cupom)
) ENGINE = innodb;

CREATE TABLE produtos_promocao_nestle (
  codigo_produto bigint not null,
  descricao varchar(80) not null,
  PRIMARY KEY(codigo_produto)
) ENGINE = innodb;

CREATE TABLE configuracao_pre_venda (
   codigo_loja integer not null,
   codigo_setor integer not null,
   utiliza_registro_atendimento tinyint(1) not null default 0,
   exibir_alerta tinyint(1) not null default 0,
   caminho_arquivo_som varchar(200),
   utiliza_importacao_txt tinyint(1) not null default 0,
   padrao integer not null,
   caminho_arquivo_txt varchar(200),
   permitir_desconto tinyint(1) not null default 0,
   consultar_matriz tinyint(1) not null default 0,
   destacar_tela_confirmacao tinyint(1) not null default 0,
   tipo_pre_venda integer not null,
   permitir_desconto_pre_venda tinyint(1) not null default 0,
   registrar_pre_venda_durante_venda tinyint(1) not null default 0,
   solicitar_medicamento tinyint(1) not null default 0,
   solicitar_convenio tinyint(1) not null default 0,
   solicitar_cliente tinyint(1) not null default 0,
   solicitar_bin tinyint(1) not null default 0,
   solicitar_vendedor tinyint(1) not null default 0,
   controle_ficha tinyint(1) not null default 0,
   desc_label_controle varchar(25),
   utiliza_balanca tinyint(1) not null default 0,
   carregar_ficha tinyint(1) not null default 0,
   acumular_item tinyint(1) not null default 0,
   identificar_fidelidade tinyint(1) not null default 0,
   conferir_produtos tinyint(1) not null default 0,
   mostrar_preco_custo tinyint(1) not null default 0,
   habilitar_principio_ativo tinyint(1) not null default 0,
   resgatar_preco_fidelidade tinyint(1) not null default 0,
   nao_identificar_cliente tinyint(1) not null default 0,
   registrar_pre_venda_sem_conf tinyint(1) not null default 0,
   nao_participa_promocao_mix tinyint(1) not null default 0,
   permitir_cons_socket_pre_venda tinyint(1) not null default 0,
   ass_vlr_tot_fin tinyint(1) not null default 0,
   utiliza_desc_cliente_fid tinyint(1) not null default 0,
   hab_imp_num_pre_venda tinyint(1) not null default 0,
   numero_de_vias_impr integer not null,
   impressora_num_pre_venda varchar(60) not null default '',
   vis_ite_cnf tinyint(1) not null default 0,
   enr_cnf_ite_pen tinyint(1) not null default 0,
   utiliza_dav tinyint(1) not null default 0,
   nao_acu_fin tinyint(1) not null default 0,
   for_cns_ean tinyint(1) not null default 0 ,
   cns_fid_local tinyint(1) not null default 0 ,
   reg_dav_pdv tinyint(1) not null default 0 ,
   crm_obr tinyint(1) not null default 0 ,
   vld_pvd_ats_cup_fsc tinyint(1) not null default 0 ,
   msr_ind_pbm_fmc_ppl tinyint(1) not null default 0 ,
   msr_cus_liq tinyint(1) not null default 0 ,
   msr_mrg_ral tinyint(1) not null default 0 ,
   msr_per_ral tinyint(1) not null default 0 ,
   msr_est tinyint(1) not null default 0 ,
   psq_prd_pcp_atv tinyint(1) not null default 0 ,
   pga_utl_cpf_nfp tinyint(1) not null default 0 ,
   pcp_ati integer not null ,
   qtd_max_pms integer not null ,
   vrf_prc_vda_pdv tinyint(1) NOT NULL DEFAULT 0 ,
   vld_cam_sat tinyint(1) NOT NULL DEFAULT 0 ,
   pdr_int_dav integer not null,
   pmt_sel_ean tinyint(1) not null default 0,
   for_reg_ite_dav tinyint(1) not null default 0,
   emt_gui_spr_dav tinyint(1) not null default 0,
   hab_tec_rap_qtd_dav tinyint(1) not null default 0,
   vld_ins_etd_dav tinyint(1) not null default 0,
   psq_ini tinyint(1) not null default 0,
   cms_ven_ino_dav tinyint(1) not null default 0,
   sol_usr_inc_ped tinyint(1) not null default 0,
   imp_dad_cli tinyint(1) default 0,
   PRIMARY KEY(codigo_loja, codigo_setor)
)  ENGINE = innodb;

CREATE TABLE movimento_inventario (
  data_inventario date not null,
  numero_inventario integer not null default 0,
  numero_loja integer not null default 0,  
  numero_pdv integer not null default 0,
  sequencia integer not null,
  codigo_ean bigint not null,
  quantidade double(16,3) not null,
  descricao varchar(20) default '',
  unidade varchar(2) default '',
  preco double(16,2) not null,
  codigo_produto bigint not null,
  PRIMARY KEY(data_inventario, numero_inventario, numero_loja, numero_pdv, sequencia)
) ENGINE = innodb;

CREATE TABLE produto_receita (
  numero_loja integer not null,
  codigo_produto bigint not null,
  observacao varchar(100) not null,
  receita varchar(840) not null,
  PRIMARY KEY(numero_loja, codigo_produto)
) ENGINE = innodb;

CREATE TABLE tipo_parcelamento_plano (
  codigo INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(60) NOT NULL
) ENGINE = innodb;

CREATE TABLE plano (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  descricao VARCHAR(60) NOT NULL,
  sequencia_video INTEGER NOT NULL,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NOT NULL,
  entrada_opcional tinyint(1) not null default 0,
  vlr_min_parcela double(16,2) DEFAULT '0',
  codigo_tipo_parcelamento INTEGER NOT NULL,
  nao_adr_cal TINYINT(1) NOT NULL DEFAULT 0,
  vlr_min_cmp_prl double(16,2) DEFAULT '0',
  vrf_lim TINYINT(1) NOT NULL DEFAULT 0,
  qtd_dia_ret_cns_cli TINYINT(1) NOT NULL DEFAULT 0,
  qtd_dia_par_unc INTEGER,
  PRIMARY KEY(codigo_loja, codigo_plano)
) ENGINE = innodb;

CREATE TABLE plano_produto (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  codigo_produto bigint not null,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NOT NULL,
  PRIMARY KEY(codigo_loja, codigo_plano, codigo_produto)
) ENGINE = innodb;

CREATE TABLE plano_secao (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  codigo_secao INTEGER NOT NULL,
  codigo_grupo INTEGER NOT NULL,
  codigo_sub_grupo INTEGER NOT NULL,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NOT NULL,
  PRIMARY KEY(codigo_loja, codigo_plano, codigo_secao, codigo_grupo, codigo_sub_grupo)
) ENGINE = innodb;

CREATE TABLE plano_parcelas (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  qtde_parcelas INTEGER NOT NULL,
  coeficiente_juros double(16,8) DEFAULT '0',
  tip_jur INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY(codigo_loja, codigo_plano, qtde_parcelas)
) ENGINE = innodb;

CREATE TABLE plano_finalizadora (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  codigo_finalizadora INTEGER NOT NULL,
  validar_bin tinyint(1) not null default 0,
  ocu_opc_vta TINYINT(1) NOT NULL DEFAULT 0,
  dia_vnc INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(codigo_loja, codigo_plano, codigo_finalizadora)
) ENGINE = innodb;

CREATE TABLE plano_finalizadora_bin (
  codigo_loja INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  codigo_finalizadora INTEGER NOT NULL,
  codigo_bin INTEGER NOT NULL,
  PRIMARY KEY(codigo_loja, codigo_plano, codigo_finalizadora, codigo_bin)
) ENGINE = innodb;

CREATE TABLE plano_acumulado (
  numero_cupom INTEGER NOT NULL,
  codigo_plano INTEGER NOT NULL,
  valor_acumulado double(16,2) DEFAULT '0',
  valor_utilizado double(16,2) DEFAULT '0',
  PRIMARY KEY(numero_cupom, codigo_plano)
) ENGINE = innodb;

CREATE TABLE cadastro_ticket (
  codigo_loja integer not null,
  codigo_ticket integer not null,
  descricao varchar(100) not null,
  percentual double(16,2),  
  PRIMARY KEY(codigo_loja, codigo_ticket)
) ENGINE = innodb;

CREATE TABLE inventario_pdv (
  data_inventario date not null,
  numero_inventario integer not null default 0,
  numero_loja integer not null default 0,  
  numero_pdv integer not null default 0,
  situacao integer not null,
  data_hora_inicio datetime,
  data_hora_fechamento datetime,
  PRIMARY KEY(data_inventario, numero_inventario, numero_loja, numero_pdv)
) ENGINE = innodb;

CREATE TABLE entrega_cartao_fidelidade (
  data_hora datetime not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cpf bigint not null,
  situacao integer not null,
  id_transacao integer not null,
  codigo_operador int not null,
  numero_cartao varchar(20),
  primary key(data_hora, numero_loja, numero_pdv, numero_cpf)
) ENGINE = INNODB;

CREATE TABLE movto_taxa_entrega (
  data_venda date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  codigo_operador integer not null,
  codigo_veiculo integer not null,
  codigo_regiao integer not null,
  valor_taxa double(16,2) not null,
  situacao integer not null,
  vlr_fin DOUBLE NOT NULL,
  usu_aut INTEGER NOT NULL,
  PRIMARY KEY (data_venda, numero_loja, numero_pdv, numero_cupom)
) ENGINE = innodb;

CREATE TABLE resgate_vale_troca (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   codigo_vale_troca varchar(40),
   valor double(16,2) not null,
   codigo_operador int not null,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_vale_troca)
) ENGINE = innodb;

create table executar_funcao_keycode (
	id_gerenciador integer not null,
	key_code integer not null,
    descricao varchar(40) not null,
	primary key (id_gerenciador, key_code)
) ENGINE = innodb;


CREATE TABLE movimento_entrada_operador (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   sequencia_operador integer not null,
   codigo_operador int not null,
   data_hora_entrada datetime not null,
   grande_total_inicial double(16,2) not null,
   grande_total_final double(16,2) not null,
   contador_inicial int not null,
   contador_final int not null,
   contador_reducao int not null,
   cancelado double(16,2) not null,
   desconto double(16,2) not null,
   numero_cupom_atual integer not null,
   mtc INTEGER not null default 0,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, sequencia_operador)
) ENGINE = innodb;

CREATE TABLE movimento_saida_operador (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   sequencia_operador integer not null,
   codigo_operador int not null,
   data_hora_saida datetime not null,
   grande_total_inicial double(16,2) not null,
   grande_total_final double(16,2) not null,
   contador_inicial int not null,
   contador_final int not null,
   contador_reducao int not null,
   cancelado double(16,2) not null,
   desconto double(16,2) not null,
   numero_cliente_atend int not null,
   numero_cupom_atual integer not null,
   mtc INTEGER not null default 0,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, sequencia_operador)
) ENGINE = innodb;

CREATE TABLE totalizadores_ecf (
  numero_loja integer not null,  
  codigo_hardware integer not null,
  codigo_totalizador integer not null,
  codigo_totalizador_nao_fiscal varchar(30) not null,  
  codigo_totalizador_gerencial varchar(30) not null,
  codigo_indice_totalizador varchar(30) not null,
  indice_positivo tinyint(1) not null default 1,
  PRIMARY KEY(numero_loja, codigo_totalizador, codigo_hardware)
) ENGINE = innodb;

CREATE TABLE configuracao_tef (
  id_configuracao_tef integer not null AUTO_INCREMENT,  
  descricao varchar(30) not null default '',  
  ip_tef_primario varchar(30) not null default '',
  ip_tef_secundario varchar(30) not null default '',
  gateway_primario varchar(30) not null default '',
  gateway_secundario varchar(30) not null default '',
  tempo_reinicio_thread integer not null default 0,
  timeout_gateway integer not null default 0,
  codigo_empresa_sitef varchar(8) not null default '',
  PRIMARY KEY(id_configuracao_tef)
) ENGINE = innodb;

create table cad_param (
  id integer not null auto_increment,
  descricao varchar(100) not null,  
  primary key (id)
) ENGINE = innodb;

create table param_atributos (
  id_cad_param integer not null,
  atributo varchar(60) not null,  
  valor varchar(150) not null,  
  comentario varchar(255) default '',
  primary key (id_cad_param, atributo)
) ENGINE = innodb;

CREATE TABLE loja (
  codigo_loja integer not null,
  razao varchar(60) not null,
  endereco varchar(60) not null,
  numero integer not null,
  cidade varchar(60) not null,
  bairro varchar(20) not null,
  sigla_estado varchar(2) not null,
  cep varchar(10) not null,
  ddd varchar(4),
  fone varchar(10),
  cnpj bigint not null,
  insc_estadual varchar(16) not null,
  insc_municipal varchar(16),
  cripto varchar(255),
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE configuracao_loja (
  codigo_loja integer not null,
  codigo_nivel integer not null,
  finalizadora_diversos integer,
  matriz tinyint(1) not null default 0,
  horario_verao tinyint(1) not null default 0,
  desconto_maximo double(16,2) not null,
  acrescimo_maximo double(16,2) not null,
  ip_matriz varchar(16) not null,
  ip_loja varchar(16) not null,
  ip_retaguarda varchar(16) not null,
  ip_tef varchar(16) not null,
  codigo_empresa_sitef varchar(8) not null,
  qtd_digitos_etiqueta integer not null,
  buscar_peso tinyint(1) not null default 0,
  calc_digito_balanca tinyint(1) not null default 0,
  retaguarda_especifica integer not null,
  cliente_especifico integer not null,
  integracao_econect integer not null,
  utiliza_corban tinyint(1) not null default 0,
  fechamento_dia_auto tinyint(1) not null default 0,
  conf_autom_apos_pagto_concluido tinyint(1) not null default 0,
  solic_motivo_troca_merc tinyint(1) not null default 0,
  solic_motivo_descto tinyint(1) not null default 0,
  solic_motivo_sangria tinyint(1) not null default 0,
  captura_cartao_inicio tinyint(1) not null default 0,
  controla_vendedor tinyint(1) not null default 0,
  forca_emissao_x tinyint(1) not null default 0,
  tempo_envio_mapa_resumo integer not null,
  comprovante_reduzido tinyint(1) not null default 0,
  emitir_cheques_sangria tinyint(1) not null default 0,
  msg_rodape_1 varchar(40) not null,
  msg_rodape_2 varchar(40) not null,
  msg_rodape_3 varchar(40) not null,
  usuario_nao_desbloq_ele_mesmo tinyint(1) not null default 0,
  sincronizar_hora_pdv_servidor tinyint(1) not null default 0,
  controla_promocao_por_loja tinyint(1) not null default 0,
  controla_nivel_preco_por_loja tinyint(1) not null default 0,
  mfd_perc_alerta integer not null,
  mfd_perc_bloqueio integer not null,
  habilitar_suspensao_operador tinyint(1) not null default 0,
  forcar_batimento_caixa tinyint(1) not null default 0,
  controlar_protecao_tela_por_loja tinyint(1) not null default 0,
  utiliza_recarga tinyint(1) not null default 0,
  loja_offline tinyint(1) not null default 0,
  imprime_codigo_generico tinyint(1) not null default 0,
  tentativas_batimento integer not null default 0,
  codigo_nivel_padrao integer not null,
  codigo_gerente integer not null,
  utiliza_private_label tinyint(1) not null default 0,
  nome_private_origem varchar(20) not null,
  nome_private_destino varchar(20) not null,
  utilizar_batimento_caixa tinyint(1) not null default 0,
  cons_etiqueta_balanca_ean tinyint(1) not null default 0,
  percentual_limite_alcada double(16,2) not null default 0,
  solicitar_convenio_conveniado tinyint(1) not null default 0,
  cancelar_item_sequencia tinyint(1) not null default 0,
  forcar_captura_fundo_caixa tinyint(1) not null default 0,
  controla_produto_por_loja tinyint(1) not null default 0,
  delimitador_cartao_inicial varchar(1) not null,
  delimitador_cartao_final varchar(1) not null,
  exportar_movimento_venda_local tinyint(1) not null default 0,
  tecla_rapida_tef_corban tinyint(1) not null default 0,  
  emite_cupom_isencao_estacionamento tinyint(1) not null default 0,  
  valor_minimo_venda double(16,2) not null default 0,
  controla_prod_contr_por_loja tinyint(1) not null default 0,
  solic_motivo_cancelamento tinyint(1) not null default 0,
  verificar_gaveta_aberta tinyint(1) not null default 0,
  solic_cliente_inicio_venda tinyint(1) not null default 0,
  utiliza_fidel_cliente tinyint(1) not null default 0,
  gerar_arquivo_cat52 tinyint(1) not null default 0,
  prioridade_carga integer not null default 0,
  utiliza_desc_cortesia tinyint(1) not null default 0,
  qtde_verifica_gaveta integer not null,
  imprime_descritivo_prod_pesavel tinyint(1) not null default 0,
  utilizar_entrega_cesta_basica tinyint(1) not null default 0,
  utilizar_controle_ponto tinyint(1) not null default 0,
  habilita_desc_operador tinyint(1) not null default 0,
  percentual_desc_operador double(16,2) not null default 0,
  bloquear_desc_produto_promocao tinyint(1) not null default 0,
  deixar_desc_pendente tinyint(1) not null default 0,
  utiliza_rec_fatura_off_line tinyint(1) not null default 0,
  exibir_tabela_motivo tinyint(1) not null default 0,
  quebra_tef_por_redes tinyint(1) not null default 0,
  justifica_diferenca_caixa tinyint(1) not null default 0,
  peso_embalagem double(16,2) not null default 0,
  permite_capturar_peso_valor tinyint(1) not null default 0,
  limite_cancelamento_item integer not null default 0,
  multiplicacao_item double not null default 0,
  controlar_conj_prod_por_loja tinyint(1) not null default 0,
  algoritmos integer not null default 1,
  hora_agendamento varchar(40),
  fator_divisao double not null default 0,
  troco_maximo_doacao double not null default 0,
  verificar_troco tinyint(1) not null default 0,
  verificar_nf_paulista tinyint(1) not null default 0,
  forcar_cancel_conjunto_produto tinyint(1) not null default 0,
  diferenciar_produto_conj_cupom tinyint(1) not null default 1,
  unica_pre_venda tinyint(1) not null default 0,
  solic_socio tinyint(1) not null default 0,
  altera_msg_erro tinyint(1) not null default 0,
  diferenciar_preco_prod_ean tinyint(1) not null default 0,
  tratamento_troca_finalizadora tinyint(1) not null default 0,
  log_liberacao_bloqueio tinyint(1) not null default 0,
  tamanho_min_senha integer not null,
  valor_min_compra double(16,2) not null default 0,
  percentual_desconto_sacola double(16,2) not null default 0,
  valor_desconto_sacola double(16,2) not null default 0,
  cadastrar_bin_pdv tinyint(1) not null default 0,
  imprime_cheques_avulsos tinyint(1) not null default 0,
  controla_multiplicacao_secao tinyint(1) not null default 0,
  utilizar_estorno_venda tinyint(1) not null default 0,
  imprimir_comprovante_conjunto tinyint(1) not null default 0,
  identificador_conjunto varchar(1) not null default '',
  identificador_conjunto_seq tinyint(1) not null default 0,
  codigo_gerente_generico integer not null, 
  concentrador_controla_sangria tinyint(1) not null default 0,
  participa_promocao_nestle tinyint(1) not null default 0,  
  delimitador_vendedor varchar(1) not null default '',
  sobrescrever_vendedor tinyint(1) not null default 0,
  forcar_desc_mix_sub_total tinyint(1) not null default 0,
  sangria_concentrador tinyint(1) not null default 0,
  nao_validar_bin_cartao_fidelidade tinyint(1) not null default 0,
  destaca_tela_consulta_produto tinyint(1) not null default 0,
  tempo_timeout_consulta_socket integer not null default 10000,
  id_configuracao_tef integer not null default 0,
  imprimir_descricao_completa_produto tinyint(1) not null default 0,
  utilizar_desc_todos_itens tinyint(1) not null default 0,
  solicitar_envelope_sangria tinyint(1) not null default 0,
  gerar_mfd_mf_autom tinyint(1) not null default 0,
  transmitir_situacao_pdv tinyint(1) not null default 0,
  solicitar_dados_comp_nf_paulista tinyint(1) not null default 0,
  permitir_troco_negativo tinyint(1) not null default 0,
  forcar_preco_promocao tinyint(1) not null default 0,
  ident_cup_origem_cancela_tef tinyint(1) not null default 0,
  reenvia_cupom_ret tinyint(1) not null default 0,
  codigo_nivel_preco_produto_diferenciado integer not null,
  dif_preco_cliente_nao_contri tinyint(1) not null default 0,
  codigo_loja_retaguarda integer not null default 0,
  executar_imp_cadastro_filial tinyint(1) not null default 0,
  capturar_inf_cliente_pinpad tinyint(1) not null default 0,
  verificar_operador_aberto tinyint(1) not null default 0,
  controlar_suspensao_operador_pdv tinyint(1) not null default 0,
  registrar_item_associado_excedente tinyint(1) not null default 0,
  solicitar_liberacao_bloqueio_superus_card tinyint(1) not null default 0,
  solicitar_taxa_entrega_automatico tinyint(1) not null default 0,
  solicitar_confirmacao_produto_balanca tinyint(1) not null default 0,
  desabilitar_reforco_prod_controlado tinyint(1) not null default 0,
  inibir_codigo_seguranca_cartao tinyint(1) not null default 0,
  habilitar_suspensao_venda tinyint(1) not null default 0,
  realizar_trans_private_adm tinyint(1) not null default 0,
  nao_utiliza_promo_conj_prod tinyint(1) not null default 0,
  recurso_perda_foco tinyint(1) not null default 0,
  exibir_desconto_tela tinyint(1) not null default 0,
  gerar_tdm_autom tinyint(1) not null default 0,
  compactar_mfd tinyint(1) not null default 0,
  solic_motivo_acresc tinyint(1) not null default 0,
  utilizar_etq_balanca_qtd tinyint(1) not null default 0,
  ocultar_lista_produto_controlado_batimento tinyint(1) not null default 0,
  nivel_preco_dois integer not null default 0,
  destacar_tela_produto_nao_cadastrado tinyint(1) not null default 0,
  controlar_bebida_alcoolica tinyint(1) not null default 0,
  verificar_nf_paulista_cliente_fidelidade tinyint(1) not null default 0,
  utilizar_controle_estoque tinyint(1) not null default 0,
  utilizar_nivel_preco_promocao tinyint(1) not null default 0,
  verificar_cad_bin_cartao_fidelidade tinyint(1) not null default 0,
  solicitar_ident_bin_fidelidade tinyint(1) not null default 0,
  gerar_arq_tdm_diario_automatico tinyint(1) not null default 0,
  enviar_arq_tdm_matriz tinyint(1) not null default 0,
  destacar_prod_prom tinyint(1) not null default 0,
  recuperar_qualquer_cupom tinyint(1) not null default 0,
  solicitar_cliente_prazo_fin tinyint(1) not null default 0,
  controlar_formacao_dum_individual tinyint(1) not null default 0,
  nao_exportar_movimento_recarga tinyint(1) not null default 0,
  controlar_qtd_cartao_presente tinyint(1) not null default 0,
  qtd_max_tef_compra integer not null default 0,
  controlar_prod_pesavel_ean tinyint(1) not null default 0,
  forcar_captura_vendedor tinyint(1) not null default 0,
  utl_trc_mda tinyint(1) not null default 0,
  dha_msg_epr_crg tinyint(1) not null default 0 ,
  hab_lim_dsc_spv tinyint(1) not null default 0 ,
  env_prm_som_loj tinyint(1) not null default 0 ,
  utl_cap_cpf_ppd tinyint(1) not null default 0 ,
  utl_soc_trc tinyint(1) not null default 0 ,
  vlt_tla_vda_ope tinyint(1) not null default 0 ,
  nao_arm_bin_prm_fid tinyint(1) NOT NULL DEFAULT 0 ,
  utl_ctr_aqt_dia tinyint(1) NOT NULL DEFAULT 0 ,
  controlar_desconto_dum_acima_de tinyint(1) not null default 0,
  nao_cap_con tinyint(1) NOT NULL DEFAULT 0 ,
  nao_cap_cns_chq tinyint(1) NOT NULL DEFAULT 0 ,
  utl_hor_dif_ecf TINYINT NOT NULL DEFAULT 0 ,
  for_prc_prd_ean TINYINT NOT NULL DEFAULT 0 ,
  ptp_ccs_cre TINYINT NOT NULL DEFAULT 0 ,
  nom_fan_loj varchar(60) NOT NULL DEFAULT '' ,
  qtd_max_fin_cup integer not null default 0 ,
  nao_inf_cli_fid_vda TINYINT NOT NULL DEFAULT 0 ,
  ctr_pms_crg TINYINT NOT NULL DEFAULT 0 ,
  imp_cpv_ite_can TINYINT NOT NULL DEFAULT 0 ,
  imp_cpv_dsc_ite TINYINT NOT NULL DEFAULT 0 ,
  utl_mdd_par TINYINT NOT NULL DEFAULT 0 ,
  ctr_ftc_dum_qtd_emb TINYINT NOT NULL DEFAULT 0 ,
  pmt_trc_dia_ant TINYINT NOT NULL DEFAULT 0 ,
  sol_mtv_can_ats_sup TINYINT NOT NULL DEFAULT 0 ,
  dsb_dum_acm_de TINYINT(1) NOT NULL DEFAULT 0 ,
  csd_fam_prd_cal_dsc_apt_de TINYINT(1) NOT NULL DEFAULT 0 ,
  utl_cup_mni TINYINT(1) NOT NULL DEFAULT 0 ,
  rsm_ite_fec_cxa TINYINT(1) NOT NULL DEFAULT 0 ,
  csd_qtd_emb_ean_prm TINYINT(1) NOT NULL DEFAULT 0 ,
  dct_dsc_utp_val_ite TINYINT(1) NOT NULL DEFAULT 0 ,
  utl_prc_vig_prm_fid TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_sol_aut_mtp_ite TINYINT(1) NOT NULL DEFAULT 0 ,
  ctr_dep TINYINT(1) NOT NULL DEFAULT 0 ,
  trt_prd_unt_etq_qtd TINYINT(1) NOT NULL DEFAULT 0 ,
  reg_ite_cod_itr TINYINT(1) NOT NULL DEFAULT 0 ,
  ipr_cpa_via_cli_tef_prl TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_imp_inf_trc_fin_fch_ope TINYINT(1) NOT NULL DEFAULT 0 ,
  acd_doa_tco  TINYINT(1) NOT NULL DEFAULT 0 ,
  gra_prd_via_tec  TINYINT(1) NOT NULL DEFAULT 0 ,
  cal_dsc_fid_bin_fim_vda TINYINT(1) NOT NULL DEFAULT 0 ,
  snz_hor_cpu_ecf TINYINT(1) NOT NULL DEFAULT 0 ,
  qtd_ten_vrf_pda_lik INTEGER NOT NULL DEFAULT 0 ,
  nao_reg_prd_asd TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_sol_qtd_cjt_prd TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_sol_cfr_qtd_cjt_prd TINYINT(1) NOT NULL DEFAULT 0 ,  
  inb_pga_dgo_fch TINYINT(1) NOT NULL DEFAULT 0 ,
  ctr_dum_prm_acm TINYINT(1) NOT NULL DEFAULT 0 ,
  gra_vle_trc TINYINT(1) NOT NULL DEFAULT 0 ,
  for_dsc_prm_lev_pag TINYINT(1) NOT NULL DEFAULT 0,
  ctr_cpf_usu TINYINT(1) NOT NULL DEFAULT 0,
  sol_sup_prd_nao_cad TINYINT(1) NOT NULL DEFAULT 0,
  cli_mod_fid TINYINT(1) NOT NULL DEFAULT 0,
  exi_avs_dvg_mov TINYINT(1) NOT NULL DEFAULT 0,
  pmt_can_grp_fin TINYINT(1) NOT NULL DEFAULT 0,
  blq_cap_ven_tec TINYINT(1) NOT NULL DEFAULT 0,
  hab_ctr_tef_mdd TINYINT(1) NOT NULL DEFAULT 0,
  cap_cel_rcg_ppd TINYINT(1) NOT NULL DEFAULT 0,
  dlt_dat_lim_niv_prc TINYINT(1) NOT NULL DEFAULT 0,
  sol_seq_ite_dsc TINYINT(1) NOT NULL DEFAULT 0,
  sep_tco_ced_doa_fch_ope TINYINT(1) NOT NULL DEFAULT 0,
  dsb_ger_map_rsm tinyint(1) not null default 0,
  env_tab_crg_lib TINYINT(1) NOT NULL DEFAULT 0,
  nao_sgr_vlr_doa TINYINT(1) NOT NULL DEFAULT 0,
  exi_prm_cli TINYINT(1) NOT NULL DEFAULT 0,
  pmt_dgr_num_crt TINYINT(1) NOT NULL DEFAULT 0,
  sol_cmo_fid TINYINT(1) NOT NULL DEFAULT 0,
  sol_cmo_prz TINYINT(1) NOT NULL DEFAULT 0,
  con_cre_prr_apv TINYINT(1) NOT NULL DEFAULT 0,
  idt_ope_cod_idt TINYINT(1) NOT NULL DEFAULT 0,
  rcp_vda_pdv TINYINT(1) NOT NULL DEFAULT 0,
  vis_tds_prd_cns_ite TINYINT(1) NOT NULL DEFAULT 0,
  nao_acu_prm_mix_lev_pag TINYINT(1) NOT NULL DEFAULT 0,
  csd_ean_prm_mix_lev_pag TINYINT(1) NOT NULL DEFAULT 0,
  det_exi_pln_prl TINYINT(1) NOT NULL DEFAULT 0,
  nao_cal_min_pln_din TINYINT(1) NOT NULL DEFAULT 0,
  exp_cad_prm_avn TINYINT(1) NOT NULL DEFAULT 0,
  rlz_bat_cxa_sng TINYINT(1) NOT NULL DEFAULT 0,
  exi_fin_bat_cxa TINYINT(1) NOT NULL DEFAULT 0,
  exi_prc_atc_ger TINYINT(1) NOT NULL DEFAULT 0,
  blq_dsc_man_prm TINYINT(1) NOT NULL DEFAULT 0,
  nao_frm_dum_prm TINYINT(1) NOT NULL DEFAULT 0,
  nao_lim_prd_not TINYINT(1) NOT NULL DEFAULT 0,
  ver_emb_vda TINYINT(1) NOT NULL DEFAULT 0,
  lim_acs_rsm_fsc TINYINT(1) NOT NULL DEFAULT 0,
  des_rdz_srv_gtc TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE impressao_cheque_loja (
  codigo_loja integer not null,
  codigo_pdv integer not null,
  captura_nro_cheque tinyint(1) not null default 0,
  captura_conta_corrente tinyint(1) not null default 0,
  captura_cod_banco tinyint(1) not null default 0,
  captura_agencia tinyint(1) not null default 0,
  captura_cmc7 tinyint(1) not null default 0,  
  imprime_choro tinyint(1) not null default 0,
  favorecido_cheque varchar(60),
  capturar_rodape tinyint(1) not null default 0,
  captura_rg tinyint(1) not null default 0,
  captura_ramal tinyint(1) not null default 0,
  simula_captura_cmc7 tinyint(1) not null default 0,
  validar_cmc7_cheque tinyint(1) not null default 0,
  mostrar_msg_bloqueio_visor_teclado tinyint(1) not null default 0,
  emitir_cheque_data_deposito tinyint(1) not null default 0,
  imp_dad_nfc tinyint(1) not null default 0,
  exi_vlr_ext_tla tinyint(1) not null default 0,
  nao_cal_min_pln_din TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY(codigo_loja, codigo_pdv)
) ENGINE = innodb;

CREATE TABLE cadastro_pdv (
  codigo_pdv integer not null,
  codigo_loja integer not null,  
  codigo_nivel integer,
  numero_pdv integer not null,
  tipo_pdv integer not null,
  troco_abertura double(16,2) not null,
  ip_pdv varchar(16) not null,
  imprime_cheque tinyint(1) not null default 0,
  utiliza_balanca tinyint(1) not null default 0,
  utiliza_scanner tinyint(1) not null default 0,
  utiliza_tef tinyint(1) not null default 0,
  utiliza_teclado tinyint(1) not null default 0,
  gaveta_sol_inv tinyint(1) not null default 0,
  situacao_pdv integer not null,  
  tempo_bloqueio integer not null,
  troca_mercadoria tinyint(1) not null default 0,
  cons_imagem_prod tinyint(1) not null default 0,
  aceita_recebimento tinyint(1) not null default 0,
  tipo_validacao_usu integer not null,
  desativa_corte_bobina tinyint(1) not null default 0,
  tipo_validacao_senha integer not null,
  desativa_contr_abert_fecham tinyint(1) not null default 0,
  troco_maximo double(16,2) not null,
  leitura_mf_automatica tinyint(1) not null default 0,  
  numero_balcao integer not null,
  orientacao varchar(1) not null,
  grupo_carga_coordenada integer not null,
  ip_chama_fila varchar(16) not null default '',
  codigo_empresa_sitef varchar(8) not null default '',
  codigo_pdv_sitef integer not null,
  nivel_log varchar(20) not null default 'INFO',
  controla_finalizadora_descricao tinyint(1) not null default 0,
  prioridade_carga integer not null default 0,
  tentativas_id_usuario integer not null default 0,
  tentativas_id_senha integer not null default 0,
  utiliza_imp_cheque_externa tinyint(1) not null default 0, 
  gravar_log_operacao tinyint(1) not null default 0,
  captura_cartao_pinpad tinyint(1) not null default 0,
  codigo_grupo_teclado integer not null default 0,
  utiliza_desconto_sacola tinyint(1) not null default 0,
  imprimir_cheque_apos_encerrar_cupom tinyint(1) not null default 0,
  id_skin integer default 0,
  ocultar_login_usuario tinyint(1) not null default 0,
  nao_exibir_produto_teclado tinyint(1) not null default 0,
  utilizar_comanda_facil tinyint(1) not null default 0,
  destaca_cupom_tef_automatico tinyint(1) not null default 0,
  solicitar_forma_venda tinyint(1) not null default 0,
  utilizar_nota_fiscal_pdv tinyint(1) not null default 0,
  utilizar_controle_vasilhame tinyint(1) not null default 0,
  desabilitar_limpar_input tinyint(1) not null default 0,
  imprimir_tef_unico_comp tinyint(1) not null default 0,
  ecf_manutencao tinyint(1) not null default 0,  
  utiliza_gaveta_serial tinyint(1) not null default 0,
  confirmar_senha_auto tinyint(1) not null default 0,
  imprimir_prod_duas_linhas tinyint(1) not null default 0,
  aplicar_desc_registro_item tinyint(1) not null default 0,
  acumular_finalizadora_ecf tinyint(1) not null default 0,
  bloquear_promocao_pdv tinyint(1) not null default 0,
  blq_pgt_acm_uma_fin tinyint(1) not null default 0,
  exibir_relogio tinyint(1) not null default 0,
  dha_rec_pda_foc tinyint(1) not null default 0 , 
  dha_soc_trc tinyint(1) not null default 0 ,
  dha_ctr_cnf_prd TINYINT NOT NULL DEFAULT 0 ,
  del_ini_crt varchar(1) not null default '' ,
  del_fim_crt varchar(1) not null default '' ,
  reg_pvd_dav TINYINT NOT NULL DEFAULT 0 ,
  nao_fec_res_pdv TINYINT NOT NULL DEFAULT 0 ,
  ign_prm_dav_pvd TINYINT NOT NULL DEFAULT 0 ,
  ign_prm_csb TINYINT NOT NULL DEFAULT 0 ,
  pdr_tec integer not null default 0 ,
  nao_ctr_enc_dia TINYINT NOT NULL DEFAULT 0 ,
  nao_ini_mov_ecf TINYINT NOT NULL DEFAULT 0 ,
  ctr_idc_aqt TINYINT NOT NULL DEFAULT 0 ,
  ign_prm_rst TINYINT(1) NOT NULL DEFAULT 0 ,
  idt_csm_dur_cda TINYINT NOT NULL DEFAULT 0 ,
  rgt_smt_ped_res TINYINT NOT NULL DEFAULT 0 ,
  blq_cor_ban TINYINT NOT NULL DEFAULT 0 ,
  blq_rec_cel TINYINT NOT NULL DEFAULT 0 ,
  tim_cpn INTEGER ,
  sol_cnv TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_sol_qtd_inv TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_ajt_tot_psv TINYINT(1) NOT NULL DEFAULT 0 ,
  otm_mem_jva TINYINT(1) NOT NULL DEFAULT 0,
  imp_crg_bck TINYINT(1) NOT NULL DEFAULT 0,
  nro_ckt INTEGER NOT NULL DEFAULT 0,
  dsb_cte_beb_alc TINYINT(1) NOT NULL DEFAULT 0,
  dsb_cte_ats_fto TINYINT(1) NOT NULL DEFAULT 0,
  nao_sol_pms_mtp_ite TINYINT(1) NOT NULL DEFAULT 0,
  nao_imp_cpv_fch_opd TINYINT(1) NOT NULL DEFAULT 0,
  ctr_dum_acm_de tinyint(1) not null default 0,
  slt_rcg_cel_tmn_vda tinyint(1) not null default 0,
  dsb_ctr_abe_ope_pdv tinyint(1) not null default 0,
  sol_crg_tab_ino_apc tinyint(1) not null default 0,
  vda_vlr_dif_hab tinyint(1) not null default 0,
  dvl_str_qrc tinyint(1) not null default 0,
  PRIMARY KEY(codigo_pdv)
) ENGINE = innodb;

-- id_aplicacao - 0 - concentrador e 1 - pdv
CREATE TABLE cadastro_skin (
	id_skin integer not null auto_increment,
	descricao varchar(60) not null,
	skin_default tinyint(1) not null default 0,
	id_aplicacao integer not null,
	excluido tinyint(1) not null default 0,
	PRIMARY KEY(id_skin, descricao, id_aplicacao)
) ENGINE = INNODB;


create table produto_lista (
  codigo_loja integer not null,
  codigo_lista integer not null,
  codigo_produto bigint not null,
  primary key (codigo_loja, codigo_lista, codigo_produto)
) ENGINE =  innodb; 

CREATE TABLE configuracao_limpeza (
  codigo_loja integer not null, 
  id_tipo_registro integer not null,
  local_registro varchar(40),
  quantidade_dias integer,
  PRIMARY KEY (codigo_loja, id_tipo_registro, local_registro)
) ENGINE = innodb;

CREATE TABLE permissao_status (
  id_permissao integer not null,
  codigo_status integer not null,
  PRIMARY KEY(id_permissao,codigo_status)
) ENGINE = innodb;

CREATE TABLE solicita_exp_mov_pdv (
  codigo_loja integer not null,
  codigo_pdv integer not null,
  data_movimento date not null,
  situacao integer not null,
  PRIMARY KEY(codigo_loja, codigo_pdv, data_movimento)
) ENGINE = innodb;

CREATE TABLE movimento_sangria (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv int not null,
  numero_cupom int not null,
  codigo_finalizadora int not null,
  numero_envelope bigint not null,
  codigo_operador int not null,
  hora_sangria datetime not null,
  valor_sistema double(16,2) not null,
  valor_sangria double(16,2) not null,
  motivo_sangria int not null,   
  tipo_movimento int not null,
  situacao_sangria int not null,
  usuario_autorizou int,
  sequencia_operador int not null,
  sequencia int not null,
  ctx_sng int not null,
  PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_finalizadora)
) ENGINE = innodb;

CREATE TABLE config_house_cheque (
  id integer not null, 
  diretorio_leitura varchar(200),
  diretorio_gravacao varchar(200),
  extensao_fixa tinyint(1) not null default 0,
  nome_arquivo varchar (30),
  PRIMARY KEY (id)
) ENGINE = innodb;

CREATE TABLE configuracao_gateway (  
  id_gateway int unsigned not null auto_increment,
  codigo_loja integer not null,
  ip_gateway varchar(30) not null default '',
  prioridade tinyint unsigned not null,
  id_tipo_gateway int unsigned not null default 0,
  PRIMARY KEY(id_gateway)   
) ENGINE = innodb;

CREATE TABLE configuracao_gateway_tef (
  id_gateway_tef int unsigned not null auto_increment,
  id_gateway int unsigned not null,
  ip_tef varchar(30) not null default '',
  prioridade tinyint unsigned not null,
  PRIMARY KEY(id_gateway_tef)  
) ENGINE = innodb;

CREATE TABLE configuracao_atual_gateway_tef (
  codigo_loja integer not null,
  id_gateway integer not null,
  id_gateway_tef integer not null,
  situacao_gateway integer not null default 0,
  verifica_retorno_primario tinyint unsigned not null,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE rodape_comprovante (
  codigo_loja integer not null,
  codigo_comprovante integer not null,
  item_rodape integer not null,
  item_rodape_prioridade integer not null,
  PRIMARY KEY(codigo_loja, codigo_comprovante, item_rodape)
) ENGINE = innodb;

CREATE TABLE configuracao_sangria (
  id integer not null, 
  omitir_valor_sangria_aplicacao tinyint(1) not null default 0,
  exibir_msg_sangria_inicio_aplicacao tinyint(1) not null default 0,
  mostrar_finalizadora_limite_sangria tinyint(1) not null default 0,
  exibir_alerta_sangria_concentrador tinyint(1) not null default 0,
  efetuar_sangria_concentrador tinyint(1) not null default 0,
  dtc_pdv_lim_atg tinyint(1) not null default 0,
  ipm_mtv_sng tinyint(1) not null default 0 ,
  ipm_nom_sup tinyint(1) not null default 0 ,
  pmt_rpt_fin tinyint(1) not null default 0,
  dtc_ale_lim_sng tinyint(1) not null default 0,
  PRIMARY KEY (id)
) ENGINE = innodb;

CREATE TABLE cadastro_campanha(
  codigo_loja integer not null,
  codigo integer not null,
  descricao varchar(40) not null default '',
  tipo integer not null,
  modalidade integer not null,
  data_inicio date,
  data_termino date,
  qtd_exigida double(16,3) not null,
  valor_min_compra double(16,2) not null,
  qtd_max_produto double(16,3) not null,
  qtd_definida double(16,3) not null,
  qtd_normal double(16,3) not null,
  valor_max_desconto double(16,2) not null,
  numero_ocorrencia integer not null,
  numero_reincidencia integer not null,
  codigo_fin integer not null,
  codigo_fin_cont integer not null,
  codigo_fin_desc integer not null,
  incremento integer not null,
  hora_inicio datetime,
  hora_termino datetime,
  controlar_pdv tinyint(1) not null default 0,
  perc_desconto double(16,2) not null,
  PRIMARY KEY (codigo_loja, codigo)
) ENGINE = INNODB;

CREATE TABLE parametros_campanha(
  codigo_loja integer not null,
  codigo_campanha integer not null,
  codigo_fin integer not null,
  descricao_fin varchar(20) not null default '',
  codigo_fin_cont integer not null,
  descricao_fin_cont varchar(20) not null default '',
  codigo_fin_desc integer not null,
  descricao_fin_desc varchar(20) not null default '',
  venda_acumulada integer not null,
  data_atualizacao date,
  PRIMARY KEY (codigo_loja, codigo_campanha)
) ENGINE = INNODB;

CREATE TABLE produto_campanha(
  codigo_loja integer not null,
  codigo_campanha integer not null,
  codigo_produto bigint(14) not null,
  descricao_produto varchar(20) not null default '',
  preco_diferenciado double(16,2) not null,
  preco_normal double(16,2) not null,
  PRIMARY KEY (codigo_loja, codigo_campanha, codigo_produto)
) ENGINE = INNODB;

CREATE TABLE perfil_campanha(
  codigo_loja integer not null,
  codigo_campanha integer not null,
  perfil varchar(25) not null default '',
  PRIMARY KEY (codigo_loja, codigo_campanha, perfil)
) ENGINE = INNODB;

CREATE TABLE identificacao_campanha(
  codigo_loja integer not null,
  codigo_campanha integer not null,
  codigo_identificacao bigint not null,
  PRIMARY KEY (codigo_loja, codigo_campanha, codigo_identificacao)
) ENGINE = INNODB;

CREATE TABLE mov_cupom_campanha(
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  hora_venda datetime not null,
  codigo_operador integer not null,
  codigo_campanha integer not null,
  modalidade_campanha integer not null,
  numero_cartao varchar(25) not null default '',
  total_compra double(12,2) not null,
  total_desconto double(12,2) not null,
  total_fin_campanha double(12,2) not null,
  total_outras_fin double(12,2) not null,
  qtd_parcelas integer not null,
  tipo_fechamento integer not null,
  numero_seq_premiada integer not null,
  PRIMARY KEY (data_movimento, numero_loja, numero_pdv, numero_cupom)
) ENGINE = INNODB;

CREATE TABLE mov_produto_campanha(
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  sequencia integer not null,
  codigo_produto bigint(14) not null,
  quantidade double(12,3) not null,
  preco_unitario double(12,2) not null,
  preco_difer double(12,2) not null,
  total double(12,2) not null,
  total_promocao double(12,2) not null,
  PRIMARY KEY (data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = INNODB;

CREATE TABLE convenio_parcela (
   codigo_convenio varchar(16) not null,
   numero_parcela int not null,
   valor_minimo_venda double(16,2) not null,
   percentual_acrescimo double(16,2) not null, 
   valor_acrescimo double(16,2) not null,
   data_atualizacao date not null,
   exg_aut tinyint(1) not null default 0,
   PRIMARY KEY(codigo_convenio, numero_parcela)
) ENGINE = innodb;

CREATE TABLE menu_fiscal (
   codigo integer not null,
   descricao varchar(40) not null,
   descricao_exibicao varchar(40) not null,
   PRIMARY KEY(codigo)
) ENGINE = innodb;

CREATE TABLE informacoes_software (
   cnpj bigint not null,   
   nome varchar(50) not null,
   endereco varchar(60) not null,
   telefone varchar(14) not null,
   contato varchar(20) not null,
   nome_aplicativo varchar(20) not null,
   nome_executavel varchar(20) not null,
   laudo varchar(20) not null,
   md5 varchar(40) not null,
   versao_er_paf_ecf  varchar (08) not null,
   PRIMARY KEY(cnpj)
) ENGINE = innodb;

CREATE TABLE comprovante_emitido (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv integer not null,   
   numero_cupom integer not null,   
   gnf int not null default 0,
   cdc int not null default 0,
   grg int not null default 0,
   tipo varchar(2) not null,
   hora_emissao datetime,   
   cripto varchar(255),
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom)
) ENGINE = INNODB;

CREATE TABLE ecf_nacional (
   codigo_hardware integer not null,   
   codigo_ecf_nacional varchar (08) not null,   
   PRIMARY KEY(codigo_hardware)
) ENGINE = INNODB;

CREATE TABLE servico_finalizadora (
  codigo_servico integer not null,
  codigo_finalizadora integer not null,
  prioridade integer not null,
  consulta_local_offline tinyint(1) not null default 0,  
  bloquear_cheque_nao_cadastrado tinyint(1) not null default 0,  
  autorizacao_desbloquear_cliente tinyint(1) not null default 0,
  codigo_loja integer not null default 0,
  solicitar_dados_adicionais tinyint(1) not null default 0,
  nao_vld_sha tinyint(1) not null default 0,
  tip_cap integer not null,
  PRIMARY KEY(codigo_servico, codigo_finalizadora, codigo_loja)
) ENGINE = innodb;

CREATE TABLE movimento_vasilhame (  
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  codigo_produto bigint(14) not null,
  qtd_informada integer not null default 0,
  qtd_vendida integer not null default 0,
  qtd_excedente integer not null default 0,
  preco double(12,2) not null default 0,
  descricao varchar(25) not null default '',
  qtd_cobrada integer not null default 0,
  seq_ope int not null default 0,
  PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_produto)
) ENGINE = innodb;

CREATE TABLE codigo_fiscal_operacao(
  codigo integer not null,
  descricao varchar(80) not null,
  tipo varchar(80) not null,
  destino varchar(80) not null,
  PRIMARY KEY(codigo)
) ENGINE = innodb;

CREATE TABLE cadastro_modalidade (
   codigo_loja int not null,   
   codigo_modalidade int not null,
   descricao varchar(30) not null default '',
   finalizadora int not null default 0,
   modalidade_compra int not null default 0,
   PRIMARY KEY(codigo_loja, codigo_modalidade)   
) ENGINE = innodb;

CREATE TABLE prioridade_modalidade (
   codigo_loja int not null,   
   prioridade int not null,
   codigo_modalidade int not null,
   PRIMARY KEY(codigo_loja, prioridade, codigo_modalidade)   
) ENGINE = innodb;

CREATE TABLE plano_modalidade (
   codigo_loja int not null,   
   codigo_modalidade int not null,
   codigo_plano int not null,
   descricao varchar(30) not null default '',
   sequencia_exibir int not null default 0,
   numero_parcelas int not null default 0,
   percentual_entrada double(3,2) not null default 0.00,
   PRIMARY KEY(codigo_loja, codigo_modalidade, codigo_plano)   
) ENGINE = innodb;

CREATE TABLE cartao_cliente (
   codigo_cartao integer not null, 
   sequencia_cartao varchar(2) not null,
   nome varchar(40) not null default '',      	
   faturamento int not null default 0, 
   bloqueio int not null default 0,
   sinal1 int not null default 0,  
   saldo_disponivel double(16,2) not null default 0,   
   tipo int(11) not null default 0, 
   limite double(16,2) not null default 0,
   sinal2 int not null default 0,
   saldo_atual double(16,2) not null default 0,	   
   saldo_cheque double(16,2) not null default 0,
   pagamento_minimo double(16,2) not null default 0,
   data_vencimento date,   
   PRIMARY KEY(codigo_cartao, sequencia_cartao)   
) ENGINE = innodb;

CREATE TABLE controle_cliente_pdv (
  codigo_loja integer not null,
  cadastrar_cliente_pdv tinyint(1) not null default 0,
  identificar_cliente_inicio_venda tinyint(1) not null default 0,
  cnpj_loja_cliente_nao_informado tinyint(1) not null default 0,
  utilizar_cliente_pagamento tinyint(1) not null default 0,
  forcar_cliente_inicio_venda tinyint(1) not null default 0,
  identificar_codigo_cliente tinyint(1) not null default 0,
  identificar_cnpf_cpf_cliente tinyint(1) not null default 0,
  utilizar_dados_cliente_cupom tinyint(1) not null default 0,
  forcar_dados_cliente_cupom tinyint(1) not null default 0,
  for_cep_cli_cup tinyint(1) not null default 0,
  sol_cep_cli_cup tinyint(1) not null default 0,
  obr_idt_vlr_cmp tinyint(1) not null default 0 ,
  vlr_min_cmp double null ,
  idt_vlr_cmp tinyint(1) default 0 ,
  dtc_tla_cmp tinyint(1) default 0 ,
  cal_prz_vnc tinyint(1) not null default 0 ,
  sol_att_cli tinyint(1) default 0,
  cli_pdr int default 0,
  ccl_cpf_cnj tinyint(1) default 0,
  sel_cam_obr tinyint(1) default 0,
  sol_aut_sup tinyint(1) default 0,
  txt_idt varchar(50) not null default '',
  sgl_idt varchar(50) not null default '',
  obr_csr_ino_vda TINYINT(1) NOT NULL DEFAULT 0,
  utl_ctr_cli_pdr TINYINT(1) NOT NULL DEFAULT 0,
  aza_cpr_dad_ppd TINYINT(1) NOT NULL DEFAULT 0,
  cap_cpf_unf TINYINT(1) NOT NULL DEFAULT 0,
  url_cns_cli VARCHAR(255) NOT NULL DEFAULT '',
  lik_qrc VARCHAR(255) NOT NULL DEFAULT '' ,
  lab_qrc VARCHAR(255) NOT NULL DEFAULT '' ,
  cli_pdr_cct int default 0,
  PRIMARY KEY(codigo_loja)    
) ENGINE = innodb;

CREATE TABLE mov_cartao_cliente(
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null,
  sequencia integer not null,
  numero_cartao bigint(8) not null default 0,
  codigo_operador integer not null default 0,
  codigo_plano integer not null default 0,
  valor_compra double(12,2) not null default 0,
  tipo varchar(1) not null default '',
  modalidade_compra integer not null default 0,
  numero_parcelas integer not null default 0,
  numero_autorizacao bigint(8) not null default 0,
  numero_banco integer not null default 0,
  data_cheque date,
  valor_juros double(12,2) not null default 0,
  tipo_transacao integer not null default 0,
  situacao integer not null default 0,
  cheque tinyint(1) not null default 0,
  codigo_agencia integer not null default 0,
  sequencia_operador integer not null default 0,
  PRIMARY KEY (data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = INNODB;

CREATE TABLE configuracao_entrega(
  codigo_loja integer not null,
  capturar_cliente tinyint(1) not null default 0,
  capturar_qtd_caixas tinyint(1) not null default 0,
  capturar_num_caixas tinyint(1) not null default 0,
  nao_imprime_comprovante tinyint(1) not null default 0,
  consultar_cliente_servico tinyint(1) not null default 0,
  imprimir_observacoes tinyint(1) not null default 0,
  imprimir_assinatura tinyint(1) not null default 0,
  imprimir_comp_nao_fiscal tinyint(1) not null default 0,
  consultar_cliente_campanha tinyint(1) not null default 0,
  exi_cmo TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (codigo_loja)
) ENGINE = INNODB;

CREATE TABLE cfg_dsc_sla (
  cod_loj INTEGER NOT NULL  ,
  tip_cfg INTEGER NOT NULL  ,
  tip_dsc INTEGER NOT NULL  ,
  dsc DOUBLE NOT NULL  ,
  vlr_min_cmp DOUBLE NOT NULL  ,
  qtd_ite INTEGER NOT NULL  ,
  dsc_aut TINYINT NOT NULL  ,
  PRIMARY KEY (cod_loj, tip_cfg)
) ENGINE = InnoDB
;

CREATE  TABLE cfg_nao_ctb (
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  dha_acr TINYINT NOT NULL  ,
  prc_acr DOUBLE NOT NULL DEFAULT 0  ,
  PRIMARY KEY (sec, grp, sgr, prd)
)ENGINE = InnoDB
;

CREATE TABLE prm_mdd (
  cod_loj INTEGER NOT NULL  ,
  dat_ini DATE NOT NULL  ,
  dat_fim DATE NOT NULL  ,
  PRIMARY KEY (cod_loj, dat_ini, dat_fim)
) ENGINE = InnoDB
;

CREATE TABLE prm_mdd_sem (
  cod_loj INTEGER NOT NULL  ,
  dat_ini DATE NOT NULL  ,
  dat_fim DATE NOT NULL  ,
  dia_sem INTEGER  NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj, dat_ini, dat_fim, dia_sem)
) ENGINE = InnoDB
;

CREATE TABLE prm_mdd_ite (
  cod_loj INT NOT NULL  ,
  dat_ini DATE NOT NULL  ,
  dat_fim DATE NOT NULL  ,
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd INT NOT NULL  ,
  mdd INT NOT NULL  ,
  PRIMARY KEY (cod_loj, dat_ini, dat_fim, sec, grp, sgr, prd)
) ENGINE = InnoDB
;

CREATE TABLE mdd_prd (
  cod_loj INT NOT NULL  ,
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd bigint NOT NULL  ,
  mdd INT NOT NULL  ,
  PRIMARY KEY (cod_loj, sec, grp, sgr, prd)
) ENGINE = InnoDB
;

CREATE TABLE dsc_ite_vda (
  seq INT NOT NULL  ,
  dsc DOUBLE NOT NULL  ,
  tot_ite DOUBLE NOT NULL  ,
  tip_dsc INT NOT NULL  ,
  cod_mix INT NOT NULL  ,
  apl_dsc TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (seq)
) ENGINE = InnoDB
;

CREATE TABLE prd_atc (
  cod_ean bigint not null ,
  qtd_atc DOUBLE NOT NULL  ,
  nao_atl_vlr_imp TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_ean, qtd_atc)
) ENGINE = InnoDB
;

CREATE TABLE prm_mix_lev_pag (
  cod_loj INT NOT NULL  ,
  cod_mix INT NOT NULL  ,
  des VARCHAR(40) NOT NULL  ,
  dat_ini DATE NOT NULL  ,
  dat_fim DATE NOT NULL  ,
  ctr_acm TINYINT NOT NULL  ,
  rat_dsc_prd TINYINT NOT NULL DEFAULT 0  ,
  cal_dsc_ite TINYINT NOT NULL DEFAULT 0  ,
  eft_dsc_sbt tinyint(1) not null default 0 ,
  prm_grl TINYINT NOT NULL DEFAULT 0,
  dst_prd_pes TINYINT(1) not null default 0,
  hor_ini TIME null,
  hor_fim TIME null,
  qtd_max_cup INT NOT NULL DEFAULT 0,
  ctr_prc_fix TINYINT NOT NULL,
  ctr_vlr_acm TINYINT NOT NULL DEFAULT 0,
  cod_cbn INT NOT NULL,
  acu_dsc_ots_prm TINYINT NOT NULL,
  ctr_emb_vda_prd_psv TINYINT(1) NOT NULL,
  tip_prm INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, cod_mix)
) ENGINE = InnoDB
;  

CREATE TABLE prd_mix_lev_pag (
  cod_loj INT NOT NULL  ,
  cod_mix INT NOT NULL  ,
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  ctr_fam TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, cod_mix, sec, grp, sgr, prd)
) ENGINE = InnoDB
;

CREATE TABLE dsc_mix_lev_pag (
  cod_loj INT NOT NULL  ,
  cod_mix INT NOT NULL  ,
  qtd DOUBLE NOT NULL  ,
  dsc DOUBLE NOT NULL  ,
  dsc_vlr TINYINT NOT NULL  ,
  dsc_per TINYINT NOT NULL  ,
  cod_prd BIGINT NOT NULL  ,
  vlr_vda DOUBLE NOT NULL ,
  niv_prc INT NOT NULL ,
  qtd_max DOUBLE NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, cod_mix, qtd)
) ENGINE = InnoDB
;

CREATE TABLE configuracao_carga_loja (
  codigo_loja integer not null,
  efetuar_backup_pdv_apos_z tinyint(1) not null default 1,
  efetuar_download_arq_carga_filial tinyint(1) not null default 0,
  utilizar_carga_coordenada tinyint(1) not null default 0,
  bloquear_carga_produto_matriz tinyint(1) not null default 0,
  gerar_arquivo_produto_filial tinyint(1) not null default 0,
  exibir_aviso_carga_pendente_filial tinyint(1) not null default 0,
  controlar_emissao_etiqueta_carga tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE configuracao_importacao_tabela (
  codigo_loja integer not null,
  id_tabela integer not null,
  nro_minimo_registro bigint not null,
  percentual_tolerancia double not null,  
  PRIMARY KEY(codigo_loja, id_tabela)
) ENGINE = innodb;

CREATE TABLE controle_importacao (
  id_tipo_importacao integer not null,
  situacao_importacao integer not null,
  data_hora_inicio datetime,
  data_hora_termino datetime,
  PRIMARY KEY(id_tipo_importacao)
) ENGINE = innodb;

CREATE TABLE controle_importacao_tabela (
  codigo_loja integer not null,
  id_tipo_importacao integer not null,
  id_tabela integer not null,
  data_hora_inicio datetime,
  data_hora_termino datetime,
  nro_reg_importar bigint not null,
  nro_reg_antes_imp bigint not null,
  nro_reg_depois_imp bigint not null,
  nro_reg_sucesso bigint not null,
  nro_reg_erro bigint not null,
  nro_reg_incons bigint not null,
  situacao_importacao integer not null,
  PRIMARY KEY(codigo_loja, id_tipo_importacao, id_tabela)
) ENGINE = innodb;

CREATE TABLE movimento_desconto (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   tipo_desconto integer not null default 0,
   tipo_promocao integer not null default 0,
   codigo_mix integer not null default 0,
   valor_desconto double(16,2) not null default 0,
   cod_grp_cli varchar(20),
   usu_dsc int not null default 0 ,
   preco_normal double(16,2) not null default 0,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb;

CREATE TABLE config_controle_vasilhame (  
  codigo_loja integer not null,  
  utilizar_coleta_vasilhame_pdv TINYINT(1) NOT NULL DEFAULT 0,
  registrar_item_associado_excedente TINYINT(1) NOT NULL DEFAULT 0,
  imprimir_comprovante tinyint(1) not null default 1,
  sol_cpv_vas_exc tinyint(1) not null default 0,
  blq_cpv_fra_dat_ger tinyint(1) not null default 0,
  nao_imp_cpv_dvl_bal tinyint(1) not null default 0,
  tip_ctr_dvl integer not null default 1,
  nao_imp_cpv_txt tinyint(1) not null default 0,
  sol_opr_cpv tinyint(1) not null default 0,
  emt_rsm_fec tinyint(1) not null default 0,
  sol_sup_cob tinyint(1) not null default 0,
  sol_sup_dvl tinyint(1) not null default 0,
  blq_alt_cpv_utl tinyint(1) not null default 0,
  ctr_ent_cob_vas tinyint(1) not null default 0,
  pmt_can tinyint(1) not null default 0,
  ipr_cod_bar tinyint(1) not null default 0,
  pmt_bxa_parc TINYINT(1) NOT NULL DEFAULT 0,
  ctr_rgt_pgt TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE controle_vasilhame_tmp (  
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  numero_cupom integer not null, 
  codigo_comprovante bigint(14) not null,
  PRIMARY KEY(data_movimento, numero_loja, numero_pdv, numero_cupom, codigo_comprovante)
) ENGINE = innodb;

CREATE TABLE cad_campanha_fidel(
  codigo_loja integer not null,
  codigo integer not null,
  qtd_cupom_fidel integer not null default 0,
  valor_compra_fidel double(16,3) not null default 0,
  qtd_cupom integer not null default 0,
  valor_compra double(16,3) not null default 0,
  status tinyint(1) not null default 0,
  data_sorteio date,
  observacao varchar(200) not null default '',
  mensagem varchar(80) not null default '',
  identificacao_prod varchar(10) not null default '',
  PRIMARY KEY (codigo_loja, codigo)
) ENGINE = INNODB;

CREATE TABLE cpf_cnpj_nao_permitidos(
  identificacao integer not null,
  cpf_cnpj bigint not null default 0,
  PRIMARY KEY(identificacao, cpf_cnpj)
) ENGINE = innodb;

CREATE TABLE estado (
  sigla_estado varchar(2) not null,
  estado varchar(20) not null,
  PRIMARY KEY(sigla_estado)
) ENGINE = innodb;


CREATE TABLE produto_campanha_fidel(
  codigo_loja integer not null,
  codigo_campanha integer not null,
  codigo_produto bigint(14) not null,
  qtd_prod_fidel double(16,3) not null,
  qtd_cupom_fidel integer not null,
  qtd_prod double(16,3) not null,
  qtd_cupom integer not null,
  PRIMARY KEY (codigo_loja, codigo_campanha, codigo_produto)
) ENGINE = INNODB;

CREATE TABLE finalizadora_tipo (
   codigo_loja integer not null,
   codigo_finalizadora integer not null,
   tipo integer not null,
   PRIMARY KEY(codigo_loja, codigo_finalizadora, tipo)
) ENGINE = innodb;

CREATE TABLE mov_cadastro_clientes (
  data_movimento date not null,
  numero_loja integer not null,
  numero_pdv integer not null,
  sequencia integer not null,
  cpf_cnpj bigint not null default 0,
  insc_estadual varchar(14) not null default '',
  nome_razao varchar(40) not null default '',
  endereco varchar(40) not null default '',
  numero varchar(10) not null default '',
  bairro varchar(20) not null default '',
  cidade varchar(20) not null default '',
  estado varchar(2) not null default '',
  cep varchar(9) not null default '',
  ddd_telefone varchar(4) not null default '',
  numero_telefone varchar(12) not null default '',
  codigo_cliente bigint not null default 0,
  situacao integer not null default 0,
  tipo_cliente integer not null default 0,
  limite double not null default 0,
  acumulado double not null default 0,
  nivel_preco int not null default 0,
  data_atualizacao date not null,
  lista_negra tinyint(1) not null default 0,
  exibe_mensagem tinyint(1) not null default 0,
  mensagem varchar(50) not null,
  consulta_serasa tinyint(1) not null default 0,
  informacoes_credito varchar(820) not null,
  complemento varchar(40) not null default '',
  PRIMARY KEY(data_movimento, numero_loja, numero_pdv, sequencia)
) ENGINE = innodb;

CREATE TABLE configuracao_ntp (
   codigo_loja integer not null,
   sincronizar_conc tinyint(1) not null default 0,
   ip_ntp_conc varchar(40) not null,
   sincronizar_pdv tinyint(1) not null default 0,
   ip_ntp_pdv varchar(40) not null,
   PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE operadora_pbm (
  codigo_rede_pbm integer not null,
  codigo_operadora_pbm integer not null,
  descricao varchar(50) not null,
  cod_ope varchar(40) not null default '' ,
  PRIMARY KEY(codigo_rede_pbm, codigo_operadora_pbm)
) ENGINE = innodb;

CREATE TABLE config_finalizadora_pbm (
  codigo_loja integer not null,
  codigo_finalizadora integer not null,
  codigo_rede_pbm integer not null,
  codigo_operadora_pbm integer not null,
  utiliza_calculo_preco_fabrica tinyint(1) not null default 0,
  codigo_nivel_preco_fabrica integer default 0,
  desativar_desconto_produto tinyint(1) not null default 0,
  desativar_subsidio_produto tinyint(1) not null default 0,
  cal_dsc_per tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja, codigo_finalizadora)
) ENGINE = innodb;

CREATE TABLE redes_pbm(
 id_rede_pbm integer not null,
 descricao varchar(50) not null,
 configurar_url_web_service tinyint(1) not null default 0,
 convenio tinyint(1) not null default 0,
 primary key(id_rede_pbm)
)ENGINE = innodb;

CREATE TABLE configuracao_redes_pbm(
 codigo_loja integer not null,
 id_rede_pbm integer not null,
 desc_label_tela varchar(60) not null,
 finalizadora_desconto integer not null,
 finalizadora_subsidio integer not null,
 numero_vias integer not null,
 autentica varchar(20) default '',
 url_web_service varchar(255) default '', 
 utiliza_calculo_preco_fabrica tinyint(1) not null default 0,
 codigo_nivel_preco_fabrica integer default 0,
 convenio bigint not null default 0,
 conveniado bigint not null default 0,
 ite_avl tinyint(1) not null default 0,
 tru_cal_dsc tinyint(1) not null default 0,
 primary key(codigo_loja,id_rede_pbm)
)ENGINE = innodb;

CREATE TABLE vendas_pbm_pharmalink(
 loja integer not null,
 pdv integer not null,
 cupom long not null,
 nsu_host integer not null,
 situacao integer not null,
 data_venda date not null,
 primary key(nsu_host)
)ENGINE = innodb;

CREATE TABLE configuracao_proxy (
  codigo_loja integer not null,
  host varchar(16) not null,
  porta integer not null,
  usuario varchar(40) not null,
  senha varchar(40) not null,
  ativo tinyint(1) not null default 0,
  ativo_pdv tinyint(1) not null default 0,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE operadora_pbm_phama_link (
  id int(10) not null auto_increment,
  codigo_operadora varchar(20) not null,
  descricao varchar(20) not null,
  empresa varchar(20) not null,
  PRIMARY KEY(id)
) ENGINE = innodb;

CREATE TABLE transacao_pendente_pbm_phama_link (
  projeto varchar(20) not null,
  timestamp varchar(20) not null,
  cartao varchar(20) not null,
  cpf varchar(20) not null,
  cnpj varchar(20) not null,
  nsuhost varchar(20) not null,
  terminal varchar(20) not null,
  autentica bigint not null default '0',
  PRIMARY KEY(autentica)
) ENGINE = innodb;

CREATE TABLE cliente_fidel(
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	nome VARCHAR(100),
	codigo_cliente BIGINT NOT NULL DEFAULT 0,
	insc_estadual_rg VARCHAR(14),
	data_nascimento DATE NOT NULL,
	cep VARCHAR(10),
	endereco VARCHAR(100),
	numero VARCHAR(20),
	complemento VARCHAR(50),
	bairro VARCHAR(60),
	codigo_cidade INTEGER NOT NULL DEFAULT 0,
	codigo_uf INTEGER NOT NULL DEFAULT 0,
	nacionalidade VARCHAR(50),
	pais VARCHAR(50),
	sexo VARCHAR(1),
	situacao_cliente INTEGER NOT NULL DEFAULT 0,
	situacao_cadastro INTEGER NOT NULL DEFAULT 0,
	tipo_cliente INTEGER NOT NULL DEFAULT 0,
	numero_cartao BIGINT NOT NULL DEFAULT 0,
	limite DOUBLE NOT NULL DEFAULT 0,
	acumulado DOUBLE NOT NULL DEFAULT 0,
	data_ultima_compra DATE,
	qtd_frequencia INTEGER NOT NULL DEFAULT 0,
	observacao VARCHAR(255),
	data_atualizacao DATETIME NOT NULL,
	data_cadastro DATE NOT NULL,
	hora_cadastro DATETIME NOT NULL,
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	usuario_cadastro INTEGER NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	data_expiracao DATE NULL,
	etd_civ INTEGER NOT NULL DEFAULT 0,
	nao_act_rbr_eml TINYINT(1) NOT NULL DEFAULT 0,
	opr_cad INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY (cpf_cnpj)
)ENGINE = innodb;

CREATE TABLE config_fidelidade(
	id BIGINT NOT NULL AUTO_INCREMENT,
	habilitar_fidelidade TINYINT(1) NOT NULL DEFAULT 0,
	validade_pontos INTEGER NOT NULL DEFAULT 0,
	pontos_negativos INTEGER NOT NULL DEFAULT 0,
	valor_calc_pontos DOUBLE NOT NULL DEFAULT 0,
	qtde_calc_pontos INTEGER NOT NULL DEFAULT 0,
	continuar_pontuando TINYINT(1) NOT NULL DEFAULT 0,
	qtde_parc_maximas INTEGER NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	pmt_pes_fis TINYINT(1) NOT NULL DEFAULT 0,
  	pmt_pes_jrd TINYINT(1) NOT NULL DEFAULT 0,
  	tim_rsp INTEGER NOT NULL DEFAULT 0,
  	tim_rsp_pdv INTEGER NOT NULL DEFAULT 0,
  	qtd_pnt_cad_ste INTEGER NOT NULL DEFAULT 0,
  	qtd_pnt_com_ste INTEGER NOT NULL DEFAULT 0, 
  	sol_cfr_dad_cli TINYINT(1) NOT NULL DEFAULT 0,
	qtd_dia_sol_cfr_dad_cli INTEGER NOT NULL DEFAULT 0,
	env_eml_boa TINYINT(1) NOT NULL DEFAULT 0,
	dat_ini_cfr_cli date null,
	loj_ste  INTEGER NOT NULL DEFAULT 0,
	imp_cpv_utl_pnt TINYINT(1) NOT NULL DEFAULT 0,
	cad_cli_spd TINYINT(1) NOT NULL DEFAULT 0,
	msg_cli_nao_cad VARCHAR(50) NULL, 
	cor_msg_cli_nao_cad INT NOT NULL DEFAULT 0,
	pmt_cdt_cli_pdv TINYINT(1) NOT NULL DEFAULT 0,
	hab_sau_cli TINYINT(1) NOT NULL DEFAULT 0,
	msg_sau_cli VARCHAR(255) NULL,
	PRIMARY KEY (id)
)ENGINE = innodb;

CREATE TABLE grupo_fidelidade(
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	descricao VARCHAR(50),
	exige_vincular_nivel TINYINT(1) NOT NULL DEFAULT 0,
	fidelidade TINYINT(1) NOT NULL DEFAULT 0,
	obrigar_vinc_cartao TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	dsb_eml TINYINT(1) NOT NULL DEFAULT 0,
	utl_prf_ste TINYINT(1) NOT NULL DEFAULT 0,
	utl_rgr_vld_ste TINYINT(1) NOT NULL DEFAULT 0,
	chv_imp VARCHAR(100) null,
	dsb_vis_pdv TINYINT(1) NOT NULL DEFAULT 0,
	pvl_grp TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (codigo_grupo)
)ENGINE = innodb;

CREATE TABLE nivel_atuacao(
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	codigo_nivel INTEGER NOT NULL DEFAULT 0,
	descricao VARCHAR(50),
	desabilitar_desc TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (codigo_loja, codigo_grupo, codigo_nivel)
)ENGINE = innodb;

CREATE TABLE nivel_indice_desconto(
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	codigo_nivel INTEGER NOT NULL DEFAULT 0,
	indice_desconto INTEGER NOT NULL DEFAULT 0,
	perc_desconto DOUBLE NOT NULL DEFAULT 0,
	descricao VARCHAR(50),
	PRIMARY KEY (codigo_loja, codigo_grupo, codigo_nivel, indice_desconto)
)ENGINE = innodb;

CREATE TABLE pontos_fidelidade(
	id BIGINT NOT NULL AUTO_INCREMENT,
	codigo_secao INTEGER NOT NULL DEFAULT 0,
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	codigo_sub_grupo INTEGER NOT NULL DEFAULT 0,
	codigo_produto BIGINT NOT NULL DEFAULT 0,
	bloquear_pontos TINYINT(1) NOT NULL DEFAULT 0,
	valor_calc_pontos DOUBLE NOT NULL DEFAULT 0,
	qtd_calc_pontos INTEGER NOT NULL DEFAULT 0,
	bloquear_desc TINYINT(1) NOT NULL DEFAULT 0,
	indice_desconto INTEGER NOT NULL DEFAULT 0,
	continuar_pontuacao TINYINT(1) NOT NULL DEFAULT 0,
	bloquear_devolucao TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (id),
	UNIQUE UQ_prod_sec_gru_sub_fid_key(codigo_secao, codigo_grupo, codigo_sub_grupo, codigo_produto)
)ENGINE = innodb;

CREATE TABLE pontos_extras(
	id BIGINT NOT NULL AUTO_INCREMENT,
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	tipo_campanha INTEGER NOT NULL DEFAULT 0,
	data_inicio DATE NOT NULL,
	data_final DATE NOT NULL,
	qtd_pontos INTEGER NOT NULL DEFAULT 0,
	valor_min_compra DOUBLE NOT NULL DEFAULT 0,
	qtd_compras_mes INTEGER NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (id),
	UNIQUE UQ_pontos_extras_key(codigo_loja, tipo_campanha, data_inicio, data_final)
)ENGINE = innodb;

CREATE TABLE pontos_extras_item(
	id BIGINT NOT NULL AUTO_INCREMENT,
	id_pontos_extras BIGINT NOT NULL DEFAULT 0,
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	codigo_secao INTEGER NOT NULL DEFAULT 0,
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	codigo_subgrupo INTEGER NOT NULL DEFAULT 0,
	codigo_produto BIGINT NOT NULL DEFAULT 0,
	qtd_pontos_extras INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	UNIQUE UQ_pontos_extras_prod_key(id_pontos_extras, codigo_loja, codigo_secao, codigo_grupo, codigo_subgrupo, codigo_produto)
)ENGINE = innodb;

CREATE TABLE catalogo(
	codigo_catalogo INTEGER NOT NULL DEFAULT 0,
	descricao VARCHAR(60),
	data_inicio DATE NOT NULL,
	data_final DATE NOT NULL,
	habilitado TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (codigo_catalogo)
)ENGINE = innodb;

CREATE TABLE produto_premio(
	codigo_premio INTEGER NOT NULL DEFAULT 0,
	tipo_premio INTEGER NOT NULL DEFAULT 0,
	descricao VARCHAR(40),
	codigo_produto BIGINT NOT NULL DEFAULT 0,
	qtde_pontos INTEGER NOT NULL DEFAULT 0,
	habilitado TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt timestamp null,
	nom_usr VARCHAR(50) null,
	ste TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (codigo_premio)
)ENGINE = innodb;

CREATE TABLE catalogo_premio(
	codigo_catalogo INTEGER NOT NULL DEFAULT 0,
	codigo_premio INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (codigo_catalogo, codigo_premio)
)ENGINE = innodb;

CREATE TABLE grupo_cliente_fidel(
	codigo_grupo INTEGER NOT NULL DEFAULT 0,
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	nivel_atuacao INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (codigo_grupo, cpf_cnpj)
)ENGINE = innodb;

CREATE INDEX idx_grupo_cliente_fidel_cpf ON grupo_cliente_fidel (cpf_cnpj);

CREATE TABLE historico_ponto(
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	tipo_ponto INTEGER NOT NULL DEFAULT 0,
	qtd_pontos INTEGER NOT NULL DEFAULT 0,
	data_movimento DATE,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (cpf_cnpj, tipo_ponto)
)ENGINE = innodb;

CREATE TABLE venda_fidelidade(
	data DATE NOT NULL,
	loja INTEGER NOT NULL DEFAULT 0,
	pdv INTEGER NOT NULL DEFAULT 0,
	cupom INTEGER NOT NULL DEFAULT 0,
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	desabilitar_desc TINYINT(1) NOT NULL DEFAULT 0,
	capturou_cartao TINYINT(1) NOT NULL DEFAULT 0,
	offline TINYINT(1) NOT NULL DEFAULT 0,
	resgate TINYINT(1) NOT NULL DEFAULT 0,
	inf_cli_dur_vda TINYINT(1) NOT NULL DEFAULT 0 ,
	tip_cli INT(8) NOT NULL DEFAULT 0,
	niv_prc INT(8) NOT NULL DEFAULT 0,
	cod_cli BIGINT NOT NULL DEFAULT 0,
	PRIMARY KEY (data, loja, pdv, cupom)
)ENGINE = innodb;

CREATE TABLE finalizadora_fidelidade(
	codigo_loja INTEGER NOT NULL DEFAULT 0,
	codigo_finalizadora INTEGER NOT NULL DEFAULT 0,
	acumular_ponto TINYINT(1) NOT NULL DEFAULT 0,
	cod_usr BIGINT NULL ,
	dat_alt TIMESTAMP NULL,
	nom_usr VARCHAR(50) null,
	PRIMARY KEY (codigo_loja, codigo_finalizadora)
)ENGINE = innodb;

CREATE  TABLE IF NOT EXISTS email_cliente (
  id BIGINT NOT NULL AUTO_INCREMENT ,
  cpf_cnpj BIGINT NOT NULL DEFAULT 0  ,
  email VARCHAR(60) NOT NULL DEFAULT ''  ,
  cod_cli BIGINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (`id`) ,
CONSTRAINT UNIQUE constr_email(cpf_cnpj, email, cod_cli)
) ENGINE = innodb
;

CREATE TABLE cad_set_pdv (
  cod_loj integer not null  ,
  cod_set integer not null  ,
  cod_pdv integer not null  ,
  PRIMARY KEY(cod_loj, cod_set, cod_pdv)
) ENGINE = innodb
;

CREATE TABLE cfg_cnv (
  cod_loj INT NOT NULL  ,
  imp_lim TINYINT NOT NULL ,
  imp_sld TINYINT NOT NULL ,
  imp_lim_rst TINYINT NOT NULL ,
  tam_cmp_cnv INT NOT NULL ,
  cap_emp_cnv_cod_bar TINYINT NOT NULL ,
  nao_val_lim TINYINT NOT NULL ,
  dia_vnc INT NOT NULL ,
  imp_cpf_cli TINYINT NOT NULL ,
  imp_tel_cli TINYINT NOT NULL ,
  spm_ips_lim_cli DOUBLE NOT NULL ,
  ocu_sld_acd TINYINT NOT NULL,
  qtd_min_bio INT NOT NULL DEFAULT 0 ,
  qtd_max_bio INT NOT NULL DEFAULT 0 , 
  apl_dsc_cvd_pgt TINYINT NOT NULL,
  idt_cnv_ino_vda TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE trc_pdv (
  seq bigint not null auto_increment  ,
  dat DATE NOT NULL,
  pdv_ant INT NOT NULL ,
  pdv_nov INT NOT NULL ,
  trc_pdv TINYINT NOT NULL ,
  PRIMARY KEY (seq)
)ENGINE = InnoDB
;

CREATE TABLE mov_dvg (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  vlr_ecf DOUBLE NOT NULL ,
  vlr_sis DOUBLE NOT NULL ,
  sit_dvg INT NOT NULL ,
  cod_usu INT NOT NULL ,
  gtf_ecf DOUBLE NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup)
)ENGINE = InnoDB
;

CREATE TABLE mov_dvg_ite (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq_ite INT NOT NULL ,
  vlr_ecf DOUBLE NOT NULL ,
  vlr_sis DOUBLE NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq_ite)
)ENGINE = InnoDB
;

CREATE TABLE ctr_bat_ecf (
  num_cup INT NOT NULL ,
  tot_liq_ecf DOUBLE NOT NULL ,
  PRIMARY KEY (num_cup)
)ENGINE = InnoDB
;

CREATE TABLE ped_res (
  cod_ped bigint NOT NULL DEFAULT 0 ,
  cod_cmd INT NOT NULL  DEFAULT 0  ,
  cod_loj INT NOT NULL DEFAULT 0  ,
  coo INT NOT NULL DEFAULT 0   ,
  cer INT NOT NULL DEFAULT 0   ,
  ecf INT NOT NULL DEFAULT 0   ,
  pgt TINYINT(1) NOT NULL ,
  PRIMARY KEY (cod_cmd)
)ENGINE = InnoDB
;

CREATE TABLE fin_pdv (
  cod_loj INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  cod_fin INT NOT NULL ,
  cod_fin_ecf INT NOT NULL ,
  lim_sga DOUBLE(16,2) not null ,
  des_fin varchar(20) NOT NULL DEFAULT '' ,
  PRIMARY KEY(cod_loj, cod_fin, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE cfg_srv_autoriz_estac (
  numero_loja integer not null,
  id_servico integer not null,
  ativo tinyint(1) not null default 1,
  id_sistema integer not null,
  ip_servico varchar(16) not null,
  porta_servico integer not null,
  timeout_servico integer not null,
  valor_min_venda double(16,2) not null,
  tmp_ise int(11) not null default 0,
  vrs DOUBLE NOT NULL DEFAULT 0,
  dir_arq VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY(numero_loja)
) ENGINE = innodb;

CREATE TABLE mov_rpt_stf_cli (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  cod_prg INT NOT NULL DEFAULT 0 ,
  des_prg VARCHAR(40) NOT NULL DEFAULT '' ,
  cod_rpt INT NOT NULL DEFAULT 0 ,
  des_rpt VARCHAR(40) NOT NULL DEFAULT '' ,
PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup, cod_prg)
)ENGINE = InnoDB
;

CREATE TABLE pdv_cph(
  cod_loj integer not null ,
  cod_cph integer not null ,
  cod_pdv integer not null ,
  PRIMARY KEY (cod_loj, cod_cph, cod_pdv)
) ENGINE = INNODB
;

CREATE TABLE sec_grp_sgr_prd_cph(
  cod_loj integer not null ,
  cod_cph integer not null ,
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_cph, sec, grp, sgr, prd)
) ENGINE = INNODB
;

CREATE TABLE cfg_lim_prd(
  cod_loj INT(11) NOT NULL DEFAULT 0  ,
  tip_cfg INT(11) NOT NULL DEFAULT 0  ,
  cod_chv INT(11) NOT NULL DEFAULT 0  ,
  cod_prd INT(11) NOT NULL DEFAULT 0  ,
  qtd_lim DOUBLE(16,2) NOT NULL DEFAULT 0  ,
  PRIMARY KEY(cod_loj,tip_cfg,cod_chv,cod_prd)
)ENGINE = InnoDB
;

CREATE TABLE cfg_prz_fin (
  cod_loj INT NOT NULL ,
  cod_prz INT NOT NULL ,
  des_prz VARCHAR(45) NOT NULL ,
  tip INT NOT NULL ,
  max_dia INT NOT NULL ,
  dia INT NOT NULL , 
  cef DOUBLE NOT NULL ,
  cal_jur TINYINT NOT NULL ,
  dia_virada INT NOT NULL ,
  PRIMARY KEY(cod_loj, cod_prz)
  )ENGINE = InnoDB
;

CREATE TABLE cfg_prz_pdv (
  cod_loj INT NOT NULL ,
  cod_prz INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  PRIMARY KEY(cod_loj, cod_prz, cod_pdv),
  FOREIGN KEY(cod_loj, cod_prz) REFERENCES cfg_prz_fin (cod_loj, cod_prz)
)ENGINE = InnoDB
;

CREATE TABLE cfg_lim_fin (
  cod_loj INT NOT NULL ,
  cod_fin INT NOT NULL ,
  prz_max DATE NOT NULL ,
  PRIMARY KEY(cod_loj, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE cfg_lim_chq (
  cod_loj INT NOT NULL ,
  cod_fin INT NOT NULL ,
  qtd_chq INT NOT NULL ,
  vlr_chq DOUBLE NOT NULL ,
  aut_sup TINYINT NOT NULL ,
  lim_min_chq INT ,
  blq_chq_dvl TINYINT ,
  lim_esd TINYINT ,
  PRIMARY KEY(cod_loj, cod_fin, qtd_chq),
  FOREIGN KEY (cod_loj, cod_fin) REFERENCES cfg_lim_fin (cod_loj, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE cfg_psq_cli (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_pdv INT NOT NULL DEFAULT 0 ,
	hab TINYINT(1) NOT NULL DEFAULT 0 ,
	obr TINYINT(1) NOT NULL DEFAULT 0 ,
	cap_rsp_ppd TINYINT(1) NOT NULL DEFAULT 0 ,
PRIMARY KEY(cod_loj, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE prg_stf_cli (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_prg INT NOT NULL DEFAULT 0 ,
	des_prg VARCHAR(40) NOT NULL DEFAULT '' ,
	ord_exi INT NOT NULL DEFAULT 0 ,
	PRIMARY KEY(cod_loj, cod_prg)
)ENGINE = InnoDB
;

CREATE TABLE rpt_stf_cli (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_prg INT NOT NULL DEFAULT 0 ,
	cod_rpt INT NOT NULL DEFAULT 0 ,
	des_rpt VARCHAR(40) NOT NULL DEFAULT '' ,
	PRIMARY KEY(cod_loj, cod_prg, cod_rpt)
)ENGINE = InnoDB
;

CREATE TABLE mov_dsc_fid(
	dat_mov DATE NOT NULL,
	cod_loj INTEGER NOT NULL DEFAULT 0,
	cod_pdv INTEGER NOT NULL DEFAULT 0,
	cod_cup INTEGER NOT NULL DEFAULT 0,
	seq INTEGER NOT NULL DEFAULT 0,
	cod_prd BIGINT NOT NULL DEFAULT 0,
	cod_grp INTEGER NOT NULL DEFAULT 0,
	cod_niv INTEGER NOT NULL DEFAULT 0,
	cod_ind INTEGER NOT NULL DEFAULT 0,
	prc_dsc DOUBLE(16,2) NOT NULL DEFAULT 0,
	PRIMARY KEY (dat_mov, cod_loj, cod_pdv, cod_cup, seq)
)ENGINE = innodb;

CREATE TABLE cfg_bar_pdv (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_cmp INT NOT NULL DEFAULT 0 ,
	vlr VARCHAR(250) NOT NULL DEFAULT '' ,
	PRIMARY KEY(cod_loj, cod_cmp)
)ENGINE = InnoDB
;

CREATE TABLE cfg_crt_spa_net (
	cod_loj INT NOT NULL DEFAULT 0 ,
	vlr_cmp_ini DOUBLE NOT NULL ,
	vlr_cmp_fim DOUBLE NOT NULL ,
	tmp_ise INT NOT NULL ,
	cod_tab INT NOT NULL DEFAULT 0 ,
	lim_pmn INT NOT NULL DEFAULT 0 ,
	PRIMARY KEY(cod_loj, vlr_cmp_ini, vlr_cmp_fim)
)ENGINE = InnoDB
;

CREATE TABLE cfg_env_arq_pdv (
	cod_loj INT NOT NULL DEFAULT 0 ,
	tip_arq INT NOT NULL DEFAULT 0 ,
	nom_arq VARCHAR(255) NOT NULL DEFAULT '' ,
	arq MEDIUMBLOB NOT NULL ,
	cmh_dtn_arq VARCHAR(255) NOT NULL DEFAULT '' ,
	PRIMARY KEY(cod_loj, tip_arq, nom_arq)
)ENGINE = InnoDB
;


CREATE TABLE vda_prz(
	dat DATE NOT NULL,
	loj INTEGER NOT NULL DEFAULT 0,
	pdv INTEGER NOT NULL DEFAULT 0,
	cup INTEGER NOT NULL DEFAULT 0,
	cpf BIGINT NOT NULL DEFAULT 0,
	cod_prz INTEGER NOT NULL DEFAULT 0,
	dat_vct DATE,
	cod_niv INTEGER NOT NULL DEFAULT 0,
	lim DOUBLE(16,2) NOT NULL DEFAULT 0,
	qtd_chq INTEGER NOT NULL DEFAULT 0,
	chq_dvl TINYINT NOT NULL,
	lim_esd DOUBLE(16,2) NOT NULL DEFAULT 0,
	PRIMARY KEY (dat, loj, pdv, cup)
)ENGINE = innodb;

CREATE TABLE pre_vda_pnd (
  cod_pre_vda BIGINT NOT NULL,
  obj BLOB,
  sit  INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_pre_vda)
) ENGINE = INNODB;

CREATE TABLE configuracao_servico_pdv (
  codigo_loja integer not null,
  prior_thread_pdv integer not null,
  sleep_thread_pdv long not null,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS funcao_modulo (
  cod_loj INT NOT NULL ,
  id_modulo INT NOT NULL  ,
  id_funcao INT NOT NULL  ,
  descricao VARCHAR(30) NULL  ,
  des_tec VARCHAR(8) NULL  ,
  key_cod INT NOT NULL  ,
  ord INT NULL  ,
  primary key (cod_loj, id_modulo, id_funcao)
) ENGINE = innodb;

CREATE TABLE dad_rdz (
  cod_pdv integer not null,
  cro integer not null,
  crz integer not null,
  vda_brt DOUBLE(16,2) NOT NULL DEFAULT 0,
  PRIMARY KEY(cod_pdv)
) ENGINE = innodb;

CREATE TABLE map_res_det (
   dat_mov date not null ,
   cod_loj integer not null ,
   cod_pdv integer not null ,
   seq integer not null ,
   cod_tot varchar(10) ,
   val_aqt double(16,2) not null ,
   bas_imp double(16,2) not null ,
   tot_imp double(16,2) not null ,
   cripto varchar(400) ,
   PRIMARY KEY(dat_mov, cod_loj, cod_pdv, seq)
) ENGINE = innodb
;

CREATE TABLE ser_men (
  tip_srv integer not null ,
  cod_ser integer not null ,
  ord integer not null ,
  PRIMARY KEY(tip_srv, cod_ser)
)ENGINE = InnoDB
;

CREATE TABLE rsp_aut (
   num_cup integer not null ,
   seq integer not null ,
   cod_ser integer not null ,
   tip_ser integer not null ,
   stt integer not null ,
   obj BLOB ,
   PRIMARY KEY(num_cup, seq)
) ENGINE = innodb
;

CREATE TABLE cfg_imp_mov_ecf (
  cod_loj integer not null ,
  num_pdv integer not null ,
  tip_cfg integer not null ,
  cod integer not null ,
  des_ecf varchar(40) not null ,
  PRIMARY KEY(cod_loj, num_pdv, tip_cfg, cod)
) ENGINE = innodb
;

CREATE TABLE ser_ip_pta_pdv (
  cod_loj INT NOT NULL ,
  cod_pdv INT NOT NULL ,
  cod_ser integer not null ,
  tip_ser integer not null ,
  ip varchar(16) not null ,
  pta_con integer not null ,
  pta_can integer not null ,
  pta_efe integer not null ,
  PRIMARY KEY(cod_loj, cod_pdv, cod_ser)
)ENGINE = InnoDB
;

CREATE TABLE cad_pnl (
 cod_loj integer not null ,
 num_pnl integer not null ,
 dsc_pnl varchar(40) not null ,
 ip varchar(16) not null ,
 pta integer not null ,
 tip_pnl integer not null ,
 msg varchar(40) ,
 PRIMARY KEY(cod_loj, num_pnl)
) ENGINE = innodb
;

CREATE TABLE cfg_pnl_loj (
 cod_loj integer not null ,
 hab_chm_fla tinyint not null default 0 ,
 hab_chm_sup tinyint not null default 0 ,
 utl_fla_man tinyint not null default 0,
 PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE cfg_pnl_pdv (
 cod_loj integer not null ,
 num_pdv integer not null ,
 hab_chm_fla tinyint not null default 0 ,
 hab_chm_sup tinyint not null default 0 ,
 num_pnl_fla integer not null ,
 num_pnl_sup integer not null ,
 num_idt_pdv integer not null default 0 ,
 otc varchar(1) not null ,
 tim integer ,
 tim_rpt integer ,
 PRIMARY KEY(cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE cph_prm(
  cod_loj integer not null,
  cod_cph integer not null,
  acm_prm tinyint(1) not null default 0,
  acm_prm_mix tinyint(1) not null default 0,
  acm_prm_fid tinyint(1) not null default 0,
  dsc double(16,2) not null,
  tip_dsc integer not null, 
  PRIMARY KEY (cod_loj, cod_cph) 
) ENGINE = INNODB;

CREATE TABLE cph_prm_fin(
  cod_loj integer not null,
  cod_cph integer not null,
  cod_fin integer not null,
  per_min double not null,
  PRIMARY KEY (cod_loj, cod_cph, cod_fin) 
) ENGINE = INNODB;

CREATE TABLE cli_cph (
  cod_cli BIGINT NOT NULL  ,
  cpf_cnp BIGINT NOT NULL  ,
  nom VARCHAR(40) NOT NULL  ,
  end VARCHAR(72) NULL  ,
  brr VARCHAR(72) NULL  ,
  num VARCHAR(15) NULL  ,
  cep VARCHAR(9) NULL  ,
  cdd integer NULL  ,
  uf integer NOT NULL  ,
  com VARCHAR(40) NULL  ,
  rg_ie VARCHAR(20) NULL  ,
  stt VARCHAR(2) NULL  ,
  ins_mun VARCHAR(20) NULL  ,
  sxo VARCHAR(1) NOT NULL ,
  dat_nsc date ,
  sms_prm VARCHAR(1) NOT NULL DEFAULT 'N'  ,
  PRIMARY KEY (cod_cli, cpf_cnp)
)ENGINE = innodb
;

CREATE TABLE tel_cli (
  id bigint(20) NOT NULL AUTO_INCREMENT ,
  cod_cli bigint(20) NOT NULL ,
  cpf_cnp bigint(20) NOT NULL ,
  ddd varchar(4) NOT NULL ,
  tel varchar(13) NOT NULL ,
  tip varchar(20) DEFAULT NULL ,
  ram int(11) DEFAULT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `constr_tel` (`cod_cli`,`ddd`,`tel`,`cpf_cnp`)
) ENGINE=InnoDB
;

CREATE TABLE mov_fin_par (
   dat_mov date not null ,
   cod_ope integer not null ,
   num_loj integer not null ,
   num_pdv integer not null ,
   tip_mov integer not null ,
   num_cup integer not null ,
   seq integer not null ,
   dat_vnc date not null ,
   vlr double(16,2) not null ,
   PRIMARY KEY(dat_mov, cod_ope, num_loj, num_pdv, tip_mov, num_cup, seq, dat_vnc)
) ENGINE = innodb
;

CREATE TABLE cnf_cph_prm (
  cod_loj INT NOT NULL  ,
  tip_cli INT NOT NULL  ,
  vlr_ems_cup DOUBLE(16,2) NOT NULL  ,
  emt_cup_pzd TINYINT(1) NOT NULL DEFAULT 0 ,
  dbr_qtd_cup TINYINT(1) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, tip_cli)
 ) ENGINE = InnoDB
;

CREATE TABLE ctr_cup_imp (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  dat_vda DATETIME NOT NULL  ,
  num_cup INT NOT NULL  ,
  cod_cli bigint(20) NOT NULL  ,
  ori_imp INT NULL  ,
  cod_prm INT NULL ,
  qtd_cup INT NULL  ,
  qtd_imp INT NULL  ,
  sit INT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, num_pdv, dat_vda, num_cup) 
)ENGINE = InnoDB
;

CREATE TABLE cadastro_uf(
  codigo integer not null,
  uf varchar(2)	unique not null,
  estado varchar(60) unique not null,
  PRIMARY KEY(codigo)
) ENGINE = innodb;

CREATE INDEX index_cadastro_uf_estado ON cadastro_uf (estado(60));

CREATE TABLE municipio(
  codigo integer not null,
  codigo_uf integer not null, 
  municipio varchar(80) not null,
  codigo_pais integer not null,
  PRIMARY KEY(codigo)
) ENGINE = innodb;

CREATE INDEX index_municipio_ident ON municipio(municipio(80), codigo_uf);

CREATE TABLE cfg_tim_cnp (
  cod_loj INT NOT NULL  ,
  cnp INT NOT NULL  ,
  tim INT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj, cnp) )
ENGINE = InnoDB
;

CREATE TABLE grp_cli (
  cod_grp INTEGER NOT NULL  ,
  grp_prc INTEGER NOT NULL  ,
  cod_loj INTEGER NOT NULL  ,
  des VARCHAR(35)  , 
  cnl_dst INTEGER NOT NULL DEFAULT 0  ,
  pdr tinyint(1) NOT NULL DEFAULT 0 ,
  org_vda VARCHAR(20) ,
  id_grp_cli VARCHAR(20)  ,
  PRIMARY KEY (cod_grp, grp_prc, cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE grp_cli_dsc (
  cod_loj INT NOT NULL  ,
  grp_prc INT NOT NULL  ,
  sec_prd INT NOT NULL  ,
  per_dsc VARCHAR(45) NULL  ,
  org_vda VARCHAR(20)  ,
  PRIMARY KEY (cod_loj, grp_prc, sec_prd) 
)ENGINE = InnoDB
;

CREATE TABLE vda_abt (
  dat DATE NOT NULL  ,
  loj INT NOT NULL  ,
  pdv INT NOT NULL  ,
  cup INT NOT NULL  ,
  chv VARCHAR(45) NOT NULL  ,
  vlr VARCHAR(2048) NULL  ,
  PRIMARY KEY (dat, loj, pdv, cup, chv)
)ENGINE = InnoDB
;

CREATE TABLE mov_trc_mda (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  cod_fin INT NULL  ,
  cod_fin_trc INT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup) 
) ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS vin_trc_mda (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  cod_fin_trc INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_fin, cod_fin_trc) 
) ENGINE = InnoDB
;

CREATE TABLE dados_adicionais_capa (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   id_campo integer not null default 0,
   valor_campo TEXT,
   PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom, id_campo)
) ENGINE = innodb;

CREATE TABLE dados_adicionais_detalhe (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   sequencia integer not null,
   id_campo integer not null default 0,
   valor_campo TEXT,
   PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom, sequencia, id_campo)
) ENGINE = innodb;

CREATE TABLE dados_adicionais_pagto (
   data_venda date not null,
   numero_loja integer not null,
   numero_pdv integer not null,
   numero_cupom integer not null,
   sequencia integer not null,
   id_campo integer not null default 0,
   valor_campo TEXT,
   PRIMARY KEY(data_venda, numero_loja, numero_pdv, numero_cupom, sequencia, id_campo)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cad_fei (
  cod_fei INT NOT NULL  ,
  des VARCHAR(45) NULL  ,
  cod_cli_fei VARCHAR(20) NOT NULL DEFAULT ''  ,
  PRIMARY KEY (`cod_fei`) 
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS vin_pdv_fei (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  cod_fei INT NOT NULL  ,
  dat_ini DATE NOT NULL  ,
  dat_fin DATE NOT NULL  ,
  PRIMARY KEY (`cod_loj`, `cod_pdv`, `cod_fei`) 
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS frm_pgt (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  cnd_pgt VARCHAR(45) NULL  ,
  frm_pgt VARCHAR(45) NULL  ,
  qtd_par INT NULL DEFAULT 1  ,
  qtd_dia INT NULL DEFAULT 0  ,
  PRIMARY KEY (`cod_loj`, `cod_fin`)
 ) ENGINE = InnoDB
;

CREATE TABLE prd_loj_com (
  cod_prd bigint not null ,
  cod_loj integer not null ,
  prc_cus double(16,3) not null ,
  dat_atu date not null ,
  cnt varchar(20) DEFAULT '' ,
  dpt varchar(20) DEFAULT '' ,
  org_vda varchar(20) DEFAULT '' ,
  nao_dig_prc tinyint(1) not null default 0 ,
  prd_pbm tinyint(1) not null default 0 ,
  prd_fmc_ppl tinyint(1) not null default 0 ,
  cus_liq double(16,3) not null ,
  mrg_ral double(16,3) not null ,
  per_ral double(16,3) not null ,
  per_tri double(16,2) not null,
  per_ise double(16,2) not null,
  per_out double(16,2) not null,
  per_ali double(16,2) not null,
  cst VARCHAR(3) not null default '',
  per_ali_st double(16,2) not null default 0,
  per_acr_st double(16,2) not null default 0,
  per_red_bc double(16,2) not null default 0,
  per_red_bcst double(16,2) not null default 0,
  cnt_cus integer not null default 0,
  tab_prc integer not null default 0,
  cod_nat varchar(3) DEFAULT '',
  prd_txa_ent tinyint(1) not null default 0,
  pdz_sca_nao_rlv tinyint(1) not null default 0,
  cnj_fbt bigint not null default 0,
  cod_bnf_fsc varchar(10) not null default '',
  per_red_bc_efv double(16,2) not null default 0,
  per_alq_efv double(16,2) not null default 0,
  PRIMARY KEY(cod_prd, cod_loj)
) ENGINE = innodb
;

CREATE  TABLE IF NOT EXISTS  cfg_dsc_vda_atc (
  cod_loj INT(11) NOT NULL  ,
  sec INT(11) NOT NULL ,
  grp INT(11) NOT NULL  ,
  sgr INT(11) NOT NULL  ,
  prd BIGINT NOT NULL  ,
  prc_dsc DOUBLE NOT NULL  ,
  ctr_acm TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, sec, grp, sgr, prd) 
) ENGINE = InnoDB
;

CREATE TABLE ctr_vas_vda (
  seq_ite INT NOT NULL ,
  seq_vas INT NOT NULL ,
  PRIMARY KEY ( seq_ite , seq_vas )
) ENGINE = InnoDB
;

CREATE TABLE cfg_prd_mod_vle_gas (
  cod_loj INT NOT NULL  ,
  des_rde VARCHAR(60) NOT NULL  ,
  des_prd VARCHAR(40) NULL  ,
  PRIMARY KEY (cod_loj, des_rde) 
)ENGINE = InnoDB
;

CREATE TABLE cfg_mod_vle_gas (
  cod_loj INT NOT NULL  ,
  hab_mod_vle_gas TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj) 
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_oft_rod_cup (
  cod_loj INT NOT NULL  ,
  cod_oft INT NOT NULL  ,
  dat_ini_div DATE NOT NULL  ,
  dat_fim_div DATE NOT NULL  ,
  dat_ini_vig DATE NOT NULL  ,
  dat_fim_vig DATE NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_oft)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_msg_oft_rod_cup (
  cod_loj INT NOT NULL  ,
  cod_oft INT NOT NULL  ,
  seq INT NOT NULL  ,
  msg VARCHAR(40) NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_oft, seq)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS mov_aut_pms_pdv (
  dat_mov Date NOT NULL ,
  hor_mov Time NOT NULL ,
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  cod_mtv int NOT NULL  ,
  cod_sup int NOT NULL  ,
  seq_ope int NOT NULL  ,
  PRIMARY KEY (dat_mov,hor_mov,cod_loj,num_pdv,num_cup)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_crt_saq (
  cod_loj INT NOT NULL  ,
  tip_lei_crt INT NOT NULL DEFAULT 1  ,
  sol_doc TINYINT NOT NULL DEFAULT 0  ,
  sol_sha TINYINT NOT NULL DEFAULT 1  ,
  exi_sld_tec TINYINT NOT NULL DEFAULT 0  ,
  exi_sld_mnt TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj)
 )
ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS mov_saq_ope (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  cod_ope INT NOT NULL  ,
  seq_ope INT NOT NULL  ,
  val_saq DOUBLE NOT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_mtr (
  cod INT NOT NULL  ,
  exp_arq_txt TINYINT NOT NULL DEFAULT 0  ,
  exp_wsv TINYINT NOT NULL DEFAULT 0  ,
  hab_mtr TINYINT NOT NULL DEFAULT 0  ,
  cmh_arq varchar(60) NOT NULL  ,
  cmh_url varchar(60) NOT NULL  ,
  tpo_mrt_onl INT NOT NULL DEFAULT 0  ,
  tpo_mrt_off INT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod)
 )
ENGINE = InnoDB
;

CREATE TABLE evt_mtr_ecn (
   dat_evt date not null,
   loc_evt integer not null ,
   cod_loj integer not null ,
   num_pdv integer not null ,
   cod_evt integer not null ,   
   cod_mtr integer not null ,
   cod_pdv integer not null ,
   hor_evt time not null,
   flg_atu tinyint(1) not null default 1 ,
   dat_atu datetime not null ,
   json_obj TEXT ,
   PRIMARY KEY(dat_evt, loc_evt, cod_loj, num_pdv, cod_evt)
) ENGINE = innodb
;

CREATE TABLE trb_pdv (
  cod_loj INT NOT NULL , 
  cod_nat VARCHAR(5) NOT NULL ,
  cod_pdv INT NOT NULL ,
  cod_trb_ecf  VARCHAR(5) NOT NULL ,
  PRIMARY KEY(cod_loj,cod_pdv,cod_nat)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prm_brd (
cod_loj INT NOT NULL  ,
cod_prm INT NOT NULL  ,
des_prm varchar(50) NOT NULL  ,
dat_vig_ini DATE NOT NULL  ,
dat_vig_fim DATE NOT NULL  ,
PRIMARY KEY (cod_loj, cod_prm)
)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_prm_brd (
cod_loj INT NOT NULL  ,
cod_prm INT NOT NULL  ,
cod_prd BIGINT NOT NULL  ,
prd_brd TINYINT NOT NULL  ,
PRIMARY KEY (cod_loj, cod_prm, cod_prd)
)
ENGINE = InnoDB
;

CREATE TABLE cad_bio_cli (
  cpf bigint not null,
  cod_hdw integer not null,
  dig BLOB,
  PRIMARY KEY (cpf, cod_hdw)
) ENGINE = INNODB
;


CREATE  TABLE IF NOT EXISTS  cfg_ajt_hor_ecf (
  cod_loj INT NOT NULL  ,
  ip_srv_ntp VARCHAR(16) NOT NULL  ,
  hab_cns_ntp TINYINT(1) NOT NULL DEFAULT 0  ,
  ajt_hor_ecf_hor_vra TINYINT(1) NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj)
 )
 ENGINE = InnoDB
;

CREATE TABLE cfg_trn_sck (
   cod_loj integer not null ,
   cod_ser integer not null ,
   tip integer not null ,
   PRIMARY KEY(cod_loj, cod_ser, tip)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_txt_tef (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  txt_tef VARCHAR(255) NOT NULL  ,
  vlr_pdr VARCHAR(255) NOT NULL  ,
  mon_opc TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj, cod_fin, txt_tef)
 )ENGINE = InnoDB
;

CREATE TABLE config_transmissao_movimento (
  codigo_loja integer not null,
  tipo_transmissao integer not null,
  compactar_arquivo tinyint(1) not null default 1,
  quantidade_cupom integer not null default 1,
  perido_tempo_minuto integer not null default 60,
  data_hora_ultima_trans datetime,
  enviar_movimento_consolidado tinyint(1) not null default 1,
  tamanho_arquivo long not null,
  qtd_ten_env_mov_pdv integer not null default 0 ,
  PRIMARY KEY(codigo_loja)
) ENGINE = innodb;

CREATE  TABLE IF NOT EXISTS cfg_prc_trm_cns (
  cod_loj INT NOT NULL  ,
  hor_vig TIME NULL  ,
  PRIMARY KEY (cod_loj)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_fin_omt_sng (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  omt_vlr_sng TINYINT(1) NOT NULL DEFAULT 0  ,
  pmt_vlr_mor TINYINT(1) NOT NULL DEFAULT 0  ,
  pmt_sng_parc TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, cod_fin)
 )
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_aqt_dia (
  cod_prd BIGINT NOT NULL  ,
  cod_nat VARCHAR(3) NOT NULL  ,
  dat_atu DATE NOT NULL  ,
  cod_cfop INT(8) NULL ,
  per_ali double(16,2) NOT NULL,
  cst VARCHAR(3) not null default '',
  per_ali_st DOUBLE(16,2) NOT NULL DEFAULT 0,
  per_acr_st DOUBLE(16,2) NOT NULL DEFAULT 0,
  per_red_bc DOUBLE(16,2) NOT NULL DEFAULT 0,
  per_red_bcst DOUBLE(16,2) NOT NULL DEFAULT 0,
  per_fcp DOUBLE(16,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_prd)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_ipt_prd (
  cod_loj INT NOT NULL  ,
  imp_ipt_ite TINYINT NOT NULL DEFAULT 0  ,
  imp_ipt_rod TINYINT NOT NULL DEFAULT 0  ,
  msg_rod_ipt VARCHAR(60)  ,
  imp_ipt_per TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS ctr_cup_srt (
  cod_loj INT NOT NULL  ,
  cod_srt INT NOT NULL  ,
  des_srt VARCHAR(50) NOT NULL  ,
  des_pmo VARCHAR(50) NULL  ,
  dat_vig_ini DATE NOT NULL  ,
  dat_vig_fim DATE NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_srt)
 ) ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS prd_cup_srt (
  cod_loj INT NOT NULL  ,
  cod_srt INT NOT NULL  ,
  sec INT NOT NULL  ,
  grp INT NOT NULL DEFAULT 0  ,
  sgr INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  qtd_vda DOUBLE NOT NULL  ,
  qtd_cup INT NOT NULL  ,
  PRIMARY KEY (cod_loj ,  cod_srt ,  sec ,  grp ,  sgr ,  prd ) 
)ENGINE = InnoDB
;

CREATE  TABLE cad_ipt_prd (
  uf VARCHAR(2) NOT NULL  ,
  cod_prd BIGINT NOT NULL  ,
  cod_ipt INT NOT NULL  ,
  cod_ncm BIGINT NULL DEFAULT 0  ,
  per_aqt DOUBLE NULL  ,
  per_aqt_fed DOUBLE NULL  ,
  per_aqt_mun DOUBLE NULL  ,
  PRIMARY KEY (uf, cod_prd, cod_ipt)
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS ctr_prd_psv (
  cod_loj INT NOT NULL ,
  hab_ctr_prd_psv TINYINT NOT NULL DEFAULT 0  ,
  tol_pes_dvg DOUBLE NOT NULL DEFAULT 0  ,
  qtd_max_bal INT DEFAULT 0  ,
  sol_pms TINYINT(1) NOT NULL DEFAULT 0  ,
  sol_btr_cap TINYINT(1) NOT NULL DEFAULT 0 ,
  hab_tol_pes TINYINT(1) NOT NULL DEFAULT 0,
  pso_acm DOUBLE NOT NULL DEFAULT 0,
  pso_abx DOUBLE NOT NULL DEFAULT 0,
  cnf_pso_clf_mer TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
 ) ENGINE = InnoDB
;

CREATE  TABLE cfg_arq (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  tip_arq INT NOT NULL  ,
  seq INT NOT NULL  ,
  txt VARCHAR(255) NULL ,
  PRIMARY KEY (cod_loj, cod_pdv, tip_arq, seq)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS fin_blq_pdv (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_pdv, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fun_ped (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  cod_mod INT NOT NULL  ,
  cod_fun INT NOT NULL  ,
  PRIMARY KEY (cod_loj, num_pdv, cod_mod, cod_fun)
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_txt_cpv (
  cod_loj INT NOT NULL  ,
  tip_cpv INT NOT NULL  ,
  seq INT NOT NULL  ,
  txt VARCHAR(100) NULL ,
  tip_fon INT NOT NULL  ,
  PRIMARY KEY (cod_loj, tip_cpv, seq)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ctr_can_loj (
  cod_loj INT NOT NULL  ,
  tip_can INT NOT NULL  ,
  vlr_max DOUBLE NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj, tip_can) )
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ctr_can_usu (
  lgn_usu INT NOT NULL  ,
  tip_can INT NOT NULL  ,
  vlr_max DOUBLE NOT NULL DEFAULT 0  ,
  PRIMARY KEY (lgn_usu, tip_can) )
ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_msg_spa_net (
  cod_loj INT NOT NULL ,
  tmp_msg INT NOT NULL DEFAULT 0 ,
  msg VARCHAR(40) NOT NULL ,
  PRIMARY KEY (cod_loj)
 )ENGINE = InnoDB
;

CREATE TABLE mov_rsv (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  seq INT NOT NULL  ,
  cod_rsv INT NULL  ,
  tip_mov INT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq) 
) ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS ctr_ret_trn_sck (
  cod_ret INT NOT NULL  ,
  des VARCHAR(50) NOT NULL  ,
  PRIMARY KEY (cod_ret)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS ctr_trn_sck_pfl (
  cod_ret INT NOT NULL  ,
  cod_pfl INT NOT NULL  ,
  PRIMARY KEY (cod_ret, cod_pfl)
 )ENGINE = InnoDB
;

CREATE TABLE usuario_perfil (
  id_usuario integer not null,
  id_perfil integer not null,
  PRIMARY KEY  (id_usuario, id_perfil)
  ) ENGINE = innodb;
  
CREATE  TABLE IF NOT EXISTS cfg_ips_cpv_pdv (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  tip_cpv INT NOT NULL  ,
  ipr VARCHAR(40) NOT NULL  ,
  atv TINYINT(1) NULL  ,
  ipm_clt TINYINT(1) NULL  ,
  PRIMARY KEY (cod_loj, cod_pdv, tip_cpv)
)ENGINE = InnoDB
;

CREATE TABLE mov_cpv_pdv (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  tip_cpv INT NOT NULL  ,
  imp TINYINT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, tip_cpv) 
) ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS ctr_rtd_rsv (
  dat DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  cup INT NOT NULL  ,
  cod_rsv INT NOT NULL  ,
  cod_prd INT NOT NULL  ,
  qtd DOUBLE NOT NULL  ,
  prc DOUBLE NOT NULL  ,
  cod_ven INT NOT NULL  ,
  PRIMARY KEY (dat, cod_loj, cod_pdv, cup, cod_rsv, cod_prd)
 )ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cad_rsv (
  cod_loj INT NOT NULL  ,
  cod_rsv INT NOT NULL  ,
  cpf_cli BIGINT NOT NULL  ,
  nom_cli VARCHAR(40) NOT NULL  ,
  tel_cli BIGINT NOT NULL  ,
  dat_cad DATE NOT NULL  ,
  dat_alt DATE NULL  ,
  usu_cad INT NOT NULL  ,
  usu_alt INT NULL  ,
  sit INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_rsv)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_rsv (
  cod_loj INT NOT NULL  ,
  cod_rsv INT NOT NULL  ,
  cod_prd BIGINT NOT NULL  ,
  qtd_rsv DOUBLE NOT NULL  ,
  qtd_can DOUBLE NULL  ,
  qtd_rtd DOUBLE NULL  ,
  prc_prd DOUBLE NOT NULL  ,
  cod_ven INT NOT NULL DEFAULT 0 ,
  prc_prd_dsc DOUBLE NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_rsv, cod_prd) ,
  UNIQUE INDEX rsv_prd_uq1 (cod_loj ASC, cod_rsv ASC)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_sci_tdr (
   cod_loj INT NOT NULL  ,
   utl_soc_trc tinyint(1) not null default 0 ,
   cod_fin INT NOT NULL ,
   ipm_cpv tinyint(1) not null default 0 ,
   nao_vrf_prd_ptp tinyint(1) not null default 0 ,
   inb_cpf tinyint(1) not null default 0,
   ocu_msg_cpf tinyint(1) not null default 0,
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_ped_pdv (
   cod_loj INT NOT NULL  ,
   cod_pdv INT NOT NULL  ,
   ipr VARCHAR(40) NOT NULL , 
   PRIMARY KEY(cod_loj, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_lin (
  cod_lin INT NOT NULL  ,
  des_lin VARCHAR(40) NOT NULL  ,
  PRIMARY KEY (cod_lin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_lin_loj (
  cod_lin INT NOT NULL  ,
  cod_loj INT NOT NULL  ,
  PRIMARY KEY (cod_lin, cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_ean_ina_lin (
  cod_lin INT NOT NULL  ,
  cod_ean BIGINT NOT NULL  ,
  dat_cad DATE NOT NULL  ,
  PRIMARY KEY (cod_lin, cod_ean)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_etq_bln (
  cod_loj INT NOT NULL  ,
  exi_msg INT NOT NULL  ,
  msg_vde VARCHAR(40) NOT NULL  ,
  qtd_dia_vnc INT NOT NULL DEFAULT 0  ,
  sol_spr TINYINT NOT NULL DEFAULT 0  ,
  nao_reg_prd_vnc TINYINT NOT NULL DEFAULT 0  ,
  fmt_dat VARCHAR(40) NOT NULL,
  pos_ini_dat_vde TINYINT NOT NULL DEFAULT 0,
  utl_niv_prc_unt TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
 )
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_pln_pgt (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  cod_pln INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_fin)
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS rtd_enc (
  dat DATE NOT NULL  ,
  num_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  cup INT NOT NULL  ,
  num_enc BIGINT NOT NULL  ,
  cod_prd BIGINT NOT NULL  ,
  qtd_rtd DOUBLE NOT NULL  ,
  cod_ven INT NOT NULL  ,
  PRIMARY KEY (dat, num_loj, num_pdv, cup, num_enc, cod_prd)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS trn_enc (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  seq INT NOT NULL  ,
  num_enc BIGINT NULL  ,
  tip_mov INT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq) 
) ENGINE = InnoDB
;

CREATE TABLE mov_enc (
  cod_loj INTEGER NOT NULL,
  num_enc BIGINT NOT NULL,
  cpf BIGINT NOT NULL,
  cod_loj_frn INTEGER,
  cod_prd BIGINT,
  qtd DOUBLE(16,3),
  prc DOUBLE(16,2),
  prc_fab DOUBLE(16,2),
  fte DOUBLE(16,2),
  dat_inc DATE,
  dat_alt DATE,
  dat_ent DATE,
  sit INTEGER,
  tip_ctt INTEGER,
  mtv INTEGER,
  cod_usu INTEGER,
  PRIMARY KEY (cod_loj, num_enc)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cad_cph_pmo (
  cod_loj INT NOT NULL  ,
  tpo_msg INT NOT NULL ,
  nom_cph VARCHAR(40) NOT NULL  ,
  msg VARCHAR(40) NOT NULL  ,
  hab TINYINT NOT NULL DEFAULT 0  ,
  sol_cpf_cph TINYINT(1) NOT NULL DEFAULT 0	,
  msg_cap_cpf VARCHAR(40) NOT NULL	,
  PRIMARY KEY (cod_loj)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_cph_pmo (
  cod_loj INT NOT NULL  ,
  seq_pmo BIGINT NOT NULL  ,
  pmo VARCHAR(40) NOT NULL  ,
  pmo_rtd TINYINT(1) NOT NULL DEFAULT 0  ,
  num_pmo BIGINT  ,
  PRIMARY KEY (cod_loj, seq_pmo)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cfp_nat_fsc (
  cod_loj INT NOT NULL  ,
  cfp INT NOT NULL  ,
  cod_nat_fsc varchar(3) not null,
  PRIMARY KEY (cod_loj, cfp, cod_nat_fsc) 
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cli_prm_fid (
  cpf_cnpj BIGINT NOT NULL  ,
  ina TINYINT NOT NULL DEFAULT 0  ,
  tip_cli INT(8) NOT NULL  ,
  niv_prc INT(8) NOT NULL  ,
  PRIMARY KEY (cpf_cnpj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_crt_prm_fid (
  cpf_cnpj BIGINT NOT NULL  ,
  num_crt BIGINT NOT NULL  ,
  ina TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cpf_cnpj, num_crt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_gjt_res(
    cod_loj INTEGER(11) NOT NULL ,
    cod_pdv INTEGER(11) NOT NULL  ,
    PRIMARY KEY (cod_loj,cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_per_gjt_res(
    cod_loj INTEGER(11) NOT NULL ,
    per_gjt INTEGER(11) NOT NULL  ,
    PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_pms_bio (
  cod_loj INT NOT NULL  ,
  cod_pms INT NOT NULL  ,
  rpt_idt TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (cod_loj, cod_pms)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prm_fid (
  cod_loj INT NOT NULL  ,
  cns_cli_loc TINYINT NOT NULL DEFAULT 0  ,
  utl_cli_sci_tdr TINYINT NOT NULL DEFAULT 0  ,
  msg_idt_cli VARCHAR(40) NULL  ,
  msg_ret_cpf_nao_cad VARCHAR(40) NULL  ,
  sol_cli_sci_esp TINYINT(1) NOT NULL DEFAULT 0  ,
  cli_ret_sck TINYINT(1) NOT NULL DEFAULT 0  ,
  exi_msg_gno_pdv TINYINT(1) NOT NULL DEFAULT 0  ,
  exi_msg_pda_pdv TINYINT(1) NOT NULL DEFAULT 0  ,
  exi_msg_gno_rst TINYINT(1) NOT NULL DEFAULT 0  ,
  exi_msg_pda_rst TINYINT(1) NOT NULL DEFAULT 0  ,
  msg_gno VARCHAR(100) NULL  ,
  msg_pda VARCHAR(100) NULL  ,
  nao_exi_ide_cli TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_idt_prm_fid (
  cod_loj INT NOT NULL  ,
  tip_idt INT NOT NULL  ,
  ord INT UNSIGNED NOT NULL  ,
  PRIMARY KEY (cod_loj, tip_idt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS usu_bio (
  id integer not null ,
  PRIMARY KEY (id)
) ENGINE = INNODB
;

CREATE TABLE IF NOT EXISTS cad_frs_fin (
  cod_loj INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  seq INT NOT NULL  ,
  frs VARCHAR(40) NOT NULL  ,
  fmt_rsp INT NOT NULL  ,
  obr TINYINT NOT NULL DEFAULT 0  ,
  ord INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_fin, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_frs_fin (
  dat_mov DATE NOT NULL DEFAULT 0  ,
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  seq INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  frs VARCHAR(40) NOT NULL  ,
  rsp VARCHAR(255) NOT NULL  ,
  fmt_rsp INT NOT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ctr_pda (
 rtc INT NOT NULL  ,
 gua_dad_bco TINYINT NOT NULL DEFAULT 0  ,
 env_dad_oln_mnt TINYINT NOT NULL DEFAULT 0  ,
 cap_inp TINYINT NOT NULL DEFAULT 0  ,
 msr_det_prd TINYINT NOT NULL DEFAULT 0 ,
 pmt_reg_prd TINYINT NOT NULL DEFAULT 0 ,
 nao_utl_ale_snr TINYINT NOT NULL DEFAULT 0  ,
 reg_prd_atm TINYINT NOT NULL DEFAULT 0  ,
 pmt_reg_prd_sem_val TINYINT NOT NULL DEFAULT 0  ,
 PRIMARY KEY (rtc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ctr_pda (
  dat DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL ,
  hor TIME NULL ,
  cod_ope INT NOT NULL ,
  cod_rtc INT NOT NULL ,
  cod_prd BIGINT NOT NULL ,
  msg VARCHAR(255) NULL ,
  prc_prd DOUBLE(16,2) NULL DEFAULT 0  ,
  des_prd VARCHAR(50) NOT NULL  ,
  qtd DOUBLE(16,3) NULL DEFAULT 0  ,
  prd BIGINT NOT NULL ,
  PRIMARY KEY (dat, cod_loj, num_pdv, num_cup, seq)
)ENGINE = InnoDB
;

CREATE TABLE ger_key_cod_tch (
  cod_loj integer not null ,
  id_ger integer not null ,
  key_cod integer not null ,
  ord integer not null ,
  id_pnl integer not null ,
  dsc varchar(255) DEFAULT NULL ,
  primary key (cod_loj, id_ger, key_cod)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_prt_loj_sat (
	cod_loj INTEGER NOT NULL ,
	vrs_lay_arq_dad DOUBLE (8,2) NOT NULL DEFAULT 1.00 ,
	cnj_sft BIGINT(14) NOT NULL ,
	asn_cfe VARCHAR (344) NOT NULL ,
	cnj_emt BIGINT NOT NULL ,
	ins_etd VARCHAR(12) NOT NULL ,
	ins_mun VARCHAR(15) NOT NULL ,
	rgm_esp_trb INTEGER (1) NOT NULL ,
	ind_rat VARCHAR (1) NOT NULL ,
	num_ses INTEGER NOT NULL ,
	ipr_lgm TINYINT NOT NULL ,
	cmh VARCHAR(255) NOT NULL ,
	lim_pdv INTEGER NOT NULL ,
	hab_ctg TINYINT NOT NULL ,
	vrf_st_oper_sat TINYINT NOT NULL DEFAULT 1 ,
	exi_st_oper_sat TINYINT NOT NULL DEFAULT 0 ,
	lim_dia_env_xml INTEGER NOT NULL DEFAULT 10 ,
	lim_hor_blq_sefaz INTEGER NOT NULL DEFAULT 40 ,
	hab_pis_cofins TINYINT(1) NOT NULL ,
	blq_cmc_sfz INT(8) NOT NULL DEFAULT 0 ,
	spl_nac TINYINT(1) NOT NULL,
	tmp_env_sit INTEGER NOT NULL,
	tok_cns VARCHAR(255) NOT NULL,
	url_ccl_sat VARCHAR(255) NOT NULL,
	tim_ccl_sat INT NOT NULL DEFAULT 0,
	tmp_max_nao_cmc_sfz INTEGER NOT NULL DEFAULT 0,
	nao_pmt_vda_aps_zro_hor TINYINT(1) NOT NULL,
	tpo_exi_ale_fch INT NOT NULL DEFAULT 0,
	qtd_cup_exi_ale_fch INT NOT NULL DEFAULT 0,
	PRIMARY KEY (cod_loj)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_prt_pdv_sat (
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	cod_sol INTEGER NOT NULL ,
	PRIMARY KEY (cod_loj,num_pdv, cod_sol)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_hdw_sat(
	cod_loj INTEGER NOT NULL ,
	seq INTEGER NOT NULL ,
	cod_hdw INTEGER NOT NULL ,
	ip VARCHAR (200) ,
	pta INTEGER NOT NULL ,
	cod_atv VARCHAR (200) ,
	tip_itf INTEGER NOT NULL ,
	nom_red VARCHAR (200) ,
	tip_seg VARCHAR (200) ,
	chv_acs VARCHAR (200) ,
	tip_lan INTEGER NOT NULL ,
	ip_red VARCHAR (200) ,
	msc_sub_red VARCHAR (200) ,
	gtw_pdr VARCHAR (200) ,
	dns_pri VARCHAR (200) ,
	dns_scd VARCHAR (200) ,
	usu_red VARCHAR (200) ,
	sha_red VARCHAR (200) ,
	prx INTEGER NOT NULL ,
	ip_prx VARCHAR (200) ,
	pta_red INTEGER NOT NULL ,
	usu VARCHAR (200) ,
	sha VARCHAR (200) ,
	pta_cmc VARCHAR (20) ,
	num_pdv INTEGER NOT NULL ,
	vrs_lay_xml VARCHAR (10),
	qtd_ten_env INT not null,
	PRIMARY KEY (cod_loj,seq)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_hdw_sat_pdv(
	cod_loj INTEGER NOT NULL ,
	seq INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	PRIMARY KEY (cod_loj,seq,num_pdv)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_otc_pdv_tch(
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	otc INTEGER NOT NULL ,
	pdv_tch VARCHAR (500) ,
	cap_cpf_cnj_ppd INTEGER NOT NULL ,
	PRIMARY KEY (cod_loj,num_pdv)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS frm_pgt_sat (
  cod_loj INT NOT NULL  ,
  cod_frm_pgt INT NOT NULL  ,
  nom_frm_pgt VARCHAR(40) NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_frm_pgt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS frm_pgt_sat_fin (
  	cod_loj INT NOT NULL  ,
	cod_frm_pgt INT NOT NULL  ,	
	cod_fin INT NOT NULL  ,
	PRIMARY KEY (cod_loj,cod_frm_pgt,cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_rat_aqt (
	dat_vda  DATE NOT NULL DEFAULT 0  ,
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
    cod_nat VARCHAR(5) NOT NULL ,
    vlr double not null ,
	num_cup INTEGER NOT NULL ,
	PRIMARY KEY (dat_vda,cod_loj,num_pdv,cod_nat)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_rat_aqt (
	dat_vda  DATE NOT NULL DEFAULT 0  ,
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	num_cup INTEGER NOT NULL ,
    cod_nat VARCHAR(5) NOT NULL ,
    vlr_ant double not null ,
    vlr_bse double not null ,
	PRIMARY KEY (dat_vda,cod_loj,num_pdv,num_cup,cod_nat)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_crd_crt (
  cod_crd INT NOT NULL  ,
  nom_crd VARCHAR(50) NOT NULL  ,
  cnj_crd MEDIUMTEXT NOT NULL  ,
  PRIMARY KEY (cod_crd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_crd_crt_ptp (
  cod_crd INT NOT NULL  ,
  cod_ptp INT NOT NULL  ,
  PRIMARY KEY (cod_crd, cod_ptp)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_ban_crt (
  cod_ban INT NOT NULL  ,
  tip_crt INT NOT NULL  ,
  des_ban VARCHAR(50) NOT NULL  ,
  rlz_bsc_ban_flh INT NOT NULL  ,
  nao_exi_tla_vcl TINYINT(1) NOT NULL  ,
  PRIMARY KEY (cod_ban,tip_crt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_bin_ban (
  cod_bin INT NOT NULL  ,
  cod_ban INT NOT NULL  ,
  tip_crt INT NOT NULL  ,
  PRIMARY KEY (cod_bin, cod_ban,tip_crt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_txt_ban (
  cod_ban INT NOT NULL  ,
  tip_crt INT NOT NULL  ,
  seq INT NOT NULL  ,
  txt VARCHAR(50) NOT NULL  ,
  ord INT NOT NULL  ,
  PRIMARY KEY (cod_ban, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ban_bin (
  dat_mov DATE NOT NULL DEFAULT 0  ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL ,
  cod_bin INT NOT NULL  ,
  cod_ban INT NOT NULL  ,
  tip_crt INT NOT NULL  ,
  cod_ban_flh INT NOT NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ctd_dig (
  cod_loj INT NOT NULL  ,
  tip_ctd INT NOT NULL  ,
  cmh_ctd VARCHAR(500) NOT NULL  ,
  snh_ctd VARCHAR(250) NOT NULL  ,
  ctd_dig BLOB NOT NULL ,
  tip_ctd_dig INT NOT NULL DEFAULT 1  ,
  raz_soc VARCHAR(100) NOT NULL  ,
    ale_epr INT DEFAULT 0 ,
  PRIMARY KEY (cod_loj, tip_ctd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ipr (
  id_ipr INT NOT NULL AUTO_INCREMENT  ,
  tip_ipr INT NOT NULL  ,
  nom_ipr VARCHAR(255) NOT NULL  ,
  PRIMARY KEY (id_ipr)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ipr_dad (
  id_ipr INT NOT NULL  ,
  cod_hdw INT NOT NULL  ,
  pta VARCHAR(255) NOT NULL  ,
  vel INT NOT NULL  ,
  tam INT NOT NULL  ,
  pdd VARCHAR(1) NOT NULL  ,
  bts INT NOT NULL  ,
  PRIMARY KEY (id_ipr)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ipr_pdv (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  tip_ipr INT NOT NULL  ,
  nom_ipr VARCHAR(255) NOT NULL  ,
  cod_hdw INT NOT NULL  ,
  pta VARCHAR(255) NOT NULL  ,
  vel INT NOT NULL  ,
  tam INT NOT NULL  ,
  pdd VARCHAR(1) NOT NULL  ,
  bts INT NOT NULL  ,
  idc_img INT NOT NULL,
  PRIMARY KEY (cod_loj, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_fin_cnv (
  cod_loj INT NOT NULL  ,
  cod_ser INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  cod_cnv VARCHAR(16) NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_ser, cod_fin, cod_cnv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_sat (
  dat_mov DATE NOT NULL ,
  num_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_sre_hdw BIGINT NOT NULL ,
  num_cfe INT NOT NULL ,
  seq INT NOT NULL ,
  ope INT NOT NULL ,
  num_cup INT NOT NULL ,
  num_ses INT NOT NULL  ,
  dat_hor_proc DATETIME ,
  chv_acs VARCHAR(60) NULL ,
  val_cfe DOUBLE(16,2) NOT NULL ,
  cod_ret_sat INT NOT NULL ,
  cod_err_sat INT NOT NULL ,
  msg_err_sat VARCHAR(255) NULL ,
  cod_sfz INT NULL ,
  msg_sfz VARCHAR(255) NULL ,
  xml_env LONGTEXT NULL ,
  xml_ret LONGTEXT NULL ,
  num_pdv_exec INT NOT NULL ,
  PRIMARY KEY (dat_mov, num_loj, num_pdv, num_sre_hdw, num_cfe, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cph_mrc_cpe (
  cod_loj INT NOT NULL  ,
  cod_cph INT NOT NULL  ,
  des VARCHAR(40) NOT NULL  ,
  dat_vig_ini DATE NOT NULL  ,
  dat_vig_fim DATE NOT NULL  ,
  vlr_cup DOUBLE NOT NULL  ,
  qtd_cup_vlr INT NOT NULL  ,
  qtd_prd INT NOT NULL  ,
  qtd_cup_prd INT NOT NULL  ,
  sol_cli TINYINT NOT NULL DEFAULT 0  ,
  sol_cli_obr TINYINT NOT NULL DEFAULT 0  ,
  cns_sck_cli TINYINT NOT NULL DEFAULT 0  ,
  inb_msg_qtd_cup TINYINT NOT NULL DEFAULT 0  ,
  inb_ips_qtd_cup TINYINT NOT NULL DEFAULT 0  ,
  val_vlr_prd_cph TINYINT NOT NULL DEFAULT 0,
  msg_cmo_cpf VARCHAR(255) NOT NULL,
  msg_dgc_cpf VARCHAR(255) NOT NULL,
  utl_cli_fid TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, cod_cph)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_cph_mrc_cpe (
  cod_loj INT NOT NULL  ,
  cod_cph INT NOT NULL  ,
  cod_prd BIGINT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_cph, cod_prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_pdv_ecf (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num_sre_ecf varchar(255) NOT NULL  ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fin_cph_prm (
  cod_loj INT NOT NULL  ,
  tip_cli INT NOT NULL  ,
  cod_fin INT NOT NULL  ,
  PRIMARY KEY (cod_loj, tip_cli, cod_fin)
 ) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_rsv (
  cod_loj INT NOT NULL ,
  sol_ven TINYINT NOT NULL DEFAULT 0 ,
  ven_obr TINYINT NOT NULL DEFAULT 0 ,
  cns_cli_fid TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_mdd_pln_ban (
  cod_loj INT NOT NULL  ,
  cod_mdd INT NOT NULL  ,
  cod_pln INT NOT NULL  ,
  cod_ban INT NOT NULL  ,
  tip_crt INT NOT NULL  ,
  PRIMARY KEY (cod_loj, cod_mdd, cod_pln, cod_ban, tip_crt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prt_nfc (
  cod_loj INT NOT NULL  ,
  tim_ccd INT NOT NULL  ,
  num_ten_env_xml INT NOT NULL  ,
  tim_rsp INT NOT NULL  ,
  vlr_lim_nfc DOUBLE NOT NULL  ,
  vlr_lim_idt_dto DOUBLE NOT NULL  ,
  vrs_lay_nfc DOUBLE (8,2) NOT NULL DEFAULT 1.00 ,
  cod_uf_ibg INT NOT NULL ,
  cod_mun_ibg INT NOT NULL ,
  cod_rgm_trb INT NOT NULL ,
  loc_gra_xml_vda VARCHAR(255) NULL ,
  loc_gra_xml_can VARCHAR(255) NULL ,
  env_cns_stt INT NOT NULL DEFAULT 0  ,
  atz_mnt INT NOT NULL DEFAULT 0  ,
  prz_max_env_xml_ctg INT NOT NULL DEFAULT 0  ,
  cod_tok_hml INT NOT NULL DEFAULT 0 ,
  cod_tok_pdc INT NOT NULL DEFAULT 0 ,
  tok_hml VARCHAR(255) NULL ,
  tok_pdc VARCHAR(255) NULL ,
  ip_cfe VARCHAR(16) NULL ,
  pta_cfe INT NOT NULL DEFAULT 0  ,
  gra_xml_dsp_mvl TINYINT(1) NOT NULL DEFAULT 0  ,
  epc_min_dsp_mvl int NOT NULL DEFAULT 0  ,
  sol_env_daf_eml TINYINT(1) NOT NULL DEFAULT 0  ,
  nao_ipm_daf TINYINT(1) NOT NULL DEFAULT 0  ,
  hab_ger_pis_cfn TINYINT(1) NOT NULL DEFAULT 0  ,
  hab_ctg_sat TINYINT(1) NOT NULL DEFAULT 0 ,  
  hab_pre_vld TINYINT(1) NOT NULL DEFAULT 0 ,
  pmt_can_dia_ant TINYINT(1) NOT NULL DEFAULT 0 ,
  emt_ctg TINYINT(1) NOT NULL DEFAULT 0,
  num_reg_ctg  INT NOT NULL DEFAULT 0,
  obr_nom TINYINT(1) NOT NULL DEFAULT 0,
  obr_edr TINYINT(1) NOT NULL DEFAULT 0,
  sol_vlr_can_nfc TINYINT(1) NOT NULL DEFAULT 0,
  pmt_inf_cli_vda TINYINT(1) NOT NULL DEFAULT 0,
  vrs_nfc DOUBLE NOT NULL,
  nao_eme_via_etb_ctg TINYINT(1) NOT NULL DEFAULT 0,
  cnj_esc_ctl BIGINT DEFAULT 0,
  obr_cli_ctg TINYINT(1) NOT NULL DEFAULT 0,
  exl_icm_bse_cal_con TINYINT(1) NOT NULL DEFAULT 0,
  utl_atm_cpf_nfp_nfe_cns_eml  TINYINT(1) NOT NULL DEFAULT 0,
  env_eml_daf_sen_pga  TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prt_url_nfc (
  cod_loj INT NOT NULL  ,
  url_cns VARCHAR(255) NULL  ,
  url_rpc VARCHAR(255) NULL  ,
  url_evt VARCHAR(255) NULL  ,
  url_stt_ser VARCHAR(255) NULL  ,
  url_cns_not VARCHAR(255) NULL  ,
  url_ret_rpc VARCHAR(255) NULL  ,
  url_itz VARCHAR(255) NULL  ,
  url_qrc VARCHAR(255) NULL  ,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prt_uf_nfc (
  uf VARCHAR(2) NOT NULL  ,
  PRIMARY KEY (uf)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prt_und_cmr_nfc (
  sgl_und_cmr VARCHAR(2) NOT  NULL  ,
  des VARCHAR(15) NULL  ,
  PRIMARY KEY (sgl_und_cmr)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prt_pdv_nfc (
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_sre_daf INT NOT NULL  ,
  num_ini_nfc INT NOT NULL  ,
  blq_pdv_sem_cmc TINYINT NOT NULL DEFAULT 0  ,
  mdl_daf_spd TINYINT NOT NULL DEFAULT 0  ,
  num_lot_env_xml bigint NOT NULL ,
  mdl_doc_fsc INT NOT NULL ,
  hom TINYINT NOT NULL DEFAULT 0  ,
  ip_cfe VARCHAR(16) NULL ,
  pta_cfe INT NOT NULL DEFAULT 0  ,
  mdl_daf_cmt TINYINT NOT NULL DEFAULT 0  ,
  imp_cpv_can TINYINT NOT NULL DEFAULT 0 ,
  imp_cpv_can_aut TINYINT NOT NULL ,
  nao_imp_cpv_fch TINYINT NOT NULL ,
  imp_ite_can_cup TINYINT NOT NULL ,
  abr_gvt_ats_sfz TINYINT(1) NOT NULL DEFAULT 0 ,
  vrs_nfc DOUBLE NOT NULL  ,
  ipm_cpv_aut_cnc TINYINT(1) NOT NULL DEFAULT 0,
  ipm_cpv_daf_rdz TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj,cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS frm_pgt_nfc (
  cod_loj INT NOT NULL ,
  cod_frm_pgt INT NOT NULL ,
  cod_fin INT NOT NULL ,
  prz TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, cod_frm_pgt, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS crt_ctg (
  num_nfc INT  NOT NULL  ,
  dat_hor DATETIME  DEFAULT NULL  ,
  dat_hor_trs DATETIME  DEFAULT NULL  ,
  trs_ccd TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (num_nfc)
)ENGINE = InnoDB
;

CREATE TABLE conf_integracao_bd_comum (
  chave VARCHAR(40) NOT NULL ,
  valor TEXT NOT NULL ,
  PRIMARY KEY(chave)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cnv_int(
	cpf_cnj BIGINT NOT NULL ,
	nro_frm_pgt INTEGER NOT NULL DEFAULT 0,
	cod_cli INTEGER NOT NULL DEFAULT 0,
	nom_cli VARCHAR (50) NOT NULL DEFAULT '' ,
	edr_cli VARCHAR (50) NOT NULL DEFAULT '' ,
	brr_cli VARCHAR (20) NOT NULL DEFAULT '' ,
	cdd_cli VARCHAR (30) NOT NULL DEFAULT '' ,
	uf_cli VARCHAR (2) NOT NULL DEFAULT '' ,
	cep_cli VARCHAR (20) NOT NULL DEFAULT '' ,
	ins_etd_rg VARCHAR (25) NOT NULL DEFAULT '' ,	
	tel_cli VARCHAR (14) NOT NULL DEFAULT '' ,
	tip_cli INTEGER NOT NULL DEFAULT 0 ,
	sit_cli INTEGER NOT NULL DEFAULT 0 ,
	lim_cli DOUBLE  NOT NULL DEFAULT 0 ,
	acd_cli DOUBLE  NOT NULL DEFAULT 0 ,
	PRIMARY KEY (cpf_cnj,nro_frm_pgt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ger_tdm (
  cod_loj INT NOT NULL ,
  ger_arq_tdm_atm_drm TINYINT NOT NULL DEFAULT 0 ,
  ger_arq_tdm_atm TINYINT NOT NULL DEFAULT 0 ,
  vld_arq_tdm TINYINT NOT NULL DEFAULT 0 ,
  env_arq_ftp TINYINT NOT NULL DEFAULT 0 ,
  cmh_ftp VARCHAR(255) NULL ,
  usu_ftp VARCHAR(50) NULL ,
  sha_ftp VARCHAR(50) NULL ,
  sol_des_ant_ger TINYINT(1) NOT NULL DEFAULT 0 ,
  vrf_ict_ecf TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ger_tdm_pdv (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS cfg_ncm (
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cod_ncm BIGINT NULL ,
  dat_atz DATE NOT NULL ,
  obr_cest TINYINT NULL,
  PRIMARY KEY (sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_url_nfc (
  url_uf VARCHAR(2) NOT NULL  ,
  pte_fix VARCHAR(255) NULL  ,
  url_rpc VARCHAR(255) NULL  ,
  url_ret_rpc VARCHAR(255) NULL  ,
  url_evt VARCHAR(255) NULL  ,
  url_stt_ser VARCHAR(255) NULL  ,
  url_rpc_hml VARCHAR(255) NULL  ,
  url_ret_rpc_hml VARCHAR(255) NULL  ,
  url_evt_hml VARCHAR(255) NULL  ,
  url_stt_ser_hml VARCHAR(255) NULL  ,
  PRIMARY KEY (url_uf)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_rtc_ser (
  cod_loj INT NOT NULL ,
  cod_ser INT NOT NULL ,
  cod_rtc INT NOT NULL ,
  aca INT NOT NULL ,
  PRIMARY KEY (cod_loj, cod_ser, cod_rtc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_mrt (
  cod_loj INT NOT NULL ,
  tip_mrt INT NOT NULL ,
  hab_evt TINYINT NOT NULL DEFAULT 0 ,
  cmh_bse VARCHAR(255) NOT NULL ,
  ip_srv VARCHAR(20) NOT NULL ,
  de_pra_fin VARCHAR(255),
  PRIMARY KEY (cod_loj, tip_mrt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_evt_mrt (
  cod_loj INT NOT NULL ,
  tip_mrt INT NOT NULL ,
  evt INT NOT NULL ,
  PRIMARY KEY (cod_loj, tip_mrt, evt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ale_pda (
 rtc INT NOT NULL  ,
 qtd_cls_ale INT NOT NULL  ,
 tpo_ldo INT NOT NULL  ,
 tpo_dgo INT NOT NULL  ,
 PRIMARY KEY (rtc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_mod_cbc (
  cod_loj INT NOT NULL ,
  hab_mod TINYINT NOT NULL DEFAULT 0 ,
  idt_pgt_crt VARCHAR(255) NOT NULL ,
  idt_frm_crt VARCHAR(255) NOT NULL ,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE mov_sai_ope_fin (
   dat_mov DATE NOT NULL ,
   cod_loj INT NOT NULL  ,
   cod_pdv INT NOT NULL  ,
   seq_ope INT NOT NULL  ,
   cod_fin INT NOT NULL  ,
   cod_ope INT NOT NULL  ,
   vlr_vda DOUBLE(16,2) NOT NULL DEFAULT 0 ,
   vlr_tco DOUBLE(16,2) NOT NULL DEFAULT 0 ,
   fin_pgt_rbt INT NOT NULL DEFAULT 0  ,
   mtc INTEGER not null default 0,
   PRIMARY KEY(dat_mov, cod_loj, cod_pdv, seq_ope, cod_fin)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_pdv_mob (
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	ip VARCHAR(20) NOT NULL ,
	pta INTEGER NOT NULL ,
	pmt_fec tinyint(1) NULL DEFAULT 0 ,
	otc INTEGER NOT NULL ,
	PRIMARY KEY (cod_loj, num_pdv)
) ENGINE = InnoDB
;	

CREATE TABLE IF NOT EXISTS cad_dep_cli (
  cpf_cnp_tit BIGINT NOT NULL ,
  cpf_cnp_dep BIGINT NOT NULL ,
  nom_dep VARCHAR(50) NOT NULL ,
  sha_dep VARCHAR(255) NOT NULL ,
  sit INT NOT NULL ,
  PRIMARY KEY (cpf_cnp_tit, cpf_cnp_dep)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_dep_cvd (
  cod_cnv VARCHAR(16) NOT NULL ,
  cod_cvd VARCHAR(20) NOT NULL ,
  cvd_dep VARCHAR(20) NOT NULL ,
  nom_dep VARCHAR(50) NOT NULL ,
  sha_dep VARCHAR(255) NOT NULL ,
  sit INT NOT NULL ,
  PRIMARY KEY (cod_cnv, cod_cvd, cvd_dep)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_cpv_vas (
	dat_mov DATE NOT NULL ,
	num_loj INT NOT NULL ,
	num_pdv INT NOT NULL ,
	num_cup INT NOT NULL ,
	num_cpv INT NOT NULL ,
	cod_prd BIGINT NOT NULL ,
	prc DOUBLE NOT NULL ,
	des_prd VARCHAR(255) NOT NULL ,
	qtd_inf INT NOT NULL ,
	qtd_utl INT NOT NULL ,
	cod_ope INT NOT NULL ,
	PRIMARY KEY (dat_mov, num_loj, num_pdv, num_cup, num_cpv, cod_prd)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_num_nfc (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num INT NOT NULL  ,
  sre INT NOT NULL  ,
  dat_hor_alt DATETIME NOT NULL ,
  num_ctg INT NOT NULL  ,
  sre_ctg INT NOT NULL  ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_atz_num_nfc (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  num INT NOT NULL  ,
  sre INT NOT NULL  ,
  dat_hor_atz DATETIME NOT NULL ,
  sit INT NOT NULL ,
  num_ctg INT NOT NULL  ,
  sre_ctg INT NOT NULL  ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_itz_num_nfc (
  cod_loj INT NOT NULL  ,
  num_ini INT NOT NULL  ,
  num_fim INT NOT NULL  ,
  sre INT NOT NULL  ,
  sit INT NOT NULL ,
  vrs_nfc DOUBLE NOT NULL,
  num_cup INT NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, num_ini, num_fim, sre)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ctr_itz_num_nfc (
  dat_mov DATETIME NOT NULL ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  seq INT NOT NULL  ,
  num_ini INT NOT NULL  ,
  num_fim INT NOT NULL  ,
  sre INT NOT NULL  ,
  sit INT NOT NULL ,
  vrs_nfc DOUBLE NOT NULL,
  num_cup INT NOT NULL DEFAULT 0,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_url_wsv_nfc (
  url_uf VARCHAR(2) NOT NULL  ,
  tip_url INTEGER NOT NULL  ,
  url_hml VARCHAR(255) NULL  ,
  url_pdc VARCHAR(255) NULL  ,
  pta INTEGER NULL  ,
  tim INTEGER NULL  ,
  acn TINYINT(1) NOT NULL DEFAULT 0  ,
  PRIMARY KEY (url_uf, tip_url)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_nfc (
  num_loj INT NOT NULL ,
  num_nfc INT NOT NULL ,
  sre_nfc INT NOT NULL ,
  seq INT NOT NULL ,
  ope INT NOT NULL ,
  num_pdv INT NOT NULL ,
  tip_ems INT NOT NULL ,
  num_lot INT NOT NULL ,
  dat_hor_ems DATETIME NOT NULL ,
  dat_hor_rcb DATETIME NULL ,
  dat_hor_ctg DATETIME NULL ,
  chv_acs VARCHAR(44) NULL ,
  dgt_vlr VARCHAR(255) NULL ,
  num_ptc BIGINT NULL ,
  num_rcb BIGINT NULL ,
  amb INT NULL ,
  cod_sfz INT NULL ,
  msg_sfz VARCHAR(255) NULL ,
  mtv_sfz VARCHAR(255) NULL ,
  xml_env LONGTEXT NULL,
  xml_ret LONGTEXT NULL ,
  sit_env_nfc INT NOT NULL ,
  mtv_ctg INT NOT NULL ,
  dat_hor_ult_env DATETIME NULL ,
  qtd_env_nfc INT NOT NULL ,
  cod_ret_nfc INT NOT NULL ,
  cod_err_nfc INT NOT NULL ,
  msg_err_nfc VARCHAR(255) NULL ,
  qrcode TEXT NULL ,
  vrs_lay_nfc DOUBLE NULL ,
  PRIMARY KEY (num_loj, num_nfc, sre_nfc, seq)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_ori_prd (
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cod_ori INT(3) NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cfop_prd (
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cod_cfop INT(8) NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_fam_prd (
  cod_loj INT NOT NULL  ,
  prd_pai BIGINT NOT NULL ,
  prd_flh BIGINT NOT NULL ,
  PRIMARY KEY (cod_loj, prd_pai, prd_flh)
 )ENGINE = InnoDB
;

create index idx_cad_fam_prd on cad_fam_prd (prd_flh);

CREATE  TABLE IF NOT EXISTS cad_ptp_trn (
  cod_ptp INT NOT NULL   ,
  nom VARCHAR(100) NOT NULL  ,
  cpf_cnj MEDIUMTEXT NOT NULL  ,
  ins_uf VARCHAR(20) NULL  ,
  cdd INT NOT NULL  ,
  uf INT NOT NULL  ,
  cod_suf VARCHAR(9) NULL  ,
  end VARCHAR(60) NOT NULL  ,
  num VARCHAR(15) NOT NULL  ,
  com VARCHAR(60) NULL  ,
  brr VARCHAR(60) NULL  ,
  tip_ptp INT NOT NULL  ,
  cod_idt VARCHAR(255) NULL  ,
  PRIMARY KEY (cod_ptp)
 )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_cam_cad_fid_pdv (
  grp INT NOT NULL ,
  cam INT NOT NULL ,
  obr TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (grp, cam)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_msg (
 id INT NOT NULL  ,
 dat_hor DATETIME  DEFAULT NULL  ,
 msg VARCHAR(60) NOT NULL ,
 ori VARCHAR(20) NOT NULL ,
 pdt TINYINT NOT NULL DEFAULT 0 ,
 tim INT NOT NULL  ,
 PRIMARY KEY (id)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_arq_hdw (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  cod_hdw INT NOT NULL ,
  chv INT NOT NULL ,
  vlr VARCHAR(255) NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv, cod_hdw, chv))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_dsc_ite (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL ,
  tip_dsc INT NOT NULL ,
  cod_prm INT NOT NULL ,
  vlr_dsc DOUBLE NOT NULL ,
  qtd_prm DOUBLE NOT NULL ,
  usr INT NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, seq, tip_dsc)
)ENGINE = InnoDB
;

CREATE TABLE ctr_mov_dsc_ite (
  seq INT NOT NULL  ,
  tip_dsc INT NOT NULL  ,
  cod_prm INT NOT NULL  ,
  vlr_dsc DOUBLE NOT NULL  ,
  qtd_prm DOUBLE NOT NULL ,
  grp_dsc INT NOT NULL,
  dsc_apl TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (seq, tip_dsc, cod_prm)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ipt_ite (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL ,
  cod_ipt INT NOT NULL ,
  tip_ipt INT NOT NULL ,
  vlr_ite DOUBLE NOT NULL ,
  vlr_ipt DOUBLE NOT NULL ,
  alq_ipt DOUBLE NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, seq, tip_ipt, cod_ipt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ctg_tef (
  cod_loj INT NOT NULL ,
  mnt_ctg INT NOT NULL ,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ip_ctg_tef (
  cod_loj INT NOT NULL ,
  ip VARCHAR(16) NOT NULL ,
  ord INT NOT NULL ,
  PRIMARY KEY (cod_loj, ip)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_ctg_tef (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  ip VARCHAR(16) NOT NULL ,
  ord INT NOT NULL ,
  sit INT NOT NULL ,
  dat_hor_atz DATETIME NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cmd_res (
  cod_loj INT NOT NULL ,
  cod_cmd INT NOT NULL ,
  cod_grp INT NOT NULL DEFAULT 0 ,
  sit INT NOT NULL DEFAULT 0 ,
  idv TINYINT NOT NULL DEFAULT 0 ,
  ina TINYINT NOT NULL DEFAULT 0 ,
  cod_ped_atu BIGINT NOT NULL ,
  dat_ult_atu TIMESTAMP ,
  PRIMARY KEY (cod_loj, cod_cmd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ped (
  cod bigint(20) NOT NULL AUTO_INCREMENT,
  dat_alt datetime DEFAULT NULL,
  usr bigint(20) DEFAULT NULL,
  dat_abt datetime DEFAULT NULL,
  dat_fec datetime DEFAULT NULL,
  qtd int(11) DEFAULT NULL,
  seq_ite int(11) DEFAULT NULL,
  sit int(11) DEFAULT NULL,
  cod_cmd int(11) NOT NULL,
  usr_ped bigint(20) DEFAULT NULL,
  version int(11) NOT NULL,
  num_msa int(11) DEFAULT NULL,
  cpt VARCHAR(500) NULL,
  bal TINYINT(1) NULL,
  PRIMARY KEY (cod)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ite_ped (
  cod bigint(20) NOT NULL AUTO_INCREMENT,
  dat_alt datetime DEFAULT NULL,
  usr bigint(20) DEFAULT NULL,
  cod_cmd_org int(11) DEFAULT NULL,
  cod_seq int(11) DEFAULT NULL,
  frc bit(1) DEFAULT NULL,
  imd bit(1) DEFAULT NULL,
  obs varchar(255) DEFAULT NULL,
  prc_ttl double DEFAULT NULL,
  prc_utl double DEFAULT NULL,
  qtd double DEFAULT NULL,
  sit int(11) DEFAULT NULL,
  cod_ped bigint(20) NOT NULL,
  cod_prd bigint(20) NOT NULL,
  usr_ped bigint(20) DEFAULT NULL,
  dat_ped datetime DEFAULT NULL,
  usr_can bigint(20) DEFAULT NULL,
  cpt VARCHAR(650) NULL,
  dsc_prd VARCHAR(255) NULL,
  dsc_sit VARCHAR(255) NULL,
  cod_grp int(11) DEFAULT NULL,
  ipm TINYINT(1) NULL,
  dat_ent DATETIME NULL,
  usu_ent int(11) DEFAULT NULL,
  PRIMARY KEY (cod)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS mov_txa_ent_cli(
	dat_vda DATE NOT NULL DEFAULT 0  ,
	cod_loj INT NOT NULL ,
	num_pdv INT NOT NULL ,
	num_cup INT NOT NULL ,
	cpf VARCHAR(16) NOT NULL ,
	nom VARCHAR(60) NOT NULL ,
	edr VARCHAR(80) NOT NULL ,
	brr VARCHAR(80) NOT NULL ,
	cdd VARCHAR(80) NOT NULL ,
	PRIMARY KEY (dat_vda,cod_loj, num_pdv, num_cup)
) ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_eml_nfc (
  cod_loj INT NOT NULL ,
  eml_rem VARCHAR(255) NOT NULL ,
  end_stp VARCHAR(255) NOT NULL ,
  pta_stp VARCHAR(255) NOT NULL  ,
  usu_eml VARCHAR(255) NOT NULL ,
  sha_eml VARCHAR(255) NOT NULL ,
  ass VARCHAR(255) NOT NULL ,
  tip_ptc_seg INT NOT NULL ,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_eml_daf_nfc (
  num_loj INT NOT NULL ,
  num_nfc INT NOT NULL ,
  sre_nfc INT NOT NULL ,
  seq INT NOT NULL ,
  eml VARCHAR(255) NULL ,
  chv_acs VARCHAR(255) NULL ,
  stt INT NOT NULL ,
  PRIMARY KEY (num_loj, num_nfc, sre_nfc, seq)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS psm_etp (
  cod_loj INT NOT NULL ,
  id_pms INT NOT NULL ,
  vlr double NOT NULL ,
  PRIMARY KEY (cod_loj, id_pms)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_max_mtp_prd (
  cod_loj INT NOT NULL ,
  cod_prd BIGINT NOT NULL ,
  max_mtp INT NOT NULL ,
  PRIMARY KEY (cod_loj, cod_prd)
)ENGINE = InnoDB
;

CREATE TABLE ger_key_cod_mob (
  cod_loj integer not null ,
  id_ger integer not null ,
  key_cod integer not null ,
  ord integer not null ,
  id_pnl integer not null ,
  dsc varchar(255) DEFAULT NULL ,
  primary key (cod_loj, id_ger, key_cod)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_pes_prd (
  ean BIGINT NOT NULL ,
  tip INT NOT NULL ,
  pes double(8,3) NOT NULL ,
  tol_min double(8,3) NOT NULL ,
  tol_max double(8,3) NOT NULL ,
  ina TINYINT NOT NULL ,
  dat_atz DATETIME NOT NULL ,
  qtd_oco INT NOT NULL ,
  cal_qtd_prd TINYINT NOT NULL ,
  hab_mul TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (ean, tip)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_pes_prd (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL ,
  ean BIGINT NOT NULL ,
  pes DOUBLE(16,3) NOT NULL ,
  pes_min DOUBLE(16,3) NOT NULL ,
  pes_max DOUBLE(16,3) NOT NULL ,
  cod_usu DOUBLE NOT NULL ,
  dat_hor DATETIME NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_cad_pes_prd (
  ean BIGINT NOT NULL ,
  pes double(8,3) NOT NULL ,
  tol_min double(8,3) NOT NULL ,
  tol_max double(8,3) NOT NULL ,
  qtd_oco INT NOT NULL ,
  dat_atz DATETIME NOT NULL ,
  PRIMARY KEY (ean)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_fxa_pes (
  id BIGINT NOT NULL ,
  fxa_ini double(8,3) NOT NULL ,
  fxa_fim double(8,3) NOT NULL ,
  tol_min double(8,3) NOT NULL ,
  tol_max double(8,3) NOT NULL ,
  per TINYINT NOT NULL ,
  PRIMARY KEY (id)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS sec_prd_tol_frc (
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  tol_min double(8,3) NOT NULL ,
  tol_max double(8,3) NOT NULL ,
  per TINYINT NOT NULL ,
  ina TINYINT NOT NULL ,
  dat_atz DATETIME NOT NULL ,
  PRIMARY KEY (sec, grp, sgr, prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_grp_sct(
	cod_loj integer not null default 0,
	cod_grp integer not null default 0,
	des varchar(40) not null default '',
	ip varchar(16) not null default '',
	pta integer not null default 0,
	ipm_cpv_fec TINYINT NOT NULL ,
	ipm_cpv_tef_fec TINYINT NOT NULL ,
	qtd_max_ite integer not null default 0,
	nao_ipm_tef_etb TINYINT(1) NOT NULL,
	PRIMARY KEY (cod_loj, cod_grp)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_grp_sct_pdv(
	cod_loj integer not null default 0,
	cod_grp integer not null default 0,
	cod_pdv integer not null default 0,
	ord integer not null default 0,
	PRIMARY KEY (cod_loj, cod_grp, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_sct(
	cod_loj integer not null default 0,
	tol_min DOUBLE(8,3) NOT NULL DEFAULT 0,
	tol_max DOUBLE(8,3) NOT NULL DEFAULT 0,
	tol_min_pso_atl_ant DOUBLE(8,3) NOT NULL DEFAULT 0,
	pso_ini_min DOUBLE(8,3) NOT NULL DEFAULT 0,
    pso_max_blc integer not null default 0,
    tim_msg_cli integer not null default 0,
    tim_msg_ict integer not null default 0,
    qtd_pra_mdi_prd integer not null default 0,
    qtd_ocr_pra_blq_prd integer not null default 0,
    tol_max_bal DOUBLE(8,3) NOT NULL DEFAULT 0,
    pss_pag_mai_frm_pgt TINYINT(1) NOT NULL DEFAULT 0 ,
   	inf_cli TINYINT(1) DEFAULT 0,
   	tim_exi_img integer not null default 0,
   	sol_att_tef_sha TINYINT(1) DEFAULT 0,
   	fin_pgt_itg_dsc integer not null default 0,
   	tpo_val_prd_ina integer not null default 0,
   	hab_som TINYINT(1) not null default 0,
   	cod_prd_scl BIGINT NOT NULL ,
   	dsb_doa_tco TINYINT(1) NOT NULL DEFAULT 0,
   	pmt_pln_prl_cup TINYINT(1) NOT NULL DEFAULT 0,
   	hab_mtp_man_ite TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cad_img_prd (
  cod_prd BIGINT NOT NULL  ,
  url VARCHAR(50) NOT NULL  ,
  exl TINYINT(1) NOT NULL ,
  PRIMARY KEY (cod_prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_res (
  cod_Loj INT NOT NULL ,
  qtd_lin_cmd INT NULL DEFAULT NULL ,
  qtd_col_cmd INT NULL DEFAULT NULL ,
  qtd_dia_lpz INT NULL DEFAULT NULL ,
  per_atd DOUBLE NULL DEFAULT NULL ,
  tip_arr INT NULL DEFAULT NULL ,
  abt_atm TINYINT NULL DEFAULT NULL ,
  cob_pfr TINYINT NULL DEFAULT NULL ,
  dsp_cmd_fec TINYINT NULL DEFAULT NULL ,
  ipm_ped TINYINT NULL DEFAULT NULL ,
  isr_prd_cod_bar TINYINT NULL DEFAULT NULL ,
  sol_cod_atd TINYINT NULL DEFAULT NULL ,
  sol_num_msa_ped TINYINT NULL DEFAULT NULL ,
  utl_bln TINYINT NOT NULL DEFAULT false ,
  ult_psv TINYINT NOT NULL DEFAULT true ,
  niv_prc INT NOT NULL ,
  nao_ult_prm_loj TINYINT NOT NULL DEFAULT true ,
  exp_ean TINYINT NOT NULL DEFAULT true ,
  ip_pdv_rel VARCHAR(255) NOT NULL ,
  trt_prd_unt_etq_qtd TINYINT NOT NULL DEFAULT true ,
  utl_etq_bln_qtd TINYINT NOT NULL DEFAULT true ,
  qtd_dgi_etq integer ,
  imp_nao_cob_dez_por TINYINT NOT NULL ,
  nao_exi_cod_prd TINYINT(1) NOT NULL ,
  exi_prd_qtd_vda TINYINT(1) NOT NULL ,
  qtd_dia_apr INT NULL DEFAULT NULL ,
  agd_ips_ped TINYINT(1) DEFAULT false NOT NULL ,
  qtd_mrt INT(8) NULL DEFAULT NULL ,
  hab_vis_ite_ved TINYINT(1) DEFAULT false NOT NULL ,
  qtd_dia_fch_cmd integer NULL DEFAULT 0 ,
  ale_cmd_pen_fch_ope TINYINT(1) DEFAULT false NOT NULL,
  obr_reg_cmd_abr TINYINT(1) DEFAULT false NOT NULL,
  mte_prc_prd_frc TINYINT(1) DEFAULT false NOT NULL,
  utl_cte_exd TINYINT(1) DEFAULT false NOT NULL,
  ipm_txa_ser_pre_cta TINYINT(1) DEFAULT false NOT NULL,
  msg_txa_ser VARCHAR(200) NOT NULL,
  rep_pdv_rel_cpv_dsp_mvl TINYINT(1) DEFAULT false NOT NULL,
  url_img_prd VARCHAR(200) DEFAULT '' NULL,
  ipm_txa_ser_cta TINYINT(1) DEFAULT false NOT NULL,
  msg_txa_ser_cta VARCHAR(20),
  opn_inf_num_msa  TINYINT(1) DEFAULT false NOT NULL,
  PRIMARY KEY (cod_Loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prf_ite (
  cod bigint(20) NOT NULL AUTO_INCREMENT,
  prc double DEFAULT NULL,
  adc_sub bit(1) DEFAULT NULL,
  cod_prf bigint(20) NOT NULL,
  cod_ite_ped bigint(20) NOT NULL,
  des VARCHAR(255) NOT NULL ,
  qtd double not null,
  PRIMARY KEY (cod)
) ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_tla_prd_pes(
  cod_loj integer not null ,
  sec INT NOT NULL  ,
  grp INT NOT NULL  ,
  sgr INT NOT NULL  ,
  prd INT NOT NULL  ,
  PRIMARY KEY (cod_loj, sec, grp, sgr, prd)
) ENGINE = INNODB
;

CREATE TABLE IF NOT EXISTS nom_exi_pdv (
  cod_loj INTEGER not null ,
  dat_ini DATE not null ,
  dat_fim DATE not null ,
  tip_prm INTEGER not null ,
  cod_prm BIGINT not null ,
  cod_prd BIGINT not null ,
  nom_prm VARCHAR(50) not null ,
  PRIMARY KEY(cod_loj, dat_ini, dat_fim, tip_prm, cod_prm, cod_prd)
) ENGINE = innodb
;

CREATE INDEX idx_nom_exi_pdv_loj_dat ON nom_exi_pdv (cod_loj, dat_ini, cod_prm, tip_prm);

CREATE TABLE IF NOT EXISTS ips_daf (
  dat_mov date not null ,
  cod_loj INTEGER(11) not null ,
  cod_pdv INTEGER(11) not null ,
  num_cup INTEGER(11) not null ,
  seq INTEGER(11) not null ,
  lin_tck MEDIUMTEXT not null ,
  tip_cpv INTEGER(11) not null ,
  via_cpv INTEGER(11) not null ,
  PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS psm_etp_crt_mag (
  cod_loj INT NOT NULL ,
  cod_pms INT NOT NULL ,
  PRIMARY KEY (cod_loj, cod_pms)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ope_adc (
   dat_mov DATE NOT NULL ,
   cod_loj INT NOT NULL  ,
   cod_pdv INT NOT NULL  ,
   cod_ope INT NOT NULL  ,
   cod_fin INT NOT NULL  ,
   mtc INTEGER not null default 0,
   PRIMARY KEY(dat_mov, cod_loj, cod_pdv, cod_ope, cod_fin)
) ENGINE = InnoDB
;

CREATE  TABLE IF NOT EXISTS cfg_bat_cxa (
  cod_loj INT NOT NULL ,
  ctr_mtv_qbr_cxa TINYINT NOT NULL DEFAULT 0  ,
  hab_dif_val_cxa TINYINT NULL  ,
  ipm_rel_sin_pdv TINYINT NULL DEFAULT 0 ,
  qbr_vlr_crt_ban TINYINT NULL DEFAULT 0 ,
  ctr_alt_bat INT NOT NULL  ,
  nao_exp_mov TINYINT NULL DEFAULT 0,
  hab_nav_tla TINYINT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
 )ENGINE = InnoDB
;

CREATE TABLE cfg_spa_net_tab_prc (
  cod_loj INT NOT NULL DEFAULT 0 ,
  mnt_ini INT NOT NULL ,
  mnt_fim INT NOT NULL ,
  vlr_cob DOUBLE NOT NULL ,
  PRIMARY KEY(cod_loj, mnt_ini, mnt_fim)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_ori_prd_loj (
  cod_loj INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cod_ori INT(3) NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (cod_loj, sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cfop_prd_loj (
  cod_loj INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cod_cfop INT(8) NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (cod_loj, sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE cfg_msg_ale (
  cod_loj INT NOT NULL DEFAULT 0 ,
  tip_opr INT NOT NULL DEFAULT 0 ,
  seq INT NOT NULL DEFAULT 0 ,
  msg VARCHAR(255) NOT NULL ,
  PRIMARY KEY(cod_loj, tip_opr, seq)
)ENGINE = InnoDB
;

CREATE TABLE cfg_prt_ale (
  cod_loj INT NOT NULL DEFAULT 0 ,
  utl_msg_dtc_pdv TINYINT(1) NOT NULL ,
  PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE cfg_fun_ale (
  cod_loj INT NOT NULL DEFAULT 0 ,
  fnd INT NOT NULL ,
  cor INT NOT NULL ,
  env_scn TINYINT(1) NOT NULL ,
  blq_scn TINYINT(1) NOT NULL ,
  PRIMARY KEY(cod_loj, fnd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ger_tec_cpn_pdv (
	cod_loj INT NOT NULL DEFAULT 0 ,
	fun INT NOT NULL DEFAULT 0 ,
	tec INT NOT NULL DEFAULT 0 ,
	PRIMARY KEY(cod_loj, fun)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_crd (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL DEFAULT 0 ,
  num_pdv INT NOT NULL DEFAULT 0 ,
  num_cup INT NOT NULL DEFAULT 0 ,
  seq INT NOT NULL DEFAULT 0 ,
  tco DOUBLE NOT NULL DEFAULT 0 ,
  ccf INT NOT NULL DEFAULT 0 ,
  crd INT NOT NULL DEFAULT 0 ,
  cpf_cli VARCHAR(14) NOT NULL ,
  num_tto INT NOT NULL DEFAULT 0 ,
  cnj_edd_rbr VARCHAR(16) NOT NULL ,
  cpt  VARCHAR(500) NULL DEFAULT NULL ,
  PRIMARY KEY(dat_mov,cod_loj,num_pdv,num_cup,seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cdm_paf (
	uf VARCHAR(2) NOT NULL ,
	vrs INT NOT NULL ,
	num_cdm BIGINT NOT NULL ,
	PRIMARY KEY(uf, vrs)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_prm_cup (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_prm INT NOT NULL DEFAULT 0 ,
	nom_prm VARCHAR(80) NOT NULL DEFAULT '' ,
	tip_prm INT DEFAULT 0 ,
	dat_srt DATE ,
	hor_srt TIME ,
	vde_ini DATE NOT NULL ,
	vde_fim DATE NOT NULL ,
	vde_hor TIME NOT NULL ,
	vlr_min DOUBLE NOT NULL DEFAULT 0 ,
	qtd_cup INT NOT NULL DEFAULT 0 ,
	num_aut_cef VARCHAR(40) NOT NULL ,
	num_lei VARCHAR(40) NOT NULL ,
	tip_brd VARCHAR(80) NOT NULL DEFAULT '' ,
	frs_lvr VARCHAR(80) NOT NULL DEFAULT '' ,
	id_cpv INT NOT NULL DEFAULT 0 ,
	vlr_sgt_prm DOUBLE NOT NULL DEFAULT 0,
	msg_sgt_prm VARCHAR(80),
	exi_msg_sgt_prm INT NOT NULL DEFAULT 0,
	cdt_tip_brd VARCHAR(80) NOT NULL ,
	cod_cpv_cli_idt INT NOT NULL ,
	qtd_brd INT NOT NULL , 
	cdt_cod_unc INT NOT NULL ,
	ina tinyint(1) NOT NULL DEFAULT 0,
	qtd_dsp INT NOT NULL DEFAULT 0,
	PRIMARY KEY(cod_loj, cod_prm)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fxa_vlr_prm_cup (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_prm INT NOT NULL DEFAULT 0 ,
	seq INT NOT NULL ,
	fxa_ini DOUBLE NOT NULL DEFAULT 0 ,
	fxa_fim DOUBLE DEFAULT 0 ,
	qtd_cup INT NOT NULL DEFAULT 0  ,
	PRIMARY KEY(cod_loj, cod_prm, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_prm_cup (
	dat_mov DATE NOT NULL ,
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_pdv INT NOT NULL DEFAULT 0 ,
	num_cup INT NOT NULL DEFAULT 0 ,
	cod_prm INT NOT NULL DEFAULT 0 ,
	vlr_min DOUBLE NOT NULL DEFAULT 0 ,
	qtd_cup INT NOT NULL DEFAULT 0 ,
	fxa_ini DOUBLE NOT NULL DEFAULT 0 ,
	fxa_fim DOUBLE DEFAULT 0 ,
	PRIMARY KEY(dat_mov, cod_loj,cod_pdv, num_cup)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_mnc_cod_cest (
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd_itr BIGINT NOT NULL ,
  cod_cest INT NOT NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (sec, grp, sgr,prd_itr)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_wsv_int (
  cod_loj INT NOT NULL  ,
  tip INT NOT NULL  ,
  hab TINYINT NOT NULL  ,
  url_wsv VARCHAR(255) NOT NULL  ,
  usu VARCHAR(255) NOT NULL  ,
  sha VARCHAR(255) NOT NULL default ''  ,
  cpt INT NOT NULL default 0  ,
  tim INT NOT NULL DEFAULT 0 ,
  acc_tok VARCHAR(255) NOT NULL default '' ,
  pr_ip TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, tip)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mnc_cad_pis_cfs (
  dat_atz DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  cst INT NOT NULL ,
  tip_vlr_pis INT NOT NULL , 
  tip_vlr_cfs INT NOT NULL ,
  vlr_pis DOUBLE(16,4) ,
  vlr_cfs DOUBLE(16,4) ,
  bse_cal_zer tinyint(1) not null default 0, 
  cod_rec int not null default 0,
  PRIMARY KEY (cod_loj,sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_pln_prl (
	cod_loj INTEGER NOT NULL , 
	cod_prl INTEGER NOT NULL DEFAULT 0 , 
	seq INTEGER NOT NULL DEFAULT 0 ,
	qtd_par INTEGER NOT NULL DEFAULT 0 ,
	cef_jur DOUBLE NOT NULL DEFAULT 0 ,
	cal_jur_drm TINYINT(1) DEFAULT 0 ,
	PRIMARY KEY(cod_loj, cod_prl)
) ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cst_pis_cfs(
	cod_loj INT NOT NULL ,
	cod_cst INT NOT NULL ,
	tip_cst INT NOT NULL ,
	per_bse DOUBLE DEFAULT 0 ,
	per_aqt DOUBLE DEFAULT 0 ,
	PRIMARY KEY (cod_loj, cod_cst, tip_cst)
) ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ite_doc_etr(
	dat_mov DATE NOT NULL ,
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_pdv INT NOT NULL DEFAULT 0 ,
	num_cup INT NOT NULL DEFAULT 0 ,
	seq INT NOT NULL DEFAULT 0 ,
	cst_pis INT NOT NULL DEFAULT 0 ,
	bse_cal_pis DOUBLE(16,4) NOT NULL DEFAULT 0 ,
	aqt_pis DOUBLE(16,4) NOT NULL DEFAULT 0 ,
	vlr_pis DOUBLE(16,2) NOT NULL DEFAULT 0 ,
	cst_cofins INT NOT NULL DEFAULT 0 ,
 	bse_cal_cofins DOUBLE(16,4) NOT NULL DEFAULT 0 ,
	aqt_cofins DOUBLE(16,4) NOT NULL DEFAULT 0 ,
	vlr_cofins DOUBLE(16,2) NOT NULL DEFAULT 0 ,
	bse_cal DOUBLE(16,4) NOT NULL DEFAULT 0 ,
	aqt DOUBLE(16,2) NOT NULL DEFAULT 0 ,
	vlr_icm DOUBLE(16,2) NOT NULL DEFAULT 0 ,
	org INT(8) NOT NULL DEFAULT 0 ,
	nat_ope INT(8) NOT NULL DEFAULT 0 ,
	PRIMARY KEY(dat_mov, cod_loj,cod_pdv, num_cup, seq)
)ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_sct_msg_img (
	cod_loj INT NOT NULL ,
	txt VARCHAR(60) NOT NULL DEFAULT '' ,
	msg VARCHAR(60) NOT NULL DEFAULT '' ,
	html VARCHAR(60) NOT NULL DEFAULT '' ,
	tam INT NOT NULL ,
	PRIMARY KEY(cod_loj, txt)
)ENGINE=InnoDB
;

CREATE TABLE cfop_doc_etr (
  cfop integer not null,  
  PRIMARY KEY(cfop)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_pdv_doc_etr (
	cod_loj INTEGER NOT NULL ,
	num_pdv INTEGER NOT NULL ,
	cod_sol INTEGER NOT NULL ,
	PRIMARY KEY (cod_loj,num_pdv, cod_sol)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_cpv_prm_cup (
	id_cpv INTEGER NOT NULL ,
	des_cpv VARCHAR(50) NOT NULL ,
	PRIMARY KEY (id_cpv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_txt_cpv_prm_cup (
	id_cpv INTEGER NOT NULL ,
	seq INTEGER NOT NULL ,
	txt VARCHAR(50) NOT NULL ,
	clz INTEGER NOT NULL,
	PRIMARY KEY (id_cpv, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_fun_pdv (
  cod_loj INT NOT NULL  ,
  num_pdv INT NOT NULL  ,
  cod_rtc INT NOT NULL  ,
  cod_mod INT NOT NULL  ,
  cod_fun INT NOT NULL  ,
  PRIMARY KEY (cod_loj, num_pdv, cod_rtc, cod_mod, cod_fun)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_pso_emb (
  dat_atz DATE NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  pso_emb INT NULL ,
  PRIMARY KEY (sec, grp, sgr,prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_ipt_ncm (
	cod_ncm BIGINT NOT NULL ,
	des VARCHAR(150) NOT NULL ,
	nac_fed DOUBLE(16,2) NOT NULL ,
	fed_ipd DOUBLE(16,2) NOT NULL ,
	etd DOUBLE(16,2) NOT NULL ,
	mun DOUBLE(16,2) NOT NULL ,
	fon VARCHAR(50) NOT NULL ,
	PRIMARY KEY(cod_ncm)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_tar_prd (
  cod_tar VARCHAR(10) NOT NULL ,
  pso DOUBLE(16,3) NOT NULL ,
  PRIMARY KEY (cod_tar)
)ENGINE = InnoDB
;


CREATE TABLE mov_ite_vda_tec (
   dat_vda DATE NOT NULL,
   cod_loj INT NOT NULL,
   num_pdv INT NOT NULL,
   num_cup INT NOT NULL,
   seq INT NOT NULL,
   cod_prd BIGINT NOT NULL,
   des_prd varchar(40), 
   prc DOUBLE(16,2) NOT NULL,
   qtd DOUBLE(16,3) NOT NULL,
   usu INT NOT NULL,
   nom_usu VARCHAR(300),
   PRIMARY KEY(dat_vda, cod_loj, num_pdv, num_cup, seq)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_exi_inf (
   cod_loj INTEGER NOT NULL ,
   seq INTEGER NOT NULL ,
   loc_txt INTEGER NOT NULL ,
   msg VARCHAR(40) NOT NULL ,	
   sgd INTEGER NOT NULL ,
   PRIMARY KEY(cod_loj, seq)	
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cnv_int(
	cpf_cnj BIGINT NOT NULL ,
	nro_frm_pgt INTEGER NOT NULL DEFAULT 0 ,
	cod_cli INTEGER NOT NULL DEFAULT 0 ,
	nom_cli VARCHAR (50) NOT NULL DEFAULT '' ,
	edr_cli VARCHAR (50) NOT NULL DEFAULT '' ,
	brr_cli VARCHAR (20) NOT NULL DEFAULT '' ,
	cdd_cli VARCHAR (30) NOT NULL DEFAULT '' ,
	uf_cli VARCHAR (2) NOT NULL DEFAULT '' ,
	cep_cli VARCHAR (20) NOT NULL DEFAULT '' ,
	ins_etd_rg VARCHAR (25) NOT NULL DEFAULT '' ,	
	tel_cli VARCHAR (14) NOT NULL DEFAULT '' ,
	tip_cli INTEGER NOT NULL DEFAULT 0 ,
	sit_cli INTEGER NOT NULL DEFAULT 0 ,
	lim_cli DOUBLE  NOT NULL DEFAULT 0 ,
	acd_cli DOUBLE  NOT NULL DEFAULT 0 ,
	PRIMARY KEY (cpf_cnj,nro_frm_pgt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_vld_cam_stf (
  cod_loj INTEGER NOT NULL ,
  tip_cam INTEGER NOT NULL ,
  txt VARCHAR(60) NOT NULL ,
  qtd_dia INTEGER NOT NULL ,	
  nao_act_dat_psd TINYINT(1) DEFAULT 0 ,
  PRIMARY KEY (cod_loj, tip_cam)
) ENGINE=InnoDB
;

CREATE TABLE configuracao_nfe(
  numero_loja integer not null,
  versao varchar(15) not null,
  serie integer not null,
  tipo_doc integer not null,
  finalidade_emissao integer not null,
  formato_impressao integer not null,  
  origem_mercadoria integer not null,
  processo_emissao integer not null,
  homologacao tinyint(1) not null default 0,
  certificado_digital varchar(300) not null,
  senha varchar(10) not null,
  versao_aplicativo varchar(15) not null,
  dados_adicionais varchar(256) default '',
  reg_trb integer not null,
  cod_sfm integer,
  nao_cal_trb tinyint(1) default 0 ,
  nom_arq varchar(256) default '' ,
  cnj_cpf_ctl BIGINT DEFAULT 0 ,
  vrs_cnp_cfe DOUBLE (8,2) NOT NULL DEFAULT 1.00 ,
  PRIMARY KEY(numero_loja)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_ems_not_fsc (
  cod_loj INT NOT NULL DEFAULT 0 ,
  blq_mdc_man_num_not_fsc TINYINT NOT NULL DEFAULT 0 ,
  tip_pdr_ems_not INTEGER NOT NULL DEFAULT 1 ,
  mvr_atm_ise_cam_ins_etd TINYINT NOT NULL DEFAULT 0 ,
  cap_atm_cdd_etd_cep TINYINT NOT NULL DEFAULT 0 ,
  agp_ite_idc TINYINT NOT NULL DEFAULT 0 ,
  vld_cod_ncm TINYINT(1) NOT NULL DEFAULT 1 ,
  per_nf_smt_cnj TINYINT(1) NOT NULL DEFAULT 0 ,
  nao_per_ems_fra_uf TINYINT(1) NOT NULL DEFAULT 0 ,
  sol_per_ems_fra_uf TINYINT(1) NOT NULL DEFAULT 0 ,
  emt_cpv_rtd TINYINT(1) NOT NULL DEFAULT 0 ,
  cns_cad_cli TINYINT(1) NOT NULL DEFAULT 0 ,
  emt_not_erp TINYINT(1) NOT NULL DEFAULT 0,
  nao_trt_psv TINYINT(1) NOT NULL DEFAULT 0,
  qtd_max_ite INTEGER NOT NULL DEFAULT 0,
  dir_ger_xml VARCHAR(100) NOT NULL DEFAULT '',
  pmt_cnc TINYINT(1) NOT NULL DEFAULT 0,
  ipm_cpv_cnc TINYINT(1) NOT NULL DEFAULT 0,
  ipm_ite_cnc TINYINT(1) NOT NULL DEFAULT 0,
  tpo_proc_mtz INTEGER NOT NULL DEFAULT 0,
  val_ins_etd TINYINT(1) NOT NULL DEFAULT 0,
  sep_vlr_nfe_fch TINYINT(1) NOT NULL DEFAULT 0,
  reg_dad_cli_dav_atm TINYINT(1) NOT NULL DEFAULT 0,
  nao_pmt_doa_tco TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ent_dom_vas (
  dat_ems DATE NOT NULL ,
  cod_loj int(11) NOT NULL ,
  cod_pdv int(11) NOT NULL ,
  num_cup int(11) NOT NULL ,
  cod_prd BIGINT NOT NULL ,
  cod_cpv int(11) NOT NULL ,
  cod_ope int(11) NOT NULL ,
  dsc VARCHAR(100) ,
  qtd DOUBLE(16,2) NOT NULL ,
  prc DOUBLE(16,2) NOT NULL ,
  dat_bxa DATE NULL ,
  usu_bxa INT NULL DEFAULT 0 ,
  stt INT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (dat_ems, cod_loj, cod_pdv, num_cup, cod_prd)
) ENGINE=InnoDB 
;

CREATE TABLE IF NOT EXISTS cfg_msg_pdv (
  cod_loj INT NOT NULL ,
  msg_pdr INT NOT NULL ,
  msg_pdz varchar(50) not null ,
  msg_ati tinyint(1) not null default 0 ,
  PRIMARY KEY (cod_loj,msg_pdr)
)Engine = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_mqt_pos (
cod_mqt INT NOT NULL ,
des_mqt VARCHAR(50) NOT NULL ,
PRIMARY KEY (cod_mqt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prm_acm (
  cod_loj INT NOT NULL ,
  prz_max INT NOT NULL ,
  ctr_est TINYINT(1) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj)
)Engine = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_cor_fun_pdv (
  cod_loj INT NOT NULL ,
  cod_fun INT NOT NULL ,
  cor INT NOT NULL ,
  PRIMARY KEY (cod_loj, cod_fun))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_cpf_blq (
  cpf VARCHAR(50) NOT NULL,
  PRIMARY KEY (cpf)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cpo (
  cod_loj INT NOT NULL ,
  cod_cpo INT NOT NULL ,
  des VARCHAR(50) NOT NULL ,
  tip INT NOT NULL ,
  ipr VARCHAR(255) NULL ,
  qtd_via INT NOT NULL DEFAULT 1 ,
  mrg_spr INT NOT NULL ,
  mrg_esq INT NOT NULL ,
  ord INT NOT NULL ,
  dat_ult_atu TIMESTAMP ,
  ina TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, cod_cpo)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_res_dps (
  cod_prd BIGINT NOT NULL ,
  obr_pfr TINYINT NOT NULL DEFAULT 0 ,
  des VARCHAR(255) NOT NULL ,
  psv TINYINT NOT NULL DEFAULT 0 ,
  prc DOUBLE NULL ,
  dsc DOUBLE NULL ,
  cod_cpo INT NOT NULL ,
  ord INT NOT NULL ,
  frc TINYINT NOT NULL DEFAULT 0 ,
  dat_ult_atu TIMESTAMP ,
  ina TINYINT(1) NOT NULL DEFAULT 0 ,
  url_img VARCHAR(200) NULL,
  PRIMARY KEY (cod_prd, cod_cpo))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prr_prm (
  cod_prd BIGINT NOT NULL ,
  dat_ini DATE NOT NULL ,
  dat_fim DATE NOT NULL ,
  cod_oft INT NOT NULL , 
  cod_prr INT NOT NULL ,
  prc DOUBLE(16,2) NOT NULL ,
  PRIMARY KEY (cod_prd, dat_ini,dat_fim,cod_oft,cod_prr))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_cpv_vle_trc (
  dat DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  cod INT NOT NULL ,
  vlr DOUBLE NOT NULL ,
  sit INT NOT NULL ,
  PRIMARY KEY (dat, cod_loj, num_pdv, num_cup,cod))
ENGINE = InnoDB
;

CREATE TABLE mov_can_tef (
   dat_trn date not null ,
   cod_loj int not null ,
   cod_pdv int not null ,
   num_cup int not null ,
   seq int not null ,
   hor_trn time not null,
   num_doc varchar(30) not null,
   dat_doc date not null ,
   tip_can int not null ,
   vlr_can double(16,2) not null ,
   cod_ope int not null ,
   nom_ope varchar(40) not null ,
   cod_sup int not null ,
   nom_sup varchar(40) not null ,
   PRIMARY KEY(dat_trn, cod_loj, cod_pdv, num_cup, seq)
) ENGINE = innodb;

create table controle_versao_teste (
  id integer not null,
  versao VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
) ENGINE = INNODB;

CREATE TABLE cfg_tzn (
   cod_loj int not null ,
   cod_tzn_uf int not null ,
   dat_ini date not null ,
   dat_fim date not null ,
   PRIMARY KEY(cod_loj)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_loj_pdv_prm_gbl (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  cod_prm INT NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv, cod_prm))
ENGINE = InnoDB
;

CREATE INDEX idx_cad_loj_pdv_prm_gbl_prm ON cad_loj_pdv_prm_gbl (cod_prm, cod_loj);

CREATE TABLE IF NOT EXISTS grp_cli_prm_gbl (
  cod_grp INT NOT NULL ,
  cod_prm INT NOT NULL ,
  PRIMARY KEY (cod_grp, cod_prm))
ENGINE = InnoDB
;

CREATE INDEX idx_grp_cli_prm_gbl_prm ON grp_cli_prm_gbl (cod_prm);

CREATE TABLE IF NOT EXISTS cad_prm_gbl (
  cod_prm INT NOT NULL ,
  nom_prm VARCHAR(80) NOT NULL DEFAULT '' ,
  tip_prm INT NOT NULL ,
  dat_vig_ini DATE NOT NULL ,
  dat_vig_fim DATE NOT NULL ,
  stt INT NOT NULL ,
  tip_dsc INT NOT NULL ,
  vlr_dsc DOUBLE(16,2) NOT NULL ,
  vlr DOUBLE(16,2) NOT NULL ,
  tip_rat INT NOT NULL ,
  tip_rlm INT NOT NULL ,
  PRIMARY KEY (cod_prm))
ENGINE = InnoDB
;

CREATE INDEX idx_cad_prm_gbl_loj_vig ON cad_prm_gbl (cod_prm, dat_vig_ini);

CREATE TABLE IF NOT EXISTS fxa_dsc_prm_gbl (
  cod_prm INT NOT NULL ,
  seq INT NOT NULL ,
  vlr_qtd_ini DOUBLE(16,2) NOT NULL ,
  vlr_qtd_fim DOUBLE(16,2) NOT NULL ,
  vlr_dsc DOUBLE(16,2) NOT NULL ,
  PRIMARY KEY (cod_prm, seq))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_prm_gbl (
  cod_prm INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  dtm INT NOT NULL ,
  fbt BIGINT NOT NULL ,
  mrc BIGINT NOT NULL ,
  crt_fml tinyint(1) NOT NULL ,
  prd BIGINT NOT NULL ,
  qtd DOUBLE(16,2) NOT NULL ,
  vlr DOUBLE(16,2) NOT NULL ,
  prd_dsc tinyint(1) NOT NULL ,
  prd_exv tinyint(1) NOT NULL ,
  cod_niv_prc INT NOT NULL ,
  PRIMARY KEY (cod_prm, sec, grp, sgr, dtm, fbt, mrc, prd))
ENGINE = InnoDB
;

CREATE INDEX idx_prd_prm_gbl on prd_prm_gbl (cod_prm,fbt,mrc,prd,crt_fml,sec,grp,sgr,dtm);

CREATE TABLE IF NOT EXISTS cad_fbt (
  cod_fbt BIGINT NOT NULL ,
  des VARCHAR(255) NOT NULL ,
  PRIMARY KEY (cod_fbt))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fbt_prd (
  cod_fbt BIGINT NOT NULL ,
  prd BIGINT NOT NULL ,
  PRIMARY KEY (cod_fbt, prd))
ENGINE = InnoDB
;

create index idx_fbt_prd on fbt_prd (prd);

CREATE TABLE IF NOT EXISTS cad_mrc (
  cod_mrc BIGINT NOT NULL ,
  des VARCHAR(255) NOT NULL ,
  PRIMARY KEY (cod_mrc))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mrc_prd (
  cod_mrc BIGINT NOT NULL ,
  prd BIGINT NOT NULL ,
  PRIMARY KEY (cod_mrc, prd))
ENGINE = InnoDB
;

create index idx_mrc_prd on mrc_prd (prd);

CREATE TABLE IF NOT EXISTS cad_dtm (
  cod_dtm INT NOT NULL ,
  des VARCHAR(255) NOT NULL ,
  PRIMARY KEY (cod_dtm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS dtm_prd (
  cod_dtm INT NOT NULL ,
  sec BIGINT NOT NULL ,
  PRIMARY KEY (cod_dtm, sec))
ENGINE = InnoDB
;

create index idx_dtm_prd on dtm_prd (sec);

CREATE TABLE IF NOT EXISTS ctr_prm_cup (
  dat DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT not null ,
  num_cup INT not null ,
  seq INT not null ,
  tip_prm INT not null default 0 ,
  cod_prm INT not null default 0 ,
  vlr_dsc DOUBLE(16,2) not null default 0 ,
  qtd_apl DOUBLE(16,3) not null default 0 ,
  PRIMARY KEY(dat, cod_loj, num_pdv, num_cup, seq, tip_prm, cod_prm)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_itc (
  cod_loj INT NOT NULL,
  cod_itc INT NOT NULL,
  nom_itc varchar(100) NOT NULL,
  cnj_itc bigint NULL,
  PRIMARY KEY(cod_loj, cod_itc)
) ENGINE = innodb
;

CREATE TABLE mov_enc_prd (
  cod_loj INTEGER NOT NULL,
  num_enc BIGINT NOT NULL,
  cod_loj_frn INTEGER,
  cod_prd BIGINT,
  qtd DOUBLE(16,3),
  prc DOUBLE(16,2),
  prc_fab DOUBLE(16,2),
  PRIMARY KEY (cod_loj, num_enc, cod_prd)
) ENGINE = InnoDB;

CREATE TABLE prd_enc (
  cod_loj INTEGER NOT NULL DEFAULT 0 ,
  num_enc BIGINT NOT NULL ,
  cod_prd BIGINT NOT NULL ,
  qtd DOUBLE(16,3) NOT NULL DEFAULT 0 ,
  prc DOUBLE(16,2) NOT NULL DEFAULT 0 ,
  prc_fab DOUBLE(16,2) NOT NULL DEFAULT 0 ,
  cod_ven INT NOT NULL DEFAULT 0 ,
  sit INT NOT NULL DEFAULT 0 ,
  qtd_prd_can DOUBLE(16,2) NOT NULL DEFAULT 0 ,
  qtd_prd_can_aux DOUBLE(16,2) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, num_enc, cod_prd)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS tlz_nao_fsc_pdv (
  cod_loj int not null ,
  cod_pdv int not null ,
  cod_tlz int not null ,
  tlz_nao_fsc varchar(30) not null ,
  tlz_grl varchar(30) not null ,
  cod_idc varchar(30) not null ,
  idc_pst tinyint(1) not null ,
  PRIMARY KEY(cod_loj,cod_pdv,cod_tlz)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_pmo_fid (
  cod_prm INTEGER not null ,
  seq INTEGER not null ,
  pnt DOUBLE(16,2) not null ,
  PRIMARY KEY(cod_prm,seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS prm_brd_por_vlr (
  cod_loj int not null ,
  vlr_cmp double not null ,
  dat_ini DATE not null ,
  dat_fim DATE not null ,
  cod_prd bigint(20) ,
  dsc_prd varchar(30) ,
  nao_cmr tinyint(1) not null ,
  grp_fid int not null ,
  rat_etr_ite tinyint(1) not null ,
  imp_cpv tinyint(1) not null ,
  exi_msg tinyint(1) not null ,
  acd tinyint(1) not null ,
  PRIMARY KEY(cod_loj,vlr_cmp,dat_ini,dat_fim)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_prm_brd_vlr (
 cod_loj int ,  
 num_cup int ,
 num_pdv int ,
 dat DATE ,
 vlr_cmp double not null ,
 ini_vde DATE not null ,
 fim_vde DATE not null ,
 cod_brd bigint(20) not null ,
 nom_brd varchar(30) ,
 vlr_vda double not null ,
 cod_ope int not null ,
 PRIMARY KEY(cod_loj,num_cup,num_pdv,dat,vlr_cmp)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_mov_prm_brd_vlr (
  num_cup int ,
  vlr_cmp double not null ,
  ini_vde DATE not null ,
  fim_vde DATE not null ,
  cod_brd bigint(20) not null ,
  nom_brd varchar(30) ,
  vlr_vda double not null ,
  cod_ope int not null ,
  PRIMARY KEY(num_cup,vlr_cmp)
) ENGINE = innodb
;

CREATE TABLE cfg_cns_cli (
  cod_loj integer not null,
  tip_cns integer not null default 1,
  seq integer not null,
  PRIMARY KEY(cod_loj, tip_cns)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_trc_ope (
  dat_mov DATE NOT NULL ,
  num_loj INT NOT NULL ,
  num_pdv INT not null ,
  seq_ope INT not null ,
  seq_ope_ant INT not null ,
  PRIMARY KEY(dat_mov, num_loj, num_pdv, seq_ope)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS lot_vch (
  cod_lot BIGINT NOT NULL,
  id_lot VARCHAR(50) NOT NULL,
  dat_ini_vig DATE NULL,
  dat_fim_vig DATE NULL,
  qtd_ger_cli INT NULL,
  tip_ger INT NULL,
  cod_prm_ger INT NULL,
  stt INT NULL,
  sol_pms_off TINYINT NOT NULL,
  qtd_pmt_utl_cli INT NOT NULL,
  qtd_pmt_utl_vch INT NOT NULL,
  cod_prm_utl INT NOT NULL,
  can_vch_trc TINYINT NOT NULL DEFAULT 0,
  nao_ipr_vch TINYINT NOT NULL DEFAULT 0,
  exg_aps_vch TINYINT NOT NULL DEFAULT 0,
  cod_cpv_vch INT NOT NULL DEFAULT 0,
  vlr_min_vda_ger DOUBLE(16,2) NULL,
  vlr_min_vda_utl DOUBLE(16,2) NULL,
  qtd_max_prd INT NOT NULL DEFAULT 0,
  PRIMARY KEY(cod_lot),
  UNIQUE INDEX id_lot_UNIQUE (id_lot ASC))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_gbl_vch (
  cod_loj INT NOT NULL,
  qtd_pmt_utl_dia INT NOT NULL DEFAULT 0,
  qtd_pmt_utl_cmp INT NOT NULL DEFAULT 0,
  blq_utl_vch_trc TINYINT NOT NULL DEFAULT 0,
  blq_ger_vch_trc TINYINT NOT NULL DEFAULT 0,
  dsb_vch TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_vch (
  cod_vch BIGINT NOT NULL,
  cod_lot BIGINT NOT NULL,
  dat_ger DATE NOT NULL,
  stt INT NOT NULL,
  qtd_utl INT NOT NULL,
  cpf BIGINT NULL,
  id_vch VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_vch))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_vch (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  num_cup INT NOT NULL,
  cod_vch BIGINT NOT NULL,
  seq INT NOT NULL,
  tip_mov INT NOT NULL,
  vlr_vch DOUBLE NOT NULL,
  vlr_utl DOUBLE NOT NULL,
  cpf VARCHAR(16) NOT NULL,
  cod_lot BIGINT NOT NULL,
  dat_ini_vig DATE NOT NULL,
  dat_fim_vig DATE NOT NULL,
  usr_pms_ger_off INT NOT NULL,
  cod_prm INT NOT NULL,
  des_utl LONGTEXT NOT NULL,
  id_vch VARCHAR(50) NOT NULL,
  id_lot VARCHAR(50) NOT NULL,
  qtd_pmt_utl_dia INT NOT NULL, 
  qtd_pmt_utl_cmp INT NOT NULL,
  can_vch_trc TINYINT NOT NULL DEFAULT 0,
  nao_ipr_vch TINYINT NOT NULL DEFAULT 0,
  exg_aps_vch TINYINT NOT NULL DEFAULT 0,
  qtd_pmt_utl_cli INT NOT NULL DEFAULT 0,
  qtd_pmt_utl_vch INT NOT NULL DEFAULT 0,
  tip_ger_vch INT NOT NULL DEFAULT 0,
  tip_dsc INT NOT NULL DEFAULT 0,
  vlr_min_vda_ger DOUBLE(16,2) NULL,
  vlr_min_vda_utl DOUBLE(16,2) NULL,
  qtd_max_prd INT NOT NULL DEFAULT 0,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, cod_vch, seq))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prm_gbl (
  cod_loj INT NOT NULL ,
  msg_gno VARCHAR(255) NOT NULL DEFAULT '' ,
  msg_pda VARCHAR(255) NOT NULL DEFAULT '' ,
  cod_grp_cal_pda INT NOT NULL ,
  csd_qtd_emb_ean TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS dad_cns_sat_opr (
    num_sre_hdw BIGINT NOT NULL,
	sat_pri INTEGER,
	num_loj INTEGER,
	num_pdv INTEGER,
	mrc_sat VARCHAR(40),
	suc_cns_sat TINYINT,
	suc_cns_opr_sat TINYINT,
	cod_err_cns_sat INTEGER,
	msg_err_cns_sat VARCHAR(255),
	cod_sfz_cns_sat INTEGER,
	msg_sfz_cns_sat VARCHAR(255),
	cod_stt_opr_sat INTEGER,
	hor_blq_atm BIGINT,
	mnt_blq_atm BIGINT,
	dat_hor_atu TIMESTAMP,
	dat_hor_cmc_sfz TIMESTAMP,
	dia_ina_sfz BIGINT,
	hor_ina_sfz BIGINT,
	mnt_ina_sfz BIGINT,
	stt_red_sat VARCHAR(255),
	qtd_cfe_pen_tms BIGINT,
	fax_ini_cfe_pen_tms INTEGER,
	fax_fim_cfe_pen_tms INTEGER,
	dat_hor_ult_cfe_tms TIMESTAMP,
	dia_tms_sfz BIGINT,
	hor_tms_sfz BIGINT,
	mnt_tms_sfz BIGINT,
	dat_ems_ctd DATE,
	dat_vnc_ctd DATE,
	prz_epr_ctd BIGINT,
	tip_lan VARCHAR(255),
	lan_ip  VARCHAR(255),
	lan_mac VARCHAR(255),
	lan_msc VARCHAR(255),
	lan_gtw  VARCHAR(255),
	lan_dns1 VARCHAR(255),
	lan_dns2 VARCHAR(255),
	niv_bat  VARCHAR(255),
	mem_tot  VARCHAR(255),	
	mem_usd  VARCHAR(255),
	vrs_sft_bse VARCHAR(255),
	vrs_lay VARCHAR(255),	
	ult_cfe VARCHAR(255),
	stt_eno INTEGER,
	PRIMARY KEY(num_sre_hdw)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_ccl_sat (
 dat_mov DATE ,
 num_sre_sat BIGINT ,
 dat_hor_ult_cns TIMESTAMP ,
 PRIMARY KEY(dat_mov)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_ccl_sat (
  dat_mov DATE NOT NULL ,
  num_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_sre_hdw BIGINT NOT NULL ,
  num_cfe INT NOT NULL ,
  seq INT NOT NULL ,
  ope INT NOT NULL ,
  sit INTEGER NOT NULL , 
  dat_proc_sfz DATE ,
  PRIMARY KEY (dat_mov, num_loj, num_pdv, num_sre_hdw, num_cfe, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS perfil (
  id int(10) not null auto_increment,
  nome varchar(45) not null default '',
  descricao varchar(100) not null default '',
  nivel int not null default 0,
  att_sct TINYINT NOT NULL default 0 ,
  tip_dsc INT NOT NULL default 0 ,
  vlr_dsc DOUBLE NOT NULL default 0 ,
  PRIMARY KEY(id)
) ENGINE = innodb;

CREATE TABLE perfil_permissao (
  id_perfil integer not null,
  id_permissao integer not null,
  PRIMARY KEY (id_perfil, id_permissao)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cad_pfr_res (
  cod_loj INT NOT NULL ,
  cod_pfr INT NOT NULL ,
  des VARCHAR(255) NOT NULL ,
  prc_adi DOUBLE NOT NULL DEFAULT 0 ,
  prc_sub DOUBLE NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj, cod_pfr)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS lim_pfr_prd_res (
  cod_loj INT(11) NOT NULL,
  cod_cpo INT(11) NOT NULL,
  cod_prd BIGINT NOT NULL,
  qtd_max_pfr INT(11) NULL,
  PRIMARY KEY (cod_loj, cod_cpo, cod_prd))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS pfr_prd_res (
  cod_loj INT(11) NOT NULL,
  cod_cpo INT(11) NOT NULL,
  cod_prd BIGINT NOT NULL,
  cod_pfr INT(11) NOT NULL,
  pfr_pdr TINYINT(1) NULL,
  ord INT(11) NULL,
  PRIMARY KEY (cod_loj, cod_cpo, cod_prd, cod_pfr))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prd_blq_sct(
  cod_loj integer not null,
  sec INT NOT NULL,
  grp INT NOT NULL,
  sgr INT NOT NULL,
  prd INT NOT NULL,
  PRIMARY KEY (cod_loj, sec, grp, sgr, prd)
) ENGINE = INNODB
;

CREATE TABLE IF NOT EXISTS cfg_int_mlz (
   cod_loj  INT NOT NULL,
   tok_idt VARCHAR(50) NOT NULL,
   msg_idt VARCHAR(100) NOT NULL,
   tip_exp INT NOT NULL,
   url_int VARCHAR(50),
   hab_int TINYINT NOT NULL DEFAULT 0,
   afd VARCHAR(50) NOT NULL,
   for_tec TINYINT(1) NOT NULL DEFAULT 0, 
   itv_pri_cns_fch INT NOT NULL,
   itv_cns_fch INT NOT NULL,
   env_fch INT NOT NULL,
   partner_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE ctr_int_vda (
  dat_mov DATE not null ,
  cod_loj int not null ,
  cod_pdv int not null ,
  num_cup int not null ,
  tip_int int not null ,
  stt_int int not null,
  dat_env TIMESTAMP null,
  cod_ret int not null ,
  qtd_ten_env int not null,
  jso_ret LONGTEXT NULL ,
  url_env LONGTEXT NULL ,
  jso_env LONGTEXT NULL ,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,num_cup,tip_int)
) ENGINE = innodb
;

CREATE TABLE ctr_int_fch (
  dat_mov DATE not null ,
  cod_loj int not null ,
  cod_pdv int not null ,
  tip_fch int not null ,
  tip_int int not null ,
  stt_int int not null,
  dat_env TIMESTAMP null ,
  cod_ret int not null ,
  qtd_ten_env int not null,
  jso_ret LONGTEXT NULL ,
  url_env LONGTEXT NULL ,
  jso_env LONGTEXT NULL ,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,tip_fch,tip_int)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_fin_bat_cxa (
	cod_loj INT NOT NULL DEFAULT 0 ,
	fin INT NOT NULL DEFAULT 0 ,
	seq INT NOT NULL DEFAULT 0 ,
	bat_qtd TINYINT(1) NOT NULL DEFAULT 0,
	reg_atm_vlt_bat_cxa TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY(cod_loj, fin, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_pbm_wsv (
  dat DATE NOT NULL ,
  num_loj INT NOT NULL,
  num_pdv INT NOT NULL ,
  cup INT NOT NULL ,
  seq INT NOT NULL ,
  tpo_pbm INT NOT NULL ,
  num_aut BIGINT NOT NULL ,
  num_ean BIGINT NOT NULL ,
  qtd INT NOT NULL,
  stt INT NOT NULL ,
  eno INT NOT NULL ,
  PRIMARY KEY(dat,num_loj,num_pdv,cup,seq)
) ENGINE = innodb;


CREATE TABLE IF NOT EXISTS dad_adc_ope (
  dat_mov DATE NOT NULL  ,
  cod_loj INT NOT NULL  ,
  cod_pdv INT NOT NULL  ,
  num_cup INT NOT NULL  ,
  chv VARCHAR(45) NOT NULL  ,
  vlr VARCHAR(2048) NULL  ,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, chv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_vde_prd_psv (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL,
  cod_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  seq INT NOT NULL,
  cod_prd BIGINT NOT NULL ,
  cod_ope INT NOT NULL,
  des VARCHAR(255) NOT NULL,
  vlr DOUBLE(16,2) NOT NULL,
  qtd DOUBLE(16,3) NOT NULL,
  dat_vde DATE NOT NULL ,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,num_cup,seq,cod_prd)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cad_fxa_pnt_fid (
   num_fxa  INT NOT NULL,
   fxa_ini  INT NOT NULL,
   fxa_fim  INT  NOT NULL,
   dsc DOUBLE NOT NULL,
   per TINYINT(1) NOT NULL ,
   PRIMARY KEY(num_fxa,fxa_ini, fxa_fim)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cad_msg_rod_fid (
   tip  INT NOT NULL,
   msg  VARCHAR(250) NOT NULL,
   PRIMARY KEY(tip)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS mov_dsc_pnt_fid (
   dat_mov DATE NOT NULL,
   cod_loj INTEGER NOT NULL,
   num_pdv INTEGER NOT NULL,
   num_cup INTEGER NOT NULL,
   fxa_pnt INTEGER NOT NULL,
   qtd_pnt_utl DOUBLE NOT NULL,
   cli BIGINT NOT NULL,
   ope INTEGER NOT NULL,
   vlr_cup DOUBLE NOT NULL,
   tot_dsc DOUBLE NOT NULL,
   per TINYINT(1) NOT NULL,
   PRIMARY KEY(dat_mov,cod_loj,num_pdv,num_cup)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_bbl(
  cod_emp VARCHAR(255) not null,
  tok VARCHAR(255) not null,
  cod_seg VARCHAR(255) not null,
  url VARCHAR(255) not null,
  PRIMARY KEY (cod_emp)
) ENGINE = INNODB
;

CREATE TABLE IF NOT EXISTS cfg_bbl_loj(
  cod_loj INT not null,
  hab_bbl TINYINT(1) default 0,
  env_tds_vda TINYINT(1) default 0,
  env_fch TINYINT(1) default 0,
  PRIMARY KEY (cod_loj)
) ENGINE = INNODB
;

CREATE TABLE mov_trn_cbk (
  dat_mov DATE not null ,
  cod_loj int not null ,
  cod_pdv int not null ,
  num_cup int not null ,
  seq int not null,
  dat_env DATETIME default null,
  qtd_ten_env int not null,
  tip_int int not null,
  tip_trn int not null,
  chv_idt VARCHAR(220) not null,
  stt_trn int not null,
  cod_fin int not null,
  vlr_rgt double (16,2),
  vlr_ttl double (16,2),
  cpf BIGINT not null,
  cod_ret int not null ,
  jso_ret LONGTEXT NULL ,
  url_env LONGTEXT NULL ,
  jso_env LONGTEXT NULL ,
  seq_fin int not null,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,num_cup,seq)
)ENGINE = innodb
;

CREATE TABLE mov_idt_cbk (
  dat_mov DATE not null ,
  cod_loj int not null ,
  cod_pdv int not null ,
  num_cup int not null ,
  seq int not null,
  tip_int int not null,
  chv_idt VARCHAR(220) not null,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,num_cup,seq)
)ENGINE = innodb
;

CREATE TABLE ctr_lib_bbl (
  dat_lib DATE not null ,
  cod_loj int not null ,
  cod_lib VARCHAR(200) not null ,
  PRIMARY KEY(dat_lib,cod_loj, cod_lib)
)ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_crm_izi (
  cod_loj INT NOT NULL,
  niv_prc INT NOT NULL,
  tok VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  hab tinyint(1) not null default 0,
  env_tds_cup tinyint(1) not null default 0,
  cod_emp BIGINT NOT NULL,
  utl_ana_dad TINYINT(1) NOT NULL DEFAULT 0,
  cns_dsc TINYINT(1) NOT NULL DEFAULT 0,
  url_dsc VARCHAR(255) NOT NULL,
  tok_dsc VARCHAR(255) NOT NULL,
  cod_emp_dsc BIGINT NOT NULL,
  PRIMARY KEY(cod_loj)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_msg_crm_izi (
  cod_loj INT NOT NULL,
  tip INT NOT NULL,
  msg VARCHAR(120) NOT NULL,
  PRIMARY KEY(cod_loj, tip)
) ENGINE = innodb;


CREATE TABLE IF NOT EXISTS grp_prd (
cod_grp INT NOT NULL,
cod_prd BIGINT NOT NULL,
PRIMARY KEY (cod_grp,cod_prd))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS grp_prd_prm_vch (
cod_grp INT NOT NULL,
cod_prm INT NOT NULL,
PRIMARY KEY (cod_grp,cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fin_prm_vch (
cod_fin INT NOT NULL,
cod_prm INT NOT NULL,
PRIMARY KEY (cod_fin,cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_loj_pdv_prm_vch (
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  cod_prm INT NOT NULL,
  PRIMARY KEY (cod_loj, num_pdv, cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS grp_cli_prm_vch (
  cod_grp INT NOT NULL,
  cod_prm INT NOT NULL,
  PRIMARY KEY (cod_grp, cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_prm_vch (
  cod_prm INT NOT NULL,
  nom_prm LONGTEXT NOT NULL,
  tip_prm INT NOT NULL,
  dat_vig_ini DATE NOT NULL,
  dat_vig_fim DATE NOT NULL,
  stt INT NOT NULL,
  tip_dsc INT NOT NULL,
  vlr_dsc DOUBLE(16,2) NOT NULL,
  vlr DOUBLE(16,2) NOT NULL,
  tip_rat INT NOT NULL,
  tip_rlm INT NOT NULL,
  mod_prm INT NOT NULL,
  PRIMARY KEY (cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fxa_dsc_prm_vch (
  cod_prm INT NOT NULL,
  seq INT NOT NULL,
  vlr_qtd_ini DOUBLE(16,2) NOT NULL,
  vlr_qtd_fim DOUBLE(16,2) NOT NULL,
  vlr_dsc DOUBLE(16,2) NOT NULL,
  PRIMARY KEY (cod_prm, seq))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_prm_vch (
  cod_prm INT NOT NULL,
  sec INT NOT NULL,
  grp INT NOT NULL,
  sgr INT NOT NULL,
  dtm INT NOT NULL,
  fbt BIGINT NOT NULL,
  mrc BIGINT NOT NULL,
  crt_fml tinyint(1) NOT NULL,
  prd BIGINT NOT NULL,
  qtd DOUBLE(16,2) NOT NULL,
  vlr DOUBLE(16,2) NOT NULL,
  prd_dsc tinyint(1) NOT NULL,
  prd_exv tinyint(1) NOT NULL,
  PRIMARY KEY (cod_prm, sec, grp, sgr, dtm, fbt, mrc, prd))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prm_vch (
  cod_loj INT NOT NULL,
  msg_gno VARCHAR(255) NOT NULL DEFAULT '',
  msg_pda VARCHAR(255) NOT NULL DEFAULT '',
  cod_grp_cal_pda INT NOT NULL,
  PRIMARY KEY (cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_prm_vch_cup (
  dat DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT not null,
  num_cup INT not null,
  seq INT not null,
  tip_prm INT not null default 0,
  cod_prm INT not null default 0,
  vlr_dsc DOUBLE(16,2) not null default 0,
  PRIMARY KEY(dat, cod_loj, num_pdv, num_cup, seq, tip_prm, cod_prm)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_vch_utl (
  dat DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  num_cup INT NOT NULL,
  vch varchar(50) NOT NULL,
  PRIMARY KEY(dat, cod_loj, num_pdv, num_cup, vch)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_vch_cfr (
  dat DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  num_cup INT NOT NULL,
  cod_vch BIGINT NOT NULL,
  cod_lot BIGINT NOT NULL,
  cod_prm INT NOT NULL,
  cpf bigint NOT NULL,
  vlr_utl DOUBLE NOT NULL,
  vlr_vch DOUBLE NOT NULL,
  id_vch VARCHAR(50) NOT NULL,
PRIMARY KEY(dat, cod_loj, num_pdv, num_cup, cod_vch)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS fin_dsc_vch (
  cod_loj INT NOT NULL,
  cod_fin INT NOT NULL,
  ord INT NOT NULL,
PRIMARY KEY(cod_loj, cod_fin)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_vch_prm (
  cod_prm INT NOT NULL,
  qtd_vch INT NOT NULL,
  vlr_vch DOUBLE NOT NULL,
  PRIMARY KEY(cod_prm)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_vch_utl (
  cod_vch BIGINT NOT NULL,
  cod_lot BIGINT NOT NULL,
  qtd_utl INT NOT NULL,
  stt INT NOT NULL,
  dat_atz DATETIME NOT NULL,
  PRIMARY KEY (cod_vch))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ope_vch (
  dat_alt DATE NOT NULL,
  cod_loj INT NOT NULL,
  seq INT NOT NULL,
  hor_alt TIME NOT NULL,
  cod_ope INT NOT NULL,
  cod_lot BIGINT NOT NULL,
  cod_vch BIGINT NOT NULL,
  stt_ant INT NOT NULL,
  stt_alt INT NOT NULL,
  cod_usu INT NOT NULL,
  nom_usu VARCHAR(40) NOT NULL,
  cod_usu_aut INT NOT NULL,
  nom_usu_aut VARCHAR(40) NOT NULL,
  PRIMARY KEY (dat_alt, cod_loj, seq))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_can_sfz (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  num_cup INT NOT NULL,
  cod_prd INT NOT NULL,
  seq INT NOT NULL,
  cod_sfz INT NOT NULL,
  des VARCHAR(50) NOT NULL,
  vlr DOUBLE NOT NULL,
  mtv_rjc VARCHAR(150) NOT NULL,
PRIMARY KEY(dat_mov, cod_loj, num_pdv, num_cup, cod_prd, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_trn_mqt_pos (
  tip_trn INT NOT NULL,
  cod_ban INT NOT NULL,
  cod_mqt INT NOT NULL,
PRIMARY KEY (tip_trn, cod_ban, cod_mqt)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_vle_lnc (
   cod_loj  INT NOT NULL,
   hab_int TINYINT NOT NULL DEFAULT 0,
   eml VARCHAR(50) NOT NULL,
   tok_idt VARCHAR(50) NOT NULL,
   url_int VARCHAR(100),
   msg_idt VARCHAR(100) NOT NULL,
   tip_cap INT not null,
   itv_tpo_imp INT NOT NULL,
   tip_api INT NOT NULL DEFAULT 0,
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_adr (
  cod_loj INT NOT NULL,
  nom_rpl VARCHAR(100) NOT NULL,
  eml_rpl VARCHAR(100) NOT NULL,
  url VARCHAR(250) NOT NULL,
  chv_int VARCHAR(100) NOT NULL,
PRIMARY KEY(cod_loj)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_doa_adr (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  num_cup INT NOT NULL,
  tip_fin VARCHAR(50) NOT NULL,
  qtd_par INT NOT NULL,
  sit_eno INT NOT NULL,
  vlr_cup DOUBLE NOT NULL,
  vlr_pag DOUBLE NOT NULL,
  vlr_tco DOUBLE NOT NULL,
  vlr_doa DOUBLE NOT NULL,
PRIMARY KEY(dat_mov, cod_loj, num_pdv, num_cup)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_doa_adr (
  seq INT NOT  NULL,	
  tip_fin VARCHAR(50) NOT NULL,
  qtd_par INT NOT NULL,
  vlr_cup DOUBLE NOT NULL,
  vlr_pag DOUBLE NOT NULL,
  vlr_tco DOUBLE NOT NULL,
  vlr_doa DOUBLE NOT NULL,
PRIMARY KEY(seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS fxa_msg_prm_vch (
  cod_fxa INT NOT NULL,
  vlr_ini DOUBLE NOT NULL,
  vlr_fim DOUBLE NOT NULL,
  msg LONGTEXT NOT NULL,
  del_msg VARCHAR(1) NOT NULL,
  PRIMARY KEY (cod_fxa)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_msg_prm_vch (
  cod_prm INT NOT NULL,
  cod_fxa INT NOT NULL,
  PRIMARY KEY (cod_prm)
  )ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_ite_vch (
	dat_vda DATE NOT NULL,
	cod_loj INT NOT NULL,
	num_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	seq INT NOT NULL,
	cod_prm INT NOT NULL,
	tip_dsc INT NOT NULL,
PRIMARY KEY(dat_vda, cod_loj, num_pdv, num_cup, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_cpv_vch (
  cod_cpv INT NOT NULL,
  seq INT NOT NULL,
  txt VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_cpv, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_vle_trc_oln (
 cod_loj integer not null,
 cod integer not null,
 fin integer not null,
 ip varchar(100) not null,
 cmh varchar(100) not null,
 prt integer not null,
 usu varchar(100) not null,
 sha varchar(100) not null,
 cpt integer not null,
 PRIMARY KEY(cod_loj, cod, fin)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_vle_trc_oln (
	dat_mov DATE not null ,
	cod_loj integer not null,
	cod_pdv integer not null,
	num_cup integer not null,
	tip_trc integer not null,
	cod_trc integer not null,
	seq integer not null,
	cod_fin integer not null,
	stt integer not null,
	tot_trc double not null,
	cli integer not null,
	ope integer not null,
	ret_int varchar(200) not null,
	hor_mov datetime not null,
	PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup, tip_trc, cod_trc, seq)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_trn_aut (
	dat_mov DATE not null ,
	cod_loj integer not null,
	cod_pdv integer not null,
	num_cup integer not null,
	seq integer not null,
	ope integer not null,
	cod_fin integer,
	tip_ser integer ,
	cod_ser integer ,
	cod_cnv varchar(45) ,
	cod_cvd varchar(45) ,
	cod_cli varchar(45) ,
	cod_crt varchar(45) ,
	vlr_trn double ,
	ret integer ,
	rtc integer ,
	aut integer ,
	sit integer ,
	PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup, seq, ope)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_lsn_rms (
  cod_loj INT NOT NULL,
  cod_fin INT NOT NULL,
  cod_cns INT NOT NULL,
PRIMARY KEY(cod_loj, cod_fin,cod_cns)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cte_cam_obr_pdv (
  cod_loj integer not null,
  id_cam integer not null,
  ord_cam integer not null,
  obr tinyint(1) not null default 0 ,
  PRIMARY KEY(cod_loj, id_cam)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cte_vda_sps (
 dat_mov date not null ,
 cod_loj integer not null,
 cod_pdv integer not null,
 num_cup integer not null,
 vlr_cmp double(16,2) not null,
 cod_mtv integer not null,
 utl tinyint(1) not null default 0,
 cod_usu_aut integer not null,
 PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_zcd (
   cod_loj INT NOT NULL  ,
   utl_zcd tinyint(1) not null default 0 ,
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE ctr_dsc_prd_zcd (
  dat_mov DATE not null ,
  cod_loj int not null ,
  cod_pdv int not null ,
  num_cup int not null ,
  seq int not null,
  stt INT NOT NULL,
  cod_fun INT NOT NULL,
  cod_trn INT NOT NULL,
  cod_prm INT NOT NULL,
  des_prm VARCHAR(255) NOT NULL,
  stt_prm INT NOT NULL,
  tip_cod_prd INT NOT NULL,
  ean BIGINT NOT NULL,
  cod_prd INT NOT NULL,
  vlr_unt DOUBLE NOT NULL,
  per tinyint(1) not null default 0 ,
  dsc_uni DOUBLE NOT NULL,
  qtd_vda DOUBLE NOT NULL,
  qtd_auz DOUBLE NOT NULL,
  stt_prd INT NOT NULL,
  PRIMARY KEY(dat_mov,cod_loj,cod_pdv,num_cup,seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_dvg_pso (
	dat_mov DATE NOT NULL ,
	cod_loj INT NOT NULL ,
	cod_pdv INT NOT NULL ,
	num_cup INT not null ,
	seq     INT not null ,
	cod_ope INT NOT NULL ,
	usu_auz INT NOT NULL ,
	cod_prd BIGINT NOT NULL ,
	dsc_prd VARCHAR(50) NOT NULL,
	pso double(8,3) NOT NULL ,
	dvg_pso double(8,3) NOT NULL ,
	vlr double(8,3) NOT NULL ,
	vlr_dvg double(8,3) NOT NULL ,
	PRIMARY KEY(dat_mov, cod_loj, cod_pdv,num_cup,seq)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_vda_pto (
  tip_vda INT NOT NULL,
  cod_fxa INT NOT NULL,
PRIMARY KEY(tip_vda, cod_fxa)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_ope_dia (
  dat_ope DATE NOT NULL,
  ope INT NOT NULL,
  dat_hor_ini DATETIME NOT NULL,
  dat_hor_fim DATETIME NOT NULL,
  PRIMARY KEY (dat_ope, ope)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_fid_cli_nao_cad (
	dat_mov DATE NOT NULL,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	seq INT NOT NULL,
	cpf_cnj BIGINT NOT NULL,
	dat_hor_cns DATETIME NOT NULL,
	PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_brd_prm_cup (
  cod_brd INT NOT NULL,
  des VARCHAR(50) NOT NULL,
PRIMARY KEY(cod_brd)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS lay_num_prm_cup (
  cod_lay INT NOT NULL,
  des VARCHAR(50) NOT NULL,
PRIMARY KEY(cod_lay)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cam_num_prm_cup (
  cod_lay INT NOT NULL,
  cod_cam INT NOT NULL,
  seq INT NOT NULL,
  tam_cam INT NOT NULL,
PRIMARY KEY(cod_lay, cod_cam, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS grp_cli_prm_cup (
  cod_prm INT NOT NULL,
  cod_grp INT NOT NULL,
  PRIMARY KEY (cod_grp, cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS prd_prm_cup_adc (
  cod_prm INT NOT NULL,
  sec INT NOT NULL,
  grp INT NOT NULL,
  sgr INT NOT NULL,
  dtm INT NOT NULL,
  fbt BIGINT NOT NULL,
  mrc BIGINT NOT NULL,
  prd BIGINT NOT NULL,
  ctr_fam tinyint(1) not null default 0,
  PRIMARY KEY (cod_prm, sec, grp, sgr, dtm, fbt, mrc, prd))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cdt_prd_prm_cup_adc (
  cod_prm INT NOT NULL,
  vlr double (16,2) NOT NULL,
  qtd_cup INT NOT NULL,
  qtd_prd INT NOT NULL,
  ign_mut TINYINT(1) NOT NULL,
  PRIMARY KEY (cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_cod_unc_prm_cup (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL,
  cod_pdv INT NOT NULL,
  cod_cup INT NOT NULL,
  cod_prm INT NOT NULL,
  seq INT NOT NULL,
  cod_unc VARCHAR(50) NOT NULL,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, cod_cup, cod_prm, seq))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS grp_cli_prm_cup_adc (
  cod_grp INT NOT NULL,
  cod_prm INT NOT NULL,
  qtd_cup INT NOT NULL,
  PRIMARY KEY (cod_grp, cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ite_dav (
	dat_mov DATE NOT NULL,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	cod_dav BIGINT NOT NULL,
	seq_dav INT NOT NULL,
	cod_ean BIGINT NOT NULL,
	cod_prd BIGINT NOT NULL,
	des_prd VARCHAR(100) NOT NULL,
	qtd_dav DOUBLE(16,3) NOT NULL,
	qtd_reg DOUBLE(16,3) NOT NULL,
	prc DOUBLE(16,3) NOT NULL,
	tot DOUBLE(16,2) NOT NULL,
	can TINYINT(1) NOT NULL,
	cod_cjt BIGINT NOT NULL,
	vlr_dsc DOUBLE(16,2) NOT NULL,
	PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, cod_dav, seq_dav)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_int_zmb (
   cod_loj  INT NOT NULL,
   url_int VARCHAR(150),
   tok_idt VARCHAR(50) NOT NULL,
   hab_int TINYINT NOT NULL DEFAULT 0,
   tip_cap INT NOT NULL,
   msg_idt VARCHAR(100) NOT NULL,
   env_cup INT NOT NULL,
   fin_rgt INT NOT NULL,
   pbn_cli_anv TINYINT NOT NULL DEFAULT 0,
   vlr_min_cmp DOUBLE(16,2) NOT NULL DEFAULT 0,
   nao_cns_cli TINYINT NOT NULL DEFAULT 0,
   dsc_dif TINYINT(1) NOT NULL DEFAULT 0,
   dsc_csr TINYINT(1) NOT NULL DEFAULT 0,
   nvl_prc INT NOT NULL,
   msg_rod_cli_nao_idt_1 VARCHAR(80) NOT NULL,
   msg_rod_cli_nao_idt_2 VARCHAR(80) NOT NULL,
   idt_crt_pro TINYINT(1) NOT NULL DEFAULT 0,
   cap_cpf_idt TINYINT(1) NOT NULL DEFAULT 0,   
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_ite_vch_int (
	dat_mov date not null,
    cod_loj int not null,
    num_pdv int not null,
    num_cup int not null,
    tip_int int not null,
    cod_vch VARCHAR(255) not null,
    seq int not null,
   	cod_ean BIGINT NOT NULL,
	cod_prd BIGINT NOT NULL,
    sit int not null,
    qtd_dis double(16,2) not null,
    qtd_utl double(16,2) not null,
    vlr_dsc double(16,2) not null,
    primary key(dat_mov, cod_loj, num_pdv, num_cup, tip_int, cod_vch, seq)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_mdd_fin(
	cod_loj INTEGER NOT NULL DEFAULT 0,
	cod_fin INTEGER NOT NULL DEFAULT 0,
	mdd_blq INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY(cod_loj, cod_fin, mdd_blq)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_fcp_prd (
  cod_loj INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  ncm INT NOT NULL ,
  prd BIGINT NOT NULL ,
  alq DOUBLE NOT NULL ,
  dat_atz DATE NOT NULL ,
  PRIMARY KEY (cod_loj, sec, grp, sgr, ncm, prd)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_wsv_nfc (
  url_uf VARCHAR(2) NOT NULL  ,
  tip_url INTEGER NOT NULL  ,
  vrs_nfc DOUBLE NOT NULL  ,
  url_hml VARCHAR(255) NULL  ,
  url_pdc VARCHAR(255) NULL  ,
  pta INTEGER NULL  ,
  tim INTEGER NULL  ,
  acn TINYINT(1) NOT NULL DEFAULT 0  ,
  PRIMARY KEY (url_uf, tip_url, vrs_nfc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_vch_int (
	dat_mov date not null,
    cod_loj int not null,
    num_pdv int not null,
    num_cup int not null,
    tip_int int not null,
    cod_prm int not null,
    cod_vch VARCHAR(255) not null,
    vlr_vch double(16,2) not null,
    vlr_utl double(16,2) not null,
    dat_vde date not null,
    sit int not null,
    id_vch bigint not null,
    primary key(dat_mov, cod_loj, num_pdv, num_cup, tip_int, cod_prm, cod_vch)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS inf_adc_ean (
	ean BIGINT not null,
	cod_prd BIGINT not null,
	ean_erp varchar(30) not null,
	PRIMARY KEY(ean)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_dat_hor_prm_cup (
	cod_loj INT NOT NULL DEFAULT 0 ,
	cod_prm INT NOT NULL DEFAULT 0 ,
	nom_prm VARCHAR(80) NOT NULL DEFAULT '' ,
	seq INT NOT NULL DEFAULT 0 ,
	dat_srt DATE ,
	hor_srt TIME ,
	PRIMARY KEY(cod_loj, cod_prm, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_cte_brd (
  dat_mov DATE NOT NULL,
  cod_loj INT NOT NULL,
  cod_pdv INT NOT NULL,
  cod_cup INT NOT NULL,
  cod_prm INT NOT NULL,
  qtd_cda VARCHAR(50) NOT NULL,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, cod_cup, cod_prm))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_pfr_ite(
	dat_mov DATE NOT NULL,
	cod_loj INT NOT NULL,
	num_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	num_ped INT NOT NULL,
	seq_ite INT NOT NULL,
	cod_pfr INT NOT NULL,
	qtd_pfr DOUBLE(16,2) NOT NULL,
	des_pfr VARCHAR(255) NOT NULL,
	prc_pfr DOUBLE(16,2) NOT NULL,
	tip_pfr INT NOT NULL ,
	cod_prd BIGINT NOT NULL,
	des_prd VARCHAR(255) NOT NULL,
	PRIMARY KEY(dat_mov, cod_loj, num_pdv, num_cup, num_ped, seq_ite, cod_pfr)
)ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS ctr_blc_ckt (
  num_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  ctr_blc_cxa_lvr TINYINT(1) NOT NULL,
  ctr_blc_ini_vda TINYINT(1) NOT NULL,
  ctr_blc_est_tod TINYINT(1) NOT NULL,
  blq_vda_blc_nao_est TINYINT(1) NOT NULL,
  qtd_chg_slt_sup INT NOT NULL,
  PRIMARY KEY (num_loj, num_pdv))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_pre_gs1 (
  pre_ini INT NOT NULL,
  pre_fim INT NOT NULL,
  ind_esp TINYINT(1) NOT NULL,
  pais_nom VARCHAR(255) NOT NULL,
  PRIMARY KEY (pre_ini, pre_fim))
ENGINE = InnoDB
;

CREATE TABLE cliente_fidel_email(
	id BIGINT NOT NULL AUTO_INCREMENT,
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	email VARCHAR(60) NOT NULL DEFAULT '',
	PRIMARY KEY (id),
	UNIQUE UQ_cliente_fidel_email_key(cpf_cnpj, email)
)ENGINE = innodb;

CREATE TABLE cliente_fidel_fone(
	id BIGINT NOT NULL AUTO_INCREMENT,
	cpf_cnpj BIGINT NOT NULL DEFAULT 0,
	tipo_telefone INTEGER NOT NULL DEFAULT 0,
	ddd VARCHAR(6),
	telefone VARCHAR(10),
	ramal VARCHAR(8),
	PRIMARY KEY (id),
	UNIQUE UQ_cliente_fidel_fone_key(cpf_cnpj, tipo_telefone)
)ENGINE = innodb;

CREATE TABLE IF NOT EXISTS ctr_blq_cli_prm(
    cpf_cnpj BIGINT NOT NULL  ,  
    tip_prm INTEGER NOT NULL  ,
    nom VARCHAR(80) NOT NULL  ,
    PRIMARY KEY(cpf_cnpj, tip_prm)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_slz_sct (
  cod_loj INT NOT NULL,
  txt VARCHAR(200) NOT NULL,
  cor VARCHAR(50) NOT NULL,
  ati_slz TINYINT(1) NOT NULL,
  PRIMARY KEY (cod_loj, txt))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_slz_sit_sct (
  cod_loj INT NOT NULL,
  cor_cxa_lvr VARCHAR(50) NOT NULL,
  cor_chm_att VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_oft_pzd (
	cod_loj int not null ,
	hab_int tinyint(1) NOT NULL DEFAULT 0 ,
	url_int VARCHAR(100) NOT NULL,
	tip_cap INT NOT NULL,
	msg_idt VARCHAR(200) NOT NULL,
	env_vda INT NOT NULL,
	PRIMARY KEY (cod_loj)
) ENGINE = innodb
;

CREATE TABLE dat_lim_niv_prc_prd (
	cod_niv integer not null,
	cod_prd bigint not null,
	dat_prc date not null,
	dat_lim date default null,
	PRIMARY KEY(cod_niv, cod_prd, dat_prc)
) ENGINE = innodb;
;

CREATE TABLE cfg_rta_pdv (
	cod_loj int not null ,
	hab_rta tinyint(1) NOT NULL DEFAULT 0 ,
	ip VARCHAR(30) NOT NULL,
	msc VARCHAR(30) NOT NULL,
	ip_gtw VARCHAR(30) NOT NULL,
	PRIMARY KEY(cod_loj)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS cfg_fin_dsc_int_mlz (
	cod_loj INTEGER NOT NULL,
	fin_dsc INTEGER NOT NULL,
	PRIMARY KEY(cod_loj, fin_dsc)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS mov_dsc_oft_cbd (
  dat_mov DATE NOT NULL ,
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_cup INT NOT NULL ,
  tip_dsc INT NOT NULL , 
  seq INT NOT NULL,
  cod_prm INT NOT NULL ,
  cod_cbn INT NOT NULL ,
  dat_ini DATE NOT NULL ,
  dat_fim DATE NOT NULL ,
  vlr_dsc_apd DOUBLE NOT NULL ,
  vlr_dsc_prm DOUBLE NOT NULL ,
  qtd_prd INT NOT NULL ,
  PRIMARY KEY (dat_mov, cod_loj, num_pdv, num_cup, tip_dsc, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_vtc (
   cod_loj  INT NOT NULL,
   tok_idt VARCHAR(50) NOT NULL,
   url_int VARCHAR(100),
   msg_idt VARCHAR(100) NOT NULL,
   cod_emp VARCHAR(100) NOT NULL,
   tip_cap INT not null,
   hab_int TINYINT(1) NOT NULL,
   env_tds_cup TINYINT(1) NOT NULL,
   frm_idt INT not null,
   PRIMARY KEY(cod_loj)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cor_prm(
	tip_dsc INT NOT NULL,
	cor INT DEFAULT 0,
	PRIMARY KEY(tip_dsc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_grt_tco (
	cod_loj INT NOT NULL,
	cod_fin INT NOT NULL,
	PRIMARY KEY(cod_loj, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_grt_tco_fxa (
	cod_loj INT NOT NULL,
	cod_fin INT NOT NULL,
	fxa_ini INT NOT NULL,
	fxa_fim INT NOT NULL,
	tip_adr INT NOT NULL,
	PRIMARY KEY(cod_loj, cod_fin, fxa_ini, fxa_fim)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_idt_fid(
	tip_idt INT NOT NULL,
	msg_idt VARCHAR(255) NOT NULL,
	PRIMARY KEY (tip_idt)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_saq(
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	vlr_max_saq DOUBLE NOT NULL ,
	PRIMARY KEY(cod_loj, cod_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_saq(
	dat_mov DATE,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	seq INT NOT NULL,
	num_cup INT NOT NULL,
	hor_opr TIME,
	opd INT NOT NULL,
	vlr_saq DOUBLE NOT NULL ,
	fin INT NOT NULL,
	seq_ope INT NOT NULL,
	usu_sup INT NOT NULL,
	PRIMARY KEY(dat_mov, cod_loj, cod_pdv, seq, num_cup)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fin_asd_dav(
	cod_loj INT NOT NULL,
	cod_fin_dav INT NOT NULL,
	cod_fin_pdv INT NOT NULL,
	PRIMARY KEY(cod_loj, cod_fin_pdv, cod_fin_dav)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_fin_asd_dav(
	cod_fin_dav INT NOT NULL,
	des_fin_dav VARCHAR(100),
	per_acr DOUBLE NOT NULL ,
	PRIMARY KEY(cod_fin_dav)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ips_cup_prm_avl(
	dat_ips DATE NOT NULL,
	cod_loj INT NOT NULL,
	num_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	usu INT NOT NULL,
	PRIMARY KEY(dat_ips, cod_loj, num_pdv, num_cup)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_vas_fal_ent_dom (
	dat_mov DATE NOT NULL,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	seq INT NOT NULL,
	cod_prd BIGINT NOT NULL,
	usu INT NOT NULL,
	qtd DOUBLE NOT NULL,
	qtd_orn DOUBLE NOT NULL,
	cpv BIGINT NOT NULL,
	PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq, cod_prd)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_bio_cnv (
  cod_emp varchar(16) not null ,
  cod_cnv varchar(20) not null ,
  cod_hdw integer not null,
  seq integer not null,
  dig blob,
  PRIMARY KEY (cod_emp, cod_cnv, cod_hdw, seq)
) ENGINE = INNODB
;

CREATE  TABLE IF NOT EXISTS mov_cad_bio_cnv (
  dat_alt datetime not null ,
  cod_emp varchar(16) not null ,
  cod_cnv varchar(20) not null ,
  cod_hdw integer not null,
  seq integer not null,
  cod_loj integer not null ,
  ori_atu integer not null ,
  cod_usu integer not null ,  
  dig blob,
  tip_atu integer not null ,
  PRIMARY KEY (dat_alt, cod_emp, cod_cnv, cod_hdw, seq)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_aut_bio_cnv (
   dat_mov date not null ,
   cod_loj integer not null ,
   cod_pdv integer not null ,
   num_cup integer not null ,
   seq_fin integer not null ,
   cod_emp varchar(16) not null ,
   cod_cnv varchar(20) not null ,
   cod_ope integer not null ,  
   dig blob,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv, num_cup, seq_fin)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_eco(
	dat DATE NOT NULL,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	num_cup INT NOT NULL,
	num_ped bigint NOT NULL,
	cpf_cli VARCHAR(14),
	nom_cli VARCHAR(100),
	vlr_vda double(16,2) not null,
	vlr_fte double(16,2) not null,
	PRIMARY KEY(dat, cod_loj, cod_pdv, num_cup)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS env_prd_nao_cnf (
	dat DATE NOT NULL,
	loj INT NOT NULL,
	pdv INT NOT NULL,
	num_cup INT NOT NULL,
	num_oct BIGINT NOT NULL DEFAULT 0,
	ite_seq INT NOT NULL,
	idt_cli VARCHAR(50) NOT NULL DEFAULT '',
	idt_opd INT NOT NULL DEFAULT 0,
	idt_cxa INT NOT NULL DEFAULT 0,
	idt_ven INT NOT NULL DEFAULT 0,
	sre_not VARCHAR(50) NOT NULL DEFAULT '',
	cod_ite BIGINT NOT NULL DEFAULT 0,
	qtd_item DOUBLE NOT NULL DEFAULT 0,
	ite_des VARCHAR(50) NOT NULL DEFAULT '',
	ite_rtr VARCHAR(1) NOT NULL DEFAULT '',
  PRIMARY KEY (dat, loj, pdv, num_cup, num_oct, ite_seq)
) ENGINE = InnoDB
;

CREATE TABLE cfg_num_nfe_pdv (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  num_pdv_dep INT NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv, num_pdv_dep)
)ENGINE = InnoDB
;

CREATE TABLE cte_cfg_num_nfe_pdv (
  cod_loj INT NOT NULL ,
  num_pdv INT NOT NULL ,
  PRIMARY KEY (cod_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE cfg_nfe_tok_sft_hou (
  uf VARCHAR(5) NOT NULL,
  tok VARCHAR(255) NOT NULL,
  num_seq BIGINT NOT NULL,
  ger_dad_rpl_sft TINYINT(1) NOT NULL,
  PRIMARY KEY (uf)
)ENGINE = InnoDB
;

CREATE TABLE prd_fin_obr (
	sec INTEGER NOT NULL,
	grp INTEGER NOT NULL,
	sgr INTEGER NOT NULL,
	prd BIGINT NOT NULL,
	fin INTEGER NOT NULL,
	PRIMARY KEY (sec, grp, sgr, prd, fin)
) ENGINE = InnoDB
;

CREATE TABLE cad_acr_txa_ent (
	cod_loj INTEGER NOT NULL,
    cod_vei INTEGER NOT NULL,
    cod_rga INTEGER NOT NULL,
    vlr_vda DOUBLE NOT NULL DEFAULT 0,
    per_acr DOUBLE NOT NULL,
    acr_vlr_exc TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY(cod_loj, cod_vei, cod_rga, vlr_vda)
)Engine = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_tms_arq_ftp (
  cod_loj INT NOT NULL,
  tip INT NOT NULL,
  edr VARCHAR(200) NOT NULL,
  nom_arq VARCHAR(200) NOT NULL,
  dir_dtn VARCHAR(200) NOT NULL,
  usu VARCHAR(200) NOT NULL,
  sha VARCHAR(200) NOT NULL,
  tim INT NOT NULL,
  slv_arq_env_ftp TINYINT(1) NOT NULL,
  PRIMARY KEY (cod_loj, tip))
ENGINE = InnoDB
;

CREATE TABLE mov_cte_opd (
   data_movimento date not null,
   numero_loja integer not null,
   numero_pdv int not null,
   codigo_operador int not null,
   codigo_finalizadora int not null,
   desc_finalizadora varchar(20),
   situacao int not null,
   valor double(16,2) not null,
   troco double(16,2) not null,
   vale double(16,2) not null,
   juros double(16,2) not null,
   sangria double(16,2) not null,
   fundo_caixa double(16,2) not null,
   devolucao double(16,2) not null,
   quantidade int not null default 0,
   valor_doacao double not null default 0,
   saque_sitef double not null default 0,
   sequencia_operador integer,
   PRIMARY KEY(data_movimento, numero_loja, numero_pdv, codigo_operador, codigo_finalizadora)
) ENGINE = innodb;

CREATE TABLE cfg_wsv (
  cod_loj INT NOT NULL  ,
  tip INT NOT NULL  ,
  hab TINYINT NOT NULL  ,
  url_wsv VARCHAR(255) NOT NULL  ,
  PRIMARY KEY (cod_loj, tip)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cte_cmp_cpf_cnj (
	cte_vda INT NOT NULL,
	cod_prd BIGINT NOT NULL,
	qtd_emb INT NOT NULL,
	emb VARCHAR(20),
	PRIMARY KEY(cte_vda, cod_prd)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_cte_cmp_cpf_cnj (
	cte_vda INT NOT NULL,
	des VARCHAR(80),
	qtd_max_cpf INT NOT NULL,
	qtd_max_cnj INT NOT NULL,
	emb_cte VARCHAR(20),
	PRIMARY KEY(cte_vda)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_vda_prd_cto_cpf_cnj_tmp(
	seq INT NOT NULL,
	cpf_cnj VARCHAR(14) NOT NULL,
	prd BIGINT NOT NULL,
	qtd DOUBLE NOT NULL,
	cte_vda INT NOT NULL,
	PRIMARY KEY(seq)
)ENGINE = InnoDB
;

CREATE TABLE dsc_cnv_ite_vda (
  seq INT NOT NULL  ,
  dsc DOUBLE NOT NULL  ,
  tot_ite DOUBLE NOT NULL  ,
  tip_dsc INT NOT NULL  ,
  cod_mix INT NOT NULL  ,
  apl_dsc TINYINT NOT NULL DEFAULT 0  ,
  PRIMARY KEY (seq)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_vrs_stf (
	cod_loj INT(20) NOT NULL ,
	vrs_stf INT(20) NOT NULL ,
  PRIMARY KEY (cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_doa_tco (
	dat DATE NOT NULL,
	loj INT NOT NULL,
	pdv INT NOT NULL,
	cup INT NOT NULL,
	nsu VARCHAR(9) NOT NULL,
	cod_ope INT NOT NULL,
	cli VARCHAR(14) NOT NULL,
	seq_fin INT NOT NULL,
	vlr_doa DOUBLE NOT NULL,
	tip_doa INT NOT NULL,
	stt INT NOT NULL,
	nsu_cnc INT NOT NULL,
	PRIMARY KEY (dat, loj, pdv, cup)
)ENGINE = InnoDB
;

CREATE TABLE cte_pre_dif_zmb (
  seq INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  vlr_ori DOUBLE NOT NULL  ,
  dsc_vlr DOUBLE NOT NULL  ,
  dsc_per DOUBLE NOT NULL  ,
  PRIMARY KEY (seq, prd)
) ENGINE = InnoDB
;

CREATE TABLE cte_pre_dif_lst_prd_zmb (
  id INT NOT NULL  ,
  prd BIGINT NOT NULL  ,
  dsc_per DOUBLE NOT NULL  ,
  vlr_unt DOUBLE NOT NULL  ,
  qtd INT NOT NULL  ,
  PRIMARY KEY (id, prd)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_prm_fid_bin (
  cod_loj INT NOT NULL ,
  msg_gno VARCHAR(100) NULL ,
  pmt_pgt_par TINYINT(1) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (cod_loj)
)Engine = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_env_blc_red (
	dat_mov DATE NOT NULL,
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	sit INT NOT NULL,
	dat_hor_ult_env DATE,
    qtd_env INT NOT NULL,
  PRIMARY KEY (dat_mov, cod_loj, cod_pdv))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_env_blc_est (
	ref INT NOT NULL,
	cod_loj INT NOT NULL,
	sit INT NOT NULL,
	dat_hor_ult_env DATE,
    qtd_env INT NOT NULL,
  PRIMARY KEY (ref, cod_loj))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_xml_blc_10 (
	chv VARCHAR(255) NOT NULL,
	tip INT NOT NULL,
	xml_env LONGTEXT NULL,
    xml_rec LONGTEXT NULL ,
    xml_ret LONGTEXT NULL ,
  PRIMARY KEY (chv, tip))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_aut_pms(
	cod_loj INTEGER NOT NULL,
	fun INTEGER NOT NULL,
	PRIMARY KEY(cod_loj, fun)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cdt_tip_blq_cli (
  tip_blq VARCHAR(1) NOT NULL,
  mtv VARCHAR(100) NOT NULL,
  exi_msg TINYINT(1) NOT NULL,
  msg VARCHAR(100) NOT NULL,
  blq_cmp TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (tip_blq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS fin_tip_blq_cli (
  tip_blq VARCHAR(1) NOT NULL,
  cod_fin INT NOT NULL,
  PRIMARY KEY (tip_blq, cod_fin)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ret_cal_ctr (
	dat DATE NOT NULL,
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	num_ped BIGINT NOT NULL,  
	ret TINYINT(1) NOT NULL,
	msg VARCHAR(100) NOT NULL,
	cod_cli BIGINT NOT NULL,  
	cpf_cli VARCHAR(15) NOT NULL,
	dat_ped DATE NOT NULL,
	tip_blq VARCHAR(5) NOT NULL,
	pln INTEGER NOT NULL,
	fin INTEGER NOT NULL,
	fte DOUBLE NOT NULL,
	tot_brt DOUBLE NOT NULL,
	tot_liq DOUBLE NOT NULL,
	sit INTEGER NOT NULL,
	cod_cob VARCHAR(4) NOT NULL,
	cob VARCHAR(30) NOT NULL,
	ven INTEGER NOT NULL,
	fun INTEGER NOT NULL,
	PRIMARY KEY (dat, num_loj, num_pdv, num_cup, num_ped)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ret_prd_cal_ctr (
	dat DATE NOT NULL,
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	num_ped BIGINT NOT NULL,   
	seq BIGINT NOT NULL,  
	cod_prd BIGINT NOT NULL,
	cod_ean BIGINT NOT NULL,
	prc DOUBLE NOT NULL,
	qtd DOUBLE NOT NULL,
	qtd_ngc DOUBLE NOT NULL,
	cjt TINYINT(1) NOT NULL,
	des VARCHAR(100) NOT NULL,
	prc_tab DOUBLE NOT NULL,
	per_dsc DOUBLE NOT NULL,
	emb VARCHAR(4) NOT NULL,
	qtd_ori DOUBLE NOT NULL,
	dsc_ori DOUBLE NOT NULL,
	prc_ori DOUBLE NOT NULL,
	inc_pdv TINYINT(1) NOT NULL,
	seq_det BIGINT NOT NULL,
	seq_ori BIGINT NOT NULL,
	cod_usu INTEGER NOT NULL,
	PRIMARY KEY (dat, num_loj, num_pdv, num_cup, num_ped, seq)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_pdv_fnc (
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	PRIMARY KEY (num_loj, num_pdv)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS ctr_msg_dsc (
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	exi_msg_tla_pdv TINYINT(1) NOT NULL DEFAULT 0,
	exi_msg_rod TINYINT(1) NOT NULL DEFAULT 0,
	msg VARCHAR(44),
	PRIMARY KEY (cod_loj, cod_pdv)
)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cpp_int (
 dat DATE NOT NULL,
 cod_loj INTEGER NOT NULL,
 cod_pdv INTEGER NOT NULL,
 num_cup INTEGER NOT NULL,
 id_int INTEGER NOT NULL,
 id_prm INTEGER NOT NULL,
 cpp LONGTEXT NULL ,
 PRIMARY KEY (dat, cod_loj, cod_pdv, num_cup, id_int, id_prm)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_ger_cup_eta (
   cod_loj INT NOT NULL DEFAULT 0 ,
   cod_prm INT NOT NULL DEFAULT 0 ,
   tip_ger INT NOT NULL DEFAULT 0 ,
   qtd_eta INT NOT NULL DEFAULT 0 ,
   ger_mut DOUBLE(16,2) NOT NULL DEFAULT 0,
   pag_vlr_min TINYINT(1) NOT NULL DEFAULT 0,
   aza_cpr_dad_ppd TINYINT(1) NOT NULL DEFAULT 0,
   PRIMARY KEY (cod_loj, cod_prm)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_tip_ger_cup_eta (
   cod_loj INT NOT NULL DEFAULT 0 ,
   cod_prm INT NOT NULL DEFAULT 0 ,
   chv  INT NOT NULL DEFAULT 0 ,
   tip VARCHAR(100) NOT NULL DEFAULT "",
   des VARCHAR(100) NOT NULL DEFAULT "",
   tip_ger  INT NOT NULL DEFAULT 0 ,
   PRIMARY KEY (cod_loj, cod_prm, chv)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ctr_cup_trc_mcd (
	cod_loj INT NOT NULL,
	cod_pdv INT NOT NULL,
	dat_mov DATE NOT NULL,
	num_cup_trc_mcd BIGINT NOT NULL,
	num_cup_cmp BIGINT NOT NULL,
	PRIMARY KEY (cod_loj, cod_pdv, dat_mov, num_cup_trc_mcd, num_cup_cmp)
)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_cml (
	cod_loj INTEGER NOT NULL,
	url_int VARCHAR(100) NOT NULL,
	tok_idt VARCHAR(50) NOT NULL,
	msg_idt VARCHAR(100) NOT NULL,
	tim_cns INTEGER NOT NULL,
	hab_int TINYINT(1) NOT NULL DEFAULT 0,
	tpo_exi_msg INTEGER DEFAULT 0,
	PRIMARY KEY(cod_loj)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_srv_tms (
  cod_srv INT NOT NULL,
  pta_srv integer not null,
  srv_hab tinyint(1) not null default 1,
  tam_buf integer default 1024,
  usu VARCHAR(255) NOT NULL default '',
  sha VARCHAR(255) NOT NULL default '',
  tim_cnx integer default 30,
  tim_dld integer default 600,
  tim_upl integer default 600,
  tim_rmv integer default 30,
  tim_lst integer default 30, 
  PRIMARY KEY (cod_srv))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_srv_tms_loj_pdv (
  cod_loj INT NOT NULL,
  num_pdv INT NOT NULL,
  cod_srv INT NOT NULL, 
  prr_srv INT NOT NULL,
  PRIMARY KEY (cod_loj, num_pdv, cod_srv))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS lib_ino_dia_dat_dvg (
  sup INT NOT NULL)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cad_cat_prd (
	sec INTEGER NOT NULL,
	grp INTEGER NOT NULL,
	sgr INTEGER NOT NULL,
	cod_cat INTEGER NOT NULL,
	des_cat VARCHAR(255) NOT NULL,
	PRIMARY KEY(sec, grp, sgr, cod_cat)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS pln_clf_mer (
	cod_loj INTEGER NOT NULL,
	cod_pln INTEGER NOT NULL,
	cod_dtm INTEGER NOT NULL,
	cod_sec INTEGER NOT NULL,
	cod_grp INTEGER NOT NULL,
	cod_sgr INTEGER NOT NULL,
	cod_cat INTEGER NOT NULL,
	vig_ino DATE NOT NULL,
	vig_fim DATE NOT NULL,
	PRIMARY KEY(cod_loj, cod_pln, cod_dtm, cod_sec, cod_grp, cod_sgr, cod_cat)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_pln (
	cod_loj INTEGER NOT NULL,
	exi_pln_vir TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY(cod_loj)
) ENGINE = innodb
;

CREATE  TABLE IF NOT EXISTS ctr_cnf_clf_mer (
  cod_loj INT NOT NULL ,
  sec INT NOT NULL ,
  grp INT NOT NULL ,
  sgr INT NOT NULL ,
  prd BIGINT NOT NULL ,
  lim DOUBLE(16,3) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_loj, sec, grp, sgr,prd)
 ) ENGINE = InnoDB
;

CREATE TABLE produto_vasilhame (  
  codigo bigint(14) not null,
  codigo_produto bigint(14) not null,
  quantidade integer not null default 0,
  descricao varchar(20) not null,
  preco double(12,2) not null,
  PRIMARY KEY(codigo, codigo_produto)
) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS clf_mer_prd (
	cod_dtm INTEGER NOT NULL,
	cod_sec INTEGER NOT NULL,
	cod_grp INTEGER NOT NULL,
	cod_sgr INTEGER NOT NULL,
	cod_cat INTEGER NOT NULL,
	cod_prd BIGINT NOT NULL,
	PRIMARY KEY(cod_dtm, cod_sec, cod_grp, cod_sgr, cod_cat, cod_prd)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cfg_int_pro (
	num_loj integer not null,
	url varchar(255) not null,
	tok_api varchar(255) not null,
	usu_api varchar(255) not null,
	sha_api varchar(255) not null,
	tok_arq varchar(255) not null,
	usu_arq varchar(255) not null,
	sha_arq varchar(255) not null,
	tip_env_pro integer not null,
	dat_ini date not null,
	dat_fin date not null,
	qtd_dia integer NOT NULL,
	hab tinyint(1),
	end_ati integer not null default 0,
	cap_tel_ppd tinyint(1) not null default 0,
	niv_prc_mas integer NOT NULL default 0,
	PRIMARY KEY(num_loj)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS tco_spl ( 
	num_loj integer not null,
	url varchar(255) not null,
	cnpj_loja varchar(20) not null,
	tok_api varchar(255) not null,
	hab tinyint(1) not null default 0,
	PRIMARY KEY(num_loj)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS mov_pro (
	dat_mov DATE NOT NULL,
	cod_loj INTEGER NOT NULL,
	cod_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	tip_cns INTEGER NOT NULL,
	cpf VARCHAR(255) NOT NULL,
	uid VARCHAR(255) NOT NULL,
	stt_ret INTEGER NOT NULL,
	PRIMARY KEY(dat_mov, cod_loj, cod_pdv, num_cup, tip_cns)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cte_prd_com_prm (
	tip_dsc integer not null,
	cod_mix integer not null,
	ean BIGINT not null,
    qtd_utz integer not null,
	PRIMARY KEY(tip_dsc, cod_mix, ean)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS qtd_mix_utz (
	tip_dsc integer not null,
	cod_mix integer not null,
	qtd_utz integer not null,
	PRIMARY KEY(tip_dsc, cod_mix)
) ENGINE = innodb
;

CREATE TABLE mov_tco_spl (
   data_movimento date not null,
   codigo_operador int not null,
   numero_loja integer not null,
   numero_pdv int not null,
   numero_cupom int not null,
   sequencia int not null,
   codigo_transacao varchar(255) not null,
   valor double(12,2) not null,
   operacao varchar(255) not null,
   stt int not null,
   cpf varchar(30),
   PRIMARY KEY(data_movimento, codigo_operador, numero_loja, numero_pdv, numero_cupom, sequencia)
) ENGINE = innodb
;

CREATE TABLE IF NOT EXISTS cad_cat_cli (
	cod_cat INTEGER NOT NULL,
	des_cat VARCHAR(40) NOT NULL,
	PRIMARY KEY (cod_cat)
)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cte_crg_dif (
  dat_crg DATE NOT NULL,
  num_crg INTEGER NOT NULL,
  id_crg INTEGER NOT NULL,
  seq INTEGER NOT NULL,
  stt INTEGER NOT NULL,
  dat_hor_atz DATETIME NOT NULL,
  chv LONGTEXT not null,
PRIMARY KEY (dat_crg, num_crg, id_crg, seq)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cat_cli_prm_mix_lev_pag (
	cod_loj INTEGER NOT NULL,
	cod_mix INTEGER NOT NULL,
	cod_cat INTEGER NOT NULL,
	PRIMARY KEY (cod_loj, cod_mix, cod_cat)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cad_cnl (
  	num_loj INTEGER NOT NULL ,
  	cod_cnl INTEGER NOT NULL ,
  	des_cnl VARCHAR(100) NOT NULL ,
    cod_niv_prc INTEGER NOT NULL DEFAULT 0 ,
    ati TINYINT(1) NOT NULL ,
    ipm_cpf_cli_ped TINYINT(1) NOT NULL ,
    ptp_prm_cup TINYINT(1) NOT NULL ,
    ptp_cup_dsc TINYINT(1) NOT NULL ,
  	PRIMARY KEY(num_loj, cod_cnl)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cnl_pdv (
  	num_loj INTEGER NOT NULL ,
  	cod_cnl INTEGER NOT NULL ,
    num_pdv INTEGER NOT NULL ,
  	PRIMARY KEY(num_loj, cod_cnl, num_pdv)
) ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cad_cnl_frm_pgt (
  	num_loj INTEGER NOT NULL ,
  	cod_cnl INTEGER NOT NULL ,
    cod_frm_pgt INTEGER NOT NULL ,
  	PRIMARY KEY(num_loj, cod_cnl, cod_frm_pgt)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS mov_dsc_pro (
	dat_mov DATE NOT NULL,
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	cod_ean BIGINT NOT NULL,
	id_prm VARCHAR(255) NOT NULL,
	qtd_prd DOUBLE NOT NULL,
	prc_prd_unt_com_dsc DOUBLE NOT NULL,
	dsc_prd_unt DOUBLE NOT NULL,
	PRIMARY KEY (dat_mov, num_loj, num_pdv, num_cup, cod_ean, id_prm)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ctr_bld_apc (
 num_loj INT NOT NULL,
 num_pdv INT NOT NULL,
 tip_apc INT NOT NULL,
 des_prj VARCHAR(40) NOT NULL,
 bld_apc VARCHAR(40) NOT NULL,
 PRIMARY KEY (num_loj, num_pdv, tip_apc)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS cfg_int_oft (
	num_loj INTEGER NOT NULL,
	tok VARCHAR(255) NOT NULL,
	msg_idt VARCHAR(40) NOT NULL,
	cap_cpf_ppd TINYINT(1) NOT NULL DEFAULT 0,
	hab TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (num_loj)
) ENGINE = InnoDB;

CREATE TABLE mov_crs_vda (
	codigo_movimentacao INT NOT NULL AUTO_INCREMENT,
	data_cpr DATE NOT NULL, 
	num_operador INT NOT NULL,
	num_loja INT NOT NULL, 
	num_pdv INT NOT NULL, 
	num_cupom INT NOT NULL,
	cpr_json_envio LONGTEXT,
	cpr_json_retorno LONGTEXT,
	tip INT NOT NULL,
	status INT NOT NULL,
	dat_envio DATETIME,
	dat_resposta DATETIME,
	num_doc_cli VARCHAR(30) DEFAULT '',
	PRIMARY KEY(codigo_movimentacao)
) ENGINE = innodb;

 CREATE TABLE IF NOT EXISTS cfg_int_zeu (
	cod_loj INTEGER NOT NULL,
	hab TINYINT(1) NOT NULL DEFAULT 0,
	url VARCHAR(100) NOT NULL,
	msg_idt VARCHAR(40) NOT NULL,
	msg_rgt VARCHAR(40) NOT NULL,
	fin INTEGER NOT NULL, 
 PRIMARY KEY(cod_loj)
 ) ENGINE = innodb;
 
 CREATE TABLE IF NOT EXISTS cfg_int_pdv_zeu (
	cod_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL, 
	tok VARCHAR(500) NOT NULL,
	ppd TINYINT(1) NOT NULL DEFAULT 0,
 PRIMARY KEY(cod_loj, num_pdv)
 ) ENGINE = innodb;

CREATE TABLE IF NOT EXISTS ctr_pms_cnc_ite(
	num_loj INTEGER NOT NULL,
	pfl INTEGER NOT NULL,
	vlr_max DOUBLE NOT NULL,
	qtd_cnc DOUBLE NOT NULL,
	ctr_tds_ite TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (num_loj, pfl)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ctr_qtd_cnc_ite(
	dat DATE NOT NULL,
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	seq INTEGER NOT NULL,
	qtd DOUBLE NOT NULL,
	PRIMARY KEY (dat, num_loj, num_pdv, num_cup, seq)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_etq_aft (
	num_loj INTEGER NOT NULL,
	msg VARCHAR(50) NOT NULL,
	tpo DOUBLE(16, 2) NOT NULL,
	PRIMARY KEY (num_loj)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_int_pyf (
	cod_loj INTEGER NOT NULL,
	url VARCHAR(100) NOT NULL,
	tok VARCHAR(500) NOT NULL,
	fin INTEGER NOT NULL,
	PRIMARY KEY (cod_loj)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cfg_int_pdv_pyf (
	cod_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL, 
	dps VARCHAR(100) NOT NULL,
	PRIMARY KEY (cod_loj, num_pdv, dps)
) ENGINE = InnoDB;

CREATE TABLE cfg_vlr_vda_est (
  num_loj integer not null,
  vlr_min_vda_ini double(16,2) not null,
  vlr_min_vda_fim double(16,2) not null,
  tmp_ise int(11) not null default 0,
  id_srv integer not null,
  PRIMARY KEY(num_loj, vlr_min_vda_ini, vlr_min_vda_fim)
) ENGINE = innodb;

CREATE TABLE cfg_tab_prc_est (
  num_loj INT NOT NULL DEFAULT 0 ,
  mnt_ini INT NOT NULL ,
  mnt_fim INT NOT NULL ,
  vlr_cob DOUBLE NOT NULL ,
  id_srv integer not null,
  PRIMARY KEY(num_loj, mnt_ini, mnt_fim)
)ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS mov_trn_est (
	dat_vda DATE NOT NULL,
	num_loj INTEGER NOT NULL,
	num_pdv INTEGER NOT NULL,
	num_cup INTEGER NOT NULL,
	seq INTEGER NOT NULL,
	id_srv INTEGER NOT NULL DEFAULT 0,
	dat_hor_trn DATETIME NOT NULL,
	dat_val_tiq DATETIME,
	dat_hor_ent DATETIME NOT NULL,
	tmp_pem BIGINT NOT NULL DEFAULT 0,
	tmp_ise INTEGER NOT NULL DEFAULT 0,
	vlr_cob DOUBLE(16,2),
	vlr_ise DOUBLE(16,2),
	tiq VARCHAR(255) NOT NULL DEFAULT '',
	num_cup_rec INTEGER NOT NULL DEFAULT 0,
	sit INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (dat_vda, num_loj, num_pdv, num_cup, seq)
)ENGINE = InnoDB;
