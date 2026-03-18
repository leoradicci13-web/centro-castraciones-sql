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

INSERT INTO propietario(nombre,dni,direccion,localidad,telefono) 
VALUES
	('Juan Perez','30111222','Calle 1','Alta Gracia','351111111'),
	('Maria Gomez','28999111','Calle 2','Anisacate','351222222'),
	('Luis Diaz','31222333','Calle 3','Los talas','351333333'),
	('Ana Torres','29888777','Calle 4','Los chañiaritos','351444444'),
	('Pedro Ruiz','32222111','Calle 5','Alta Gracia','351555555'),
	('Laura Medina','33444555','Calle 6','Anisacate','351666666'),
	('Carlos Sosa','35555666','Calle 7','Alta Gracia','351777777'),
	('Lucia Rojas','36666777','Calle 8','Anisacate','351888888'),
	('Martin Lopez','37777888','Calle 9','Alta Gracia','351999999'),
	('Sofia Vega','38888999','Calle 10','Los talas','351101010');

INSERT INTO mascota(id_propietario,nombre,especie,raza,edad,sexo,peso,pelaje)
VALUES
	(1,'Firulais','Perro','Mestizo',3,'Macho',12.5,'Blanco'),
	(2,'Michi','Gato','Siames',2,'Hembra',4.2,'Marron'),
	(3,'Rex','Perro','Labrador',5,'Macho',25,'Blanco'),
	(4,'Luna','Gato','Persa',4,'Hembra',3.8,'Negro'),
	(5,'Toby','Perro','Caniche',6,'Macho',7,'Amarillo'),
	(6,'Nala','Gato','Mestizo',1,'Hembra',3,'Blanco'),
	(7,'Rocky','Perro','Boxer',4,'Macho',28,'Blanco'),
	(8,'Kira','Perro','Ovejero',2,'Hembra',20,'Negro'),
	(9,'Simba','Gato','Mestizo',3,'Macho',4,'Marron'),
	(10,'Lola','Perro','Beagle',5,'Hembra',15,'Blanco');
    
INSERT INTO adopcion(id_mascota,id_propietario,fecha,observacion)
VALUES
	(2,3,'2026-06-10','Adopcion responsable'),
	(4,5,'2026-06-11','Seguimiento en 30 dias'),
	(6,7,'2026-06-12','Adopcion aprobada'),
	(8,2,'2026-06-13','Animal recuperado'),
	(9,1,'2026-06-14','Sin observaciones'),
	(1,4,'2026-06-15','Adopcion responsable'),
	(3,6,'2026-06-16','Seguimiento'),
	(5,8,'2026-06-17','Adopcion aprobada'),
	(7,9,'2026-06-18','Sin problemas'),
	(10,10,'2026-06-19','Adopcion finalizada');

INSERT INTO ingreso_animal(id_mascota,motivo_ingreso,fecha,observacion)
VALUES
	(1,'Abandono','2026-05-20','Sin problemas'),
	(2,'Rescate','2026-05-21','Encontrado en la calle'),
	(3,'Rescate','2026-05-22','Sano'),
	(4,'Rescate','2026-05-23','Desnutrido'),
	(5,'Judicial','2026-05-24','Todo bien'),
	(6,'Rescate','2026-05-25','Herida leve'),
	(7,'Judicial','2026-05-26','Sano'),
	(8,'Rescate','2026-05-27','Recuperándose'),
	(9,'Abandono','2026-05-28','Sano'),
	(10,'Abandono','2026-05-29','Encontrado abandonado');    

INSERT INTO turno(id_mascota,fecha_turno,hora_turno,programado,asistio)
VALUES
	(1,'2026-06-01','09:00:00',1,1),
	(2,'2026-06-01','10:00:00',1,1),
	(3,'2026-06-01','11:00:00',1,1),
	(4,'2026-06-02','09:00:00',1,1),
	(5,'2026-06-02','10:00:00',1,1),
	(6,'2026-06-02','11:00:00',0,1),
	(7,'2026-06-03','09:00:00',1,0),
	(8,'2026-06-03','10:00:00',1,0),
	(9,'2026-06-03','11:00:00',1,1),
	(10,'2026-06-04','09:00:00',1,1);
    
INSERT INTO personal(nombre,rol,telefono,email)
VALUES
	('Carlos Medina','Asistente','351200001','carlos@centro.com'),
	('Ana Lopez','Asistente','351200002','ana@centro.com'),
	('Pedro Gomez','Administrativo','351200003','pedro@centro.com'),
	('Laura Diaz','Recepcion','351200004','laura@centro.com'),
	('Miguel Ruiz','Asistente','351200005','miguel@centro.com'),
	('Julia Perez','Recepcion','351200006','julia@centro.com'),
	('Lucas Torres','Administrativo','351200007','lucas@centro.com'),
	('Paula Sosa','Asistente','351200008','paula@centro.com'),
	('Mario Vega','Mantenimiento','351200009','mario@centro.com'),
	('Carla Rojas','Recepcion','351200010','carla@centro.com');
    
INSERT INTO veterinario(nombre,matricula,telefono,email)
VALUES
	('Dr. Fernandez','MAT001','351300001','vet1@centro.com'),
	('Dr. Alvarez','MAT002','351300002','vet2@centro.com'),
	('Dra. Lopez','MAT003','351300003','vet3@centro.com'),
	('Dr. Sosa','MAT004','351300004','vet4@centro.com'),
	('Dra. Medina','MAT005','351300005','vet5@centro.com'),
	('Dr. Ruiz','MAT006','351300006','vet6@centro.com'),
	('Dra. Torres','MAT007','351300007','vet7@centro.com'),
	('Dr. Vega','MAT008','351300008','vet8@centro.com'),
	('Dra. Rojas','MAT009','351300009','vet9@centro.com'),
	('Dr. Diaz','MAT010','351300010','vet10@centro.com');    

INSERT INTO castracion(id_turno,id_veterinario,id_personal,fecha,hora,observacion,monto_pagado)
VALUES
	(1,1,1,'2026-06-01','09:00:00','Sin complicaciones',15000),
	(2,2,2,'2026-06-01','10:00:00','Recuperacion normal',15000),
	(3,3,3,'2026-06-01','11:00:00','Todo correcto',15000),
	(4,1,4,'2026-06-02','09:00:00','Sin complicaciones',15000),
	(5,2,5,'2026-06-02','10:00:00','Todo bien',15000),
	(6,3,6,'2026-06-02','11:00:00','Animal nervioso',15000),
	(7,4,7,'2026-06-03','09:00:00','Sin problemas',15000),	
	(8,5,8,'2026-06-03','10:00:00','Todo normal',15000),
	(9,6,9,'2026-06-03','11:00:00','Recuperacion rapida',15000),
	(10,7,10,'2026-06-04','09:00:00','Sin observaciones',15000);

INSERT INTO ingresos_pesos(id_castracion,tipo_ingreso,monto_ingreso,fecha)
VALUES
	(1,'Castracion',15000,'2026-06-01'),
	(2,'Castracion',15000,'2026-06-01'),
	(3,'Castracion',15000,'2026-06-01'),
	(4,'Castracion',15000,'2026-06-02'),
	(5,'Castracion',15000,'2026-06-02'),
	(6,'Castracion',15000,'2026-06-02'),
	(7,'Castracion',15000,'2026-06-03'),
	(8,'Castracion',15000,'2026-06-03'),
	(9,'Castracion',15000,'2026-06-03'),
	(10,'Castracion',15000,'2026-06-04');

INSERT INTO producto(descripcion_producto)
VALUES
	('Vacuna antirrabica'),
	('Anestesia'),
	('Antibiotico'),
	('Gasas'),
	('Jeringas'),
	('Guantes'),
	('Suturas'),
	('Desinfectante'),
	('Alcohol'),
	('Vendajes');

INSERT INTO proveedor(tipo_servicio,nombre,telefono,direccion)
VALUES
	('Insumos','VetSupply','351400001','Cordoba'),
	('Insumos','AnimalMed','351400002','Cordoba'),
	('Medicamentos','Farmavet','351400003','Cordoba'),
	('Servicios','Limpieza SRL','351400004','Alta Gracia'),
	('Servicios','Electricidad AG','351400005','Alta Gracia'),
	('Insumos','Distribuidora Vet','351400006','Cordoba'),
	('Medicamentos','BioVet','351400007','Cordoba'),
	('Servicios','Agua y Gas','351400008','Alta Gracia'),
	('Insumos','VetPro','351400009','Cordoba'),
	('Medicamentos','PetMed','351400010','Cordoba');

INSERT INTO pago_servicios(id_proveedor,monto_servicio,fecha)
VALUES
	(4,20000,'2026-06-01'),
	(5,18000,'2026-06-01'),
	(8,15000,'2026-06-02'),
	(4,21000,'2026-06-02'),
	(5,17500,'2026-06-03'),
	(8,16000,'2026-06-03'),
	(4,22000,'2026-06-04'),
	(5,18000,'2026-06-04'),
	(8,17000,'2026-06-05'),
	(4,20000,'2026-06-05');

INSERT INTO compra(id_proveedor,id_producto,monto_compra,fecha)
VALUES
	(1,1,5000,'2026-06-01'),
	(2,2,7000,'2026-06-01'),
	(3,3,6000,'2026-06-02'),
	(1,4,2000,'2026-06-02'),
	(2,5,2500,'2026-06-03'),
	(3,6,3000,'2026-06-03'),
	(1,7,4000,'2026-06-04'),
	(2,8,3500,'2026-06-04'),
	(3,9,2000,'2026-06-05'),
	(1,10,1500,'2026-06-05');

INSERT INTO vacunacion(id_mascota,id_compra,fecha,observacion)
VALUES
	(1,1,'2026-06-02','Vacuna anual'),
	(2,1,'2026-06-02','Vacuna anual'),
	(3,1,'2026-06-02','Vacuna anual'),
	(4,1,'2026-06-03','Vacuna anual'),
	(5,1,'2026-06-03','Vacuna anual'),
	(6,1,'2026-06-04','Vacuna anual'),
	(7,1,'2026-06-04','Vacuna anual'),
	(8,1,'2026-06-04','Vacuna anual'),
	(9,1,'2026-06-05','Vacuna anual'),
	(10,1,'2026-06-05','Vacuna anual');
