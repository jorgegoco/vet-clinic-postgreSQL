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

/*How many animals are there?*/

SELECT COUNT(*) FROM animals;

/*How many animals have never tried to escape?*/

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/*What is the average weight of animals?*/

SELECT AVG(weight_kg) FROM animals;

/*Who escapes the most, neutered or not neutered animals?*/

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/

SELECT species, AVG(escape_attempts) FROM animals 
WHERE date_of_birth BETWEEN '01-01-1990' AND '12-31-2000' GROUP BY species;



/*What animals belong to Melody Pond?*/

SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon)*/

SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal*/

SELECT owners.full_name, animals.name FROM animals FULL JOIN owners ON animals.owner_id = owners.id;

/*How many animals are there per species?*/

SELECT species.name, COUNT(species.name) FROM animals FULL JOIN species ON animals.species_id = species.id GROUP BY species.name;

/*List all Digimon owned by Jennifer Orwell*/

SELECT animals.name FROM animals 
INNER JOIN species ON animals.species_id = species.id 
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape*/

SELECT animals.name FROM animals FULL JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/*Who owns the most animals?*/

SELECT owners.full_name, COUNT(animals.name) FROM animals FULL JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name
ORDER BY COUNT(animals.name) desc limit 1;







