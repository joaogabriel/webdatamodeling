/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     19/5/2010 01:06:50                           */
/*==============================================================*/


drop table ARQUIVO;

drop table CAMPO;

drop table COMPARTILHAMENTO;

drop table MER;

drop table PASTA;

drop table TABELA;

drop table TIPO_ARQUIVO;

drop table TIPO_CAMPO;

drop table TIPO_TABELA;

drop table USUARIO;

/*==============================================================*/
/* User: WDM_USER                                               */
/*==============================================================*/
create user WDM_USER;

/*==============================================================*/
/* Table: ARQUIVO                                               */
/*==============================================================*/
create table ARQUIVO (
   ID_ARQUIVO           SERIAL               not null,
   ID_PASTA             INT4                 null,
   DS_VERSAO            VARCHAR(5)           null,
   DS_NOME              VARCHAR(30)          null,
   DS_DESCRICAO         VARCHAR(100)         null,
   DT_CRIACAO           DATE                 null,
   DT_ULTIMA_ALTERACAO  DATE                 null,
   constraint PK_ARQUIVO primary key (ID_ARQUIVO)
);

-- set table ownership
alter table ARQUIVO owner to WDM_USER
;
/*==============================================================*/
/* Table: CAMPO                                                 */
/*==============================================================*/
create table CAMPO (
   ID_CAMPO             SERIAL               not null,
   ID_TIPO_CAMPO        INT4                 null,
   ID_TABELA            INT4                 null,
   DS_CAMPO             VARCHAR(10)          null,
   NAO_NULO             BOOL                 null,
   AUTO_INCREMENTO      BOOL                 null,
   DS_VALOR_PADRAO      VARCHAR(10)          null,
   DS_COMENTARIO        VARCHAR(30)          null,
   CHAVE_PRIMARIA       BOOL                 null,
   CHAVE_ESTRANGEIRA    BOOL                 null,
   TAMANHO              INT50                null,
   constraint PK_CAMPO primary key (ID_CAMPO)
);

-- set table ownership
alter table CAMPO owner to WDM_USER
;
/*==============================================================*/
/* Table: COMPARTILHAMENTO                                      */
/*==============================================================*/
create table COMPARTILHAMENTO (
   ID_USUARIO           INT4                 not null,
   ID_MER               INT4                 not null,
   constraint PK_COMPARTILHAMENTO primary key (ID_USUARIO, ID_MER)
);

-- set table ownership
alter table COMPARTILHAMENTO owner to WDM_USER
;
/*==============================================================*/
/* Table: MER                                                   */
/*==============================================================*/
create table MER (
   ID_MER               SERIAL               not null,
   ID_ARQUIVO           INT4                 null,
   EXPORTADO            BOOL                 null,
   DT_ULTIMA_EXPORTACAO DATE                 null,
   constraint PK_MER primary key (ID_MER)
);

-- set table ownership
alter table MER owner to WDM_USER
;
/*==============================================================*/
/* Table: PASTA                                                 */
/*==============================================================*/
create table PASTA (
   ID_PASTA             SERIAL               not null,
   ID_USUARIO           INT4                 null,
   DS_NOME              VARCHAR(30)          null,
   DS_DESCRICAO         VARCHAR(100)         null,
   DT_CRIACAO           DATE                 null,
   DT_ULTIMA_ALTERACAO  DATE                 null,
   constraint PK_PASTA primary key (ID_PASTA)
);

-- set table ownership
alter table PASTA owner to WDM_USER
;
/*==============================================================*/
/* Table: TABELA                                                */
/*==============================================================*/
create table TABELA (
   ID_TABELA            SERIAL               not null,
   ID_TIPO_TABELA       INT4                 null,
   ID_MER               INT4                 null,
   DS_TABELA            VARCHAR(10)          null,
   DS_COMENTARIO        VARCHAR(30)          null,
   COORDENADA_X         NUMERIC(5)           null,
   COORDENADA_Y         NUMERIC(5)           null,
   constraint PK_TABELA primary key (ID_TABELA)
);

-- set table ownership
alter table TABELA owner to WDM_USER
;
/*==============================================================*/
/* Table: TIPO_ARQUIVO                                          */
/*==============================================================*/
create table TIPO_ARQUIVO (
   ID_TIPO_ARQUIVO      SERIAL               not null,
   DS_TIPO_ARQUIVO      VARCHAR(200)         null,
   constraint PK_TIPO_ARQUIVO primary key (ID_TIPO_ARQUIVO)
);

-- set table ownership
alter table TIPO_ARQUIVO owner to WDM_USER
;
/*==============================================================*/
/* Table: TIPO_CAMPO                                            */
/*==============================================================*/
create table TIPO_CAMPO (
   ID_TIPO_CAMPO        SERIAL               not null,
   DS_TIPO_CAMPO        VARCHAR(50)          null,
   DS_VALOR_MINIMO      NUMERIC              null,
   DS_VALOR_MAXIMO      NUMERIC              null,
   constraint PK_TIPO_CAMPO primary key (ID_TIPO_CAMPO)
);

-- set table ownership
alter table TIPO_CAMPO owner to WDM_USER
;
/*==============================================================*/
/* Table: TIPO_TABELA                                           */
/*==============================================================*/
create table TIPO_TABELA (
   ID_TIPO_TABELA       SERIAL               not null,
   DS_TIPO_TABELA       VARCHAR(50)          null,
   constraint PK_TIPO_TABELA primary key (ID_TIPO_TABELA)
);

-- set table ownership
alter table TIPO_TABELA owner to WDM_USER
;
/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USUARIO           SERIAL               not null,
   DS_USUARIO           VARCHAR(30)          null,
   DS_SOBRENOME         VARCHAR(30)          null,
   DS_EMAIL             VARCHAR(50)          null,
   DS_SENHA             VARCHAR(20)          null,
   DT_CADASTRO          DATE                 null,
   DT_NASCIMENTO        DATE                 null,
   constraint PK_USUARIO primary key (ID_USUARIO)
);

-- set table ownership
alter table USUARIO owner to WDM_USER
;
alter table ARQUIVO
   add constraint FK_ARQUIVO_PK_PASTA__PASTA foreign key (ID_PASTA)
      references PASTA (ID_PASTA)
      on delete restrict on update restrict;

alter table CAMPO
   add constraint FK_CAMPO_PK_TABELA_TABELA foreign key (ID_TABELA)
      references TABELA (ID_TABELA)
      on delete restrict on update restrict;

alter table CAMPO
   add constraint FK_CAMPO_PK_TIPO_C_TIPO_CAM foreign key (ID_TIPO_CAMPO)
      references TIPO_CAMPO (ID_TIPO_CAMPO)
      on delete restrict on update restrict;

alter table COMPARTILHAMENTO
   add constraint FK_COMPARTI_PK_MER_CO_MER foreign key (ID_MER)
      references MER (ID_MER)
      on delete restrict on update restrict;

alter table COMPARTILHAMENTO
   add constraint FK_COMPARTI_PK_USUARI_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
      on delete restrict on update restrict;

alter table MER
   add constraint FK_MER_PK_ARQUIV_ARQUIVO foreign key (ID_ARQUIVO)
      references ARQUIVO (ID_ARQUIVO)
      on delete restrict on update restrict;

alter table PASTA
   add constraint FK_PASTA_PK_USUARI_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
      on delete restrict on update restrict;

alter table TABELA
   add constraint FK_TABELA_PK_MER_TA_MER foreign key (ID_MER)
      references MER (ID_MER)
      on delete restrict on update restrict;

alter table TABELA
   add constraint FK_TABELA_PK_TIPO_T_TIPO_TAB foreign key (ID_TIPO_TABELA)
      references TIPO_TABELA (ID_TIPO_TABELA)
      on delete restrict on update restrict;

