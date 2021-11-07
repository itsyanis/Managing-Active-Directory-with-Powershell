#!/bin/bash

function Menu_Docker {
   echo "1- Afficher la version de docker"
   echo "2- Répertorier toutes les images du Docker "
   echo "3- Répertorier tous les conteneurs docker exécutés "
   echo "4- Executer une image docker"
   echo "5- Démarrer un conteneur docker"
   echo "6- Redemmarer un conteneur docker"
   echo "7- Arreter un conteneur docker"
   echo "8- Supprimer un conteneur docker"
   echo "9- Supprimer une image docker"
}


function Docker {

  Menu_Docker

  echo -n "Choisissez une option : "
  read Option

  case $Option in

    1)
      docker --version
      ;;

    2)
      docker images
      ;;

    3)
      docker ps
      ;;

    4)
      echo -n "Entrer l'image à exécuté : "
      read Image
      docker run -it -d $Image
      ;;

    5)
      echo -n "Entrer l'ID du conteneur à démarrer : "
      read ID
      docker start $ID
      ;;

    6)
      echo -n "Entrer l'ID du conteneur à redemarrer : "
      read Image
      docker restart $ID
      ;;

    7)
      echo -n "Entrer l'ID du conteneur à arreter : "
      read Image
      docker stop $ID
      ;;
      
    8)
      echo -n "Entrer l'ID du conteneur à supprimer : "
      read ID
      docker rm $ID
      ;;
      
     9)
      echo -n "Entrer l'ID de l'image à supprimer : "
      read ID
      docker rmi $ID
      ;;

  esac

}

Docker

