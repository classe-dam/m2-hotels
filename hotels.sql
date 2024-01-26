DROP DATABASE hotels_db;

CREATE DATABASE hotels_db;

USE hotels_db;

CREATE TABLE cadena_hotelera (
	CIF char(9) ,
    constraint pk_cadena_hotelera  PRIMARY KEY (cif)
);
CREATE TABLE ciutats (
	id_ciutat int AUTO_INCREMENT,
    nom varchar(50) NOT NULL,
    constraint pk_ciutats PRIMARY KEY (id_ciutat)
);

CREATE TABLE hotels (
	id_ciutat int,
	nom varchar(50),
	numEstrelles tinyint UNSIGNED CHECK(numEstrelles <= 5) NOT NULL,
    adress varchar(255) NOT NULL,
    telefon char(9) NOT NULL,
    id_cadena_hotelera char(9),
    tipus_hotel enum("platja","muntanya") NOT NULL,
    constraint pk_hotels  PRIMARY KEY(id_ciutat, nom),
    constraint fk_cadena_hotelera FOREIGN KEY(id_cadena_hotelera) REFERENCES cadena_hotelera(CIF)
);

CREATE TABLE semblances (
    id_ciutat int,
    nom_hotel varchar(50),
    id_ciutat_semblada int,
    nom_hotel_semblada varchar(50),
    CONSTRAINT pk_semblances PRIMARY KEY (id_ciutat, nom_hotel, id_ciutat_semblada, nom_hotel_semblada),
    CONSTRAINT fk_dades_hotel FOREIGN KEY (id_ciutat, nom_hotel) REFERENCES hotels(id_ciutat, nom),
    CONSTRAINT fk_hotel_semblada FOREIGN KEY (id_ciutat_semblada, nom_hotel_semblada) REFERENCES hotels(id_ciutat, nom)
);

CREATE TABLE hotels_muntanya (
	id_ciutat_hotel int,
	nom_hotel varchar(50),
    tePiscina boolean NOT NULL,
	constraint pk_hotels PRIMARY KEY(id_ciutat_hotel, nom_hotel),
	constraint fk_dades_hotels_muntanya FOREIGN KEY (id_ciutat_hotel,nom_hotel) REFERENCES hotels(id_ciutat,nom)
);

CREATE TABLE hotels_platja (
	id_ciutat_hotel int,
	nom_hotel varchar(50),
    tePlatjaPrivada boolean NOT NULL,
    teLloguerEmbarcacions boolean NOT NULL,
	constraint pk_hotels PRIMARY KEY(id_ciutat_hotel, nom_hotel),
	constraint fk_dades_hotels_platja FOREIGN KEY (id_ciutat_hotel,nom_hotel) REFERENCES hotels(id_ciutat,nom)
);

CREATE TABLE agencia_viatges (
	id_agencia int AUTO_INCREMENT,
    nom char(255),
	constraint pk_agencia_viatges  PRIMARY KEY (id_agencia)
);

CREATE TABLE delegacio (
	id_agencia int ,
    numero_agencia int ,
    adresa varchar(255) NOT NULL,
	id_ciutat int NOT NULL,
	constraint pk_agencia_viatges  PRIMARY KEY (id_agencia, numero_agencia),
    constraint fk_agencia_viatges_ciutat FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat),
    constraint fk_delegacio_agencia FOREIGN KEY (id_agencia) REFERENCES agencia_viatges(id_agencia)
);

CREATE TABLE activitats(
	id_activitat int AUTO_INCREMENT,
    nom varchar(255) NOT NULL,
    constraint pk_activitats PRIMARY KEY(id_activitat)
);

CREATE TABLE  empleat(
	DNI char(9),
    nom varchar(30) NOT NULL,
    constraint pk_empleat PRIMARY KEY (DNI)
);

CREATE TABLE turistas (
	id_ciutat_hotel int,
	nom_hotel varchar(50),
	id_agencia int ,
    month_date date,
    numTuristas int NOT NULL,
    constraint pk_turistas PRIMARY KEY (id_agencia,id_ciutat_hotel,nom_hotel,month_date),
	constraint fk_turiatas_agencia FOREIGN KEY (id_agencia) REFERENCES agencia_viatges(id_agencia),
	constraint fk_turistas_hotel FOREIGN KEY (id_ciutat_hotel,nom_hotel) REFERENCES hotels(id_ciutat,nom)
);
CREATE TABLE activitats_hotels (
	id_ciutat_hotel int,
	nom_hotel varchar(50),
	id_activitat int ,
    nivelQualitat int UNSIGNED NOT NULL CHECK(nivelQualitat <= 5),
    constraint pk_activitats_hotel PRIMARY KEY (id_ciutat_hotel,nom_hotel,id_activitat),
    constraint fk_activitats_hotel FOREIGN KEY (id_ciutat_hotel,nom_hotel) REFERENCES hotels(id_ciutat,nom),
    constraint fk_activitats_hotel_activitat FOREIGN KEY (id_activitat) REFERENCES activitats(id_activitat)
);

CREATE TABLE historial_empleat_cadena_hotelera(
	dni_empleat char(9),
    data_inici date, 
    data_finalitzacio date,
    cif_cadena_hotelera char(9) NOT NULL,
    constraint pk_historial_empleat_cadena_hotelera PRIMARY KEY (dni_empleat, data_inici),
    constraint fk_historial_cadena_id_empleat FOREIGN KEY (dni_empleat) REFERENCES empleat(DNI),
    constraint fk_historial_cadena_cif_cadena FOREIGN KEY (cif_cadena_hotelera) REFERENCES cadena_hotelera(CIF)
);
CREATE TABLE historial_empleat_hotel(
	dni_empleat char(9),
    id_ciutat_hotel int  NOT NULL,
	nom_hotel varchar(50) NOT NULL,
    data_inici date, 
    data_finalitzacio date,
	cedit boolean NOT NULL,
    cedit_cif_cadena_hotelera char(9),
    constraint pk_historial_empleat_cadena_hotelera PRIMARY KEY (dni_empleat, data_inici),
	constraint fk_historial_empleat_hotel FOREIGN KEY (id_ciutat_hotel,nom_hotel) REFERENCES hotels(id_ciutat,nom),
    constraint fk_historial_empleat_hotel_id_empleat FOREIGN KEY (dni_empleat) REFERENCES empleat(DNI),
    constraint fk_historial_empleat_hotel_cif_cadena FOREIGN KEY (cedit_cif_cadena_hotelera) REFERENCES cadena_hotelera(CIF)
);