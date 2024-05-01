
CREATE DATABASE henry;

-- Acceder a la base de datos

USE henry;

CREATE TABLE carrera (
	idCarrera INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR (50) NOT NULL,
    PRIMARY KEY (idCarrera)
);

SELECT * FROM carrera;
SELECT * FROM henry.carrera;

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cedulaIdentidad VARCHAR (30) NOT NULL,
    nombre VARCHAR (40),
    apellido VARCHAR (40),
    fechaNacimiento DATE NOT NULL,
    fechaIncorporación DATE
);

-- Describir una tabla (y creo que ordenarlo)
DESC instructor;

CREATE TABLE cohorte (
	idCohorte INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR (30) NOT NULL,
    idCarrera INT NOT NULL,
    idInstructor INT NOT NULL,
    fechaInicio DATE,
    fechaFinalizacion DATE,
    PRIMARY KEY (idCohorte),
    FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera),
    FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor)    
);

CREATE TABLE alumno (
	idAlumno INT NOT NULL AUTO_INCREMENT,
    cedulaIdentidad VARCHAR (30) NOT NULL,
    nombre VARCHAR (40) NOT NULL,
    apellido VARCHAR (40) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fechaIngreso DATE,
    PRIMARY KEY (idAlumno),
    FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte)
);