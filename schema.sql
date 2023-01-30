/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOL,
    weight_kg DECIMAL 
);

ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (owner_id) 
REFERENCES owners (id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vet_id INT REFERENCES vets (id),
    species_id INT REFERENCES species (id),
);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date DATE,
    vet_id INT REFERENCES vets (id),
    animals_id INT REFERENCES animals (id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animals_id_idx ON visits (animals_id);
CREATE INDEX vet_id_idx ON visits (vet_id);
CREATE INDEX owners_email_idx ON owners (email);