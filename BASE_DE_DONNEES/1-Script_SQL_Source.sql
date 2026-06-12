CREATE TABLE TypeLocal(
   code_type_local INT,
   type_local VARCHAR(255),
   PRIMARY KEY(code_type_local)
);

CREATE TABLE NatureCulture(
   id_nature VARCHAR(255),
   code_nature_culture VARCHAR(255) NOT NULL,
   nature_culture VARCHAR(255),
   code_nature_culture_speciale VARCHAR(255),
   nature_culture_speciale VARCHAR(255),
   PRIMARY KEY(id_nature)
);

CREATE TABLE Commune(
   code_commune VARCHAR(100),
   nom_commune VARCHAR(255),
   code_postal INT,
   ancien_code_commune VARCHAR(100),
   ancien_nom_commune VARCHAR(255),
   code_departement VARCHAR(15),
   PRIMARY KEY(code_commune)
);

CREATE TABLE Adresse(
   id_adresse VARCHAR(255),
   adresse_numero VARCHAR(255),
   adresse_suffixe VARCHAR(255),
   adresse_nom_voie VARCHAR(255),
   adresse_code_voie VARCHAR(255),
   latitude DECIMAL(20,10),
   longitude DECIMAL(20,10),
   code_commune VARCHAR(100),
   PRIMARY KEY(id_adresse),
   FOREIGN KEY(code_commune) REFERENCES Commune(code_commune)
);

CREATE TABLE Mutation(
   id_mutation VARCHAR(255),
   numero_disposition INT,
   nature_mutation VARCHAR(255),
   valeur_fonciere DECIMAL(15,2),
   date_mutation DATE,
   PRIMARY KEY(id_mutation)
);

CREATE TABLE Parcelle(
   id_parcelle VARCHAR(255),
   numero_volume VARCHAR(255),
   ancien_id_parcelle VARCHAR(255),
   nombre_lots INT,
   surface_reelle_bati DECIMAL(15,2),
   nombre_pieces_principales INT,
   id_adresse VARCHAR(255),
   id_mutation VARCHAR(255),
   PRIMARY KEY(id_parcelle, id_mutation),
   FOREIGN KEY(id_adresse) REFERENCES Adresse(id_adresse),
   FOREIGN KEY(id_mutation) REFERENCES Mutation(id_mutation)
);

CREATE TABLE TypeParcelle(
   id_parcelle VARCHAR2(255),
   id_mutation VARCHAR2(255),
   code_type_local INT,

   PRIMARY KEY(id_parcelle, id_mutation, code_type_local),

   FOREIGN KEY (id_parcelle, id_mutation)
      REFERENCES Parcelle(id_parcelle, id_mutation),

   FOREIGN KEY(code_type_local)
      REFERENCES TypeLocal(code_type_local)
);