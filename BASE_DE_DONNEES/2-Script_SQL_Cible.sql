CREATE TABLE Dim_Nature(
   id_nature VARCHAR(255),
   nature_culture VARCHAR(255),
   nature_culture_speciale VARCHAR(255),
   PRIMARY KEY(id_nature)
);

CREATE TABLE Dim_Local(
   id_type_local INT,
   type_local VARCHAR(255),
   PRIMARY KEY(id_type_local)
);

CREATE TABLE Dim_Localisation (
   id_localisation VARCHAR2(255),
   code_departement VARCHAR2(15),
   commune VARCHAR2(50),
   latitude DECIMAL(20,10),
   longitude DECIMAL(20,10),
   PRIMARY KEY (id_localisation)
);

CREATE TABLE Dim_Mutation(
   id_mutation VARCHAR(255),
   numero_disposition INT,
   nature_mutation VARCHAR(255),
   PRIMARY KEY(id_mutation)
);

CREATE TABLE Dim_Date(
   id_date DATE,
   annee INT,
   trimestre INT,
   mois INT,
   nom_mois VARCHAR(50),
   jour INT,
   nom_jour VARCHAR(50),
   PRIMARY KEY(id_date)
);

CREATE TABLE Fait_Mutation_Parcelle(
   id_fait INT GENERATED ALWAYS AS IDENTITY,
   id_parcelle VARCHAR(255),
   valeur_fonciere DECIMAL(15,2),
   surface_terrain INT,
   surface_reelle_bati DECIMAL(15,2),
   nombre_pieces_principales INT,
   nombre_lots INT,
   id_type_local INT,
   id_nature VARCHAR(255),
   id_mutation VARCHAR(255),
   id_date DATE,
   id_localisation VARCHAR(255),
   PRIMARY KEY(id_fait),
   FOREIGN KEY(id_type_local) REFERENCES Dim_Local(id_type_local),
   FOREIGN KEY(id_nature) REFERENCES Dim_Nature(id_nature),
   FOREIGN KEY(id_mutation) REFERENCES Dim_Mutation(id_mutation),
   FOREIGN KEY(id_date) REFERENCES Dim_Date(id_date),
   FOREIGN KEY(id_localisation) REFERENCES Dim_Localisation(id_localisation)
);

SELECT
    p.id_parcelle,
    m.valeur_fonciere,
    ncp.surface_terrain,
    p.surface_reelle_bati,
    p.nombre_pieces_principales,
    p.nombre_lots,
    tp.code_type_local as id_type_local,
    ncp.id_nature,
    m.id_mutation,
    m.date_mutation as id_date,
    c.CODE_DEPARTEMENT || c.NOM_COMMUNE AS id_localisation
FROM Parcelle p
LEFT JOIN Mutation m
ON p.id_mutation = m.id_mutation
LEFT JOIN NatureCultureParcelle ncp
ON p.id_parcelle = ncp.id_parcelle AND p.id_mutation = ncp.id_mutation
LEFT JOIN TypeParcelle tp
ON p.id_parcelle = tp.id_parcelle AND p.id_mutation = tp.id_mutation
LEFT JOIN Adresse a
ON p.id_adresse = a.id_adresse
LEFT JOIN Commune c
ON a.code_commune = c.code_commune;