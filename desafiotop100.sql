--1. Crear base de datos llamada películas (1 punto)
CREATE DATABASE peliculas;
\c peliculas
--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas. (2 puntos)
CREATE TABLE peliculastop100(
  id SMALLINT UNIQUE;
  pelicula_nombre VARCHAR(200);
  year_estreno SMALLINT,
  director VARCHAR(100),
  PRIMARY KEY (id)
);
CREATE TABLE reparto(
  id_actores SMALLINT,
  actor VARCHAR(100),
  FOREIGN KEY (id_actores) peliculastop100(id)
);
--3. Cargar ambos archivos a su tabla correspondiente (1 punto)
\copy peliculastop100 TO 'peliculas.csv' csv header;
\copy reparto TO 'reparto.csv' csv;
--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto. (0.5 puntos)
