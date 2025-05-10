SET GLOBAL default_storage_engine = 'InnoDB'; /* pour les index */
SET TIME_ZONE ="+00:00";

DROP DATABASE IF EXISTS group06;
CREATE DATABASE group06;
USE group06;

/* creation des table */
DROP TABLE IF EXISTS timezoneid;
CREATE TABLE timezoneid(
tzid_fuseau varchar(38) primary key
);
insert into timezoneid values
('Africa/Abidjan'),('Africa/Accra'),('Africa/Addis_Ababa'),('Africa/Algiers'),('Africa/Asmara'),('Africa/Asmera'),('Africa/Bamako'),('Africa/Bangui'),('Africa/Banjul'),
('Africa/Bissau'),('Africa/Blantyre'),('Africa/Brazzaville'),('Africa/Bujumbura'),('Africa/Cairo'),('Africa/Casablanca'),('Africa/Ceuta'),('Africa/Conakry'),('Africa/Dakar'),
('Africa/Dar_es_Salaam'),('Africa/Djibouti'),('Africa/Douala'),('Africa/El_Aaiun'),('Africa/Freetown'),('Africa/Gaborone'),('Africa/Harare'),('Africa/Johannesburg'),('Africa/Juba'),
('Africa/Kampala'),('Africa/Khartoum'),('Africa/Kigali'),('Africa/Kinshasa'),('Africa/Lagos'),('Africa/Libreville'),('Africa/Lome'),('Africa/Luanda'),('Africa/Lubumbashi'),
('Africa/Lusaka'),('Africa/Malabo'),('Africa/Maputo'),('Africa/Maseru'),('Africa/Mbabane'),('Africa/Mogadishu'),('Africa/Monrovia'),('Africa/Nairobi'),('Africa/Ndjamena'),
('Africa/Niamey'),('Africa/Nouakchott'),('Africa/Ouagadougou'),('Africa/Porto-Novo'),('Africa/Sao_Tome'),('Africa/Timbuktu'),('Africa/Tripoli'),('Africa/Tunis'),('Africa/Windhoek'),
('America/Adak'),('America/Anchorage'),('America/Anguilla'),('America/Antigua'),('America/Araguaina'),('America/Argentina/Buenos_Aires'),('America/Argentina/Catamarca'),
('America/Argentina/ComodRivadavia'),('America/Argentina/Cordoba'),('America/Argentina/Jujuy'),('America/Argentina/La_Rioja'),('America/Argentina/Mendoza'),
('America/Argentina/Rio_Gallegos'),('America/Argentina/Salta'),('America/Argentina/San_Juan'),('America/Argentina/San_Luis'),('America/Argentina/Tucuman'),('America/Argentina/Ushuaia'),
('America/Aruba'),('America/Asuncion'),('America/Atikokan'),('America/Atka'),('America/Bahia'),('America/Bahia_Banderas'),('America/Barbados'),('America/Belem'),('America/Belize'),
('America/Blanc-Sablon'),('America/Boa_Vista'),('America/Bogota'),('America/Boise'),('America/Buenos_Aires'),('America/Cambridge_Bay'),('America/Campo_Grande'),('America/Cancun'),
('America/Caracas'),('America/Catamarca'),('America/Cayenne'),('America/Cayman'),('America/Chicago'),('America/Chihuahua'),('America/Ciudad_Juarez'),('America/Coral_Harbour'),
('America/Cordoba'),('America/Costa_Rica'),('America/Coyhaique'),('America/Creston'),('America/Cuiaba'),('America/Curacao'),('America/Danmarkshavn'),('America/Dawson'),
('America/Dawson_Creek'),('America/Denver'),('America/Detroit'),('America/Dominica'),('America/Edmonton'),('America/Eirunepe'),('America/El_Salvador'),('America/Ensenada'),
('America/Fort_Nelson'),('America/Fort_Wayne'),('America/Fortaleza'),('America/Glace_Bay'),('America/Godthab'),('America/Goose_Bay'),('America/Grand_Turk'),('America/Grenada'),
('America/Guadeloupe'),('America/Guatemala'),('America/Guayaquil'),('America/Guyana'),('America/Halifax'),('America/Havana'),('America/Hermosillo'),('America/Indiana/Indianapolis'),
('America/Indiana/Knox'),('America/Indiana/Marengo'),('America/Indiana/Petersburg'),('America/Indiana/Tell_City'),('America/Indiana/Vevay'),('America/Indiana/Vincennes'),
('America/Indiana/Winamac'),('America/Indianapolis'),('America/Inuvik'),('America/Iqaluit'),('America/Jamaica'),('America/Jujuy'),('America/Juneau'),('America/Kentucky/Louisville'),
('America/Kentucky/Monticello'),('America/Knox_IN'),('America/Kralendijk'),('America/La_Paz'),('America/Lima'),('America/Los_Angeles'),('America/Louisville'),('America/Lower_Princes'),
('America/Maceio'),('America/Managua'),('America/Manaus'),('America/Marigot'),('America/Martinique'),('America/Matamoros'),('America/Mazatlan'),('America/Mendoza'),('America/Menominee'),
('America/Merida'),('America/Metlakatla'),('America/Mexico_City'),('America/Miquelon'),('America/Moncton'),('America/Monterrey'),('America/Montevideo'),('America/Montreal'),
('America/Montserrat'),('America/Nassau'),('America/New_York'),('America/Nipigon'),('America/Nome'),('America/Noronha'),('America/North_Dakota/Beulah'),('America/North_Dakota/Center'),
('America/North_Dakota/New_Salem'),('America/Nuuk'),('America/Ojinaga'),('America/Panama'),('America/Pangnirtung'),('America/Paramaribo'),('America/Phoenix'),('America/Port-au-Prince'),
('America/Port_of_Spain'),('America/Porto_Acre'),('America/Porto_Velho'),('America/Puerto_Rico'),('America/Punta_Arenas'),('America/Rainy_River'),('America/Rankin_Inlet'),('America/Recife'),
('America/Regina'),('America/Resolute'),('America/Rio_Branco'),('America/Rosario'),('America/Santa_Isabel'),('America/Santarem'),('America/Santiago'),('America/Santo_Domingo'),
('America/Sao_Paulo'),('America/Scoresbysund'),('America/Shiprock'),('America/Sitka'),('America/St_Barthelemy'),('America/St_Johns'),('America/St_Kitts'),('America/St_Lucia'),
('America/St_Thomas'),('America/St_Vincent'),('America/Swift_Current'),('America/Tegucigalpa'),('America/Thule'),('America/Thunder_Bay'),('America/Tijuana'),('America/Toronto'),
('America/Tortola'),('America/Vancouver'),('America/Virgin'),('America/Whitehorse'),('America/Winnipeg'),('America/Yakutat'),('America/Yellowknife'),('Antarctica/Casey'),('Antarctica/Davis'),
('Antarctica/DumontDUrville'),('Antarctica/Macquarie'),('Antarctica/Mawson'),('Antarctica/McMurdo'),('Antarctica/Palmer'),('Antarctica/Rothera'),('Antarctica/South_Pole'),('Antarctica/Syowa'),
('Antarctica/Troll'),('Antarctica/Vostok'),('Arctic/Longyearbyen'),('Asia/Aden'),('Asia/Almaty'),('Asia/Amman'),('Asia/Anadyr'),('Asia/Aqtau'),('Asia/Aqtobe'),('Asia/Ashgabat'),
('Asia/Ashkhabad'),('Asia/Atyrau'),('Asia/Baghdad'),('Asia/Bahrain'),('Asia/Baku'),('Asia/Bangkok'),('Asia/Barnaul'),('Asia/Beirut'),('Asia/Bishkek'),('Asia/Brunei'),('Asia/Calcutta'),
('Asia/Chita'),('Asia/Choibalsan'),('Asia/Chongqing'),('Asia/Chungking'),('Asia/Colombo'),('Asia/Dacca'),('Asia/Damascus'),('Asia/Dhaka'),('Asia/Dili'),('Asia/Dubai'),('Asia/Dushanbe'),
('Asia/Famagusta'),('Asia/Gaza'),('Asia/Harbin'),('Asia/Hebron'),('Asia/Ho_Chi_Minh'),('Asia/Hong_Kong'),('Asia/Hovd'),('Asia/Irkutsk'),('Asia/Istanbul'),('Asia/Jakarta'),('Asia/Jayapura'),
('Asia/Jerusalem'),('Asia/Kabul'),('Asia/Kamchatka'),('Asia/Karachi'),('Asia/Kashgar'),('Asia/Kathmandu'),('Asia/Katmandu'),('Asia/Khandyga'),('Asia/Kolkata'),('Asia/Krasnoyarsk'),
('Asia/Kuala_Lumpur'),('Asia/Kuching'),('Asia/Kuwait'),('Asia/Macao'),('Asia/Macau'),('Asia/Magadan'),('Asia/Makassar'),('Asia/Manila'),('Asia/Muscat'),('Asia/Nicosia'),
('Asia/Novokuznetsk'),('Asia/Novosibirsk'),('Asia/Omsk'),('Asia/Oral'),('Asia/Phnom_Penh'),('Asia/Pontianak'),('Asia/Pyongyang'),('Asia/Qatar'),('Asia/Qostanay'),('Asia/Qyzylorda'),
('Asia/Rangoon'),('Asia/Riyadh'),('Asia/Saigon'),('Asia/Sakhalin'),('Asia/Samarkand'),('Asia/Seoul'),('Asia/Shanghai'),('Asia/Singapore'),('Asia/Srednekolymsk'),('Asia/Taipei'),
('Asia/Tashkent'),('Asia/Tbilisi'),('Asia/Tehran'),('Asia/Tel_Aviv'),('Asia/Thimbu'),('Asia/Thimphu'),('Asia/Tokyo'),('Asia/Tomsk'),('Asia/Ujung_Pandang'),('Asia/Ulaanbaatar'),
('Asia/Ulan_Bator'),('Asia/Urumqi'),('Asia/Ust-Nera'),('Asia/Vientiane'),('Asia/Vladivostok'),('Asia/Yakutsk'),('Asia/Yangon'),('Asia/Yekaterinburg'),('Asia/Yerevan'),('Atlantic/Azores'),
('Atlantic/Bermuda'),('Atlantic/Canary'),('Atlantic/Cape_Verde'),('Atlantic/Faeroe'),('Atlantic/Faroe'),('Atlantic/Jan_Mayen'),('Atlantic/Madeira'),('Atlantic/Reykjavik'),
('Atlantic/South_Georgia'),('Atlantic/St_Helena'),('Atlantic/Stanley'),('Australia/ACT'),('Australia/Adelaide'),('Australia/Brisbane'),('Australia/Broken_Hill'),('Australia/Canberra'),
('Australia/Currie'),('Australia/Darwin'),('Australia/Eucla'),('Australia/Hobart'),('Australia/LHI'),('Australia/Lindeman'),('Australia/Lord_Howe'),('Australia/Melbourne'),('Australia/NSW'),
('Australia/North'),('Australia/Perth'),('Australia/Queensland'),('Australia/South'),('Australia/Sydney'),('Australia/Tasmania'),('Australia/Victoria'),('Australia/West'),
('Australia/Yancowinna'),('Brazil/Acre'),('Brazil/DeNoronha'),('Brazil/East'),('Brazil/West'),('Canada/Atlantic'),('Canada/Central'),('Canada/Eastern'),('Canada/Mountain'),
('Canada/Newfoundland'),('Canada/Pacific'),('Canada/Saskatchewan'),('Canada/Yukon'),('Chile/Continental'),('Chile/EasterIsland'),('Cuba'),('Egypt'),('Eire'),('Europe/Amsterdam'),
('Europe/Andorra'),('Europe/Astrakhan'),('Europe/Athens'),('Europe/Belfast'),('Europe/Belgrade'),('Europe/Berlin'),('Europe/Bratislava'),('Europe/Brussels'),('Europe/Bucharest'),
('Europe/Budapest'),('Europe/Busingen'),('Europe/Chisinau'),('Europe/Copenhagen'),('Europe/Dublin'),('Europe/Gibraltar'),('Europe/Guernsey'),('Europe/Helsinki'),('Europe/Isle_of_Man'),
('Europe/Istanbul'),('Europe/Jersey'),('Europe/Kaliningrad'),('Europe/Kiev'),('Europe/Kirov'),('Europe/Kyiv'),('Europe/Lisbon'),('Europe/Ljubljana'),('Europe/London'),('Europe/Luxembourg'),
('Europe/Madrid'),('Europe/Malta'),('Europe/Mariehamn'),('Europe/Minsk'),('Europe/Monaco'),('Europe/Moscow'),('Europe/Nicosia'),('Europe/Oslo'),('Europe/Paris'),('Europe/Podgorica'),
('Europe/Prague'),('Europe/Riga'),('Europe/Rome'),('Europe/Samara'),('Europe/San_Marino'),('Europe/Sarajevo'),('Europe/Saratov'),('Europe/Simferopol'),('Europe/Skopje'),('Europe/Sofia'),
('Europe/Stockholm'),('Europe/Tallinn'),('Europe/Tirane'),('Europe/Tiraspol'),('Europe/Ulyanovsk'),('Europe/Uzhgorod'),('Europe/Vaduz'),('Europe/Vatican'),('Europe/Vienna'),('Europe/Vilnius'),
('Europe/Volgograd'),('Europe/Warsaw'),('Europe/Zagreb'),('Europe/Zaporozhye'),('Europe/Zurich'),('GB'),('GB-Eire'),('Hongkong'),('Iceland'),('Indian/Antananarivo'),('Indian/Chagos'),
('Indian/Christmas'),('Indian/Cocos'),('Indian/Comoro'),('Indian/Kerguelen'),('Indian/Mahe'),('Indian/Maldives'),('Indian/Mauritius'),('Indian/Mayotte'),('Indian/Reunion'),('Iran'),
('Israel'),('Jamaica'),('Japan'),('Kwajalein'),('Libya'),('Mexico/BajaNorte'),('Mexico/BajaSur'),('Mexico/General'),('Navajo'),('Pacific/Apia'),('Pacific/Auckland'),('Pacific/Bougainville'),
('Pacific/Chatham'),('Pacific/Chuuk'),('Pacific/Easter'),('Pacific/Efate'),('Pacific/Enderbury'),('Pacific/Fakaofo'),('Pacific/Fiji'),('Pacific/Funafuti'),('Pacific/Galapagos'),
('Pacific/Gambier'),('Pacific/Guadalcanal'),('Pacific/Guam'),('Pacific/Honolulu'),('Pacific/Johnston'),('Pacific/Kanton'),('Pacific/Kiritimati'),('Pacific/Kosrae'),('Pacific/Kwajalein'),
('Pacific/Majuro'),('Pacific/Marquesas'),('Pacific/Midway'),('Pacific/Nauru'),('Pacific/Niue'),('Pacific/Norfolk'),('Pacific/Noumea'),('Pacific/Pago_Pago'),('Pacific/Palau'),
('Pacific/Pitcairn'),('Pacific/Pohnpei'),('Pacific/Ponape'),('Pacific/Port_Moresby'),('Pacific/Rarotonga'),('Pacific/Saipan'),('Pacific/Samoa'),('Pacific/Tahiti'),('Pacific/Tarawa'),
('Pacific/Tongatapu'),('Pacific/Truk'),('Pacific/Wake'),('Pacific/Wallis'),('Pacific/Yap'),('Poland'),('Portugal'),('Singapore'),('Turkey'),('US/Alaska'),('US/Aleutian'),
('US/Arizona'),('US/Central'),('US/East-Indiana'),('US/Eastern'),('US/Hawaii'),('US/Indiana-Starke'),('US/Michigan'),('US/Mountain'),('US/Pacific'),('US/Samoa'),('Zulu')
;

DROP TABLE IF EXISTS agence;
CREATE TABLE agence
(
    ag_id INT PRIMARY KEY AUTO_INCREMENT,
    ag_nom VARCHAR(100)  NOT NULL,
    ag_url VARCHAR(255) check(ag_url REGEXP "(https?:\/\/|www\.)[\.A-Za-z0-9\-]+\.[a-zA-Z]{2,4}\/?"),
    /* http:// avec ou sans s ou www. suivi au moins de 1 ou plusiers lettre ou chiffre ou point et se terminant par .2 à 4 lettres avec ou pas un / */
    ag_fuseau VARCHAR(32) not null,
    ag_telephone VARCHAR(16) not null check(ag_telephone regexp "^\\+[0-9]{3,15}$"),
    /* commence par + et puis 3 à 15 chiffres */
    ag_siege VARCHAR(255) not null,
    unique(ag_nom),
    FOREIGN KEY(ag_fuseau) REFERENCES timezoneid(tzid_fuseau) on delete restrict on update restrict
    
);


DROP TABLE IF EXISTS arret;
CREATE TABLE arret
(
    arr_id INT PRIMARY KEY,
    arr_nom VARCHAR(100) UNIQUE NOT NULL ,
    arr_latitude FLOAT NOT NULL check(arr_latitude between -90 and 90),
    arr_longitude FLOAT NOT NULL check(arr_longitude between -180 and 180) 
);

DROP TABLE IF EXISTS  service;
CREATE TABLE service (
    serv_id INT PRIMARY KEY AUTO_INCREMENT,
    serv_nom VARCHAR(50) NOT NULL UNIQUE ,
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
    /*check(serv_dimanche or serv_lundi or serv_mardi or serv_mercredi or serv_jeudi or serv_vendredi or serv_samedi )  au moins 1 checked  probleme ici car dans le csv de service pour jour férier rien n'est cocher*/
    
);

DROP TABLE IF EXISTS exception;
CREATE TABLE exception
(
    exc_service INT  ,
    exc_date DATE NOT NULL,
    exc_code tinyint check(exc_code in (1,2)) NOT NULL, /* 1 execpetion ajouté au service 2 service annulé */
    FOREIGN KEY(exc_service) REFERENCES service(serv_ID) on delete restrict on update restrict,
    UNIQUE(exc_service, exc_date, exc_code)
);
DROP TABLE IF EXISTS itineraire;
CREATE TABLE itineraire
(
    iti_id INT PRIMARY KEY,
    iti_agence_id INT NOT NULL,
    iti_type VARCHAR(10) NOT NULL, /* check ???*/
    iti_nom VARCHAR(100)  NOT NULL,
    unique(iti_type, iti_nom),
    FOREIGN KEY(iti_agence_id) REFERENCES agence(ag_id) on delete restrict on update restrict
);
DROP TABLE IF EXISTS arret_desservi;
CREATE TABLE arret_desservi
(
    ad_itineraire_id INT NOT NULL,
    ad_arret_id INT NOT NULL,
    ad_sequence SMALLINT check(ad_sequence>0) NOT NULL,
    FOREIGN KEY(ad_itineraire_id) REFERENCES itineraire(iti_ID) on delete cascade on update restrict, /* suppression en cascade */
    FOREIGN KEY(ad_arret_id) REFERENCES arret(arr_ID) on delete restrict on update restrict, 
    UNIQUE (ad_itineraire_id, ad_sequence)
    
);
DROP TABLE IF EXISTS trajet;
CREATE TABLE trajet
(
    tr_id VARCHAR(50) PRIMARY KEY,
    tr_service_id INT NOT NULL,
    tr_itineraire_id INT NOT NULL,
    tr_direction BOOLEAN NOT NULL,
    FOREIGN KEY(tr_service_id) REFERENCES service(serv_id) on delete restrict on update restrict,
    FOREIGN KEY(tr_itineraire_id) REFERENCES itineraire(iti_id) on delete cascade on update restrict /* si o supprime un itinéraire les trajets sont supprimés*/
);
DROP TABLE IF EXISTS horaire;
CREATE TABLE horaire
(
    hor_trajet_id VARCHAR(50) NOT NULL,
    hor_itineraire_id INT NOT NULL,
    hor_arret_id INT NOT NULL,
    hor_heure_arrivee TIME,
    hor_heure_depart TIME,
   CHECK (
            hor_heure_arrivee IS NULL
            OR hor_heure_depart IS NULL
            OR hor_heure_arrivee <= hor_heure_depart
        ), /*check posait probleme quand hor_heure_arrivee ou hor_heure_depart etait nul*/
    FOREIGN KEY(hor_trajet_id) REFERENCES trajet(tr_id) on delete cascade on update restrict,
    FOREIGN KEY(hor_itineraire_id) REFERENCES itineraire(iti_id) on delete cascade on update restrict, /* si on supprime un itinéraire les horaires des arrets sont supprimés???" */
    FOREIGN KEY(hor_arret_id) REFERENCES arret(arr_id) on delete restrict on update restrict,
    unique(hor_trajet_id,hor_itineraire_id,hor_arret_id)
);

DROP TABLE if exists langue;
CREATE TABLE langue(
langue_id CHAR(2) primary key);
insert into langue values ('ab'),('aa'),('af'),('ak'),('sq'),('am'),('ar'),('an'),('hy'),('as'),('av'),('ae'),('ay'),('az'),('bm'),('ba'),('eu'),
('be'),('bn'),('bh'),('bi'),('bs'),('br'),('bg'),('my'),('ca'),('ch'),('ce'),('ny'),('zh'),('cv'),('kw'),('co'),('cr'),('hr'),('cs'),('da'),('dv'),('nl'),
('dz'),('en'),('eo'),('et'),('ee'),('fo'),('fj'),('fi'),('fr'),('ff'),('gl'),('ka'),('de'),('el'),('gn'),('gu'),('ht'),('ha'),('he'),('hz'),('hi'),('ho'),('hu'),
('ia'),('id'),('ie'),('ga'),('ig'),('ik'),('io'),('is'),('it'),('iu'),('ja'),('jv'),('kl'),('kn'),('kr'),('ks'),('kk'),('km'),('ki'),('rw'),('ky'),('kv'),('kg'),
('ko'),('ku'),('kj'),('la'),('lb'),('lg'),('li'),('ln'),('lo'),('lt'),('lu'),('lv'),('gv'),('mk'),('mg'),('ms'),('ml'),('mt'),('mi'),('mr'),('mh'),('mn'),('na'),
('nv'),('nd'),('ne'),('ng'),('nb'),('nn'),('no'),('ii'),('nr'),('oc'),('oj'),('cu'),('om'),('or'),('os'),('pa'),('pi'),('fa'),('pl'),('ps'),('pt'),('qu'),('rm'),
('rn'),('ro'),('ru'),('sa'),('sc'),('sd'),('se'),('sm'),('sg'),('sr'),('gd'),('sn'),('si'),('sk'),('sl'),('so'),('st'),('es'),('su'),('sw'),('ss'),('sv'),('ta'),
('te'),('tg'),('th'),('ti'),('bo'),('tk'),('tl'),('tn'),('to'),('tr'),('ts'),('tt'),('tw'),('ty'),
('ug'),('uk'),('ur'),('uz'),('ve'),('vi'),('vo'),('wa'),('cy'),('wo'),('fy'),('xh'),('yi'),('yo'),('za'),('zu');
DROP TABLE if exists languepricnipale;
CREATE TABLE langueprincipale
(
    lp_agence_id INT not null,
    lp_langue VARCHAR(2) not null,
    FOREIGN KEY(lp_agence_id) REFERENCES agence(ag_ID) on delete restrict on update restrict,
    FOREIGN KEY(lp_langue) references langue(langue_id) on delete restrict on update restrict,
    unique(lp_agence_id, lp_langue)
);



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
       (jour=7 and sam=1) )   ) or exception=true or (num=2 and (jour=1 or jour=7)) ) and num not in (select exc_service from exception where exc_code=2  and exc_date=date_service) 
 group by date_service
 ;
 
select * from services_exception; /* pour la question 3 */

select * from date_services_sans_les_exceptions;

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
select iti_nom, hor_trajet_id, SEC_TO_TIME(avg(timediff( hor_heure_depart ,hor_heure_arrivee))) as temps_arret_moyen
From itineraire join horaire on hor_itineraire_id =iti_id
group by iti_nom, hor_trajet_id
WITH ROLLUP;
create view resultat_temps_moyen as
select ifnull(iti_nom,"temps moyen pour tous les itinéraires") iti_nom,ifnull(  hor_trajet_id, repeat("-",100)) trajet_id ,temps_arret_moyen from temps_moyen_arret;

; 
select iti_nom, hor_trajet_id,  hor_heure_depart ,hor_heure_arrivee
From itineraire join horaire on hor_itineraire_id =iti_id;

select iti_nom, trajet_id, temps_arret_moyen from resultat_temps_moyen;

select arr_id, arr_nom,arr_latitude, arr_longitude from arret;

create view nb_arrets as 
SELECT  arr_nom, serv_nom,count(tr_id) nb_train, count(hor_heure_arrivee) nb_arrivee, count(hor_HEURE_DEPART) nb_depart FROM arret left join horaire on hor_ARRET_ID=arr_ID left join trajet on hor_trajet_id = tr_id left join service on tr_service_id=serv_id
group by arr_nom , serv_nom
order by 3 desc;

