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


/*Who was the last animal seen by William Tatcher?*/

SELECT animals.name FROM animals JOIN visits ON visits.animals_id = animals.id 
WHERE visits.date = (SELECT MAX(date) FROM visits JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'William Tatcher');

/*How many different animals did Stephanie Mendez see?*/

SELECT COUNT(DISTINCT animals.name) FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez';

/*List all vets and their specialties, including vets with no specialties*/

SELECT vets.name, species.name FROM vets
FULL JOIN specializations ON specializations.vet_id = vets.id
FULL JOIN species ON species.id = specializations.species_id;

/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020*/

SELECT animals.name FROM animals JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez'
AND visits.date BETWEEN '04-01-2020' AND '08-30-2020';

/*What animal has the most visits to vets?*/

SELECT animals.name, COUNT(animals.name) FROM animals JOIN visits ON visits.animals_id = animals.id 
GROUP BY animals.name ORDER BY COUNT(animals.name) desc limit 1;

/*Who was Maisy Smith's first visit?*/

SELECT animals.name FROM animals JOIN visits ON visits.animals_id = animals.id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date asc limit 1;

/*Details for most recent visit: animal information, vet information, and date of visit*/

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
vets.name AS vet, vets.age AS vet_age, vets.date_of_graduation AS vet_date_of_graduation, visits.date AS visit_date
FROM animals JOIN visits ON visits.animals_id = animals.id 
JOIN vets ON vets.id = visits.vet_id ORDER BY visits.date desc limit 1;

/*How many visits were with a vet that did not specialize in that animal's species?

SELECT visits.animals_id, animals.species_id, vets.name, specializations.species_id FROM visits FULL JOIN animals ON animals.id = visits.animals_id 
FULL JOIN vets ON vets.id = visits.vet_id FULL JOIN specializations ON specializations.vet_id = vets.id WHERE animals.species_id != specializations.species_id OR specializations.species_id IS NULL;*/

SELECT COUNT(*) FROM visits FULL JOIN animals ON animals.id = visits.animals_id 
FULL JOIN vets ON vets.id = visits.vet_id FULL JOIN specializations ON specializations.vet_id = vets.id WHERE animals.species_id != specializations.species_id OR specializations.species_id IS NULL;

/*What specialty should Maisy Smith consider getting? Look for the species she gets the most*/

SELECT name FROM species WHERE id = (SELECT animals.species_id FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animals_id 
WHERE vets.name = 'Maisy Smith' GROUP BY animals.species_id ORDER BY COUNT(animals.species_id) desc limit 1);

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
