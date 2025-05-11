-- SET GLOBAL default_storage_engine = 'InnoDB'; /* pour les index */
SET TIME_ZONE ="+00:00";

DROP DATABASE IF EXISTS group06;
CREATE DATABASE group06;
USE group06;

/* creation des table */
DROP TABLE IF EXISTS timezoneid;
CREATE TABLE timezoneid(
tzid_fuseau varchar(38) check(trim(tzid_fuseau)<>'') primary key
)ENGINE=INNODB;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/timezone.csv'
    INTO TABLE timezoneid
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
(tzid_fuseau);

DROP TABLE IF EXISTS agence;
CREATE TABLE agence
(
    ag_id INT PRIMARY KEY AUTO_INCREMENT,
    ag_nom VARCHAR(100)  NOT NULL check(trim(ag_nom)<>''),
    ag_url VARCHAR(255) check(ag_url REGEXP "(https?:\/\/|www\.)[\.A-Za-z0-9\-]+\.[a-zA-Z]{2,4}\/?" ),
    /* http:// avec ou sans s ou www. suivi au moins de 1 ou plusiers lettre ou chiffre ou point et se terminant par .2 à 4 lettres avec ou pas un / */
    ag_fuseau VARCHAR(32) not null check(trim(ag_fuseau)<>''),
    ag_telephone VARCHAR(16) not null check(ag_telephone regexp "^\\+[0-9]{3,15}$"  and trim(ag_telephone)<>''),
    /* commence par + et puis 3 à 15 chiffres */
    ag_siege VARCHAR(255) not null check(trim(ag_siege)<>''),
    unique(ag_nom),
    FOREIGN KEY(ag_fuseau) REFERENCES timezoneid(tzid_fuseau) on delete restrict on update restrict
    
)ENGINE=INNODB;


DROP TABLE IF EXISTS arret;
CREATE TABLE arret
(
    arr_id INT PRIMARY KEY,
    arr_nom VARCHAR(100) UNIQUE NOT NULL check(trim(arr_nom)<>'') ,
    arr_latitude FLOAT NOT NULL check(arr_latitude between -90 and 90),
    arr_longitude FLOAT NOT NULL check(arr_longitude between -180 and 180) 
)ENGINE=INNODB;

DROP TABLE IF EXISTS  service;
CREATE TABLE service (
    serv_id INT PRIMARY KEY AUTO_INCREMENT,
    serv_nom VARCHAR(50) NOT NULL UNIQUE check(trim(serv_nom)<>'') ,
    serv_lundi boolean NOT NULL ,
    serv_mardi boolean NOT NULL ,
    serv_mercredi boolean NOT NULL ,
    serv_jeudi boolean NOT NULL ,
    serv_vendredi boolean NOT NULL,
    serv_samedi boolean NOT NULL,
    serv_dimanche boolean NOT NULL,
    serv_date_debut DATE not null,
    serv_date_fin DATE not null,
    check(serv_date_debut <= serv_date_fin )/*,*/
    /*check(serv_dimanche or serv_lundi or serv_mardi or serv_mercredi or serv_jeudi or serv_vendredi or serv_samedi )  au moins 1 checked  probleme ici car dans le csv de service pour jour férier rien n'est cocher dans la version2 */
    
)ENGINE=INNODB;

DROP TABLE IF EXISTS exception;
CREATE TABLE exception
(
    exc_service INT  ,
    exc_date DATE NOT NULL,
    exc_code tinyint check(exc_code in (1,2)) NOT NULL, /* 1 execpetion ajouté au service 2 service annulé */
    FOREIGN KEY(exc_service) REFERENCES service(serv_ID) on delete restrict on update restrict,
    UNIQUE(exc_service, exc_date, exc_code)
)ENGINE=INNODB;

/*
création de 2 triggers pour vérifier que les dates d'excpetions font bien partie de l'intervalle du service associé
*/
DELIMITER $
create procedure erreur_exception(new_date date, new_service int)
BEGIN
    DECLARE date_debut DATE;
    DECLARE date_fin DATE;

    SELECT serv_date_debut, serv_date_fin   INTO date_debut, date_fin
    FROM service
    WHERE serv_id=new_service;

    if new_date not between date_debut and date_fin then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la date de l''exception n''est pas dans l''intervalle du service';
    END IF;
end $


CREATE TRIGGER tr_bi_exception_verif_date_exception BEFORE INSERT  ON exception
FOR EACH ROW
BEGIN
    call erreur_exception( new.exc_date, new.exc_service);
   
END $

CREATE TRIGGER tr_bu_exception_verif_date_exception BEFORE update  ON exception
FOR EACH ROW
BEGIN
    call erreur_exception( new.exc_date, new.exc_service);
   
END $
DELIMITER ;

DROP TABLE IF EXISTS itineraire;
CREATE TABLE itineraire
(
    iti_id INT PRIMARY KEY,
    iti_agence_id INT NOT NULL,
    iti_type VARCHAR(10) NOT NULL check(trim(iti_type)<>''), /* check supplémentaire ???*/
    iti_nom VARCHAR(100)  NOT NULL check(trim(iti_nom)<>''),
    unique(iti_type, iti_nom),
    FOREIGN KEY(iti_agence_id) REFERENCES agence(ag_id) on delete restrict on update restrict
)ENGINE=INNODB;
DROP TABLE IF EXISTS arret_desservi;
CREATE TABLE arret_desservi
(
    ad_itineraire_id INT NOT NULL,
    ad_arret_id INT NOT NULL,
    ad_sequence SMALLINT check(ad_sequence>0) NOT NULL,
        index(ad_arret_id),
    FOREIGN KEY(ad_arret_id) REFERENCES arret(arr_ID)  on update cascade,
    UNIQUE (ad_itineraire_id, ad_sequence)
)ENGINE=INNODB;
DROP TABLE IF EXISTS trajet;
CREATE TABLE trajet
(
    tr_id VARCHAR(50) PRIMARY KEY check(trim(tr_id)<>''),
    tr_service_id INT NOT NULL,
    tr_itineraire_id INT NOT NULL,
    tr_direction BOOLEAN NOT NULL,
    FOREIGN KEY(tr_service_id) REFERENCES service(serv_id) on delete restrict on update restrict,
    index(tr_itineraire_id), /* modif09052025 */ 
    FOREIGN KEY(tr_itineraire_id) REFERENCES itineraire(iti_id) on delete cascade on update restrict /* si o supprime un itinéraire les trajets sont supprimés*/
)ENGINE=INNODB;
DROP TABLE IF EXISTS horaire;
CREATE TABLE horaire
(
    hor_trajet_id VARCHAR(50) NOT NULL check(trim(hor_trajet_id)<>''),
    hor_itineraire_id INT NOT NULL,
    hor_arret_id INT NOT NULL,
    hor_heure_arrivee TIME,
    hor_heure_depart TIME,
    
   CHECK (
            hor_heure_arrivee IS NULL
            OR hor_heure_depart IS NULL
            OR hor_heure_arrivee <= hor_heure_depart
        ), /*check posait probleme quand hor_heure_arrivee ou hor_heure_depart etait nul*/
    index(hor_trajet_id),
    FOREIGN KEY(hor_trajet_id) REFERENCES trajet(tr_id) on delete cascade on update restrict,
    index(hor_itineraire_id),
    FOREIGN KEY(hor_itineraire_id) REFERENCES itineraire(iti_id) on delete cascade on update restrict, /* si on supprime un itinéraire les horaires des arrets sont supprimés???" */
    index(hor_arret_id),
    FOREIGN KEY(hor_arret_id) REFERENCES arret(arr_id) on update cascade,
    unique(hor_trajet_id,hor_itineraire_id,hor_arret_id)
)ENGINE=INNODB;

DROP TABLE if exists langue;
CREATE TABLE langue(
langue_id CHAR(2) primary key check(trim(langue_id)<>''));

LOAD DATA INFILE '/docker-entrypoint-initdb.d/iso639.csv'
    INTO TABLE langue
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
(langue_id);

DROP TABLE if exists languepricnipale;
CREATE TABLE langueprincipale
(
    lp_agence_id INT not null,
    lp_langue VARCHAR(2) not null,
    FOREIGN KEY(lp_agence_id) REFERENCES agence(ag_ID) on delete restrict on update restrict,
    FOREIGN KEY(lp_langue) references langue(langue_id) on delete restrict on update restrict,
    unique(lp_agence_id, lp_langue)
)ENGINE=INNODB;


/*------------------------------------*/
create view date_services_sans_les_exceptions as
WITH RECURSIVE days_services (num, noms_des_services, date_service, jour,date_debut, date_fin,dim,lun,mar,mer, jeu,ven, sam) AS (
    SELECT  serv_id,serv_nom,serv_date_debut,dayofweek(serv_date_debut), serv_date_debut, serv_date_fin, serv_dimanche, serv_lundi, serv_mardi, serv_mercredi,serv_jeudi, serv_vendredi, serv_samedi
    from service 
 
      UNION ALL
	SELECT  s.serv_id, s.serv_nom, DATE_ADD(date_service, INTERVAL 1 DAY) , dayofweek(DATE_ADD(date_service, INTERVAL 1 DAY)), serv_date_debut, serv_date_fin
    , serv_dimanche, serv_lundi, serv_mardi, serv_mercredi,serv_jeudi, serv_vendredi, serv_samedi
    from service s join days_services d on s.serv_id=d.num
     where  DATE_ADD(date_service, INTERVAL 1 DAY)<=d.date_fin
      
    
)
select date_service, group_concat(noms_des_services) from days_services
 where ((jour=1 and  dim=1) or
  (jour=2 and lun=1) or
   (jour=3 and mar=1) or
    (jour=4 and mer=1) or
     (jour=5 and jeu=1) or
      (jour=6 and ven=1) or
       (jour=7 and sam=1) ) 
 group by date_service;
 
/*-------------------------------------------*/ 
 
 create view ligne_depart_avec_exceptions as 
  SELECT serv_id,serv_nom,serv_date_debut date_serv ,dayofweek(serv_date_debut), serv_date_debut, serv_date_fin, serv_dimanche, serv_lundi, serv_mardi, serv_mercredi,serv_jeudi, serv_vendredi, serv_samedi, false
    from service 
   union 
    SELECT  serv_id,serv_nom,exc_date,dayofweek(exc_date), serv_date_debut, serv_date_fin, 1, 0,0,0,0,0,1, true
    from service join exception on serv_id=exc_service
    where serv_id in (select exc_service from exception where exc_code=1  ) 
    ;
 
 
drop view if exists services_exception;
create view services_exception (date_service, nom) as
 WITH RECURSIVE days_services_except (num, noms_des_services, date_service, jour,date_debut, date_fin,dim,lun,mar,mer, jeu,ven, sam, exception) AS 
    (select * from ligne_depart_avec_exceptions
      UNION ALL
    SELECT  s.serv_id, s.serv_nom, DATE_ADD(date_service, INTERVAL 1 DAY) , dayofweek(DATE_ADD(date_service, INTERVAL 1 DAY)), serv_date_debut, serv_date_fin
    , serv_dimanche, serv_lundi, serv_mardi, serv_mercredi,serv_jeudi, serv_vendredi, serv_samedi, false
    from service s join days_services_except d on s.serv_id=d.num
     where  DATE_ADD(date_service, INTERVAL 1 DAY)<=d.date_fin 
  
)
select date_service, group_concat(distinct noms_des_services) as 'nom' from days_services_except
 where ((((jour=1 and  dim=1 ) or
  (jour=2 and lun=1 ) or
   (jour=3 and mar=1) or
    (jour=4 and mer=1) or
     (jour=5 and jeu=1) or
      (jour=6 and ven=1) or
       (jour=7 and sam=1) )   ) or exception=true /*or (num=2 and (jour=1 or jour=7)) */) and num not in (select exc_service from exception where exc_code=2  and exc_date=date_service) 
 group by date_service
 ;
 
-- select * from services_exception; /* pour la question 3 */

-- select * from date_services_sans_les_exceptions;

/* load ou insert */

LOAD DATA INFILE '/docker-entrypoint-initdb.d/AGENCE.CSV'
INTO TABLE agence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ag_id, ag_nom,ag_url,ag_fuseau,ag_telephone,ag_siege);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/ARRET.CSV'
INTO TABLE arret
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(arr_id, arr_nom,arr_latitude,arr_longitude);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/SERVICE.CSV'
INTO TABLE service
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(serv_id, serv_nom, serv_lundi, serv_mardi, serv_mercredi, serv_jeudi, serv_vendredi, serv_samedi, serv_dimanche, serv_date_debut, serv_date_fin);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/ITINERAIRE.CSV'
INTO TABLE itineraire
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(iti_id, iti_agence_id, iti_type, iti_nom);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/ARRET_DESSERVI.CSV'
INTO TABLE arret_desservi
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ad_itineraire_id,ad_arret_id,ad_sequence);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/EXCEPTION.CSV'
INTO TABLE exception
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(exc_service, exc_date, exc_code);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/TRAJET.CSV'
INTO TABLE trajet
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tr_id, tr_service_id, tr_itineraire_id, tr_direction);

LOAD DATA INFILE '/docker-entrypoint-initdb.d/HORRAIRE.CSV'
INTO TABLE horaire
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hor_trajet_id, hor_itineraire_id, hor_arret_id, @hor_heure_arrivee, @hor_heure_depart)
SET 
  hor_heure_arrivee = NULLIF(@hor_heure_arrivee, ''),
  hor_heure_depart = NULLIF(@hor_heure_depart, '');

LOAD DATA INFILE '/docker-entrypoint-initdb.d/LANGUEPRINCIPALE.CSV'
INTO TABLE langueprincipale
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(lp_agence_id, lp_langue);





/* --------------------------- */

create view temps_moyen_arret as
select iti_nom, hor_trajet_id, SEC_TO_TIME(avg(time_to_sec(timediff( hor_heure_depart ,hor_heure_arrivee)))) as temps_arret_moyen
From itineraire join horaire on hor_itineraire_id =iti_id
group by iti_nom, hor_trajet_id
WITH ROLLUP;

create view resultat_temps_moyen as
select ifnull(iti_nom,"temps moyen pour tous les itinéraires") iti_nom,ifnull(  hor_trajet_id, repeat("-",100)) trajet_id ,temps_arret_moyen from temps_moyen_arret;
; 

/*
select iti_nom, hor_trajet_id,  hor_heure_depart ,hor_heure_arrivee
From itineraire join horaire on hor_itineraire_id =iti_id;

select iti_nom, trajet_id, temps_arret_moyen from resultat_temps_moyen;

select arr_id, arr_nom,arr_latitude, arr_longitude from arret;
*/
create view nb_arrets as 
SELECT  arr_nom, serv_nom,count(tr_id) nb_train, count(hor_heure_arrivee) nb_arrivee, count(hor_HEURE_DEPART) nb_depart FROM arret left join horaire on hor_ARRET_ID=arr_ID left join trajet on hor_trajet_id = tr_id left join service on tr_service_id=serv_id
group by arr_nom , serv_nom
order by 3 desc;

