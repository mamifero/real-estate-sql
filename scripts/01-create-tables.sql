USE real_estate;

-- Países
CREATE TABLE Pais (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Provincias
CREATE TABLE Provincia (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT fk_provincia_pais
    FOREIGN KEY (id_pais)
    REFERENCES Pais(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Empresas
CREATE TABLE Empresa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Edificios
CREATE TABLE Edificio (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  id_provincia INT NOT NULL,
  pisos INT NOT NULL,
  ascensores INT NOT NULL,
  cocheras INT NOT NULL,
  categoria TINYINT NOT NULL,
  CONSTRAINT fk_edificio_provincia
    FOREIGN KEY (id_provincia)
    REFERENCES Provincia(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Oficinas
CREATE TABLE Oficina (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_edificio INT NOT NULL,
  mt2_cubiertos DECIMAL(10,2) NOT NULL,
  mt2_descubiertos DECIMAL(10,2) NOT NULL,
  tocadores INT NOT NULL,
  piso INT NOT NULL,
  id_propietario INT NOT NULL,
  CONSTRAINT fk_oficina_edificio
    FOREIGN KEY (id_edificio)
    REFERENCES Edificio(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_oficina_propietario
    FOREIGN KEY (id_propietario)
    REFERENCES Empresa(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Comodidades
CREATE TABLE Comodidades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Comodidades por Edificio (relación N–N)
CREATE TABLE ComodidadesEdificio (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_edificio INT NOT NULL,
  id_comodidad INT NOT NULL,
  CONSTRAINT fk_cek_edificio
    FOREIGN KEY (id_edificio)
    REFERENCES Edificio(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_cek_comodidad
    FOREIGN KEY (id_comodidad)
    REFERENCES Comodidades(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  UNIQUE KEY uq_edif_comod (id_edificio, id_comodidad)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Alquileres
CREATE TABLE Alquiler (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_inquilino INT NOT NULL,
  id_oficina INT NOT NULL,
  precio_usd DECIMAL(12,2) NOT NULL,
  inicio DATE NOT NULL,
  fin DATE NULL,
  CONSTRAINT fk_alquiler_inquilino
    FOREIGN KEY (id_inquilino)
    REFERENCES Empresa(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_alquiler_oficina
    FOREIGN KEY (id_oficina)
    REFERENCES Oficina(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
