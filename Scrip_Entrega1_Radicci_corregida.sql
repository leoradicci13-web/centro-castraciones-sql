-- CREACION DE BASE DE DATOS
CREATE DATABASE IF NOT EXISTS centro_castracion;

USE centro_castracion;

-- TABLA PROPIETARIO
CREATE TABLE propietario(
	id_propietario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    direccion VARCHAR(150),
    localidad VARCHAR(100),
    telefono VARCHAR(30)
);

-- TABLA MASCOTA
CREATE TABLE mascota(
	id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    id_propietario INT NOT NULL,
    nombre VARCHAR(100),
    especie VARCHAR(50),
    raza VARCHAR(50),
    edad INT,
    sexo VARCHAR(10),
    peso  DECIMAL(5,2),
    pelaje VARCHAR(50),
    FOREIGN KEY (Id_propietario) REFERENCES propietario(Id_propietario)
);

-- TABLA ADOPCION
CREATE TABLE adopcion(
	id_adopcion INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    id_propietario INT NOT NULL,
    fecha DATE NOT NULL,
    observacion TEXT,
    FOREIGN KEY (Id_mascota) REFERENCES mascota(Id_mascota),
    FOREIGN KEY (Id_propietario) REFERENCES propietario(Id_propietario)
);

-- TABLA INGRESO DE ANIMALES 
 CREATE TABLE ingreso_animal(
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    motivo_ingreso VARCHAR(200),
    fecha DATE NOT NULL,
    observacion TEXT,
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota)
);

-- TABLA TURNO
CREATE TABLE turno(
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    fecha_turno DATE NOT NULL,
    hora_turno TIME NOT NULL,
    programado BOOLEAN NOT NULL,   -- programado, no_programado
    asistio BOOLEAN, -- asistio, no_asistio
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota)
);

-- TABLA PERSONAL
CREATE TABLE personal(
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    email VARCHAR(100)
);

-- TABLA VETERINARIO
CREATE TABLE veterinario(
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    matricula VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    email VARCHAR(100)
);

-- TABLA CASTRACION
CREATE TABLE castracion(
    id_castracion INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT NOT NULL,
    id_veterinario INT NOT NULL,
    id_personal INT NOT NULL,      -- asistente
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    observacion TEXT,
    monto_pagado DECIMAL(10,2),
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

-- TABLA INGRESO$
CREATE TABLE ingresos_pesos(
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_castracion INT,
    tipo_ingreso VARCHAR(100),
    monto_ingreso DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_castracion) REFERENCES castracion(id_castracion)
);

-- TABLA PRODUCTO
CREATE TABLE producto(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_producto VARCHAR(100)
);

-- TABLA PROVEEDOR
CREATE TABLE proveedor(
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    tipo_servicio VARCHAR(50) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(30),
    direccion VARCHAR(150)
);

-- TABLA PAGO DE SERVICIO
CREATE TABLE pago_servicios(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    monto_servicio DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL
);

-- TABLA COMPRA
CREATE TABLE compra(
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_producto INT NOT NULL,
    monto_compra DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- TABLA VACUNACION
CREATE TABLE vacunacion(
    id_vacunacion INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    id_compra INT NOT NULL,        -- relaciona la vacuna con la compra de ese insumo
    fecha DATE NOT NULL,
    observacion TEXT,
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);