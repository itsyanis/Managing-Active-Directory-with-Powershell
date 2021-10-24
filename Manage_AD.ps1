# Executez d'abord ces deux localmandes avant de lancer le programme
# Import-Module ActiveDirectory
# Import-Module 'Microsoft.Powershell.Security'




function Menu_Object_AD
{
    Write-Host "`n             Gérer l'Active Directory            `n"  -BackgroundColor "black"                                                      # Saut de ligne
    Write-Host "1- Ajouter un objet AD                             "    -BackgroundColor "black"
    Write-Host "2- Modifier un objet AD                            "    -BackgroundColor "black"
    Write-Host "3- Afficher un objet AD                            "    -BackgroundColor "black"
    Write-Host "4- Supprimer un objet AD                           "    -BackgroundColor "black"
    Write-Host "5- Quitter                                         "    -BackgroundColor "black"
    Write-Host "`n"
}



function Menu_Add_Object
{
    Write-Host "`n              Ajouter un Objet Active Directory            " -BackgroundColor "black"                                                       # Saut de ligne
    Write-Host "1- Ajouter un nouvel utilisateur                             " -BackgroundColor "black" 
    Write-Host "2- Ajouter une nouvelle Unitée Organisationnel               " -BackgroundColor "black" 
    Write-Host "3- Ajouter un groupe                                         " -BackgroundColor "black" 
    Write-Host "4- Ajouter une stratégie de groupe GPO                       " -BackgroundColor "black" 
    Write-Host "5- Retour                                                    " -BackgroundColor "black" 
    Write-Host "`n"
}


function Menu_Edit_Object
{
    Write-Host "`n"                                                       
    Write-Host "1- Modifier un utilisateur"
    Write-Host "2- Modifier une Unitée Organisationnel OU"
    Write-Host "3- Modifier un groupe"
    Write-Host "4- Modifier une stratégie de groupe GPO"
    Write-Host "5- Retour"
    Write-Host "`n"
}


function Menu_Delete_Object
{
    Write-Host "`n"                                                       
    Write-Host "1- Supprimer un utilisateur"
    Write-Host "2- Supprimer une Unitée Organisationnel OU"
    Write-Host "3- Supprimer un groupe"
    Write-Host "4- Supprimer une stratégie de groupe GPO"
    Write-Host "5- Retour"
    Write-Host "`n"
}


function Menu_Show_Object
{
    Write-Host "`n"                                                       
    Write-Host "1- Afficher un utilisateur"
    Write-Host "2- Afficher une Unitée Organisationnel OU"
    Write-Host "3- Afficher un groupe"
    Write-Host "4- Afficher une stratégie de groupe GPO"
    Write-Host "5- Afficher l'ensemble des utilisateurs"
    Write-Host "6- Afficher toutes les Unités oragnisationnels OU"
    Write-Host "7- Afficher tous des groupes"
    Write-Host "8- Afficher toutes les stratégies de groupe GPO"
    Write-Host "9- Retour"
    Write-Host "`n"
}


function Menu_Server_Configuration
{
    Write-Host "`n"  
    Write-Host "1- Afficher l'adresse IPv4, IPv6 et l'adresse de passerel du serveur"                                              
    Write-Host "2- Afficher la plage d'adresse DHCP"
    Write-Host "3- Afficher la configuration DNS"
    Write-Host "4- Afficher le niveau fonctionnel du windows Server"
    Write-Host "5- Quitter"
    Write-Host "`n"
}



function manageAD
{
   Menu_Object_AD

   $user_choice = Read-Host "Veuillez choisir une option"

   switch ( $user_choice )
   {

               # 1- Ajouter un Objet AD
        1 { 
        
               Menu_Add_Object
               $user_choice = Read-Host "Veuillez choisir une option"

               switch ( $user_choice )
               {    
                            # 1- Ajouter un nouvel utilisateur 
                    1 {
                
                            Write-Host "`n"                                                       # Saut de ligne
                            $user_firstName = Read-Host "Entrer le prénom de l'utilisateur"       # Saisie des differentes informations du user
                            $user_lastName = Read-Host "Entrer le nom de l'utilisateur"     
                            $user_initiale = Read-Host "Entrer les initiales de l'utilisateur"
                            $user_email = Read-Host "Entrer l'email de l'utilisateur"  
                            $user_connectionName = Read-Host "Entrer le d'ouverture de session" 

                            New-ADUser -Name $user_lastName -GivenName $user_firstName -Surname $user_lastName -Initials $user_initiale  -SamAccountName $user_connectionName -UserPrincipalName $user_lastName -Path "DC=abstergo,DC=local" -AccountPassword(Read-Host -AsSecureString "Entrer le mot de passe") -Enabled $true   # Création de l'utilisateur

                            Write-Host "`n l'utilisateur a été crée avec succès `n" -ForegroundColor "green"
        
                            Get-ADUser -Identity $user_lastName | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                            Write-Host "`n"
                      }


                            # 2- Ajouter une nouvelle Unitée Organisationnel
                    2 { 
                            $OU_name = Read-Host "Entrer le nom de l'unitée organisationnel"   # Saisie du nom de l'OU

                            New-ADOrganizationalUnit -Name $OU_name -Path "DC=abstergo,DC=local" # Création de l'OU
            
                            Write-Host "`n L'unitée organisationnel a été crée avec succès `n" -ForegroundColor "green"
                            Get-ADOrganizationalUnit -Identity "OU=$OU_name,DC=abstergo,DC=local" | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

      
                            # 4- Ajouter un groupe
                    3 {  
                            $group_name = Read-Host "Entrer le nom du groupe"

                            Write-Host "1- Groupe de sécurité"
                            Write-Host "2- Groupe de distribution"

                            $category_choice = Read-Host "Choisissez une catégorie de groupe"
            
                            switch ($category_choice)
                            {
                                1 { $category = "Security" }
                                2 { $category = "Distribution" }
                            }


                            Write-Host "Choisissez l'étendu du groupe :"
                            Write-Host "1- Groupe Universel"
                            Write-Host "2- Groupe Global"
                            Write-Host "3- Groupe Local"

                            $scope_choice = Read-Host "Choisissez le type de groupe"

                                switch ($scope_choice)
                                {
                                    1 { $scope = "Universal" }
                                    2 { $scope = "Global" }
                                    3 { $scope = "Local" }
                                }

                            $description = Read-Host "Ajouter une description" 

                            New-ADGroup -Name $group_name -GroupCategory $category -GroupScope $scope -Description $description

                            Write-Host "`n Le groupe a été crée avec succès `n" -ForegroundColor "green"

                        }


                        # 4- Ajouter une stratégie de groupe
                    4 { $result = 'GRO'    }


                        # 5- Retour
                    5 {  manageAD   }

               }

        
          }


            # 2- Modifier un objet AD
        2 {

               Menu_Edit_Object
               $user_choice = Read-Host "Veuillez choisir une option"

               switch ( $user_choice )
               {    
                            # 1- Modifier un utilisateur 
                    1 {
                
                            Write-Host "`n"                                                       # Saut de ligne
                            $user =  Read-Host "Entrer le  nom complet de l'utilisateur"

                            $user_firstName = Read-Host "Entrer le nouveau prénom de l'utilisateur"       # Saisie des differentes informations du user
                            $user_lastName = Read-Host "Entrer le nouveau nom de l'utilisateur"     
                            $user_initiale = Read-Host "Entrer les nouvelles initiales de l'utilisateur"
                            $user_email = Read-Host "Entrer le nouveau mail de l'utilisateur"  
                            $user_connectionName = Read-Host "Entrer le nouveau nom d'ouverture de session" 

                            Get-ADUser -Identity $user | Set-ADUser -GivenName $user_lastName -Surname $user_firstName -Initials $user_initiale  -SamAccountName $user_connectionName -UserPrincipalName $user_lastName  -Enabled $true   # Modification de l'utilisateur
                            Rename-ADObject -Identity $user -NewName $user_lastName
                            Write-Host "`n l'utilisateur a été modifié avec succès `n" -ForegroundColor "green"
        
                            Get-ADUser -Identity $user_lastName | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                            Write-Host "`n"
                      }


                            # 2- Modifier une Unitée Organisationnel OU
                    2 { 
                            $OU_name = Read-Host "Entrer le nom de l'unitée organisationnel"   # Saisie du nom de l'OU

                            Get-ADOrganizationalUnit -Identity "OU=$OU_name,DC=abstergo,DC=local" | Set-ADOrganizationalUnit -Name $OU_name -Path "DC=abstergo,DC=local" # Modification de l'OU
            
                            Write-Host "`n L'unitée organisationnel été modifié avec succès `n" -ForegroundColor "green"
                            Get-ADOrganizationalUnit -Identity "OU=$OU_name,DC=abstergo,DC=local" | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

      
                            # 4- Modifier un groupe
                    3 {  
                            $group_name = Read-Host "Entrer le nom du groupe"

                            Write-Host "1- Groupe de sécurité"
                            Write-Host "2- Groupe de distribution"

                            $category_choice = Read-Host "Choisissez une catégorie de groupe"
            
                            switch ($category_choice)
                            {
                                1 { $category = "Security" }
                                2 { $category = "Distribution" }
                            }


                            Write-Host "Choisissez l'étendu du groupe :"
                            Write-Host "1- Groupe Universel"
                            Write-Host "2- Groupe Global"
                            Write-Host "3- Groupe Local"

                            $scope_choice = Read-Host "Choisissez le type de groupe"

                                switch ($scope_choice)
                                {
                                    1 { $scope = "Universal" }
                                    2 { $scope = "Global" }
                                    3 { $scope = "Local" }
                                }

                            $description = Read-Host "Ajouter une description"

                            Get-ADGroup | Set-ADGroup -Name $group_name -GroupCategory $category -GroupScope $scope -Description $description
                        }


                        # 4- Modifier une stratégie de groupe
                    4 { $result = 'GRO'    }


                        # 5- Retour
                    5 {  manageAD   }

               }

          }

             # 3- Afficher les Objets AD
        3 {
              Menu_Show_Object 
              $user_choice = Read-Host "Veuillez choisir une option"

              switch ( $user_choice )
              {     
                         # 1- Afficher un utilisateur 
                    1 {
                          Write-Host "`n"
                          $user = Read-Host "Saisir le nom complet ou le GUID de l'utilisateur"
                          Get-ADUser -Identity $user | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                      }


                         # 2- Afficher une OU 
                    2 {
                          Write-Host "`n"
                          $OU = Read-Host "Saisir le path de l'unitée organisationnel OU"
                          Get-ADOrganizationalUnit -Identity $OU | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 3- Afficher un groupe AD 
                    3 {
                          Write-Host "`n"
                          $group = Read-Host "Saisir le path du groupe AD"
                          Get-ADGroup -Identity $group | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 4- Afficher une stratégie de group AD 
                    4 {
                          Write-Host "`n"
                          $gpo = Read-Host "Saisir le nom complet de la stratégie de groupe GPO"
                          Get-GPO -Name $gpo | Format-Table DisplayName,CreationTime,Owner,Id 
                      }


                          # 5- Afficher l'ensemble des utilisateurs
                    5 {                
                          Get-ADUser -Filter * | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                      }
                         
                         
                          # 6- Afficher toutes des unités organisationel OUs
                    6 {                
                          Get-ADOrganizationalUnit -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

                       
                          # 7- Afficher tous les groupes
                    7 {                
                          Get-ADGroup -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 8- Afficher l'ensemble des stratégie de groupe
                    8 {                
                          Get-GPO -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }
                       
                          # 9- Retour
                    9 {
                          manageAD
                      }
             
              }

          }


             # Supprimer les Objets AD
        4 {
              Menu_Delete_Object 
              $user_choice = Read-Host "Veuillez choisir une option"

              switch ( $user_choice )
              {     
                         # 1- Supprimer un utilisateur 
                    1 {
                          Write-Host "`n"
                          $user = Read-Host "Saisir le nom complet ou le GUID de l'utilisateur"
                          Remove-ADUser -Identity $user  
                          Write-Host "`n L'utilisateur a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                         # 2- Supprimer une OU 
                    2 {
                          Write-Host "`n"
                          $OU = Read-Host "Saisir le path de l'unitée organisationnel OU"
                          Remove-ADOrganizationalUnit -Identity $OU -Recursive
                          Write-Host "`n L'unité organisationnel a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                          # 3- Supprimer un groupe AD 
                    3 {
                          Write-Host "`n"
                          $group = Read-Host "Saisir le path du groupe AD"
                          Remove-ADGroup -Identity $group 
                          Write-Host "`n Le groupe a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                          # 4- Supprimer une stratégie de group AD 
                    4 {
                          Write-Host "`n"
                          $gpo = Read-Host "Saisir le nom complet de la stratégie de groupe GPO"
                          Remove-GPO -Name $gpo 
                          Write-Host "`n La GPO a été supprimé avec succès `n" -ForegroundColor "green"

                      }

                         
                        # 5- Retour
                    5 {
                          manageAD
                      }

              }

          }
             # Retour
        5 {
            main
          }
    }

  manageAD 

}


function configuration_server
{
   Menu_Server_Configuration

   $user_choice = Read-Host "Veuillez choisir une option"

   switch ( $user_choice )
   {
     1 {  ipconfig }
     2 {  Get-DhcpServerv4Scope }
     3 {  Get-DnsServerResourceRecord -ZoneName "abstergo.local" }
     4 {
          Write-Host "`n Le niveau fonctionnel du domain est : " (Get-ADDomain).DomainMode  
          Write-Host "`n Le niveau fonctionnel de la foret est : " (Get-ADForest).ForestMode 
       }

     5 {
           manageAD
       }
   }

   configuration_server
}


function main
{    
   Write-Host "`n                   MENU                      `n" -BackgroundColor "black"
   Write-Host "1- Administrer l'Active Directory              " -BackgroundColor "black"
   Write-Host "2- Afficher la configuration du server         " -BackgroundColor "black"
   Write-Host "3- Quitter                                     " -BackgroundColor "black"
   Write-Host "`n"

   $user_choice = Read-Host "Selectionnez une option"

   switch($user_choice)
   {
       1 {  manageAD }

       2 {  configuration_server }

       3 {  exit(0) }

   }

   main
}

main

