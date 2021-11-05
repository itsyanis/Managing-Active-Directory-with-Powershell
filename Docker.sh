#!/bin/bash

function Menu_Docker {
   echo "1- Afficher la version de docker"
   echo "2- Répertorier toutes les images du Docker "
   echo "3- Répertorier tous les conteneurs docker exécutés "
   echo "4- Executer une image docker"
   echo "5- Démarrer un conteneur docker"
   echo "6- Supprimer un conteneur docker"
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
      echo -n "Entrer l'ID du conteneur à démarrer : "
      read Image
      docker run -it -d $ID
      ;;


    7)
      echo -n "Entrer l'ID du conteneur à supprimer : "
      read ID
      docker rm $ID
      ;;


  esac

}

Docker

