/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';

SELECT name FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered IS TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Transaction update one table column and rollback*/

BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK;

/*Transaction update one table column and commit*/

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

/*Transaction update of all records in a table and rollback*/

BEGIN;
DELETE FROM animals;
ROLLBACK;

/*Transaction update and delete with savepoint, rollback, and commit in a table*/

BEGIN;
DELETE FROM animals WHERE date_of_birth >= '01-01-2022';
SAVEPOINT first_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT first_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;



