# Consulta inicial
 SELECT id, nombre, direccion, ciudad, id_provincia, pisos, ascensores, cocheras, categoria
    FROM Edificio
    WHERE Edificio.categoria = 1;
 
 # Alquileres sin vencimiento
 SELECT * FROM Alquiler a WHERE a.fin IS NULL;
 
 # Edificios en una provincia
 SELECT * FROM Edificio e WHERE e.id_provincia = 1;
 
 # Oficinas pequeñas de pocos metros cuadrados
 SELECT * FROM Oficina o WHERE o.mt2_cubiertos < 25;
 
 # Listamos las  comodidades
 SELECT * FROM Comodidades c ;
 # Oficinas por Edificio
 SELECT COUNT(1) c, o.id_edificio FROM Oficina o GROUP BY o.id_edificio;
 
 # Metros Cuadrados por Edificio
 SELECT SUM(o.mt2_cubiertos ) m2, o.id_edificio FROM Oficina o GROUP BY o.id_edificio;

 # Tamaño promedio de Oficina
  SELECT AVG(o.mt2_cubiertos ) m2, o.id_edificio FROM Oficina o GROUP BY o.id_edificio;

 # Propietarios dentro de un edificio
 SELECT e.nombre propietario, o.* FROM Oficina o 
 INNER JOIN Empresa e ON o.id_propietario = e.id
 WHERE o.id_edificio = 54;
 
 # Comodidades de un edificio
 SELECT c.nombre comodidad, e.nombre, e.id FROM Edificio e 
 INNER JOIN ComodidadesEdificio ce ON ce.id_edificio = e.id
 INNER JOIN Comodidades c ON c.id = ce.id_comodidad
 WHERE e.id = 54;
 
 # Inquilinos dentro de un edificio
 SELECT e2.nombre inquilino, o.piso, e.nombre edificio  FROM Edificio e 
 INNER JOIN Oficina o ON o.id_edificio = e.id
 INNER JOIN Alquiler a ON o.id = a.id_oficina
 INNER JOIN Empresa e2 ON a.id_inquilino = e2.id
 WHERE e.id = 54;
 
 # Costo promedio de m2 por provincia
 SELECT AVG(a.precio_usd / o.mt2_cubiertos), p.nombre FROM Edificio e 
 INNER JOIN Oficina o ON o.id_edificio = e.id
 INNER JOIN Alquiler a ON o.id = a.id_oficina
 INNER JOIN Provincia p  ON p.id = e.id_provincia
 GROUP BY p.id;
 
 # Edificios mas grandes de una provincia
 SELECT p.nombre, m2 FROM Provincia p INNER JOIN (
SELECT MAX(m2max.m2) m2, m2max.id_provincia  FROM  (
 SELECT SUM(o.mt2_cubiertos )m2, e.id, e.id_provincia FROM Edificio e 
 INNER JOIN Oficina o ON e.id = o.id_edificio
GROUP BY e.id, e.id_provincia) m2max GROUP BY id_provincia) m ON m.id_provincia = p.id; 
 # Dueños que tambien son inquilinos
 SELECT e.nombre, e.id FROM Oficina o
 INNER JOIN Alquiler a ON o.id = a.id_oficina
 INNER JOIN Empresa e ON e.id = o.id_propietario
 WHERE a.id_inquilino = o.id_propietario;
 
 # https://gamma.app/docs/Aprende-a-pensar-en-SQL-j3p8o6rkpq5935a?mode=doc
