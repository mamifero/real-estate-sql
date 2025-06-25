const { faker } = require('@faker-js/faker');
const fs = require('fs');
const path = require('path');

// Carpeta de salida
const outputDir = path.join(__dirname, 'sql');
if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir);

// Configuración de cantidad de registros
const NUM_PAISES = 1;
const NUM_PROV = 23;
const NUM_EMP = 500;
const NUM_ED = 20000;
const NUM_ALQ = 100000;

// Helper para escapar comillas simples
const esc = str => str.replace(/'/g, "''");

// Generar SQL y guardarlo en archivos separados

// 3) EMPRESAS
let empSQL = 'INSERT INTO Empresa (nombre) VALUES';
for (let i = 0; i < NUM_EMP; i++) {
  const nombre = esc(faker.company.name());
  empSQL += ` ('${nombre}')${i < NUM_EMP-1 ? ',' : ';'}`;
}
fs.writeFileSync(path.join(outputDir, 'empresa.sql'), empSQL + '\n');

// 4) EDIFICIOS
let edifSQL = 'INSERT INTO Edificio (id, nombre, direccion, ciudad, id_provincia, pisos, ascensores, cocheras, categoria) VALUES';
let pisos = [];
for (let i = 0; i < NUM_ED; i++) {
  const id = i + 1;
  const nombre = esc(`${faker.company.name()} Building`);
  const direccion = esc(faker.location.streetAddress());
  const ciudad = esc(faker.location.city());
  const idProv = faker.number.int({ min: 1, max: NUM_PROV });
  const piso = faker.number.int({ min: 1, max: 20 });
  const ascensores = faker.number.int({ min: 0, max: 6 });
  const cocheras = faker.number.int({ min: 0, max: 50 });
  const categoria = faker.number.int({ min: 1, max: 5 });
  pisos.push(piso);
  edifSQL += ` (${id},'${nombre}','${direccion}','${ciudad}',${idProv},${piso},${ascensores},${cocheras},${categoria})${i < NUM_ED-1 ? ',' : ';'}`;
}
fs.writeFileSync(path.join(outputDir, 'edificio.sql'), edifSQL + '\n');

// 5) OFICINAS
let numOficinas = 0;
let offSQL = 'INSERT INTO Oficina (id_edificio, mt2_cubiertos, mt2_descubiertos, tocadores, piso, id_propietario) VALUES';
for (let i = 0; i < NUM_ED; i++) {
    for (let j = 0; j < pisos[i]; j++) {
        for (let k = 0; k < faker.number.int({ min: 0, max: 3 }); k++) {
            numOficinas++;
            const idEdif = i + 1;
            const mt2Cub = faker.number.float({ min: 10, max: 200, precision: 0.01 });
            const mt2Desc = faker.number.float({ min: 0, max: 100, precision: 0.01 });
            const tocadores = faker.number.int({ min: 1, max: 5 });
            const piso = j + 1;
            const propietario = faker.number.int({ min: 1, max: NUM_EMP });
            offSQL += ` (${idEdif},${mt2Cub},${mt2Desc},${tocadores},${piso},${propietario}),`;
        }
    }
}
offSQL = offSQL.slice(0, -1) + ';';
fs.writeFileSync(path.join(outputDir, 'oficina.sql'), offSQL + '\n');


// 7) COMODIDADES_EDIFICIO
let ceSQL = 'INSERT INTO ComodidadesEdificio (id_edificio, id_comodidad) VALUES';
const pairs = [];
for (let edif = 1; edif <= NUM_ED; edif++) {
  const count = faker.number.int({ min: 1, max: 4 });
  const choices = faker.helpers.arrayElements(Array.from({length: 25}, (_, i) => i + 1), faker.number.int({min: 1, max: 10}));
  choices.forEach(idCom => pairs.push(`(${edif},${idCom})`));
}
ceSQL += pairs.join(',') + ';';
fs.writeFileSync(path.join(outputDir, 'comodidades_edificio.sql'), ceSQL + '\n');

// 8) ALQUILERES
let alqSQL = 'INSERT INTO Alquiler (id_inquilino, id_oficina, precio_usd, inicio, fin) VALUES';
for (let i = 0; i < NUM_ALQ; i++) {
  const inquilino = faker.number.int({ min: 1, max: NUM_EMP });
  const oficina = faker.number.int({ min: 1, max: numOficinas });
  const precio = faker.number.int({ min: 100, max: 5000, precision: 0.01 });
  const inicio = faker.date.between({ from: '2020-01-01T00:00:00.000Z', to: '2025-06-01T00:00:00.000Z' }).toISOString().split('T')[0];
  const finDate = faker.datatype.boolean() ? faker.date.between({ from: inicio, to: '2025-06-25T00:00:00.000Z' }).toISOString().split('T')[0] : null;
  alqSQL += ` (${inquilino},${oficina},${precio},'${inicio}',${finDate ? `'${finDate}'` : 'NULL'})${i < NUM_ALQ-1 ? ',' : ';'}`;
}
fs.writeFileSync(path.join(outputDir, 'alquiler.sql'), alqSQL + '\n');

console.log('Archivos SQL generados en carpeta:', outputDir);