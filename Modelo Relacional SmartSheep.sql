CREATE TYPE "tipo_de_usuario" AS ENUM (
  'Cliente',
  'Administrador',
  'Veterinario',
  'Trabajador'
);

CREATE TYPE "genero_oveja" AS ENUM (
  'Hembra',
  'Macho'
);

CREATE TYPE "si_no" AS ENUM (
  'Si',
  'No'
);

CREATE TABLE "Usuarios" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "telefono" text,
  "email" text,
  "nombre" text NOT NULL,
  "apellido" text NOT NULL,
  "clave" text NOT NULL,
  "rut" varchar UNIQUE NOT NULL,
  "tipo_de_usuario" tipo_de_usuario,
  "fecha_creacion" timestamp DEFAULT (now())
);

CREATE TABLE "Predio" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "latitud" float8,
  "longitud" float8,
  "nombre_predio" varchar,
  "fecha_creacion" timestamp DEFAULT (now())
);

CREATE TABLE "Usuarios_Predios" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "id_predio" int,
  "id_usuario" int,
  "puede_crear_predios" si_no DEFAULT 'No',
  "puede_crear_ovejas" si_no DEFAULT 'No',
  "puede_crear_usuarios" si_no DEFAULT 'No'
);

CREATE TABLE "Oveja" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "id_predio" int NOT NULL,
  "arete" int NOT NULL,
  "genero" genero_oveja,
  "raza" varchar,
  "categoria" text,
  "merito" int DEFAULT 0,
  "esta_muerta" si_no DEFAULT 'No',
  "fecha_creacion" timestamp DEFAULT (now())
);

CREATE TABLE "Filiacion" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "id_madre" int,
  "id_padre" int,
  "id_hijo" int,
  "tipo_encaste" text,
  "fecha_encaste" date,
  "fecha_nacimiento" date,
  "peso_nacimiento" float4
);

CREATE TABLE "Sanitario" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "id_oveja" int NOT NULL,
  "enfermedad" text,
  "tratamiento" text,
  "fecha_creacion" timestamp DEFAULT (now())
);

ALTER TABLE "Usuarios_Predios" ADD FOREIGN KEY ("id_predio") REFERENCES "Predio" ("id");

ALTER TABLE "Usuarios_Predios" ADD FOREIGN KEY ("id_usuario") REFERENCES "Usuarios" ("id");

ALTER TABLE "Oveja" ADD FOREIGN KEY ("id_predio") REFERENCES "Predio" ("id");

ALTER TABLE "Filiacion" ADD FOREIGN KEY ("id_madre") REFERENCES "Oveja" ("id");

ALTER TABLE "Filiacion" ADD FOREIGN KEY ("id_padre") REFERENCES "Oveja" ("id");

ALTER TABLE "Filiacion" ADD FOREIGN KEY ("id_hijo") REFERENCES "Oveja" ("id");

ALTER TABLE "Sanitario" ADD FOREIGN KEY ("id_oveja") REFERENCES "Oveja" ("id");
