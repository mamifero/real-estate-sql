USE real_estate;

-- 1) Insertar país
INSERT INTO Pais (id, nombre) VALUES
(1, 'Argentina');

-- 2) Insertar provincias de Argentina
INSERT INTO Provincia (nombre, id_pais) VALUES
('Ciudad Autónoma de Buenos Aires',                         1),
('Buenos Aires',                                            1),
('Catamarca',                                               1),
('Chaco',                                                   1),
('Chubut',                                                  1),
('Córdoba',                                                 1),
('Corrientes',                                              1),
('Entre Ríos',                                              1),
('Formosa',                                                 1),
('Jujuy',                                                   1),
('La Pampa',                                                1),
('La Rioja',                                                1),
('Mendoza',                                                 1),
('Misiones',                                                1),
('Neuquén',                                                 1),
('Río Negro',                                               1),
('Salta',                                                   1),
('San Juan',                                                1),
('San Luis',                                                1),
('Santa Cruz',                                              1),
('Santa Fe',                                                1),
('Santiago del Estero',                                     1),
('Tierra del Fuego, Antártida e Islas del Atlántico Sur',   1),
('Tucumán',                                                 1);

-- 3) Insertar comodidades
INSERT INTO Comodidades (nombre) VALUES
('Acceso 24/7'),
('WiFi de alta velocidad'),
('Cafetería interna'),
('Gimnasio'),
('Estacionamiento'),
('Recepción y vigilancia'),
('Control de acceso por huella'),
('Sala de reuniones'),
('Auditorio'),
('Business Center'),
('Coworking'),
('Terraza'),
('Patio interno'),
('Jardines'),
('Climatización central'),
('Calefacción central'),
('Sistema contra incendios'),
('Generador eléctrico'),
('Backup de agua'),
('Ascensores inteligentes'),
('Rampas y accesibilidad'),
('Baños en cada piso'),
('Lockers personales'),
('Sala de lactancia'),
('Vestuario y duchas');
