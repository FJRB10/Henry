USE henry;

-- 1. ¿Cuantas carreas tiene Henry?

SELECT COUNT(nombre) FROM carrera;			-- Cuantas
SELECT nombre FROM carrera;					-- Cuales

-- 2. ¿Cuantos alumnos hay en total?

SELECT COUNT(idAlumno) FROM alumno;

-- 3. ¿Cuantos alumnos tiene cada cohorte?

SELECT idCohorte, COUNT(idAlumno) FROM alumno GROUP BY idCohorte;

/*
	4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, 
	con nombre y apellido en un solo campo.
*/

DROP VIEW alumnos_ultimos;

CREATE VIEW alumnos_ultimos AS
SELECT  CONCAT(nombre, " ", apellido) AS nombre_completo, fechaIngreso FROM alumno 
ORDER BY fechaIngreso DESC;

SELECT  CONCAT(nombre, " ", apellido) AS nombre_completo, fechaIngreso FROM alumno 
ORDER BY fechaIngreso DESC;

SELECT * FROM alumnos_ultimos;

-- 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?

SELECT nombre_completo FROM alumnos_ultimos ORDER BY fechaIngreso ASC LIMIT 1;
SELECT nombre FROM alumno ORDER BY fechaIngreso ASC LIMIT 1;

-- 6. ¿En que fecha ingreso?

SELECT fechaIngreso FROM alumnos_ultimos ORDER BY fechaIngreso ASC LIMIT 1;
SELECT fechaIngreso FROM alumno ORDER BY fechaIngreso ASC LIMIT 1;

-- 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

SELECT nombre_completo FROM alumnos_ultimos ORDER BY fechaIngreso DESC LIMIT 1;
SELECT nombre FROM alumno ORDER BY fechaIngreso DESC LIMIT 1;

/* 
	8. La función YEAR le permite extraer el año de un campo date, utilice esta función y 
    especifique cuantos alumnos ingresarona a Henry por año.
*/

SELECT YEAR(fechaIngreso) AS año, COUNT(idAlumno) AS cantidad_alumnos FROM alumno 
GROUP BY YEAR(fechaIngreso);


-- 	9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()

SELECT YEAR(fechaIngreso) AS año, WEEKOFYEAR(fechaIngreso) AS semana, COUNT(idAlumno) FROM alumno 
GROUP BY fechaIngreso ORDER BY año DESC, semana DESC;

-- 10. ¿En que años ingresaron más de 20 alumnos?

SELECT YEAR(fechaIngreso) AS año, COUNT(idAlumno) AS cantidad
FROM alumno GROUP BY año HAVING cantidad > 20
ORDER BY año;

/*
	11. Investigue las funciones TIMESTAMPDIFF() y CURDATE(). 
    ¿Podría utilizarlas para saber cual es la edad de los instructores?. 
    ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().
*/

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, 
TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) as años FROM instructor ORDER BY años DESC;

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, fechaNacimiento, 
DATE_ADD(CURDATE(), INTERVAL -TIMESTAMPDIFF(DAY, fechaNacimiento, CURDATE()) DAY) AS fechaCaluclada
FROM instructor ORDER BY fechaNacimiento ASC;

/* 
	12. Calcula:
		- La edad de cada alumno.
		- La edad promedio de los alumnos de henry.
		- La edad promedio de los alumnos de cada cohorte.
*/

-- idAlumno = 19
/* SELECT DATE(FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(fechaNacimiento)))) AS fechaPromedio 
FROM alumno WHERE idAlumno != 19; */

SELECT * FROM alumno WHERE idAlumno = 19;

UPDATE alumno SET fechaNacimiento = "2000-05-25"
WHERE idAlumno IN (19, 127);

DROP VIEW alumnos_anios;

CREATE VIEW alumnos_anios AS
SELECT idAlumno, cedulaIdentidad, nombre, apellido, fechaNacimiento, 
TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS anios, idCohorte
FROM alumno;

SELECT AVG(anios) FROM alumnos_anios;				-- 23.2667

SELECT * FROM alumnos_anios;

SELECT idCohorte, AVG(anios) FROM alumnos_anios GROUP BY idCohorte;

-- 13. Elabora un listado de los alumnos que superan la edad promedio de Henry.

SELECT nombre, apellido, fechaNacimiento, anios FROM alumnos_anios 
WHERE anios > 23.2667 ORDER BY anios DESC;