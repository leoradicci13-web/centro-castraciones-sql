-- CREACION DE BASE DE DATOS
CREATE DATABASE IF NOT EXISTS centro_castracion;

USE centro_castracion;


CREATE TABLE Propietario(
	Id_propietario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    DNI VARCHAR(15) NOT NULL,
    Direccion VARCHAR(150),
    Localidad VARCHAR(100),
    Telefono VARCHAR(30)
);


CREATE TABLE Mascota(
	Id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    Id_propietario INT NOT NULL,
    Nombre VARCHAR(100),
    Especie VARCHAR(50),
    Raza VARCHAR(50),
    Edad INT,
    Sexo VARCHAR(10),
    Peso  DECIMAL(5,2),
    Pelaje VARCHAR(50),
    FOREIGN KEY (Id_propietario) REFERENCES Propietario(Id_propietario)
);


CREATE TABLE Adopcion(
	Id_adopcion INT AUTO_INCREMENT PRIMARY KEY,
    Id_mascota INT NOT NULL,
    Id_propietario INT NOT NULL,
    Fecha DATE NOT NULL,
    Observacion TEXT,
    FOREIGN KEY (Id_mascota) REFERENCES Mascota(Id_mascota),
    FOREIGN KEY (Id_propietario) REFERENCES Propietario(Id_propietario)
);

 
 CREATE TABLE Ingreso_animal(
    Id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    Id_mascota INT NOT NULL,
    Motivo_ingreso VARCHAR(200),
    Fecha DATE NOT NULL,
    Observacion TEXT,
    FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota)
);


CREATE TABLE Turno(
    Id_turno INT AUTO_INCREMENT PRIMARY KEY,
    Id_mascota INT NOT NULL,
    Fecha_turno DATE NOT NULL,
    Hora_turno TIME NOT NULL,
    Tipo VARCHAR(50) NOT NULL,   -- programadO, no_programadO
    Estado VARCHAR(50),
    FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota)
);

CREATE TABLE vacunacion(
    id_vacunacion INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    id_compra INT NOT NULL,        -- relaciona la vacuna con la compra de ese insumo
    tipo_vacuna VARCHAR(100),
    fecha DATE NOT NULL,
    observacion TEXT,
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);

CREATE TABLE compra(
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_producto VARCHAR(50),       -- campo de texto porque NO existe tabla producto
    fecha DATE NOT NULL,
    monto_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE proveedor(
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(30),
    direccion VARCHAR(150)
);

CREATE TABLE pago_servicios(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    tipo_servicio VARCHAR(100),
    monto_servicio DECIMAL(10,2) NOT NULL,
    proveedor VARCHAR(150),
    fecha DATE NOT NULL
);

CREATE TABLE castracion(
    id_castracion INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT NOT NULL,
    id_veterinario INT NOT NULL,
    id_personal INT NOT NULL,      -- asistente
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    observacion TEXT,
    complicaciones TEXT,
    monto_pagado DECIMAL(10,2),
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

CREATE TABLE ingresos(
    id_ingreso_extra INT AUTO_INCREMENT PRIMARY KEY,
    tipo_ingreso VARCHAR(100),
    monto_ingreso DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE personal (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    email VARCHAR(100)
);

CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    matricula VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    email VARCHAR(100)
);