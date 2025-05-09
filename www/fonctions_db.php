<?php 
function connexion()
	{//	Numéro de port 08 mysql et 06 mariadb
    /*
		$ma_db= new PDO("mysql:dbname=group06;host=localhost;port=3306" , "group06" , "secret" , 
					   //  type de DB  nom de la DB nom de l'adresse (ou IP)  nom utilisateur  mdp

				
			array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\'', PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
     */
    $ma_db = new PDO('mysql:host=db;dbname=group06;charset=utf8', 'group06', 'secret');
	return $ma_db;
}
function affichetempsmoyen($ma_db){
	
	$sql ="select iti_nom, trajet_id, temps_arret_moyen from resultat_temps_moyen;";
  $instru= $ma_db->prepare($sql);
  
 	$instru->execute();
 	$instru-> setfetchmode(PDO::FETCH_ASSOC);
 	$tab=$instru->fetchall();
 	$return="\n<TABLE>";
 	$return.="<THEAD>";
 	$return.="<TD>itinéraires</TD><TD>trajets</TD><TD>temps moyens des arrêts</TD>";
 	$return.="</THEAD>";
 	foreach ($tab as $ligne) {
 		$return.="\n<TR>";
 		$return.="<TD>".$ligne['iti_nom']."</TD>";
 		$return.="<TD>".$ligne['trajet_id']."</TD>";
 		$return.="<TD>".$ligne['temps_arret_moyen']."</TD>";
 		$return.="</TR>";
 	}
 	$return.="\n</TABLE>";
 	return $return;
}
function recherche_service($ma_db, $dateform){
	$sql ="select * from services_exception
	          where  date_service =:daterecherche;";
  $instru= $ma_db->prepare($sql);
  $instru->bindvalue('daterecherche',$dateform,PDO::PARAM_STR);
 	$instru->execute();
 	$instru-> setfetchmode(PDO::FETCH_ASSOC);
 	$tab=$instru->fetchall();
 	$return="\n<TABLE>";
 	$return.="<THEAD>";
 	$return.="<TD>Service</TD>";
 	$return.="</THEAD>";
 	foreach ($tab as $ligne) {
 		$return.="\n<TR>";
 		$return.="<TD>".$ligne['nom']."</TD>";
 		$return.="</TR>";
 	}
 	$return.="\n</TABLE>";
 	return $return;
 	
}

function select_gare($ma_db,$gare,$nb){
	if($nb=="" and $gare!=""){
		$sql ="select arr_nom,serv_nom,nb_train, nb_arrivee,nb_depart from nb_arrets where locate(lower(:nom),lower(arr_nom))>0;";
	    $instru= $ma_db->prepare($sql);
  		$instru->bindvalue('nom',$gare,PDO::PARAM_STR);
	}
	else if($nb!="" and $gare!=""){
		$sql ="select arr_nom,serv_nom,nb_train, nb_arrivee,nb_depart from nb_arrets where locate(lower(:nom),lower(arr_nom))>0 and nb_train>=:nb ;";
	    $instru= $ma_db->prepare($sql);
  		$instru->bindvalue('nom',$gare,PDO::PARAM_STR);
  		$instru->bindvalue('nb',$nb,PDO::PARAM_INT);
	}
	else if($nb!="" and $gare==""){
		$sql ="select arr_nom,serv_nom,nb_train, nb_arrivee,nb_depart
				 from nb_arrets where nb_train>=:nb;";
	    $instru= $ma_db->prepare($sql);
  		$instru->bindvalue('nb',$nb,PDO::PARAM_INT);
	 }
	
 	$instru->execute();
 	$instru-> setfetchmode(PDO::FETCH_ASSOC);
 	$tab=$instru->fetchall();
 	$return="\n<TABLE>";
 	$return.="<THEAD>";
 	$return.="<TD>Gares</TD><TD>Services</TD>
 				<TD>Nombres de trains</TD><TD>Nombres d'arrivées</TD>
 				<TD>Nombres de départ</TD>";
 	$return.="</THEAD>";
 	foreach ($tab as $ligne) {
 		$return.="\n<TR>";
 		$return.="<TD>".$ligne['arr_nom']."</TD>";
 		$return.="<TD>".$ligne['serv_nom']."</TD>";
 		$return.="<TD>".$ligne['nb_train']."</TD>";
 		$return.="<TD>".$ligne['nb_arrivee']."</TD>";
 		$return.="<TD>".$ligne['nb_depart']."</TD>";
 		$return.="</TR>";

 	}
 	$return.="\n</TABLE>";
 	return $return;

}
function select_arret($ma_db){
	$sql ="select arr_id, arr_nom,arr_latitude, arr_longitude from arret where 
	     arr_longitude between 2.51357303225 and 6.15665815596
	and arr_latitude between 49.5294835476 and 51.4750237087
	and locate('(',arr_nom)=0
	order by 1;";
	//locate('(',arr_nom)=0 pour éviter les gares non belges
  $instru= $ma_db->prepare($sql);
  
 	$instru->execute();
 	$instru-> setfetchmode(PDO::FETCH_ASSOC);
 	$tab=$instru->fetchall();
 	
   	$return="\n<TABLE>";
 	$return.="<THEAD>";
 	$return.="<TD>id Arret</TD><TD>nom</TD><TD>latitude</TD>
 	<TD>longitude</TD><TD>sélectionner</TD>";
 	$return.="</THEAD>";
 	 	
 	foreach ($tab as $ligne) {
 		$return.="\n<TR>";
 		$return.="<TD>".$ligne['arr_id']."</TD>";
 		$return.="<TD>".$ligne['arr_nom']."</TD>";
 		$return.="<TD>".$ligne['arr_latitude']."</TD>";
 		$return.="<TD>".$ligne['arr_longitude']."</TD>";
 		$return.="<TD>";
 		$return.="<INPUT type='radio' name='choix' value='".$ligne['arr_id']."'>";
 		$return.="</input>";
 		$return.="</TD></TR>";
 	}
 	
 	$return.="\n</TABLE>";
 	
 	
 	return $return;

}
function update_arret($ma_db,$arretID){
	$sql ="select arr_id, arr_nom,arr_latitude, arr_longitude from arret where arr_id=:arret_id;";
	$instru= $ma_db->prepare($sql);
	$instru->bindvalue('arret_id',$arretID,PDO::PARAM_INT);
 	$instru->execute();
 	$instru-> setfetchmode(PDO::FETCH_ASSOC);
 	$tab=$instru->fetchall();
 	foreach ($tab as $ligne) {
 		$arr_id=$ligne['arr_id'];
 		$arr_nom=$ligne['arr_nom'];
 		$arr_latitude=$ligne['arr_latitude'];
 		$arr_longitude=$ligne['arr_longitude'];


 	}

	$html1=
	" <input type='hidden' name='arr_idA' value='$arr_id'>
      <input type='hidden' name='arr_nomA' value='$arr_nom'>
      <input type='hidden' name='arr_latitudeA' value='$arr_latitude'>
     <input type='hidden' name='arr_longitudeA' value='$arr_longitude'>
     ID Arret :<input type='number' name='arr_id' value='$arr_id' min='8000000' max='9999999'>
     <BR>
     Nom : <input type='text'  name='arr_nom' value='$arr_nom' >
     <BR>
     Latitude :<input type='number' name='arr_latitude'  value='$arr_longitude' min='2.51357303225' max ='6.15665815596'>
     <BR>
     Longitude :<input type='number' name='arr_longitude' value='$arr_latitude' min='49.5294835476' max='51.4750237087'>
     <BR>
     <input type='submit' name='action2'>";
     return $html1;
}
function maj_arret($ma_db){

}
 ?>

