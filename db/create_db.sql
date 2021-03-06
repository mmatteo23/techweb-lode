SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS prenotazione_scheda;
DROP TABLE IF EXISTS esercizio_scheda;
DROP TABLE IF EXISTS prenotazione_sessione;
DROP TABLE IF EXISTS iscrizione_corso;
DROP TABLE IF EXISTS scheda;
DROP TABLE IF EXISTS ruolo;
DROP TABLE IF EXISTS corso;
DROP TABLE IF EXISTS utente;
DROP TABLE IF EXISTS esercizio;
DROP TABLE IF EXISTS categoria;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE ruolo (
	id int,
	descrizione varchar(100),

	PRIMARY KEY (id)
);

CREATE TABLE utente (
	id int NOT NULL,
	nome varchar(200) NOT NULL,
	cognome varchar(200) NOT NULL,
	email varchar(255) NOT NULL UNIQUE,
	data_nascita date NOT NULL,
	password varchar(255) NOT NULL,
	telefono varchar(10),
	sesso char NOT NULL,
	foto_profilo varchar(255),
	ruolo int NOT NULL,
	altezza int,
	peso int,

	PRIMARY KEY (id)
);

CREATE TABLE scheda (
	id int NOT NULL AUTO_INCREMENT,
	data date NOT NULL,
	cliente int NOT NULL,
	trainer int NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (cliente) REFERENCES utente(id) ON DELETE CASCADE,
	FOREIGN KEY (trainer) REFERENCES utente(id)
);

CREATE TABLE prenotazione_scheda (
	id 				int AUTO_INCREMENT,
	cliente			int NOT NULL,
	trainer			int NOT NULL,
	data 			datetime NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (cliente) REFERENCES utente(id) ON DELETE CASCADE,
	FOREIGN KEY (trainer) REFERENCES utente(id)
);

CREATE TABLE categoria (
	id int NOT NULL AUTO_INCREMENT,
	descrizione varchar(200) NOT NULL,

	PRIMARY KEY (id)
);

CREATE TABLE esercizio (
	id int NOT NULL AUTO_INCREMENT,
	nome varchar(200) NOT NULL,
	categoria int NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (categoria) REFERENCES categoria(id)
);

CREATE TABLE esercizio_scheda (
  id int PRIMARY KEY AUTO_INCREMENT,
	scheda int NOT NULL,
	esercizio int NOT NULL,
	serie int NOT NULL,
	ripetizioni int NOT NULL,
	riposo int NOT NULL,
	/*foto_esercizio varchar(255) NOT NULL,*/

	FOREIGN KEY (esercizio) REFERENCES esercizio(id),
  FOREIGN KEY (scheda) REFERENCES scheda(id) ON DELETE CASCADE
);

CREATE TABLE prenotazione_sessione (
	id int AUTO_INCREMENT,
	data date NOT NULL,
	ora_inizio time NOT NULL,
	ora_fine time NOT NULL,
	cliente int NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (cliente) REFERENCES utente(id) ON DELETE CASCADE
);

CREATE TABLE corso (
	id int,
	titolo varchar(200) NOT NULL,
	descrizione varchar(255) NOT NULL,
	data_inizio date NOT NULL,
	data_fine date NOT NULL,
	copertina varchar(255),
  alt_copertina varchar(255),
	trainer int NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (trainer) REFERENCES utente(id)
);

CREATE TABLE iscrizione_corso (
	cliente int,
	corso int,

	PRIMARY KEY (cliente, corso),
	FOREIGN KEY (cliente) REFERENCES utente(id) ON DELETE CASCADE,
	FOREIGN KEY (corso) REFERENCES corso(id) ON DELETE CASCADE
);

INSERT INTO ruolo (id, descrizione)
VALUES (1, 'Amministratore'), (2, 'Trainer'), (3, 'Cliente');

INSERT INTO utente (
    id,
    nome,
    cognome,
    email,
    data_nascita,
    password,
    telefono,
    sesso,
    foto_profilo,
    ruolo,
    altezza,
    peso)
VALUES 
(
    1,
    'Alberto',
    'Danieletto',
    'alberto.danieletto@fda.it',
    '2000-11-03',
    'alberto',
    '3456789789',
    'M',
    NULL,
    2,
    177,
    70
),
(
    2,
    'Selly',
    'Scheggia',
    'selly.scheggia@fda.it',
    '2000-07-15',
    'selly',
    '3859689456',
    'F',
    NULL,
    2,
    165,
    65
),
(
    3,
    'Danilo',
    'Stojkovic',
    'ds@ds.it',
    '2000-09-20',
    'pass',
    '3333333333',
    'M',
    NULL,
    3,
    185,
    68
),
(
    4,
    'Matteo',
    'Casonato',
    'matteo@casonato.com',
    '2000-08-08',
    'admin',
    '3923240890',
    'M',
    NULL,
    1,
    186,
    78
),
(
    5,
    'Mattia',
    'Quasinato',
    'mattia@quasinato.com',
    '2001-08-08',
    'admin',
    '3923240890',
    'M',
    NULL,
    3,
    186,
    78
),
(
    6,
    'admin',
    'admin',
    'admin',
    '2000-01-01',
    'admin',
    '3111111111',
    'M',
    NULL,
    1,
    200,
    100
),
(
    7,
    'trainer',
    'trainer',
    'trainer',
    '2000-02-02',
    'trainer',
    '3222222222',
    'F',
    NULL,
    2,
    160,
    55
),
(
    8,
    'client',
    'client',
    'client',
    '2000-03-03',
    'client',
    '3333333333',
    'M',
    NULL,
    3,
    180,
    70
);

INSERT INTO corso (
    id,
    titolo,
    descrizione,
    data_inizio,
    data_fine,
    trainer,
    copertina,
    alt_copertina
  )
VALUES (
    1,
    '<span xml:lang="en" lang="en">Total Body</span>',
    'Allenamento di tutto il corpo con poche pause',
    '2022-01-02',
    '2022-12-02',
    7,
    '1.jpg',
    'Due persone in posizione squat con un peso in mano'
  ),
  (
    2,
    '<span xml:lang="en" lang="en">ZumbaFit</span>',
    'Allenamento <span xml:lang="en" lang="en">Full Body</span> a passi di Zumba per tutte le et&agrave;',
    '2022-01-02',
    '2022-12-02',
    7,
    '2.jpg',
    'Ragazze che fanno esercizi di Zumba'
  ),
  (
    3,
    '<span xml:lang="en" lang="en">Spinning</span>',
    'Allenamento con <span xml:lang="fr" lang="fr">cyclette</span> professionali <span xml:lang="en" lang="en">Technogym</span>',
    '2022-01-02',
    '2022-12-02',
    7,
    '3.jpg',
    'Il nostro set di spin bike'
  ),
  (
    4,
    '<span xml:lang="en" lang="en">Break Ass</span>',
    'Allenamento che allena tutto il corpo usando pause piccole e ritmi di ripetizioni alte. Riuscirai a resistere?',
    '2022-01-02',
    '2022-12-02',
    7,
    NULL,
    "Immagine del corso di default con il logo del sito, teschio con dietro due bilancieri incrociati e acronimo FDA"
  ),
  (
    5,
    '<span xml:lang="en" lang="en">Calisthenics</span>',
    'Allenamento a corpo libero. Qui userai solo il tuo corpo, niente pesi e macchinari. Dovrai imparare a controllare il tuo baricentro e il respiro',
    '2022-06-23',
    '2022-12-23',
    2,
    '5.png',
    'Un uomo che fa la bandiera su un palo a petto nudo'
  ),
  (
    6,
    '<span xml:lang="en" lang="en">Six Pack</span>',
    'Corso basato su pause corte con lo scopo di colpire la parte addominale del tuo corpo. Alla fine del percorso sarai pronto per la prova costume',
    '2022-06-23',
    '2022-12-23',
    2,
    '6.png',
    'Donna distesa a terra con top nero che fa gli addominali'
  ),
  (
    7,
    '<span xml:lang="en" lang="en">Fit Boxe</span>',
    'Vieni a sfogarti su i nostri sacchi e impara a difenderti a ritmo di musica. La nostra istruttrice ti guider&agrave; per tutto l''allenamento',
    '2022-06-23',
    '2022-12-23',
    2,
    '7.jpg',
    'Donna che segue il corso di fronte all&#39;istruttore con top e guantini neri'
  );

INSERT INTO categoria(descrizione) 
VALUES 
('addominali'), 
('petto'), 
('spalla'), 
('cardio'), 
('gambe'), 
('braccia'), 
('glutei'),
('<span xml:lang="en" lang="en">stretching</span>');

INSERT INTO esercizio(nome, categoria) 
VALUES 
('<span xml:lang="en" lang="en">Plank</span>', 1), 
('<span xml:lang="en" lang="en">Crunch</span>', 1), 
('Trazioni', 2), 
('Pressa spalla', 3), 
('<span xml:lang="fr" lang="fr">Tapis roulant</span>', 4), 
('Quadricipiti', 5), 
('Salto corda', 5), 
('Manubri', 6), 
('Affondi', 5), 
('<span xml:lang="en" lang="en">Squat</span>', 7), 
('<span xml:lang="fr" lang="fr">Cyclette</span>', 4), 
('<span xml:lang="en" lang="en">Curl</span> bilancere', 6), 
('Panca piana', 6), 
('<span xml:lang="en" lang="en">Plank</span> laterale', 1), 
('<span xml:lang="en" lang="en">Stretching</span> gambe', 8);

INSERT INTO  scheda(data, cliente, trainer) VALUES 
("2022-04-26", 3, 1),
("2022-06-17", 8, 7);

INSERT INTO esercizio_scheda(scheda, esercizio, serie, ripetizioni, riposo) VALUES
(1, 3, 3, 10, 0),
(1, 1, 4, 15, 0),
(1, 7, 10, 1, 60),
(1, 12, 3, 7, 0),
(1, 13, 2, 1, 0),
(1, 10, 3, 3, 0),
(1, 5, 4, 5, 60),
(1, 9, 5, 5, 0),
(1, 2, 3, 20, 0),

(2, 4, 3, 20, 30),
(2, 1, 4, 10, 60),
(2, 11, 5, 5, 30),
(2, 8, 3, 15, 45),
(2, 5, 4, 20, 60),
(2, 12, 5, 10, 45),
(2, 6, 3, 20, 60),
(2, 9, 4, 10, 30),
(2, 10, 5, 15, 45);

INSERT INTO iscrizione_corso VALUES 
(8, 3),
(8, 6),
(8, 2),
(8, 4);

INSERT INTO prenotazione_sessione (data, ora_inizio, ora_fine, cliente) VALUES

("2022-06-17", "14:30", "15:00", 8),
("2022-06-17", "14:30", "15:00", 5),
("2022-06-17", "14:30", "15:00", 3),

("2022-06-18", "14:30", "15:00", 8),
("2022-06-18", "14:30", "15:00", 5),
("2022-06-18", "14:30", "15:00", 3),

("2022-06-18", "19:30", "20:30", 8),
("2022-06-18", "19:30", "20:30", 5),
("2022-06-18", "19:30", "20:30", 3),

("2022-06-20", "14:30", "15:00", 8),
("2022-06-20", "14:30", "15:00", 5),
("2022-06-20", "14:30", "15:00", 3),

("2022-06-21", "14:30", "15:00", 8),
("2022-06-21", "14:30", "15:00", 5),
("2022-06-21", "14:30", "15:00", 3),

("2022-06-21", "19:30", "20:30", 8),
("2022-06-21", "19:30", "20:30", 5),
("2022-06-21", "19:30", "20:30", 3),

("2022-06-22", "14:30", "15:00", 8),
("2022-06-22", "14:30", "15:00", 5),
("2022-06-22", "14:30", "15:00", 3),

("2022-06-23", "14:30", "15:00", 8),
("2022-06-23", "14:30", "15:00", 5),
("2022-06-23", "14:30", "15:00", 3),

("2022-06-24", "14:30", "15:00", 8),
("2022-06-24", "14:30", "15:00", 5),
("2022-06-24", "14:30", "15:00", 3),

("2022-06-25", "14:30", "15:00", 8),
("2022-06-25", "14:30", "15:00", 5),
("2022-06-25", "14:30", "15:00", 3),

("2022-06-27", "14:30", "15:00", 8),
("2022-06-27", "14:30", "15:00", 5),
("2022-06-27", "14:30", "15:00", 3),

("2022-06-28", "14:30", "15:00", 8),
("2022-06-28", "14:30", "15:00", 5),
("2022-06-28", "14:30", "15:00", 3),

("2022-06-29", "14:30", "15:00", 8),
("2022-06-29", "14:30", "15:00", 5),
("2022-06-29", "14:30", "15:00", 3),

("2022-06-30", "14:30", "15:00", 8),
("2022-06-30", "14:30", "15:00", 5),
("2022-06-30", "14:30", "15:00", 3),

("2022-07-18", "10:30", "11:30", 8),
("2022-07-01", "14:30", "15:00", 8),
("2022-07-05", "21:30", "22:30", 8);

INSERT INTO prenotazione_scheda (cliente, trainer, data) VALUES
(8, 7, "2022-06-17"),
(5, 7, "2022-06-17"),
(3, 7, "2022-06-17");