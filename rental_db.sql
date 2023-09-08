--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE USERS 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- login USER 
--
DROP USER IF EXISTS 'utente_login';
CREATE USER 'utente_login' IDENTIFIED WITH mysql_native_password BY 'utente_login';

--
-- PROPIRETARIO 
--
DROP USER IF EXISTS 'proprietario';
CREATE USER 'proprietario' IDENTIFIED WITH mysql_native_password BY 'proprietario';

--
-- IMPIEGATO
--
DROP USER IF EXISTS 'impiegato';
CREATE USER 'impiegato' IDENTIFIED WITH mysql_native_password BY 'impiegato';

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE TABLES 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS rental_db;
CREATE SCHEMA rental_db;
USE rental_db;

--
-- CREATE TABLE UTENTI
--
CREATE TABLE utenti(
	username VARCHAR(45) NOT NULL,
    pwd CHAR(40) NOT NULL,
    ruolo ENUM('proprietario','impiegato'),
    PRIMARY KEY(username)
) ENGINE=InnoDB;

--
-- CREATE TABLE FILM
--
CREATE TABLE film(
	titolo VARCHAR(55) NOT NULL,
	regista VARCHAR(45) NOT NULL,
	anno YEAR NOT NULL,
	attori VARCHAR(55) NOT NULL,
	PRIMARY KEY (titolo, regista)
) ENGINE= InnoDB;

--
-- CREATE TABLE REMAKE
--
CREATE TABLE remake(
	titolo_originale VARCHAR(55) NOT NULL,
	regista_originale VARCHAR(45) NOT NULL,
	titolo_remake VARCHAR(55) NOT NULL,
	regista_remake VARCHAR(45) NOT NULL,
	PRIMARY KEY (titolo_originale, regista_originale, titolo_remake, regista_remake),
	FOREIGN KEY (titolo_originale, regista_originale) REFERENCES film(titolo,regista),
	FOREIGN KEY (titolo_remake, regista_remake) REFERENCES film(titolo, regista)
) ENGINE=InnoDB;

--
-- CREATE TABLE COPIA_FILM
--
CREATE TABLE copia_film(
	titolo_film VARCHAR(55) NOT NULL,
    regista_film VARCHAR(45) NOT NULL,
    numero INT NOT NULL,
    PRIMARY KEY (titolo_film, regista_film, numero),
    FOREIGN KEY (titolo_film, regista_film) REFERENCES film(titolo, regista)
) ENGINE=InnoDB;

--
-- CREATE TABLE SETTORE
--
CREATE TABLE settore(
	codice VARCHAR(45) NOT NULL,
    PRIMARY KEY(codice)
) ENGINE=InnoDB;

--
-- CREATE TABLE COPIA_FILM_SETTORE
--
CREATE TABLE copia_film_settore(
	titolo_copia VARCHAR(55) NOT NULL,
    regista_copia VARCHAR(45) NOT NULL,
    numero_copia INT NOT NULL,
    settore VARCHAR(45) NOT NULL,
    posizione VARCHAR(55) NOT NULL,
    PRIMARY KEY (titolo_copia, regista_copia, numero_copia),
    FOREIGN KEY (titolo_copia, regista_copia, numero_copia) REFERENCES copia_film(titolo_film, regista_film, numero),
    FOREIGN KEY(settore) REFERENCES settore(codice)
) ENGINE=InnoDB;

--
-- CREATE TABLE CLIENTE
--
CREATE TABLE cliente(
	tessera VARCHAR(30) NOT NULL ,
    PRIMARY KEY(tessera)
) ENGINE=InnoDB;

--
-- CREATE TABLE NOLEGGIO_ATTIVO
--
CREATE TABLE noleggio_attivo(
	titolo_copia VARCHAR(55) NOT NULL,
    regista_copia VARCHAR(45) NOT NULL,
    numero_copia INT NOT NULL,
    data_inizio DATE NOT NULL,
    tessera_cliente VARCHAR(30) NOT NULL,
    costo DECIMAL(5,2) NOT NULL,
    data_limite DATE NOT NULL,
    PRIMARY KEY (titolo_copia, regista_copia, numero_copia, data_inizio, tessera_cliente),
    FOREIGN KEY (titolo_copia, regista_copia, numero_copia) REFERENCES copia_film(titolo_film, regista_film, numero),
    FOREIGN KEY (tessera_cliente) REFERENCES cliente(tessera)
) ENGINE=InnoDB;

--
-- CREATE TABLE NOLEGGIO_TERMINATO
--
CREATE TABLE noleggio_terminato(
	titolo_copia VARCHAR(55) NOT NULL,
    regista_copia VARCHAR(45) NOT NULL,
    numero_copia INT NOT NULL,
    data_inizio DATE NOT NULL,
	tessera_cliente VARCHAR(30) NOT NULL,
    costo DECIMAL(5,2) NOT NULL,
    data_limite DATE NOT NULL,
	data_consegna DATE NOT NULL,
    PRIMARY KEY (titolo_copia, regista_copia, numero_copia, data_inizio, tessera_cliente),
    FOREIGN KEY (titolo_copia, regista_copia, numero_copia) REFERENCES copia_film(titolo_film, regista_film, numero),
    FOREIGN KEY (tessera_cliente) REFERENCES cliente(tessera)
) ENGINE=InnoDB;

--
-- CREATE TABLE RECAPITO_CLIENTE
--
CREATE TABLE recapito_cliente(
	tessera_cliente VARCHAR(30) NOT NULL,
    cellulare VARCHAR(30) UNIQUE NOT NULL,
    telefono VARCHAR(30) UNIQUE NOT NULL,
    email VARCHAR(45) UNIQUE NOT NULL,
    PRIMARY KEY (tessera_cliente),
    FOREIGN KEY (tessera_cliente) REFERENCES cliente(tessera)
) ENGINE=InnoDB;

--
-- CREATE TABLE DATI_ANAGRAFICI
--
CREATE TABLE dati_anagrafici(
	tessera_cliente VARCHAR(30) NOT NULL,
    cf VARCHAR(45) UNIQUE NOT NULL,
    nome VARCHAR(45) NOT NULL,
    cognome VARCHAR(45) NOT NULL,
    sesso ENUM('M','F') NOT NULL,
    luogo_nascita VARCHAR(45) NOT NULL,
    data_nascita DATE NOT NULL,
	PRIMARY KEY (tessera_cliente),
    FOREIGN KEY (tessera_cliente) REFERENCES cliente(tessera)
) ENGINE=InnoDB;

--
-- CREATE TABLE IMPIEGATO
--
CREATE TABLE impiegato( 
	cf VARCHAR(45) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY(cf)
) ENGINE=InnoDB;

--
-- CREATE TABLE RECAPITO_IMPIEGATO
--
CREATE TABLE recapito_impiegato( 
	cf_impiegaTO VARCHAR(45) NOT NULL,
    cellulare VARCHAR(30) UNIQUE NOT NULL,
    telefono VARCHAR(30) UNIQUE NOT NULL,
    email VARCHAR(45) UNIQUE NOT NULL,
    PRIMARY KEY(cf_impiegato),
    FOREIGN KEY(cf_impiegato) REFERENCES impiegato(cf)
) ENGINE=InnoDB;

--
-- CREATE TABLE incarico_CORRENTE
--
CREATE TABLE incarico_corrente(
	cf_impiegaTO VARCHAR(45) NOT NULL,
    tipo ENUM('cassiere','magazziniere','commesso') NOT NULL,
	inizio DATE NOT NULL,
	PRIMARY KEY(cf_impiegato),
	FOREIGN KEY(cf_impiegato) REFERENCES impiegato(cf)
) ENGINE=InnoDB;

--
-- CREATE TABLE incarico_PASSATO
--
CREATE TABLE incarico_passato(
	cf_impiegaTO VARCHAR(45) NOT NULL,
    tipo ENUM('cassiere','magazziniere','commesso') NOT NULL,
    INizio DATE NOT NULL,
    fine DATE NOT NULL,
	PRIMARY KEY(cf_impiegato,INizio),
	FOREIGN KEY(cf_impiegato) REFERENCES impiegato(cf)
) ENGINE=InnoDB;

--
-- CREATE TABLE TURNO
--
CREATE TABLE turno(
	ora_inizio INT NOT NULL,
    ora_fine INT NOT NULL,
    PRIMARY KEY(ora_inizio,ora_fine)
) ENGINE=InnoDB;

--
-- CREATE TABLE TURNO EFFETTIVO
--
CREATE TABLE turno_effettivo(
	inizio_turno INT NOT NULL,
    fine_turno INT NOT NULL,
    data_turno DATE NOT NULL,
    PRIMARY KEY(inizio_turno,fine_turno,data_turno),
    FOREIGN KEY(inizio_turno,fine_turno) REFERENCES turno(ora_inizio,ora_fine)
) ENGINE=InnoDB;

--
-- CREATE TABLE IMPIEGATO
--
CREATE TABLE turno_impiegato(
	inizio_effettivo INT NOT NULL,
    fine_effettiva INT NOT NULL,
    data_effettiva DATE NOT NULL,
    cf_impiegaTO VARCHAR(45) NOT NULL,
    PRIMARY KEY(data_effettiva,cf_impiegato),
    FOREIGN KEY(inizio_effettivo,fine_effettiva,data_effettiva) REFERENCES turno_effettivo(inizio_turno,fine_turno,data_turno),
    FOREIGN KEY(cf_impiegato) REFERENCES impiegato(cf)
) ENGINE=InnoDB;

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GRANT PRIVILEDGES 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- PRIVILEDGES FOR UTENTE_login
--
GRANT UPDATE, SELECT ON utenti TO utente_login;

--
--  PRIVILEDGES FOR IMPIEGATO
--
GRANT SELECT ON film TO impiegato;
GRANT SELECT,INSERT ON copia_film TO impiegato;
GRANT SELECT,INSERT,DELETE ON noleggio_attivo TO impiegato;
GRANT SELECT,INSERT ON noleggio_terminato TO impiegato;
GRANT SELECT,INSERT, UPDATE ON dati_anagrafici TO impiegato;
GRANT SELECT,INSERT, UPDATE ON recapito_cliente TO impiegato;


--
-- PRIVILEDGES FOR PROPRIETARIO
--
GRANT SELECT ON utenti TO proprietario;
GRANT SELECT,INSERT,UPDATE,DELETE ON turno_impiegato TO proprietario;
GRANT SELECT,INSERT,UPDATE,DELETE ON incarico_passato TO proprietario;
GRANT SELECT,INSERT,UPDATE ON incarico_corrente TO proprietario;
GRANT SELECT,INSERT, UPDATE ON impiegato TO proprietario;

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE TRIGGERS 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER !

--
-- TRIGGER before_add_rental
--
CREATE TRIGGER before_add_rental
BEFORE INSERT ON noleggio_attivo 
FOR EACH ROW
BEGIN
	DECLARE existing_rentals INT;
    -- Conta quante copie dello stesso film l'utente ha già noleggiato
    SELECT COUNT(*) INTO existing_rentals
    FROM noleggio_attivo
    WHERE tessera_cliente = NEW.tessera_cliente
    AND titolo_copia = NEW.titolo_copia
    AND regista_copia = NEW.regista_copia;
    -- Se l'utente ha già noleggiato una copia uguale, genera un errore
    IF existing_rentals > 0 THEN
        SIGNAL SQLSTATE 'TR000'
        SET MESSAGE_TEXT = 'Questo utente ha già noleggiato una copia di questo film.';
    END IF;
END!

--
-- TRIGGER before_mod_worker
--
CREATE TRIGGER before_mod_worker
BEFORE INSERT ON incarico_passato 
FOR EACH ROW
BEGIN
    DECLARE cf_count INT;
    
    -- Conta quante volte il CF dell'impiegato appare nella tabella
    SELECT COUNT(*) INTO cf_count
    FROM incarico_passato
    WHERE cf_impiegato = NEW.cf_impiegato
    AND INizio <= NEW.fine
    AND fine >= NEW.INizio;
    
    -- Se il CF appare più di una volta nello stesso giorno, genera un errore
    IF cf_count > 0 THEN
        SIGNAL SQLSTATE 'TRP02'
        SET MESSAGE_TEXT = 'Impossibile cambiare ruolo due volte allo stesso impiegato nello stesso giorno.';
    END IF;
END!


--
-- TRIGGER prevent_duplicate_turn
--
CREATE TRIGGER prevent_duplicate_turn
BEFORE INSERT ON turno_impiegato
FOR EACH ROW
BEGIN
   DECLARE turno_count INT;
    
    -- Conta quante volte lo stesso CF_impiegato ha già un turno nello stesso giorno
    SELECT COUNT(*) INTO turno_count
    FROM turno_impiegato
    WHERE cf_impiegato = NEW.cf_impiegato
    AND data_effettiva = NEW.data_effettiva;
    
    -- Se il CF_impiegato ha già un turno nello stesso giorno, genera un errore
    IF turno_count > 0 THEN
        SIGNAL SQLSTATE 'TRP04'
        SET MESSAGE_TEXT = 'Impossibile inserire più di un turno per lo stesso impiegato nello stesso giorno.';
    END IF;
END!

--
-- TRIGGER elimina_turno_delete
--
CREATE TRIGGER elimina_turno_delete
AFTER DELETE ON turno_impiegato
FOR EACH ROW
BEGIN
   DECLARE var_inizio INT;
    DECLARE var_fine INT;
    DECLARE var_data DATE;
    DECLARE count_impiegati INT;

    -- Estrai i dati di inizio, fine e data dall'aggiornamento
    SET var_inizio = OLD.inizio_effettivo;
    SET var_fine = OLD.fine_effettiva;
    SET var_data = OLD.data_effettiva;

    -- Conta quanti impiegati hanno ancora il turno per quella data e ore
    SELECT COUNT(*) INTO count_impiegati
    FROM turno_impiegato
    WHERE inizio_effettivo = var_inizio
    AND fine_effettiva = var_fine
    AND data_effettiva = var_data;

    -- Se nessun impiegato ha più il turno, rimuovi l'entry da turno_effettivo
    IF count_impiegati = 0 THEN
        DELETE FROM turno_effettivo
        WHERE inizio_turno = var_inizio
        AND fine_turno = var_fine
        AND data_turno = var_data;
    END IF;
END!

--
-- TRIGGER elimina_turno_update
--
CREATE TRIGGER elimina_turno_update
AFTER UPDATE ON turno_impiegato FOR EACH ROW
BEGIN
    DECLARE var_inizio INT;
    DECLARE var_fine INT;
    DECLARE var_data DATE;
    DECLARE count_impiegati INT;

    -- Estrai i dati di inizio, fine e data dall'aggiornamento
    SET var_inizio = OLD.inizio_effettivo;
    SET var_fine = OLD.fine_effettiva;
    SET var_data = OLD.data_effettiva;

    -- Conta quanti impiegati hanno ancora il turno per quella data e ore
    SELECT COUNT(*) INTO count_impiegati
    FROM turno_impiegato
    WHERE inizio_effettivo = var_inizio
    AND fine_effettiva = var_fine
    AND data_effettiva = var_data;

    -- Se nessun impiegato ha più il turno, rimuovi l'entry da turno_effettivo
    IF count_impiegati = 0 THEN
        DELETE FROM turno_effettivo
        WHERE inizio_turno = var_inizio
        AND fine_turno = var_fine
        AND data_turno = var_data;
    END IF;
END!
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE PROCEDURES 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- PROCEDURE login
--
CREATE PROCEDURE login (IN var_username VARCHAR(45), IN var_password CHAR(40))
BEGIN	
	SELECT ruolo
    FROM  utenti
    WHERE username=var_username AND pwd=SHA1(var_password);
END!
GRANT EXECUTE ON PROCEDURE login TO utente_login!

--
-- PROCEDURE I00 	film_list 
--
CREATE PROCEDURE film_list()
BEGIN
    SELECT *
    FROM Film ;
END!
GRANT EXECUTE ON PROCEDURE film_list TO impiegato!

--
-- PROCEDURE I01 	available_film_list 
--
CREATE PROCEDURE available_film_list()
BEGIN
    SELECT DISTINCT F.titolo, F.regista, F.anno, F.attori
    FROM Film AS F
    JOIN Copia_Film AS CF ON F.titolo = CF.titolo_film AND F.regista = CF.regista_film
    LEFT JOIN Noleggio_Attivo AS NA ON CF.titolo_film = NA.titolo_copia AND CF.regista_film = NA.regista_copia AND CF.numero = NA.numero_copia
    WHERE NA.titolo_copia IS NULL;
END!
GRANT EXECUTE ON PROCEDURE available_film_list TO impiegato!

--
-- PROCEDURE I02	available_copy_list
--
CREATE PROCEDURE available_copy_list(IN var_titolo VARCHAR(55), IN var_regista VARCHAR(45))
BEGIN
	DECLARE custom_error CONDITION FOR SQLSTATE 'I0200';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
	IF EXISTS (SELECT titolo,regista FROM film WHERE titolo = var_titolo and regista = var_regista) THEN
		SELECT CF.titolo_film, CF.regista_film, CF.numero
		FROM copia_film CF
		LEFT JOIN noleggio_attivo NA ON CF.titolo_film = NA.titolo_copia AND CF.regista_film = NA.regista_copia AND CF.numero = NA.numero_copia
		WHERE NA.titolo_copia IS NULL AND CF.titolo_film = var_titolo AND CF.regista_film = var_regista;
	ELSE 
		SIGNAL custom_error SET MESSAGE_TEXT = 'Il film che hai scelto potrebbe essere errato o non esistente, perfavore riprova';
	END IF;
END!
GRANT EXECUTE ON PROCEDURE available_copy_list TO impiegato!

--
-- PROCEDURE I03	add_copy
--
CREATE PROCEDURE add_copy(IN var_titolo VARCHAR(55), IN var_regista VARCHAR(45), IN var_num VARCHAR(10))
BEGIN
	DECLARE count_film INT;
    DECLARE i INT DEFAULT 0;
    DECLARE last_num int;
	DECLARE var_num_as_int INT;
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0300';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION;
		IF var_num REGEXP '^[0-9]{1,2}$' THEN 
		SET var_num_as_int = CAST(var_num AS SIGNED);
			SELECT COUNT(*) INTO count_film
			FROM film 
			WHERE titolo = var_titolo AND regista = var_regista;
			IF count_film = 0 THEN 
				SIGNAL custom_error SET MESSAGE_TEXT = 'Il film a cui hai provato ad aggiungere copie potrebbe essere errato o non esistente, perfavore riprova';
			ELSE
				SELECT MAX(numero) INTO last_num
				FROM copia_film
				WHERE titolo_film = var_titolo AND regista_film = var_regista;
				
				 WHILE i < var_num DO
					SET last_num = last_num + 1;

					-- Inserisci una nuova copia nella tabella copia_film
					INSERT INTO copia_film (titolo_film, regista_film, numero)
					VALUES (var_titolo, var_regista, last_num);
					
					SET i = i + 1;
				END WHILE;
			END IF;
		ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Invalid input: il numero di copie deve essere un intero non maggiore di 99';
		END IF;	
	COMMIT;
END!
GRANT EXECUTE ON PROCEDURE add_copy TO impiegato!


--
-- PROCEDURE I04	available_rents
--
CREATE PROCEDURE available_rents(IN var_tessera varchar(30))
BEGIN
	DECLARE custom_error CONDITION FOR SQLSTATE 'I0400';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
	IF EXISTS (SELECT tessera FROM cliente WHERE tessera = var_tessera) THEN
		SELECT *
		FROM noleggio_attivo 
		WHERE tessera_cliente = var_tessera;
	ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Tessera cliente non disponibile o errata';
    END IF;
END!
GRANT EXECUTE ON PROCEDURE available_rents TO impiegato!

--
-- PROCEDURE I05	add_rental
--
CREATE PROCEDURE add_rental(IN var_titolo VARCHAR(55), IN var_regista VARCHAR(45),IN var_tessera varchar(30),IN var_costo VARCHAR(10))
BEGIN
	DECLARE num_expired INT;
	DECLARE first_num INT;
    DECLARE var_data_inizio DATE;
    DECLARE var_data_limite DATE;
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0500';
    DECLARE decimal_costo DECIMAL(5,2);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	START TRANSACTION;
		-- controllo su prezzo  --
		IF var_costo REGEXP '^[0-9]{1,3}(\\.[0-9]{1,2})?$' THEN 
		SET decimal_costo = CAST(var_costo AS DECIMAL(5, 2));
			-- controllo su tessera cliente --
			IF EXISTS (SELECT tessera FROM cliente WHERE tessera = var_tessera) THEN
				-- controllo su esistenza di copia di film --
				IF EXISTS (SELECT * FROM copia_film WHERE titolo_film = var_titolo AND regista_film = var_regista) THEN
                -- controllo se cliente ha noleggio scaduto -- 
					-- controllo se utente ha noleggio scaduto --
					IF NOT EXISTS(SELECT * FROM noleggio_attivo WHERE tessera_cliente = var_tessera AND data_limite < CURDATE()) THEN 
						-- prendi la prima copia disponibile che non fa parte di un noleggio attivo --
						SELECT MIN(numero) INTO first_num
						FROM copia_film
						WHERE titolo_film = var_titolo AND regista_film = var_regista
						AND (titolo_film, regista_film, numero) NOT IN (
							SELECT titolo_copia, regista_copia, numero_copia
							FROM noleggio_attivo);
						IF first_num IS NOT NULL THEN 
							-- inizo noleggio --
							SELECT CURDATE() INTO var_data_inizio;
							-- fine noleggio --
							SELECT DATE_ADD(CURDATE(), INTERVAL 1 WEEK) INTO var_data_limite;
							INSERT INTO noleggio_attivo(titolo_copia,regista_copia,numero_copia,data_inizio,tessera_cliente,costo,data_limite) 
							VALUES  (var_titolo,var_regista,first_num,var_data_inizio,var_tessera,decimal_costo,var_data_limite);
						ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Questo film non ha copie disponibili per essere noleggiate';
						END IF;
					ELSE 
						SIGNAL SQLSTATE '45000'
							SET MESSAGE_TEXT = 'L\'utente ha già noleggi scaduti';
					END IF;
				ELSE SIGNAL custom_error 
					SET MESSAGE_TEXT = 'Nessuna copia disponibile per il film';
				END IF;
			ELSE SIGNAL custom_error 
				SET MESSAGE_TEXT = 'Tessera cliente errata o non esistente';
			END IF;
		ELSE SIGNAL 
			custom_error SET MESSAGE_TEXT = 'Prezzo non valido';
		END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE add_rental TO impiegato!


--
-- PROCEDURE I06	end_rental
--
CREATE PROCEDURE end_rental(IN var_titolo VARCHAR(55), IN var_regista VARCHAR(45),IN var_tessera varchar(30), IN var_data_inizio VARCHAR(20))
BEGIN
	DECLARE var_end_rental DATE;
	DECLARE var_data_date DATE;
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0600';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION;
	-- controllo su tessera cliente --
	IF EXISTS (SELECT tessera FROM cliente WHERE tessera = var_tessera) THEN
		-- controllo su data --
		IF(CAST(var_data_inizio AS DATE)) IS NOT NULL THEN
			SET var_data_date = CAST(var_data_inizio AS DATE);
			-- controllo copia film che sta in un noleggio attivo -- 
			IF EXISTS (SELECT * FROM noleggio_attivo WHERE titolo_copia = var_titolo AND regista_copia = var_regista AND tessera_cliente = var_tessera AND data_inizio = var_data_date) THEN 
				SET var_end_rental = CURDATE();
				INSERT INTO noleggio_terminato (titolo_copia, regista_copia, numero_copia, data_inizio, tessera_cliente, costo, data_limite, data_consegna)
				SELECT titolo_copia,regista_copia, numero_copia, data_inizio, tessera_cliente, costo, data_limite, var_end_rental
				FROM noleggio_attivo
                WHERE titolo_copia = var_titolo AND regista_copia = var_regista AND tessera_cliente = var_tessera AND data_inizio = var_data_date;

				DELETE FROM noleggio_attivo
				WHERE titolo_copia = var_titolo
				AND regista_copia = var_regista
				AND data_inizio = var_data_inizio
				AND tessera_cliente = var_tessera;
				
			ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Copia film inesistente o non correntemente attiva in un noleggio';
			END IF;	
		ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Data errata per favore riprova';
		END IF;	
	ELSE SIGNAL custom_error SET MESSAGE_TEXT = 'Tessera cliente errata o non esistente';
	END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE end_rental TO impiegato!

--
-- PROCEDURE I07	mod_customer_registry
-- 
CREATE PROCEDURE mod_customer_registry(IN var_tessera VARCHAR(45) ,IN var_cf VARCHAR(45), IN var_nome VARCHAR(45), IN var_cognome VARCHAR(45), IN var_sesso VARCHAR(10), IN var_luogo_nascita VARCHAR(45), IN var_data_nascita VARCHAR(20))
BEGIN
	DECLARE var_old_cf VARCHAR (45);
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0700';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	START TRANSACTION;
    -- controllo cf --
    IF NOT EXISTS(SELECT tessera FROM cliente WHERE tessera = var_tessera) THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Tessera cliente non presente o errata, per favore riprova';
    END IF;
	-- controllo nome e cognome--
    IF NOT var_nome REGEXP '^[A-Za-zÀ-ÿ\\s\'-]+$' OR NOT var_cognome REGEXP '^[A-Za-zÀ-ÿ\\s\'-]+$' THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Nome o cognome errati non possono contenere numeri o essere vuoti';
    END IF;
    -- controllo sesso --
    IF var_sesso NOT IN ('M','F') THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Sesso errato prova a inserire M oppure F';
    END IF;
    -- controllo data --
    IF(CAST(var_data_nascita AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
    -- controllo nuovo codice fiscale --
    SELECT cf INTO var_old_cf FROM dati_anagrafici WHERE tessera_cliente = var_tessera;
    IF var_old_cf <> var_cf THEN
		-- controllo esistenza cf --
		IF EXISTS(SELECT cf FROM dati_anagrafici WHERE cf = var_cf) OR var_cf IS NULL THEN 
		SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale gia presente';
		END IF;
		-- aggiorna i dati se codice fiscale è diverso--
        UPDATE dati_anagrafici 
        SET cf = var_cf, nome = var_nome, cognome = var_cognome , sesso = var_sesso, luogo_nascita = var_luogo_nascita, data_nascita = var_data_nascita
        WHERE tessera_cliente = var_tessera;
    ELSE 
		-- aggiorna i dati se codice fiscale è uguiale --
         UPDATE dati_anagrafici 
		 SET nome = var_nome, cognome = var_cognome , sesso = var_sesso, luogo_nascita = var_luogo_nascita, data_nascita = var_data_nascita
		 WHERE tessera_cliente = var_tessera;
	END IF;
END!
GRANT EXECUTE ON PROCEDURE mod_customer_registry TO impiegato!

--
-- PROCEDURE I08	add_customer
-- 
CREATE PROCEDURE add_customer(IN var_tessera VARCHAR(45) ,IN var_cf VARCHAR(45), IN var_nome VARCHAR(45), IN var_cognome VARCHAR(45), IN var_sesso VARCHAR(10), IN var_luogo_nascita VARCHAR(45), IN var_data_nascita VARCHAR(20) ,IN var_cellulare VARCHAR(30) , IN var_telefono VARCHAR(30) , IN var_email VARCHAR(45))
BEGIN
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0800';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
	START TRANSACTION;
    -- controllo cf --
    IF EXISTS(SELECT tessera FROM cliente WHERE tessera = var_tessera) OR var_tessera IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Tessera cliente gia presente';
    END IF;
	-- controllo cf --
    IF EXISTS(SELECT cf FROM dati_anagrafici WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale gia presente';
    END IF;
    -- controllo nome e cognome--
    IF NOT var_nome REGEXP '^[A-Za-zÀ-ÿ\\s\'-]+$' OR NOT var_cognome REGEXP '^[A-Za-zÀ-ÿ\\s\'-]+$' THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Nome o cognome errati non possono contenere numeri o essere vuoti';
    END IF;
    -- controllo sesso --
    IF var_sesso NOT IN ('M','F') THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Sesso errato prova a inserire M oppure F';
    END IF;
    -- controllo data --
    IF(CAST(var_data_nascita AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
	-- controllo su telefono e cellulare clieni --
    IF NOT var_telefono REGEXP '^[0-9]+$'  OR NOT var_cellulare REGEXP '^[0-9]+$' THEN
	SIGNAL custom_error SET MESSAGE_TEXT = 'Numero di telefono o cellulare';
    END IF;
    IF NOT var_email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
	SIGNAL custom_error SET MESSAGE_TEXT = 'Indirizzo email non valido';
    END IF;
    -- controllo unicita recapiti --
	IF EXISTS(SELECT * FROM recapito_cliente WHERE telefono = var_telefono) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Telefono gia utilizzato per favore riprova';
    END IF;
	IF EXISTS(SELECT * FROM recapito_cliente WHERE cellulare = var_cellulare) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Cellulare gia utilizzato per favore riprova';
    END IF;
	IF EXISTS(SELECT * FROM recapito_cliente WHERE email = var_email) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Email gia utilizzato per favore riprova';
    END IF;
    -- se supera controlli allora inserisci i dati --
    INSERT INTO cliente (tessera) 
    VALUE (var_tessera);
    
    INSERT INTO dati_anagrafici(tessera_cliente, cf, nome, cognome, sesso, luogo_nascita, data_nascita)
    VALUES (var_tessera, var_cf, var_nome,var_cognome, var_sesso, var_luogo_nascita, var_data_nascita);
    
    INSERT INTO recapito_cliente (tessera_cliente, cellulare, telefono, email)
    VALUES (var_tessera, var_cellulare, var_telefono, var_email);
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE add_customer TO impiegato!


--
-- PROCEDURE I09	report_copy
--
CREATE PROCEDURE report_copy()
BEGIN
    DECLARE custom_error CONDITION FOR SQLSTATE 'I0900';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
		SELECT * 
        FROM copia_film
        WHERE (titolo_film, regista_film, numero) IN (
        SELECT titolo_copia, regista_copia, numero_copia
        FROM noleggio_attivo
        WHERE CURDATE() > data_limite);
END!
GRANT EXECUTE ON PROCEDURE report_copy TO impiegato!

--
-- PROCEDURE I10	report_customer
--
CREATE PROCEDURE report_customer()
BEGIN
    DECLARE custom_error CONDITION FOR SQLSTATE 'I1000';
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
		SELECT DISTINCT c.*, da.cf, da.nome, da.cognome, da.sesso, da.luogo_nascita, da.data_nascita, rc.cellulare, rc.telefono, rc.email
		FROM cliente c
		JOIN noleggio_attivo na ON c.tessera = na.tessera_cliente
		JOIN dati_anagrafici da ON c.tessera = da.tessera_cliente
		JOIN recapito_cliente rc ON c.tessera = rc.tessera_cliente
		WHERE CURDATE() > na.data_limite;
END!
GRANT EXECUTE ON PROCEDURE report_customer TO impiegato!


--
-- PROCEDURE P01 add_worker
--
CREATE PROCEDURE add_worker (IN var_cf VARCHAR(45), IN var_nome VARCHAR(45), IN var_cellulare VARCHAR(30) , IN var_telefono VARCHAR(30) , IN var_email VARCHAR(45), IN var_ruolo VARCHAR(20))
BEGIN	
	DECLARE custom_error CONDITION FOR SQLSTATE 'P0100';
    DECLARE curr_date DATE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
	START TRANSACTION;
	-- controllo cf --
    IF EXISTS(SELECT cf FROM impiegato WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale gia presente';
    END IF;
    -- controllo nome --
    IF NOT var_nome REGEXP '^[A-Za-zÀ-ÿ\\s\'-]+$' THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Nome o cognome errati non possono contenere numeri o essere vuoti';
    END IF;
	-- controllo su telefono e cellulare  --
    IF (NOT var_telefono REGEXP '^[0-9]+$') OR (NOT var_cellulare REGEXP '^[0-9]+$') THEN
	SIGNAL custom_error SET MESSAGE_TEXT = 'Numero di telefono o cellulare contengono lettere';
    END IF;
    IF NOT var_email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
	SIGNAL custom_error SET MESSAGE_TEXT = 'Indirizzo email non valido';
    END IF;
    -- controllo unicita recapiti --
	IF EXISTS(SELECT * FROM recapito_impiegato WHERE telefono = var_telefono) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Telefono gia utilizzato per favore riprova';
    END IF;
	IF EXISTS(SELECT * FROM recapito_impiegato WHERE cellulare = var_cellulare) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Cellulare gia utilizzato per favore riprova';
    END IF;
	IF EXISTS(SELECT * FROM recapito_impiegato WHERE email = var_email) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Email gia utilizzato per favore riprova';
    END IF;
    -- controllo ruolo --
    IF var_ruolo NOT IN ('cassiere','magazziniere','commesso') THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore incarico seleziona tra (cassiere,magazziniere,commesso)';
    END IF;
    
    SET curr_date = CURDATE();
    -- se supera controlli allora inserisci i dati --
    INSERT INTO impiegato (cf, nome) 
    VALUE (var_cf,var_nome);
    
    INSERT INTO recapito_impiegato(cf_impiegaTO, cellulare, telefono, email)
    VALUES (var_cf, var_cellulare, var_telefono, var_email);
    
    INSERT INTO incarico_corrente (cf_impiegaTO, tipo, inizio)
    VALUES (var_cf, var_ruolo, curr_date);
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE add_worker TO proprietario!



--
-- PROCEDURE P02 mod_worker
--
CREATE PROCEDURE mod_worker (IN var_cf VARCHAR(45), IN var_ruolo VARCHAR(20))
BEGIN	
	DECLARE custom_error CONDITION FOR SQLSTATE 'P0200';
    DECLARE curr_date DATE;
    DECLARE var_old_ruolo VARCHAR(20);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	START TRANSACTION;
	-- controllo cf --
    IF NOT EXISTS(SELECT cf FROM impiegato WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale errato o inesistente';
    END IF;
    -- controllo ruolo --
    IF var_ruolo NOT IN('cassiere','magazziniere','commesso') THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore incarico seleziona tra (cassiere,magazziniere,commesso)';
    END IF;
    -- verifica se ruolo in input diverso ruolo effettivo --
    SELECT tipo INTO var_old_ruolo FROM incarico_corrente WHERE cf_impiegaTO = var_cf;
    IF var_old_ruolo <> var_ruolo THEN
		-- inserisci dati nell incarico passato --
		SET curr_date = CURDATE();
        INSERT INTO incarico_passato (cf_impiegaTO, tipo, INizio, fine)
        SELECT cf_impiegaTO, tipo, inizio, curr_date
        FROM incarico_corrente
        WHERE cf_impiegaTO = var_cf;
        -- aggiorna incarico corrente -- 
        UPDATE incarico_corrente 
        SET tipo = var_ruolo, inizio = curr_date
        WHERE cf_impiegaTO = var_cf; 
    ELSE 
		 SIGNAL custom_error SET MESSAGE_TEXT = 'Questo impiegato occupa gia questo ruolo';
	END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE mod_worker TO proprietario!

--
-- PROCEDURE P03 all_workers
--
CREATE PROCEDURE all_workers ()
BEGIN	
	SELECT 
    i.cf AS CodiceFiscale,
    i.nome AS Nome,
    r.cellulare AS Cellulare,
    r.telefono AS Telefono,
    r.email AS Email,
    ic.tipo AS IncaricoCorrente,
    ic.inizio AS DataInizioIncarico
FROM 
    impiegato AS i
LEFT JOIN 
    recapito_impiegato AS r ON i.cf = r.cf_impiegaTO
LEFT JOIN 
    incarico_corrente AS ic ON i.cf = ic.cf_impiegaTO;
END!
GRANT EXECUTE ON PROCEDURE all_workers TO proprietario!

--
-- PROCEDURE P04 add_workshift
--
CREATE PROCEDURE add_workshift (IN var_cf VARCHAR(45), IN var_inizio VARCHAR(20), IN var_fine VARCHAR(20), IN var_data VARCHAR(20))
BEGIN	
	DECLARE custom_error CONDITION FOR SQLSTATE 'P0400';
    DECLARE var_data_date DATE;
    DECLARE var_inizio_int INT;
    DECLARE var_fine_int INT;
    DECLARE var_old_ruolo VARCHAR(20);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
	START TRANSACTION;
	-- controllo cf --
    IF NOT EXISTS(SELECT cf FROM impiegato WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale errato o inesistente';
    END IF;
	-- controllo validita ore --
    IF CAST(var_inizio AS SIGNED) IS NULL OR CAST(var_fine AS SIGNED) IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Ora inizio turno o ora fine turno non validi';
    END IF;
    SET var_inizio_int = CAST(var_inizio AS SIGNED);
    SET var_fine_int = CAST(var_fine AS SIGNED);
    -- controllo turno --
	IF NOT EXISTS(SELECT * FROM turno WHERE ora_inizio = var_inizio_int AND ora_fine = var_fine_int) THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Non esiste questo turno o è nullo';
    END IF;
    -- controllo date -- 
	IF(CAST(var_data AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
    SET var_data_date = (CAST(var_data AS DATE));
    -- se esiste un turno effettivo in quel giorno aggiorna il turno dell impiegato --
    IF EXISTS (SELECT * FROM turno_effettivo WHERE inizio_turno = var_inizio_int AND fine_turno = var_fine_int AND data_turno = var_data_date) THEN
		INSERT INTO turno_impiegato(inizio_effettivo, fine_effettiva, data_effettiva, cf_impiegato)
        SELECT inizio_turno, fine_turno, data_turno , var_cf
        FROM turno_effettivo
        WHERE inizio_turno = var_inizio_int AND fine_turno = var_fine_int AND data_turno = var_data_date;
    
    -- altrimenti crealo --
    ELSE 
		-- aggiungi turno effettivo --
		INSERT INTO turno_effettivo (inizio_turno, fine_turno, data_turno) 
        VALUES (var_inizio_int, var_fine_int, var_data_date);
        -- aggiungi turno all impiegato --
        INSERT INTO turno_impiegato(inizio_effettivo, fine_effettiva, data_effettiva, cf_impiegato)
        SELECT inizio_turno, fine_turno, data_turno , var_cf
        FROM turno_effettivo
        WHERE inizio_turno = var_inizio_int AND fine_turno = var_fine_int AND data_turno = var_data_date;
    
    END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE add_workshift TO proprietario!


--
-- PROCEDURE P05 mod_workshift
--
CREATE PROCEDURE mod_workshift (IN var_cf VARCHAR(45), IN var_inizio VARCHAR(20), IN var_fine VARCHAR(20), IN var_data VARCHAR(20))
BEGIN	
	DECLARE custom_error CONDITION FOR SQLSTATE 'P0500';
    DECLARE var_data_date DATE;
    DECLARE var_inizio_int INT;
    DECLARE var_fine_int INT;
    DECLARE var_old_inizio INT;
    DECLARE var_old_fine INT;
    DECLARE count_turno INT;
    DECLARE var_old_ruolo VARCHAR(20);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	START TRANSACTION;
	-- controllo cf --
    IF NOT EXISTS(SELECT cf FROM impiegato WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale errato o inesistente';
    END IF;
	-- controllo validita ore --
    IF CAST(var_inizio AS SIGNED) IS NULL OR CAST(var_inizio AS SIGNED) IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Ora inizio turno o ora fine turno non validi';
    END IF;
    SET var_inizio_int = CAST(var_inizio AS SIGNED);
    SET var_fine_int = CAST(var_fine AS SIGNED);
    -- controllo turno --
	IF NOT EXISTS(SELECT * FROM turno WHERE ora_inizio = var_inizio_int AND ora_fine = var_fine_int) THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Non esiste questo turno o è nullo';
    END IF;
    -- controllo date -- 
	IF(CAST(var_data AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
    SET var_data_date = (CAST(var_data AS DATE));
    -- controllo turno effettivo -- 
    IF NOT EXISTS(
		SELECT * 
		FROM turno_impiegato AS ti
		JOIN turno_effettivo AS te
		ON ti.inizio_effettivo = te.inizio_turno
		AND ti.fine_effettiva = te.fine_turno
		AND ti.data_effettiva = te.data_turno
		WHERE ti.cf_impiegaTO = var_cf
		AND ti.data_effettiva = var_data_date
	) THEN 
	SIGNAL custom_error SET MESSAGE_TEXT = 'Non esiste questo turno o è nullo';
	END IF;
    -- controllo cambio turno --
    SELECT inizio_effettivo,fine_effettiva INTO var_old_inizio, var_old_fine
    FROM turno_impiegato 
	WHERE cf_impiegaTO = var_cf AND data_effettiva = var_data_date;
    IF var_old_inizio <> var_inizio_int OR var_old_fine <> var_fine_int THEN
		UPDATE turno_impiegato
        SET inizio_effettivo = var_inizio_int, fine_effettiva = var_fine_int
        WHERE data_effettiva = var_data_date AND cf_impiegaTO = var_cf;
    ELSE 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Questo impiegato ricopre gia questo turno in questa data';
    END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE mod_workshift TO proprietario!

--
-- PROCEDURE P06 delete_workshift
--
CREATE PROCEDURE delete_workshift (IN var_cf VARCHAR(45), IN var_inizio VARCHAR(20), IN var_fine VARCHAR(20), IN var_data VARCHAR(20))
BEGIN	
	DECLARE custom_error CONDITION FOR SQLSTATE 'P0600';
    DECLARE var_data_date DATE;
    DECLARE var_inizio_int INT;
    DECLARE var_fine_int INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;  -- Esegui il rollback in caso di errore
        RESIGNAL; 
    END;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
	START TRANSACTION;
	-- controllo cf --
    IF NOT EXISTS(SELECT cf FROM impiegato WHERE cf = var_cf) OR var_cf IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Codice fiscale errato o inesistente';
    END IF;
	-- controllo validita ore --
    IF CAST(var_inizio AS SIGNED) IS NULL OR CAST(var_inizio AS SIGNED) IS NULL THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Ora inizio turno o ora fine turno non validi';
    END IF;
    SET var_inizio_int = CAST(var_inizio AS SIGNED);
    SET var_fine_int = CAST(var_fine AS SIGNED);
    -- controllo turno --
	IF NOT EXISTS(SELECT * FROM turno WHERE ora_inizio = var_inizio_int AND ora_fine = var_fine_int) THEN 
    SIGNAL custom_error SET MESSAGE_TEXT = 'Non esiste questo turno o è nullo';
    END IF;
    -- controllo date -- 
	IF(CAST(var_data AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
    SET var_data_date = (CAST(var_data AS DATE));
    -- controllo esistenza turno effettivo dell impiegato -- 
	IF EXISTS(SELECT * FROM turno_impiegato WHERE inizio_effettivo = var_inizio AND fine_effettiva = var_fine_int AND data_effettiva = var_data_date AND cf_impiegato = var_cf) THEN 
		DELETE FROM turno_impiegato
        WHERE inizio_effettivo = var_inizio AND fine_effettiva = var_fine_int AND data_effettiva = var_data_date AND cf_impiegato = var_cf;
    ELSE 
		   SIGNAL custom_error SET MESSAGE_TEXT = 'Non esiste questo turno per questo impiegato';
    END IF;
    COMMIT;
END!
GRANT EXECUTE ON PROCEDURE delete_workshift TO proprietario!


--
-- PROCEDURE P08 day_workshifts
--
CREATE PROCEDURE day_workshifts(IN var_data VARCHAR(20))
BEGIN
	DECLARE var_data_date DATE;
    DECLARE custom_error CONDITION FOR SQLSTATE 'P0800';
	-- controllo date -- 
	IF(CAST(var_data AS DATE)) IS NULL THEN
    SIGNAL custom_error SET MESSAGE_TEXT = 'Errore formato data';
    END IF;
    SET var_data_date = CAST(var_data AS DATE);
	SELECT cf_impiegaTO,inizio_effettivo,fine_effettiva, data_effettiva     
	FROM turno_impiegato
    WHERE data_effettiva = var_data_date; 
END!
GRANT EXECUTE ON PROCEDURE day_workshifts TO proprietario!

--
-- PROCEDURE P08 report_monthly_hours
--
CREATE PROCEDURE report_monthly_hours(IN var_month INT, IN var_year INT)
BEGIN
    -- Crea una tabella temporanea per immagazzinare i risultati
    CREATE TEMPORARY TABLE temp_monthly_hours (
        cf_impiegaTO VARCHAR(45) NOT NULL,
        total_hours INT
    );

    -- Esegui il calcolo e inserisci i risultati nella tabella temporanea
    INSERT INTO temp_monthly_hours (cf_impiegaTO, total_hours)
    SELECT 
        ti.cf_impiegaTO,
        SUM(
            CASE
                WHEN te.inizio_turno <= te.fine_turno THEN te.fine_turno - te.inizio_turno
                ELSE (24 - te.inizio_turno) + te.fine_turno
            END
        ) AS total_hours
    FROM 
        turno_impiegato AS ti
    INNER JOIN 
        turno_effettivo AS te ON ti.inizio_effettivo = te.inizio_turno
            AND ti.fine_effettiva = te.fine_turno
            AND ti.data_effettiva = te.data_turno
    WHERE 
        MONTH(ti.data_effettiva) = var_month
        AND YEAR(ti.data_effettiva) = var_year
    GROUP BY 
        ti.cf_impiegaTO;

    -- Seleziona i risultati dalla tabella temporanea
    SELECT * FROM temp_monthly_hours;

    -- Elimina la tabella temporanea
    DROP TEMPORARY TABLE temp_monthly_hours;
END!
GRANT EXECUTE ON PROCEDURE report_monthly_hours TO proprietario!


--
-- PROCEDURE P09 report_yearly_hours
--
CREATE PROCEDURE report_yearly_hours(IN var_year INT)
BEGIN
    -- Crea una tabella temporanea per immagazzinare i risultati
    CREATE TEMPORARY TABLE temp_yearly_hours (
        cf_impiegaTO VARCHAR(45) NOT NULL,
        total_hours INT
    );

    -- Esegui il calcolo e inserisci i risultati nella tabella temporanea
    INSERT INTO temp_yearly_hours (cf_impiegaTO, total_hours)
    SELECT 
        ti.cf_impiegaTO,
        SUM(
            CASE
                WHEN te.inizio_turno <= te.fine_turno THEN te.fine_turno - te.inizio_turno
                ELSE (24 - te.inizio_turno) + te.fine_turno
            END
        ) AS total_hours
    FROM 
        turno_impiegato AS ti
    INNER JOIN 
        turno_effettivo AS te ON ti.inizio_effettivo = te.inizio_turno
            AND ti.fine_effettiva = te.fine_turno
            AND ti.data_effettiva = te.data_turno
    WHERE 
        YEAR(ti.data_effettiva) = var_year
    GROUP BY 
        ti.cf_impiegaTO;

    -- Seleziona i risultati dalla tabella temporanea
    SELECT * FROM temp_yearly_hours;

    -- Elimina la tabella temporanea
    DROP TEMPORARY TABLE temp_yearly_hours;
END;
GRANT EXECUTE ON PROCEDURE report_yearly_hours TO proprietario!

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POPULATE DB --
--------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER ;

--
-- INSERT UTENTI
--
INSERT INTO utenti (username,pwd,ruolo) VALUES
('proprietario',SHA1('proprietario'),'proprietario'),
('impiegato',SHA1('impiegato'),'impiegato'),
('moretti@gmail.com',SHA1('moretti'),'proprietario'),
('dilo@gmail.com',SHA1('dilo'),'impiegato'),
('dado@gmail.com',SHA1('dado'),'impiegato'),
('damians@gmail.com',SHA1('damians'),'impiegato'),
('matt@gmail.com',SHA1('matt'),'impiegato'),
('baffo@gmail.com',SHA1('baffo'),'impiegato');

--
-- INSERT FILM
--
INSERT INTO film (titolo, regista, anno, attori) VALUES

("f","t","0000","actors"),

('Titanic', 'James Cameron', '1998', 'Leonardo DiCaprio, Kate Winslet'),
('Il Padrino', 'Francis Ford Coppola', '1972', 'Marlon Brando, Al Pacino, James Caan'),
('Schindler s List', 'Steven Spielberg', '1993', 'Liam Neeson, Ben Kingsley, Ralph Fiennes'),
('Pulp Fiction', 'QuentIN Tarantino', '1994', 'John Travolta, Samuel L. Jackson, Uma Thurman'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '2001', 'Elijah Wood, Sean Astin, Billy Boyd'),
('Fight Club', 'David Fincher', '1999', 'Edward Norton, Brad Pitt, Helena Bonham Carter'),
('Inception', 'Christopher Nolan', '2010', 'Leonardo DiCaprio, Marion Cotillard, Elliot Page'),
('Matrix', 'Lana Wachowski', '1999', 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '1991', 'Jodie Foster, Anthony Hopkins, Scott Glenn'),
('Hannibal', 'Ridley Scott', '2001', 'Anthony Hopkins, Julianne Moore, Giancarlo Giannini'),
('La Vita è Bella', 'RoberTO Benigni', '1997', 'RoberTO Benigni, Nicoletta Braschi, Giustino Durano'),
('Salvate il soldato Ryan', 'Steven Spielberg', '1998', 'Tom Hanks, Matt Damon, Tom Sizemore'),
('Il Miglio Verde', 'Frank Darabont', '1999', 'Tom Hanks, Gary Sinise, Barry Pepper'),
('Ring', 'Hideo Nakata', '1998', 'Nanako Matsushima, Hiroyuki Sanada'),
('The Ring', 'Gore Verbinski', '2002', 'Naomi Watts, Daveigh Chase'),
('Scarface - Lo sfregiato', 'Howard Hawks', '1932', 'Howard Hawks, Paul Muni'),
('Scarface', 'Brian De Palma', '1983', 'Al Pacino, Michelle Pfeiffer'),
('La Mosca', 'David Cronenberg', '1986', 'Jeff Goldblum, David Cronenberg'),
('L esperimento del dottor K.', 'Kurt Neumann', '1958', 'Vincent Price, David Hedison'),
('Interstellar', 'Christopher Nolan', '2014', 'Matthew McConaughey, Anne Hathaway, Jessica Chastain');

--
-- INSERT REMAKE
--
INSERT INTO remake (titolo_originale, regista_originale, titolo_remake, regista_remake) VALUES
('Ring','Hideo Nakata','The Ring','Gore Verbinski'),
('Scarface - Lo sfregiato','Howard Hawks','Scarface','Brian De Palma'),
('L esperimento del dottor K.','Kurt Neumann','La Mosca','David Cronenberg');

--
-- INSERT COPIA_FILM
--
INSERT INTO copia_film(titolo_film, regista_film, numero) VALUES

("f","t","1"),
("f","t","2"),
("f","t","3"),

('Titanic','James Cameron','1'),
('Titanic','James Cameron','2'),
('Titanic','James Cameron','3'),
('Titanic','James Cameron','4'),
('Titanic','James Cameron','5'),
('Il Padrino', 'Francis Ford Coppola', '1'),
('Il Padrino', 'Francis Ford Coppola', '2'),
('Il Padrino', 'Francis Ford Coppola', '3'),
('Il Padrino', 'Francis Ford Coppola', '4'),
('Il Padrino', 'Francis Ford Coppola', '5'),
('Schindler s List', 'Steven Spielberg', '1'),
('Schindler s List', 'Steven Spielberg', '2'),
('Schindler s List', 'Steven Spielberg', '3'),
('Schindler s List', 'Steven Spielberg', '4'),
('Schindler s List', 'Steven Spielberg', '5'),
('Pulp Fiction', 'QuentIN Tarantino', '1'),
('Pulp Fiction', 'QuentIN Tarantino', '2'),
('Pulp Fiction', 'QuentIN Tarantino', '3'),
('Pulp Fiction', 'QuentIN Tarantino', '4'),
('Pulp Fiction', 'QuentIN Tarantino', '5'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '1'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '2'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '3'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '4'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '5'),
('Fight Club', 'David Fincher', '1'),
('Fight Club', 'David Fincher', '2'),
('Fight Club', 'David Fincher', '3'),
('Fight Club', 'David Fincher', '4'),
('Fight Club', 'David Fincher', '5'),
('Inception', 'Christopher Nolan', '1'),
('Inception', 'Christopher Nolan', '2'),
('Inception', 'Christopher Nolan', '3'),
('Inception', 'Christopher Nolan', '4'),
('Inception', 'Christopher Nolan', '5'),
('Matrix', 'Lana Wachowski', '1'),
('Matrix', 'Lana Wachowski', '2'),
('Matrix', 'Lana Wachowski', '3'),
('Matrix', 'Lana Wachowski', '4'),
('Matrix', 'Lana Wachowski', '5'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '1'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '2'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '3'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '4'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '5'),
('Hannibal', 'Ridley Scott', '1'),
('Hannibal', 'Ridley Scott', '2'),
('Hannibal', 'Ridley Scott', '3'),
('Hannibal', 'Ridley Scott', '4'),
('Hannibal', 'Ridley Scott', '5'),
('La Vita è Bella', 'RoberTO Benigni', '1'),
('La Vita è Bella', 'RoberTO Benigni', '2'),
('La Vita è Bella', 'RoberTO Benigni', '3'),
('La Vita è Bella', 'RoberTO Benigni', '4'),
('La Vita è Bella', 'RoberTO Benigni', '5'),
('Salvate il soldato Ryan', 'Steven Spielberg', '1'),
('Salvate il soldato Ryan', 'Steven Spielberg', '2'),
('Salvate il soldato Ryan', 'Steven Spielberg', '3'),
('Salvate il soldato Ryan', 'Steven Spielberg', '4'),
('Salvate il soldato Ryan', 'Steven Spielberg', '5'),
('Il Miglio Verde', 'Frank Darabont', '1'),
('Il Miglio Verde', 'Frank Darabont', '2'),
('Il Miglio Verde', 'Frank Darabont', '3'),
('Il Miglio Verde', 'Frank Darabont', '4'),
('Il Miglio Verde', 'Frank Darabont', '5'),
('Ring', 'Hideo Nakata', '1'),
('Ring', 'Hideo Nakata', '2'),
('Ring', 'Hideo Nakata', '3'),
('Ring', 'Hideo Nakata', '4'),
('Ring', 'Hideo Nakata', '5'),
('The Ring', 'Gore Verbinski', '1'),
('The Ring', 'Gore Verbinski', '2'),
('The Ring', 'Gore Verbinski', '3'),
('The Ring', 'Gore Verbinski', '4'),
('The Ring', 'Gore Verbinski', '5'),
('Scarface - Lo sfregiato', 'Howard Hawks', '1'),
('Scarface - Lo sfregiato', 'Howard Hawks', '2'),
('Scarface - Lo sfregiato', 'Howard Hawks', '3'),
('Scarface - Lo sfregiato', 'Howard Hawks', '4'),
('Scarface - Lo sfregiato', 'Howard Hawks', '5'),
('Scarface', 'Brian De Palma', '1'),
('Scarface', 'Brian De Palma', '2'),
('Scarface', 'Brian De Palma', '3'),
('Scarface', 'Brian De Palma', '4'),
('Scarface', 'Brian De Palma', '5'),
('La Mosca', 'David Cronenberg', '1'),
('La Mosca', 'David Cronenberg', '2'),
('La Mosca', 'David Cronenberg', '3'),
('La Mosca', 'David Cronenberg', '4'),
('La Mosca', 'David Cronenberg', '5'),
('L esperimento del dottor K.', 'Kurt Neumann', '1'),
('L esperimento del dottor K.', 'Kurt Neumann', '2'),
('L esperimento del dottor K.', 'Kurt Neumann', '3'),
('L esperimento del dottor K.', 'Kurt Neumann', '4'),
('L esperimento del dottor K.', 'Kurt Neumann', '5'),
('Interstellar', 'Christopher Nolan', '1'),
('Interstellar', 'Christopher Nolan', '2'),
('Interstellar', 'Christopher Nolan', '3'),
('Interstellar', 'Christopher Nolan', '4'),
('Interstellar', 'Christopher Nolan', '5');

--
-- INSERT SETTORE
-- 
INSERT INTO settore (codice) VALUES
('S000ABC'),
('S001DEF'),
('S002GHI'),
('S003LMN'),
('S004OPQ');

--
-- INSERT COPIA_FILM_SETTORE
--
INSERT INTO copia_film_settore(titolo_copia, regista_copia, numero_copia, settore, posizione) VALUES
('Titanic','James Cameron','1','S000ABC','scaffale 1'),
('Titanic','James Cameron','2','S000ABC','scaffale IN alto'),
('Titanic','James Cameron','3','S000ABC','scaffale 4'),
('Titanic','James Cameron','4','S000ABC','sotTO lo scaffale 4'),
('Titanic','James Cameron','5','S000ABC','sopra il tetto'),
('Il Padrino', 'Francis Ford Coppola', '1','S001DEF', 'scaffale IN alto'),
('Il Padrino', 'Francis Ford Coppola', '2','S001DEF', 'scaffale IN basso'),
('Il Padrino', 'Francis Ford Coppola', '3','S001DEF', 'scaffale al centro'),
('Il Padrino', 'Francis Ford Coppola', '4','S001DEF', 'sotTO il tetto'),
('Il Padrino', 'Francis Ford Coppola', '5','S001DEF', 'vicino al muro'),
('Schindler s List', 'Steven Spielberg', '1','S002GHI', 'IN alto'),
('Schindler s List', 'Steven Spielberg', '2','S002GHI', 'IN basso'),
('Schindler s List', 'Steven Spielberg', '3','S002GHI', 'a destra'),
('Schindler s List', 'Steven Spielberg', '4','S002GHI', 'a sinistra'),
('Schindler s List', 'Steven Spielberg', '5','S002GHI', 'cercala'),
('Pulp Fiction', 'QuentIN Tarantino', '1', 'S003LMN', 'se la trovi fammelo sapere'),
('Pulp Fiction', 'QuentIN Tarantino', '2', 'S003LMN', 'non lo so'),
('Pulp Fiction', 'QuentIN Tarantino', '3', 'S003LMN', 'ho finiTO le idee'),
('Pulp Fiction', 'QuentIN Tarantino', '4', 'S003LMN', 'come quella di prima'),
('Pulp Fiction', 'QuentIN Tarantino', '5', 'S003LMN', 'non IN quesTO negozio'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '1','S002GHI','scaffale 1'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '2','S002GHI','scaffale 1'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '3','S002GHI','scaffale 1'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '4','S002GHI','scaffale 1'),
('Il Signore degli Anelli: La Compagnia dell Anello', 'Peter Jackson', '5','S002GHI','scaffale 1'),
('Fight Club', 'David Fincher', '1','S004OPQ','prova scaffale 3'),
('Fight Club', 'David Fincher', '2','S004OPQ','prova scaffale 1'),
('Fight Club', 'David Fincher', '3','S004OPQ','prova scaffale 2'),
('Fight Club', 'David Fincher', '4','S004OPQ','non puoi trovarla'),
('Fight Club', 'David Fincher', '5','S004OPQ','prova a trovarmi'),
('Inception', 'Christopher Nolan','1','S000ABC','scaffale 1'),
('Inception', 'Christopher Nolan','2','S000ABC','scaffale IN alto'),
('Inception', 'Christopher Nolan','3','S000ABC','scaffale 4'),
('Inception', 'Christopher Nolan','4','S000ABC','sotTO lo scaffale 4'),
('Inception', 'Christopher Nolan','5','S000ABC','sopra il tetto'),
('Matrix', 'Lana Wachowski', '1','S001DEF', 'scaffale IN alto'),
('Matrix', 'Lana Wachowski', '2','S001DEF', 'scaffale IN basso'),
('Matrix', 'Lana Wachowski', '3','S001DEF', 'scaffale al centro'),
('Matrix', 'Lana Wachowski', '4','S001DEF', 'sotTO il tetto'),
('Matrix', 'Lana Wachowski', '5','S001DEF', 'vicino al muro'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '1','S002GHI','scaffale 2'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '2','S002GHI','scaffale 3'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '3','S002GHI','scaffale 4'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '4','S002GHI','scaffale 5'),
('Il Silenzio degli innocenti', 'Jonathan Demme', '5','S002GHI','scaffale 6'),
('Hannibal', 'Ridley Scott', '1','S004OPQ','La copia piu rara'),
('Hannibal', 'Ridley Scott', '2','S004OPQ','rarità leggendaria'),
('Hannibal', 'Ridley Scott', '3','S004OPQ','rarità comune'),
('Hannibal', 'Ridley Scott', '4','S004OPQ','rarità epica'),
('Hannibal', 'Ridley Scott', '5','S004OPQ','rarità rara'),
('La Vita è Bella', 'RoberTO Benigni', '1','S002GHI', 'IN basso'),
('La Vita è Bella', 'RoberTO Benigni', '2','S002GHI', 'IN alto'),
('La Vita è Bella', 'RoberTO Benigni', '3','S002GHI', 'a destra di quella prima'),
('La Vita è Bella', 'RoberTO Benigni', '4','S002GHI', 'a sinistra di quella prima'),
('La Vita è Bella', 'RoberTO Benigni', '5','S002GHI', 'scaffale piu alto'),
('Salvate il soldato Ryan', 'Steven Spielberg', '1','S000ABC','scaffale 4'),
('Salvate il soldato Ryan', 'Steven Spielberg', '2','S000ABC','scaffale 3'),
('Salvate il soldato Ryan', 'Steven Spielberg', '3','S000ABC','scaffale 2'),
('Salvate il soldato Ryan', 'Steven Spielberg', '4','S000ABC','scaffale 1'),
('Salvate il soldato Ryan', 'Steven Spielberg', '5','S000ABC','scaffale 6'),
('Il Miglio Verde', 'Frank Darabont', '1','S002GHI','scaffale 1'),
('Il Miglio Verde', 'Frank Darabont', '2','S002GHI','scaffale 2'),
('Il Miglio Verde', 'Frank Darabont', '3','S002GHI','scaffale 3'),
('Il Miglio Verde', 'Frank Darabont', '4','S002GHI','scaffale 4'),
('Il Miglio Verde', 'Frank Darabont', '5','S002GHI','scaffale 5'),
('Ring', 'Hideo Nakata', '1','S003LMN','scaffale 5'),
('Ring', 'Hideo Nakata', '2','S003LMN','scaffale 4'),
('Ring', 'Hideo Nakata', '3','S003LMN','scaffale 3'),
('Ring', 'Hideo Nakata', '4','S003LMN','scaffale 2'),
('Ring', 'Hideo Nakata', '5','S003LMN','scaffale 1'),
('The Ring', 'Gore Verbinski', '1','S001DEF','scaffale 2'),
('The Ring', 'Gore Verbinski', '2','S001DEF','scaffale 2'),
('The Ring', 'Gore Verbinski', '3','S001DEF','scaffale 2'),
('The Ring', 'Gore Verbinski', '4','S001DEF','scaffale 2'),
('The Ring', 'Gore Verbinski', '5','S001DEF','scaffale 2'),
('Scarface - Lo sfregiato', 'Howard Hawks', '1','S001DEF','scaffale 3'),
('Scarface - Lo sfregiato', 'Howard Hawks', '2','S001DEF','scaffale 3'),
('Scarface - Lo sfregiato', 'Howard Hawks', '3','S001DEF','scaffale 3'),
('Scarface - Lo sfregiato', 'Howard Hawks', '4','S001DEF','scaffale 3'),
('Scarface - Lo sfregiato', 'Howard Hawks', '5','S001DEF','scaffale 3'),
('Scarface', 'Brian De Palma', '1','S004OPQ','scaffale 5'),
('Scarface', 'Brian De Palma', '2','S004OPQ','scaffale 5'),
('Scarface', 'Brian De Palma', '3','S004OPQ','scaffale 5'),
('Scarface', 'Brian De Palma', '4','S004OPQ','scaffale 5'),
('Scarface', 'Brian De Palma', '5','S004OPQ','scaffale 5'),
('La Mosca', 'David Cronenberg', '1','S000ABC','scaffale 4'),
('La Mosca', 'David Cronenberg', '2','S000ABC','scaffale 4'),
('La Mosca', 'David Cronenberg', '3','S000ABC','scaffale 4'),
('La Mosca', 'David Cronenberg', '4','S000ABC','scaffale 4'),
('La Mosca', 'David Cronenberg', '5','S000ABC','scaffale 4'),
('L esperimento del dottor K.', 'Kurt Neumann', '1','S003LMN','scaffale 6'),
('L esperimento del dottor K.', 'Kurt Neumann', '2','S003LMN','scaffale 6'),
('L esperimento del dottor K.', 'Kurt Neumann', '3','S003LMN','scaffale 6'),
('L esperimento del dottor K.', 'Kurt Neumann', '4','S003LMN','scaffale 6'),
('L esperimento del dottor K.', 'Kurt Neumann', '5','S003LMN','scaffale 6'),
('Interstellar', 'Christopher Nolan', '1','S004OPQ','ultimo scaffale'),
('Interstellar', 'Christopher Nolan', '2','S004OPQ','ultimo scaffale'),
('Interstellar', 'Christopher Nolan', '3','S004OPQ','ultimo scaffale'),
('Interstellar', 'Christopher Nolan', '4','S004OPQ','ultimo scaffale'),
('Interstellar', 'Christopher Nolan', '5','S004OPQ','ultimo scaffale');

--
-- INSERT CLIENTE
--
INSERT INTO cliente (tessera) VALUES
('T001ABC'),
('T002DEF'),
('T003GHI'),
('T004JKL'),
('T005MNO'),
('T006PQR'),
('T007STU'),
('T008VWX'),
('T009YZA');

--
-- INSERT NOLEGGIO_ATTIVO
--
INSERT INTO noleggio_attivo (titolo_copia, regista_copia, numero_copia, data_inizio, tessera_cliente,costo, data_limite) VALUES
('Titanic', 'James Cameron', 1, '2023-08-01', 'T001ABC', 2.99, '2023-08-08'),
('Il Padrino', 'Francis Ford Coppola', 2, '2023-08-02', 'T002DEF', 3.50, '2023-08-09'),
('Schindler s List', 'Steven Spielberg', 3, '2023-08-03', 'T003GHI', 2.75, '2023-08-10'),
('Pulp Fiction', 'Quentin Tarantino', 4, '2023-08-04', 'T004JKL', 2.25, '2023-08-11'),
('Interstellar', 'Christopher Nolan', 5, '2023-08-05', 'T005MNO', 4.50, '2023-08-12'),
('Matrix', 'Lana Wachowski', 1, '2023-08-06', 'T006PQR', 2.00, '2023-08-13'),
('La Vita è Bella', 'Roberto Benigni', 2, '2023-08-07', 'T007STU', 3.25, '2023-09-14'),
('Salvate il soldato Ryan', 'Steven Spielberg', 3, '2023-08-08', 'T008VWX', 2.75, '2023-09-15'),
('Inception', 'Christopher Nolan', 4, '2023-08-09', 'T009YZA', 3.99, '2023-09-16'),
('Il Miglio Verde', 'Frank Darabont', 5, '2023-08-10', 'T001ABC', 2.50, '2023-09-17');

--
-- INSERT NOLEGGIO_TERMINATO
--
INSERT INTO noleggio_terminato (titolo_copia, regista_copia, numero_copia, data_inizio, tessera_cliente, costo, data_limite, data_consegna) VALUES
('Hannibal', 'Ridley Scott', 1, '2023-08-01', 'T002DEF', 5.0, '2023-08-07', '2023-08-06'),
('Matrix', 'Lana Wachowski', 2, '2023-07-15', 'T002DEF', 4.0, '2023-07-20', '2023-07-19'),
('La Vita è Bella', 'Roberto Benigni', 3, '2023-06-10', 'T002DEF', 3.0, '2023-06-15', '2023-06-14'),
('Inception', 'Christopher Nolan', 1, '2023-05-20', 'T002DEF', 4.5, '2023-05-26', '2023-05-25'),
('La Mosca', 'David Cronenberg', 2, '2023-07-25', 'T001ABC', 3.5, '2023-08-01', '2023-07-31'),
('Pulp Fiction', 'Quentin Tarantino', 1, '2023-06-10', 'T001ABC', 5.0, '2023-06-17', '2023-06-16'),
('Titanic', 'James Cameron', 2, '2023-05-05', 'T001ABC', 6.0, '2023-05-12', '2023-05-11'),
('Il Silenzio degli Innocenti', 'Jonathan Demme', 3, '2023-04-20', 'T001ABC', 4.0, '2023-04-27', '2023-04-26');

--
-- INSERT DATI_ANAGRAFICI
--
INSERT INTO dati_anagrafici (tessera_cliente, cf, nome, cognome, sesso, luogo_nascita, data_nascita)
VALUES
('T001ABC', 'CF001', 'Mario', 'Rossi', 'M', 'Roma', '1985-03-15'),
('T002DEF', 'CF002', 'Anna', 'Bianchi', 'F', 'Milano', '1992-08-22'),
('T003GHI', 'CF003', 'Luca', 'Verdi', 'M', 'Napoli', '1978-11-10'),
('T004JKL', 'CF004', 'Giulia', 'Martini', 'F', 'Firenze', '1989-06-03'),
('T005MNO', 'CF005', 'Francesco', 'Ferrari', 'M', 'Torino', '2001-01-25'),
('T006PQR', 'CF006', 'Laura', 'Russo', 'F', 'Bologna', '1980-09-18'),
('T007STU', 'CF007', 'Davide', 'Gallo', 'M', 'Palermo', '1996-12-12'),
('T008VWX', 'CF008', 'Sara', 'Conti', 'F', 'Genova', '1990-04-07'),
('T009YZA', 'CF009', 'Alessandro', 'De Luca', 'M', 'Catania', '1975-07-29');

--
-- INSERT RECAPITO_CLIENTE
--
INSERT INTO recapito_cliente (tessera_cliente, cellulare, telefono, email)
VALUES
('T001ABC', '+39 1234567890', '+39 0123456789', 'mario@example.com'),
('T002DEF', '+39 2345678901', '+39 3456789012', 'anna@example.com'),
('T003GHI', '+39 3456789012', '+39 4567890123', 'luca@example.com'),
('T004JKL', '+39 4567890123', '+39 5678901234', 'giulia@example.com'),
('T005MNO', '+39 5678901234', '+39 6789012345', 'francesco@example.com'),
('T006PQR', '+39 6789012345', '+39 7890123456', 'laura@example.com'),
('T007STU', '+39 7890123456', '+39 8901234567', 'davide@example.com'),
('T008VWX', '+39 8901234567', '+39 9012345678', 'sara@example.com'),
('T009YZA', '+39 9012345678', '+38 0123456789', 'alessandro@example.com');

--
-- INSERT IMPIEGATO
--
INSERT INTO impiegato (cf, nome)
VALUES
('CF1', 'dilo'),
('CF2', 'dado'),
('CF3', 'damians'),
('CF4', 'matt'),
('CF5', 'baffo');

--
-- INSERT RECAPITO_IMPIEGATO
--
INSERT INTO recapito_impiegato (cf_impiegato, cellulare, telefono, email)
VALUES
('CF1', '1234567890', '9876543210', 'dilo@gmail.com'),
('CF2', '2345678901', '8765432109', 'dado@gmail.com'),
('CF3', '3456789012', '7654321098', 'damians@gmail.com'),
('CF4', '4567890123', '6543210987', 'matt@gmail.com'),
('CF5', '5678901234', '5432109876', 'baffo@gmail.com');

--
-- INSERT INCARICO_CORRENTE
--
INSERT INTO incarico_corrente (cf_impiegato, tipo, inizio)
VALUES
('CF1', 'cassiere', '2023-01-01'),
('CF2', 'magazziniere', '2023-02-01'),
('CF3', 'commesso', '2023-03-01'),
('CF4', 'cassiere', '2023-04-01'),
('CF5', 'magazziniere', '2023-05-01');

--
-- INSERT TURNO
--
INSERT INTO turno (ora_inizio, ora_fine)
VALUES
('8', '12'),
('12', '16'),
('16', '20'),
('20', '0'),
('0', '4');

--
-- INSERT TURNO EFFETTIVO
--
INSERT INTO turno_effettivo (inizio_turno, fine_turno, data_turno)
VALUES
(8, 12, '2023-09-01'),
(12, 16, '2023-09-02'),
(16, 20, '2023-09-03'),
(20, 0, '2023-09-04'),
(0, 4, '2023-09-05'),
(8, 12, '2023-09-06'),
(12, 16, '2023-09-07'),
(16, 20, '2023-09-08'),
(20, 0, '2023-09-09'),
(0, 4, '2023-09-10'),
(8, 12, '2023-09-11'),
(12, 16, '2023-09-12'),
(16, 20, '2023-09-13'),
(20, 0, '2023-09-14'),
(0, 4, '2023-09-15'),
(8, 12, '2023-09-16'),
(12, 16, '2023-09-17'),
(16, 20, '2023-09-18'),
(20, 0, '2023-09-19'),
(0, 4, '2023-09-20');
--
-- INSERT TURNO IMPIEGATO
--
INSERT INTO turno_impiegato (inizio_effettivo, fine_effettiva, data_effettiva, cf_impiegato)
VALUES
(8, 12, '2023-09-01', 'CF1'),
(12, 16, '2023-09-02', 'CF2'),
(16, 20, '2023-09-03', 'CF3'),
(20, 0, '2023-09-04', 'CF4'),
(0, 4, '2023-09-05', 'CF5'),
(8, 12, '2023-09-06', 'CF1'),
(12, 16, '2023-09-07', 'CF2'),
(16, 20, '2023-09-08', 'CF3'),
(20, 0, '2023-09-09', 'CF4'),
(0, 4, '2023-09-10', 'CF5'),
(8, 12, '2023-09-11', 'CF1'),
(12, 16, '2023-09-12', 'CF2'),
(16, 20, '2023-09-13', 'CF3'),
(20, 0, '2023-09-14', 'CF4'),
(0, 4, '2023-09-15', 'CF5'),
(8, 12, '2023-09-16', 'CF1'),
(12, 16, '2023-09-17', 'CF2'),
(16, 20, '2023-09-18', 'CF3'),
(20, 0, '2023-09-19', 'CF4'),
(0, 4, '2023-09-20', 'CF5');




