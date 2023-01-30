/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '02-03-2020', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '11-15-2018', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '01-07-2021', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '05-12-2017', 5, TRUE, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '02-08-2020', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '11-15-2021', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '04-02-1993', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '06-12-2005', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '06-07-2005', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '10-13-1998', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '05-14-2022', 4, TRUE, 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '04-23-2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '01-17-2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '05-04-1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '06-08-2008');

INSERT INTO specializations (vet_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vet_id, species_id) VALUES (4, 2);

INSERT INTO visits (date, vet_id, animals_id) VALUES ('05-24-2020', 1, 1);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('07-22-2020', 3, 1);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('02-02-2021', 4, 2);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('01-05-2020', 2, 3);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('03-08-2020', 2, 3);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('05-14-2020', 2, 3);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('05-04-2021', 3, 4);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('02-24-2021', 4, 5);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('12-21-2019', 2, 6);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('08-10-2020', 1, 6);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('04-07-2021', 2, 6);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('09-29-2019', 3, 7);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('10-03-2020', 4, 8);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('11-04-2020', 4, 8);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('01-24-2019', 2, 9);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('05-15-2019', 2, 9);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('02-27-2020', 2, 9);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('08-03-2020', 2, 9);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('05-24-2020', 3, 10);
INSERT INTO visits (date, vet_id, animals_id) VALUES ('01-11-2021', 1, 10);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vet_id, date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
