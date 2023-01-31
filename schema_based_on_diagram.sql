CREATE DATABASE clinic;

CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR,
  date_of_birth DATE,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR,
  PRIMARY KEY(id),
  FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR,
  name VARCHAR,
  PRIMARY KEY(id)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history__id INT,
  PRIMARY KEY(id)
  FOREIGN KEY(medical_history__id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id)
  FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments(
   treatments_id INT,
   medical_histories_id INT,
   PRIMARY KEY (treatments_id, medical_histories_id),
   FOREIGN KEY (treatments_id) REFERENCES treatments(id),
   FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id) 
);

CREATE INDEX patients_idx ON patients(name);
CREATE INDEX medical_histories_idx ON medical_histories(patient_id);
CREATE INDEX invoices_idx ON invoices(medical_history__id);
CREATE INDEX invoice_items_idx ON invoice_items(invoice_id);
CREATE INDEX invoice_items_idx2 ON invoice_items(treatment_id);
CREATE INDEX treatments_idx ON treatments(name);
CREATE INDEX medical_histories_treatments_idx ON medical_histories_treatments(treatments_id); 
CREATE INDEX medical_histories_treatments_idx2 ON medical_histories_treatment(medical_histories_id);