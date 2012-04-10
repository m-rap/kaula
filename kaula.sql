/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     10/04/2012 11:04:10                          */
/*==============================================================*/


drop table if exists akun;

drop table if exists alamat;

drop table if exists artikel;

drop table if exists bank;

drop table if exists detail_pembelian;

drop table if exists kategori_artikel;

drop table if exists kategori_produk;

drop table if exists komentar;

drop table if exists kota;

drop table if exists pembelian;

drop table if exists produk;

drop table if exists provinsi;

drop table if exists rekening;

drop table if exists telepon;

/*==============================================================*/
/* Table: akun                                                  */
/*==============================================================*/
create table akun
(
   id_akun              int not null,
   login                varchar(20),
   password             varchar(64),
   email                varchar(100),
   waktu_daftar         datetime,
   terakhir_login       datetime,
   nama_lengkap         varchar(250),
   nama_panggilan       varchar(100),
   admin                bool,
   primary key (id_akun)
);

/*==============================================================*/
/* Table: alamat                                                */
/*==============================================================*/
create table alamat
(
   id_alamat            int not null,
   id_bank              int,
   id_kota              int,
   id_akun              int,
   nama_alamat          text,
   primary key (id_alamat)
);

/*==============================================================*/
/* Table: artikel                                               */
/*==============================================================*/
create table artikel
(
   id_artikel           int not null,
   id_akun              int,
   id_kategori_artikel  int,
   judul_artikel        varchar(250),
   konten_artikel       text,
   waktu_artikel        datetime,
   primary key (id_artikel)
);

/*==============================================================*/
/* Table: bank                                                  */
/*==============================================================*/
create table bank
(
   id_bank              int not null,
   nama_bank            varchar(250),
   primary key (id_bank)
);

/*==============================================================*/
/* Table: detail_pembelian                                      */
/*==============================================================*/
create table detail_pembelian
(
   id_detail_pembelian  int not null,
   id_pembelian         int,
   id_produk            int,
   harga_subtotal       float,
   primary key (id_detail_pembelian)
);

/*==============================================================*/
/* Table: kategori_artikel                                      */
/*==============================================================*/
create table kategori_artikel
(
   id_kategori_artikel  int not null,
   parent_kategori_artikel int,
   nama_kategori_artikel varchar(250),
   primary key (id_kategori_artikel)
);

/*==============================================================*/
/* Table: kategori_produk                                       */
/*==============================================================*/
create table kategori_produk
(
   id_kategori_produk   int not null,
   parent_kategori_produk int,
   nama_kategori_produk varchar(250),
   primary key (id_kategori_produk)
);

/*==============================================================*/
/* Table: komentar                                              */
/*==============================================================*/
create table komentar
(
   id_komentar          int not null,
   id_produk            int,
   id_artikel           int,
   parent_komentar      int,
   konten_komentar      text,
   primary key (id_komentar)
);

/*==============================================================*/
/* Table: kota                                                  */
/*==============================================================*/
create table kota
(
   id_kota              int not null,
   id_provinsi          int,
   nama_kota            varchar(250),
   primary key (id_kota)
);

/*==============================================================*/
/* Table: pembelian                                             */
/*==============================================================*/
create table pembelian
(
   id_pembelian         int not null,
   id_pembeli           int,
   id_penjual           int,
   nomor_invoice        varchar(20),
   harga_total          float,
   status_pembayaran    bool,
   konfirmasi_pembayaran bool,
   status_pengiriman    bool,
   konfirmasi_pengiriman bool,
   primary key (id_pembelian)
);

/*==============================================================*/
/* Table: produk                                                */
/*==============================================================*/
create table produk
(
   id_produk            int not null,
   id_akun              int,
   id_kategori_produk   int,
   nama_produk          varchar(250),
   harga                float,
   info_produk          text,
   primary key (id_produk)
);

/*==============================================================*/
/* Table: provinsi                                              */
/*==============================================================*/
create table provinsi
(
   id_provinsi          int not null,
   nama_provinsi        varchar(250),
   primary key (id_provinsi)
);

/*==============================================================*/
/* Table: rekening                                              */
/*==============================================================*/
create table rekening
(
   id_rekening          int not null,
   id_akun              int,
   id_bank              int,
   nomor_rekening       varchar(100),
   nama_pemilik_rekening varchar(250),
   primary key (id_rekening)
);

/*==============================================================*/
/* Table: telepon                                               */
/*==============================================================*/
create table telepon
(
   id_telepon           int not null,
   id_akun              int,
   nomor_telepon        varchar(100),
   primary key (id_telepon)
);

alter table alamat add constraint FK_alamat_akun foreign key (id_akun)
      references akun (id_akun) on delete restrict on update restrict;

alter table alamat add constraint FK_cabang_bank foreign key (id_bank)
      references bank (id_bank) on delete restrict on update restrict;

alter table alamat add constraint FK_kota_alamat foreign key (id_kota)
      references kota (id_kota) on delete restrict on update restrict;

alter table artikel add constraint FK_artikel_akun foreign key (id_akun)
      references akun (id_akun) on delete restrict on update restrict;

alter table artikel add constraint FK_kategori_artikel foreign key (id_kategori_artikel)
      references kategori_artikel (id_kategori_artikel) on delete restrict on update restrict;

alter table detail_pembelian add constraint FK_detail_pembelian_pembelian foreign key (id_pembelian)
      references pembelian (id_pembelian) on delete restrict on update restrict;

alter table detail_pembelian add constraint FK_detail_pembelian_produk foreign key (id_produk)
      references produk (id_produk) on delete restrict on update restrict;

alter table kategori_artikel add constraint FK_relationship_9 foreign key (parent_kategori_artikel)
      references kategori_artikel (id_kategori_artikel) on delete restrict on update restrict;

alter table kategori_produk add constraint FK_parent_kategori_produk foreign key (parent_kategori_produk)
      references kategori_produk (id_kategori_produk) on delete restrict on update restrict;

alter table komentar add constraint FK_komentar_artikel foreign key (id_artikel)
      references artikel (id_artikel) on delete restrict on update restrict;

alter table komentar add constraint FK_komentar_produk foreign key (id_produk)
      references produk (id_produk) on delete restrict on update restrict;

alter table komentar add constraint FK_parent_komentar foreign key (parent_komentar)
      references komentar (id_komentar) on delete restrict on update restrict;

alter table kota add constraint FK_provinsi_kota foreign key (id_provinsi)
      references provinsi (id_provinsi) on delete restrict on update restrict;

alter table pembelian add constraint FK_pembeli foreign key (id_pembeli)
      references akun (id_akun) on delete restrict on update restrict;

alter table pembelian add constraint FK_penjual foreign key (id_penjual)
      references akun (id_akun) on delete restrict on update restrict;

alter table produk add constraint FK_kategori_produk foreign key (id_kategori_produk)
      references kategori_produk (id_kategori_produk) on delete restrict on update restrict;

alter table produk add constraint FK_produk_akun foreign key (id_akun)
      references akun (id_akun) on delete restrict on update restrict;

alter table rekening add constraint FK_bank_rekening foreign key (id_bank)
      references bank (id_bank) on delete restrict on update restrict;

alter table rekening add constraint FK_rekening_akun foreign key (id_akun)
      references akun (id_akun) on delete restrict on update restrict;

alter table telepon add constraint FK_telepon_akun foreign key (id_akun)
      references akun (id_akun) on delete restrict on update restrict;

