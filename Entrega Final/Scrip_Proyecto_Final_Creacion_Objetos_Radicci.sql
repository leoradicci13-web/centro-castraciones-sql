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

-- TABLA INGRESOS_PESOS
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

USE centro_castracion;

-- VISTA_TURNOS_MASCOTAS
CREATE VIEW vista_turnos_mascota AS 
SELECT
    t.id_turno,
    t.fecha_turno,
    t.hora_turno,
    t.programado,
    m.nombre AS nombre_mascota,
    m.especie,
    m.sexo,
    p.nombre AS nombre_propietario,
    p.telefono
FROM turno t
JOIN mascota m ON t.id_mascota = m.id_mascota
JOIN propietario p ON m.id_propietario = p.id_propietario;

-- VISTA_CASTRACIONES_REALIZADAS
CREATE VIEW vista_castraciones_realizadas AS
SELECT
    c.id_castracion,
    c.fecha,
    c.hora,
    m.id_mascota,
    m.nombre AS mascota,
    m.sexo,
    v.id_veterinario,
    v.nombre AS veterinario,
    per.id_personal,
    per.nombre AS asistente,
    per.rol,
    c.observacion
FROM castracion c
JOIN turno t ON c.id_turno = t.id_turno
JOIN mascota m ON t.id_mascota = m.id_mascota
JOIN veterinario v ON c.id_veterinario = v.id_veterinario
JOIN personal per ON c.id_personal = per.id_personal;

-- VISTA_BALANCE_MENSUAL
CREATE VIEW vista_balance_mensual AS
SELECT 
    YEAR(fecha) AS anio,
    MONTH(fecha) AS mes,
    SUM(ingresos) AS total_ingresos,
    SUM(egresos) AS total_egresos,
    SUM(ingresos) - SUM(egresos) AS balance
FROM (
	SELECT 
        fecha,
        monto_ingreso AS ingresos,
        0 AS egresos
    FROM ingresos_pesos
    
    UNION ALL
    
    SELECT 
        fecha,
        0 AS ingresos,
        monto_servicio AS egresos
    FROM pago_servicios
    
    UNION ALL
    
    SELECT 
        fecha,
        0 AS ingresos,
        monto_compra AS egresos
    FROM compra
    
) movimientos

GROUP BY anio, mes;

-- FUNCION_TOTAL_INGRESOS_MES
DELIMITER //

CREATE FUNCTION total_ingresos_mes(p_mes INT, p_anio INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE total DECIMAL(10,2);

    SELECT SUM(monto_ingreso)
    INTO total
    FROM ingresos_pesos
    WHERE MONTH(fecha) = p_mes
    AND YEAR(fecha) = p_anio;

    RETURN IFNULL(total,0);

END //

DELIMITER ;

-- FUNCION_TOAL_CASTRACIONES_MES_SEXO
DELIMITER //

CREATE FUNCTION total_castraciones_mes_sexo(p_mes INT, p_anio INT, p_sexo VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM castracion c
    JOIN turno t ON c.id_turno = t.id_turno
    JOIN mascota m ON t.id_mascota = m.id_mascota
    WHERE MONTH(c.fecha) = p_mes
    AND YEAR(c.fecha) = p_anio
    AND m.sexo = p_sexo;

    RETURN IFNULL(total,0);

END //

DELIMITER ;

-- PROCEDIMIENTO_REGISTRAR_TURNO
DELIMITER //

CREATE PROCEDURE registrar_turno(
    IN p_id_mascota INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_programado BOOLEAN
)
BEGIN

INSERT INTO turno(
    id_mascota,
    fecha_turno,
    hora_turno,
    programado
)
VALUES(
    p_id_mascota,
    p_fecha,
    p_hora,
    p_programado
);

END //

DELIMITER ;

-- PROCEDIMIENTO_REGISTRAR_CASTRACIONES
DELIMITER //

CREATE PROCEDURE registrar_castracion(
    IN p_id_turno INT,
    IN p_id_veterinario INT,
    IN p_id_personal INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_observacion TEXT,
    IN p_monto DECIMAL(10,2)
)
BEGIN

DECLARE v_id_castracion INT;

-- insertar castracion
INSERT INTO castracion(
    id_turno,
    id_veterinario,
    id_personal,
    fecha,
    hora,
    observacion,
    monto_pagado
)
VALUES(
    p_id_turno,
    p_id_veterinario,
    p_id_personal,
    p_fecha,
    p_hora,
    p_observacion,
    p_monto
);

-- obtener id generado
SET v_id_castracion = LAST_INSERT_ID();

-- registrar ingreso
INSERT INTO ingresos(
    id_castracion,
    tipo_ingreso,
    monto_ingreso,
    fecha
)
VALUES(
    v_id_castracion,
    'Castracion',
    p_monto,
    p_fecha
);

END //

DELIMITER ;

-- TIGGER_VALIDAR_PROVEEDOR_PAGO
DELIMITER //

CREATE TRIGGER validar_proveedor_pago
BEFORE INSERT ON pago_servicios
FOR EACH ROW
BEGIN

IF NOT EXISTS (
    SELECT 1
    FROM proveedor
    WHERE id_proveedor = NEW.id_proveedor
) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El proveedor no existe. Debe registrarse previamente.';

END IF;

END //

DELIMITER ;

-- TIGGER_VALIDAR_TURNO_HORARIO
DELIMITER //

CREATE TRIGGER validar_turno_horario
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN

IF EXISTS (
    SELECT 1
    FROM turno
    WHERE fecha_turno = NEW.fecha_turno
    AND hora_turno = NEW.hora_turno
) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Ya existe un turno asignado para esa fecha y hora';

END IF;

END //

DELIMITER ;