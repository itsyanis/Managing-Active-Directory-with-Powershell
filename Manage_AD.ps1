<#

 Executez d'abord ces deux commandes avant de lancer le programme :
    Import-Module ActiveDirectory
    Import-Module 'Microsoft.Powershell.Security'

 Assurez-vous que votre serveur est un contrôleur de domaine. 

 Domain : abstergo.local => DC=abstergo,DC=local

#>


# Menu Administration de l'Active Directory

function Menu_Object_AD
{
    Write-Host "`n          Gérer l'Active Directory                 "  -BackgroundColor "DarkCyan"                                                      
    Write-Host "==================================================="    -BackgroundColor "DarkCyan"
    Write-Host " 1- Ajouter un objet AD                            "    -BackgroundColor "black"
    Write-Host " 2- Afficher un objet AD                           "    -BackgroundColor "black"
    Write-Host " 3- Supprimer un objet AD                          "    -BackgroundColor "black"
    Write-Host " 4- Exporter les objets AD en fichier CSV          "    -BackgroundColor "black"
    Write-Host " 5- Retour                                         "    -BackgroundColor "black"
    Write-Host "===================================================`n"  -BackgroundColor "DarkCyan" 
}


# Menu Ajouter un Objet Active Directory

function Menu_Add_Object
{
    Write-Host "`n          Ajouter un Objet Active Directory        "  -BackgroundColor "DarkCyan"
    Write-Host "==================================================="    -BackgroundColor "DarkCyan"
    Write-Host " 1- Ajouter un nouvel utilisateur                  "    -BackgroundColor "black" 
    Write-Host " 2- Ajouter une nouvelle Unité Organisationnelle   "    -BackgroundColor "black" 
    Write-Host " 3- Ajouter un groupe                              "    -BackgroundColor "black" 
    Write-Host " 4- Ajouter une stratégie de groupe GPO            "    -BackgroundColor "black" 
    Write-Host " 5- Définir la politique de mot de passe           "    -BackgroundColor "black"  
    Write-Host " 6- Retour                                         "    -BackgroundColor "black" 
    Write-Host "===================================================`n"  -BackgroundColor "DarkCyan"
}


# Menu Supprimer un Objet Active Directory

function Menu_Delete_Object
{
    Write-Host "`n"                                                       
    Write-Host " 1- Supprimer un utilisateur"
    Write-Host " 2- Supprimer une Unité Organisationnelle UO"
    Write-Host " 3- Supprimer un groupe"
    Write-Host " 4- Supprimer une stratégie de groupe GPO"
    Write-Host " 5- Retour"
    Write-Host "`n"
}


# Menu Afficher un Objet Active Directory

function Menu_Show_Object
{
    Write-Host "`n"                                                       
    Write-Host " 1- Afficher un utilisateur"
    Write-Host " 2- Afficher une Unité Organisationnelle UO"
    Write-Host " 3- Afficher un groupe"
    Write-Host " 4- Afficher une stratégie de groupe GPO"
    Write-Host " 5- Afficher l'ensemble des utilisateurs"
    Write-Host " 6- Afficher toutes les Unités organisationnelles UO"
    Write-Host " 7- Afficher tous des groupes"
    Write-Host " 8- Afficher toutes les stratégies de groupe GPO"
    Write-Host " 9- Afficher les ordinateurs du LAN"
    Write-Host " 10- Afficher la politique de mot de passe"
    Write-Host " 11- Afficher les rôles des serveurs"
    Write-Host " 12- Retour"
    Write-Host "`n"
}


# Menu Exporter un Objet Active Directory en CSV 

function Menu_Export_Object
{
    Write-Host "`n"                                                       
    Write-Host " 1- Exporter les utilisateurs"
    Write-Host " 2- Exporter les Unité Organisationnelle UO"
    Write-Host " 3- Exporter les groupes"
    Write-Host " 4- Exporter les stratégies de groupe"
    Write-Host " 5- Retour"
    Write-Host "`n"
}


# Menu Configuration 

function Menu_Server_Configuration
{
    Write-Host "`n"  
    Write-Host " 1- Afficher l'adresse IPv4, IPv6 et l'adresse de la passerelle du serveur"       
    Write-Host " 2- Afficher la configuration du Proxy"                                        
    Write-Host " 3- Afficher la plage d'adresses DHCP"
    Write-Host " 4- Afficher la configuration DNS"
    Write-Host " 5- Afficher les informations du controleur de domaine" 
    Write-Host " 6- Afficher les cartes réseaux"
    Write-Host " 7- Afficher le niveau fonctionnel du Windows Server"
    Write-Host " 8- Retour"
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
                            $user_firstName = Read-Host "Entrer le prénom de l'utilisateur"       # Saisie des différentes informations de l'utilisateur
                            $user_lastName = Read-Host "Entrer le nom de l'utilisateur"     
                            $user_initiale = Read-Host "Entrer les initiales de l'utilisateur"
                            $user_email = Read-Host "Entrer l'adresse e-mail de l'utilisateur"  
                            $user_connectionName = Read-Host "Entrer le nom lors de l'ouverture de la session" 
                            $user_path = Read-Host "Entrer l'emplacement de l'utilisateur (donner le path : dans un groupe, OU, etc.)"

                            New-ADUser -Name $user_lastName -GivenName $user_firstName -Surname $user_lastName -Initials $user_initiale  -SamAccountName $user_connectionName -UserPrincipalName $user_lastName -EmailAddress $user_email -Path $user_path -AccountPassword(Read-Host -AsSecureString "Entrer le mot de passe") -Enabled $true -ProtectedFromAccidentalDeletion $false  # Création de l'utilisateur

                            Write-Host "`n L'utilisateur a été créé avec succès `n" -ForegroundColor "green"
        
                            Get-ADUser -Identity $user_connectionName | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                            Write-Host "`n"
                      }


                            # 2- Ajouter une nouvelle Unité Organisationnelle UO
                    2 { 
                            $OU_name = Read-Host "Entrer le nom de l'Unité Organisationnelle (UO)"   # Saisie du nom de l'UO
                            $description = Read-Host "Entrer une description l'UO"
                            $OU_DistinguishedName = Read-Host "Entrer le DistinguishedName (path) de l'UO"   # Saisie du nom de l'OU


                            New-ADOrganizationalUnit -Name $OU_name -Description $description -Path $OU_DistinguishedName -ProtectedFromAccidentalDeletion $false    # Création de l'OU
            
                            Write-Host "`n L'unité organisationnelle a été créé avec succès `n" -ForegroundColor "green"
                            Get-ADOrganizationalUnit -Identity $OU_DistinguishedName | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

      
                            # 4- Ajouter un groupe
                    3 {  
                            $group_name = Read-Host "Entrer le nom du groupe"
                            $group_DistinguishedName = Read-Host "Entrer le DistinguishedName (path) du groupe"   # Saisie du path de groupe


                            Write-Host "`n"
                            Write-Host " 1- Groupe de sécurité"
                            Write-Host " 2- Groupe de distribution"

                            $category_choice = Read-Host "Choisissez une catégorie de groupe"
            
                            switch ($category_choice)
                            {
                                1 { $category = "Security" }
                                2 { $category = "Distribution" }
                            }

                            Write-Host "`n"
                            Write-Host "Choisissez l'étendu du groupe :"
                            Write-Host " 1- Groupe Universel"
                            Write-Host " 2- Groupe Global"
                            Write-Host " 3- Groupe Local"

                            $scope_choice = Read-Host "Choisissez le type de groupe"

                                switch ($scope_choice)
                                {
                                    1 { $scope = "Universal" }
                                    2 { $scope = "Global" }
                                    3 { $scope = "Local" }
                                }

                            $description = Read-Host "Ajouter une description" 

                            New-ADGroup -Name $group_name -GroupCategory $category -GroupScope $scope -Description $description -Path $group_DistinguishedName

                            Write-Host "`n Le groupe a été créé avec succès `n" -ForegroundColor "green"

                        }


                        # 4- Ajouter une stratégie de groupe
                    4 { 
                          $gpo_name = Read-Host "Entrer de la stratégie de groupe"
                          $description = Read-Host "Entrer une description à la stratégie de groupe"

                          New-GPO -Name $gpo_name -Comment $description

                          Write-Host "`n La stratégie de groupe a été créée avec succès `n" -ForegroundColor "green"

                          Get-GPO -Name $gpo_name
                      }
                   
                        # 5- Définir la politique de mot de passe
                    5 { 
                        $identity = Read-Host "Entrer le domaine AD (ex : abstergo.local)" 
                        $c = Read-Host "Voulez-vous activer la complexité ? (ex : oui ou non)"

                        $complexity = switch ($c) {
                          'oui' { $true }
                          'non'  { $false }
                        }

                        $minPwdLength = Read-Host "Spécifier le nombre minimum de caractères que contient un mot de passe (ex : 8)"
                        $minPwdAge = Read-Host "Entrer le durée (en jours) minimum avant de changer le mot de passe (ex : 5)"
                        $maxPwdAge = Read-Host "Entrer le durée (en jours) maximum pour changer le mot de passe (ex : 85)"
                        $passHC = Read-Host "Spécifier le nombre de mot de passe à sauvegarder (ex : 10) - mot de passe à ne pas réutiliser"

                        $PolitiqueMdp = @{
                            Identity = $identity
                            ComplexityEnabled = $complexity
                            MinPasswordLength = $minPwdLength
                            MinPasswordAge = $minPwdAge 
                            MaxPasswordAge = $maxPwdAge
                            PasswordHistoryCount = $passHC
                        }

                        Set-ADDefaultDomainPasswordPolicy @PolitiqueMdp
                        Get-ADDefaultDomainPasswordPolicy
 
                        Write-Host "`n La politique de mot de passe a bien été modifiée `n" -ForegroundColor "green"

                      }

                        # 6- Retour
                    6 {  manageAD   }

               }

        
          }



             # 2- Afficher les Objets AD
        2 {
              Menu_Show_Object 
              $user_choice = Read-Host "Veuillez choisir une option"

              switch ( $user_choice )
              {     
                         # 1- Afficher un utilisateur 
                    1 {
                          Write-Host "`n"
                          $user = Read-Host "Saisir le nom d'ouverture de session ou le GUID de l'utilisateur"
                          Get-ADUser -Identity $user | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                      }


                         # 2- Afficher une unité organisationnelle 
                    2 {
                          Write-Host "`n"
                          $OU = Read-Host "Saisir le DistinguishedName (path) de l'unité organisationnelle (OU)"
                          Get-ADOrganizationalUnit -Identity $OU | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 3- Afficher un groupe AD 
                    3 {
                          Write-Host "`n"
                          $group = Read-Host "Saisir le path du groupe AD"
                          Get-ADGroup -Identity $group | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 4- Afficher une stratégie de groupe AD 
                    4 {
                          Write-Host "`n"
                          $gpo = Read-Host "Saisir le nom complet de la stratégie de groupe GPO"
                          Get-GPO -Name $gpo | Format-Table DisplayName,CreationTime,Owner,Id 
                      }


                          # 5- Afficher l'ensemble des utilisateurs
                    5 {                
                          Get-ADUser -Filter * | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                      }
                         
                         
                          # 6- Afficher toutes des unités organisationnelles OUs
                    6 {                
                          Get-ADOrganizationalUnit -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

                       
                          # 7- Afficher tous les groupes
                    7 {                
                          Get-ADGroup -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }


                          # 8- Afficher l'ensemble des stratégies de groupe
                    8 {                
                          Get-GPO -Filter * | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
                      }

                          # 9- Afficher les ordinateurs du LAN 
                    9 {
                          Get-ADComputer -Filter * | Format-Table ObjectClass,Name,OperatingSystem,IPv4Address 
                      }
                   
                          # 10- Afficher la politique de mot de passe
                   10 { 
                        Get-ADDefaultDomainPasswordPolicy
                      }

                          # 11- Afficher les rôles des serveurs
                   11 { 
                        $srv = (Get-ADComputer -Properties operatingsystem `
                        -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"').Name
 
                        $result = @()
 
                        foreach ($item in $srv) {
 
                            $test = Test-Connection $item -Count 1
 
                            If ($test.Status -eq 'Success' -or $test.StatusCode -eq '0')
                            {
                                $roles = Get-WindowsFeature -ComputerName $item | Where-Object InstallState -EQ 'Installed'
 
                                $result += New-Object -TypeName PSObject -Property ([ordered]@{
 
                                'Serveur' = $item
                                'Roles' = $roles.Name -join "`r`n"
                            }
                        )
 
                        }
                        }

                        # Affichage des serveurs et des roles
                        Write-Output $result | Format-Table -Wrap
 
                        # Création du fichier
                        $date = Get-Date -Format MM.dd.yyyy
                        $result | Format-Table -Wrap |
                        Out-File "$HOME\srv_roles_$date.txt"
                        Write-Host "`nLe fichier srv_roles_$date.txt est dans $HOME `n" -ForegroundColor "green"
 
                        # Ouverture du fichier texte
                        Start-Process $HOME\"srv_roles_$date.txt" 

                      }

                          # 12- Retour
                   12 { 
                          manageAD
                      }
             
              }

          }


             # Supprimer les Objets AD
        3 {
              Menu_Delete_Object 
              $user_choice = Read-Host "Veuillez choisir une option"

              switch ( $user_choice )
              {     
                         # 1- Supprimer un utilisateur 
                    1 {
                          Write-Host "`n"
                          $user = Read-Host "Saisir le nom d'ouverture de session ou le GUID de l'utilisateur"
                          Remove-ADUser -Identity $user  
                          Write-Host "`n L'utilisateur a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                         # 2- Supprimer une OU 
                    2 {
                          Write-Host "`n"
                          $OU = Read-Host "Saisir le DistinguishedName (path) de l'unité organisationnelle OU"
                          Remove-ADOrganizationalUnit -Identity $OU 
                          Write-Host "`n L'unité organisationnel a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                          # 3- Supprimer un groupe AD 
                    3 {
                          Write-Host "`n"
                          $group = Read-Host "Saisir le path du groupe AD"
                          Remove-ADGroup -Identity $group 
                          Write-Host "`n Le groupe a été supprimé avec succès `n" -ForegroundColor "green"

                      }


                          # 4- Supprimer une stratégie de groupe AD 
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


        4 {
              Menu_Export_Object
              $user_choice = Read-Host "Veuillez choisir une option"

              switch ( $user_choice )
              {     
                         # 1- Exporter les utilisateurs 
                    1 {
                          Write-Host "`n"
                          $path = Read-Host "Saisir l'emplacement (path) du fichier CSV"
                          Get-ADUser -Filter * -Properties * | export-csv -path $path
                          Write-Host "`n Opération réussie `n" -ForegroundColor "green"

                      }


                         # 2- Exporter les OU 
                    2 {
                          Write-Host "`n"
                          $path = Read-Host "Saisir l'emplacement (path) du fichier CSV"
                          Get-ADOrganizationalUnit -Filter * -Properties * | export-csv -path $path
                          Write-Host "`n Opération réussie `n" -ForegroundColor "green"

                      }


                          # 3- Exporter les groupes AD 
                    3 {
                          Write-Host "`n"
                          $path = Read-Host "Saisir l'emplacement (path) du fichier CSV"
                          Get-ADGroup -Filter * -Properties * | export-csv -path $path
                          Write-Host "`n Opération réussie `n" -ForegroundColor "green"

                      }


                          # 4- Exporter les stratégies de groupe AD 
                    4 {
                          Write-Host "`n"
                          $path = Read-Host "Saisir l'emplacement (path) du fichier CSV"
                          Get-GPO -Filter * -Properties * | export-csv -path $path
                          Write-Host "`n Opération réussie `n" -ForegroundColor "green"

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
     2 { netsh.exe winhttp show proxy }
     3 {  Get-DhcpServerv4Scope }
     4 {  Get-DnsServerResourceRecord -ZoneName "abstergo.local" }
     5 {  Get-ADDomainController -Filter * | Format-Table }
     6 {  Get-NetAdapter | fl Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed }
     7 {
          Write-Host "`n Le niveau fonctionnel du domain est : " (Get-ADDomain).DomainMode  
          Write-Host "`n Le niveau fonctionnel de la foret est : " (Get-ADForest).ForestMode 
       }

     8 {
           main
       }
   }

   configuration_server
}


function main
{    
   Write-Host "`n APPLICATION POUR L'ADMINISTRATION DU RESEAU       "  -BackgroundColor "Black"
   Write-Host "===================================================`n"    -BackgroundColor "Black"


   Write-Host "`n          MENU                                     "  -BackgroundColor "DarkCyan"
   Write-Host "==================================================="    -BackgroundColor "DarkCyan"
   Write-Host " 1- Administrer l'Active Directory                 "   -BackgroundColor "black"
   Write-Host " 2- Afficher la configuration du serveur           "   -BackgroundColor "black"
   Write-Host " 3- Communiquer avec un appareil du réseau         "   -BackgroundColor "black"
   Write-Host " 4- Quitter                                        "   -BackgroundColor "black"
   Write-Host "===================================================`n"  -BackgroundColor "DarkCyan"


   $user_choice = Read-Host "Sélectionnez une option"

   switch($user_choice)
   {
       1 {  manageAD }

       2 {  configuration_server }

       3 { 
            $ip = Read-Host "Donner l'adresse IPv4 de la machine"
            ping $ip
         }

       4 {  main }

   }
   
}
main
