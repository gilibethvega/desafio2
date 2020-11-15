--1. Crear base de datos llamada películas (1 punto)
CREATE DATABASE peliculas;
\c peliculas
--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas. (2 puntos)
CREATE TABLE peliculastop100(
  id SMALLINT UNIQUE,
  pelicula_nombre VARCHAR(200),
  year_estreno SMALLINT,
  director VARCHAR(100),
  PRIMARY KEY (id)
);
CREATE TABLE reparto(
  id_actores SMALLINT,
  actor VARCHAR(100),
  FOREIGN KEY (id_actores) REFERENCES peliculastop100(id)
);
--3. Cargar ambos archivos a su tabla correspondiente (1 punto)
\copy peliculastop100 FROM './peliculas.csv' csv header;
\copy reparto FROM './reparto.csv' csv;
--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto. (0.5 puntos)
SELECT y.pelicula_nombre, y.year_estreno, y.director, x.actor 
FROM
  (SELECT actor, id_actores
  FROM reparto
  WHERE id_actores=2 
  ) as x
  INNER JOIN peliculastop100 AS y ON x.id_actores = y.id
  ;
--5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)
SELECT pelicula_nombre
FROM peliculastop100
WHERE id IN
  (SELECT id_actores
  FROM reparto
  WHERE actor='Harrison Ford'
  );
--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.(1 puntos)
SELECT director, count(*)
FROM peliculastop100
GROUP BY director
ORDER BY count DESC 
LIMIT 10;
-- 7. Indicar cuantos actores distintos hay (1 puntos)
SELECT COUNT(numero_de_actores) FROM (
  SELECT actor
  FROM reparto
  GROUP BY actor) 
  AS numero_de_actores;
--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.(1 punto)
SELECT pelicula_nombre
FROM peliculastop100
WHERE (year_estreno > 1989 AND year_estreno < 2000)
ORDER BY pelicula_nombre ASC;
--9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)
SELECT actor AS Reparto_Peliculas_2001
FROM reparto
WHERE id_actores IN (
  SELECT id
  FROM peliculastop100
  WHERE year_estreno = 2001
  );
--10. Listar los actores de la película más nueva (1 punto)
SELECT actor AS Reparto_Pelicula_Mas_Nueva
FROM reparto
WHERE id_actores IN (
  SELECT id
  FROM peliculastop100
  ORDER BY year_estreno DESC
  LIMIT 1
  );


