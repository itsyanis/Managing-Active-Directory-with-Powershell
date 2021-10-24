# Executez d'abord ces deux localmandes avant de lancer le programme
# Import-Module ActiveDirectory
# Import-Module 'Microsoft.Powershell.Security'

function Menu_manage_AD
{
    Write-Host "`n"                                                       # Saut de ligne
    Write-Host "1- Ajouter un nouvel utilisateur"
    Write-Host "2- Ajouter une nouvelle Unitée Organisationnel"
    Write-Host "3- Déplacer un Objet Active directory"
    Write-Host "4- Ajouter un groupe"
    Write-Host "5- Créer une GPO"
    Write-Host "6- Lister l'ensemble des utilisateurs présent dans l'AD"
    Write-Host "7- Lister les Unités oragnisationnels"
    Write-Host "8- Lister les groupe de l'AD"
    Write-Host "9- Afficher les roles FSMO"
    Write-Host "10- Quitter"
    Write-Host "`n"
}

function Menu_configuration_Server
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
   Menu_manage_AD

   $user_choice = Read-Host "Veuillez choisir une option"

   switch ( $user_choice )
   {
                # 1- Ajouter un nouvel utilisateur
        1 { 
                Write-Host "`n"                                                       # Saut de ligne
                $user_firstName = Read-Host "Entrer le prénom de l'utilisateur"       # Saisie des differentes information du user
                $user_lastName = Read-Host "Entrer le nom de l'utilisateur"     
                $user_fullName = Read-Host "Entrer le nom localplet de l'utilisateur"
                $user_initiale = Read-Host "Entrer les initiales de l'utilisateur"
                $user_email = Read-Host "Entrer l'email de l'utilisateur"  
                $user_connectionName = Read-Host "Entrer le d'ouverture de session" 
                $user_job = Read-Host "Entrer le poste de l'utilisateur"  

                New-ADUser -Name $user_lastName -GivenName $user_lastName -Surname $user_firstName -Initials $user_initiale  -SamAccountName $user_connectionName -UserPrincipalName $user_fullName -Path "DC=abstergo,DC=local" -AccountPassword(Read-Host -AsSecureString "Entrer le mot de passe") -Enabled $true   # Création de l'utilisateur

                Write-Host "`n l'utilisateur a été crée avec succès `n"
        
                Get-ADUser -Identity $user_connectionName | Format-Table ObjectClass,Name,Surname,SamAccountName,DistinguishedName,ObjectGUID 
                Write-Host "`n"
          }


                # 2- Ajouter une nouvelle Unitée Organisationnel
        2 { 
                $OU_name = Read-Host "Entrer le nom de l'unitée organisationnel"   # Saisie du nom de l'OU

                New-ADOrganizationalUnit -Name $OU_name -Path "DC=abstergo,DC=local" # Création de l'OU
            
                Write-Host "`n L'unitée organisationnel été crée avec succès `n"
                Get-ADOrganizationalUnit -Identity "OU=$OU_name,DC=abstergo,DC=local" | Format-Table ObjectClass,Name,DistinguishedName,ObjectGUID 
           }


            # 3- Déplacer un Objet AD
        3 { 
                $old_path = Read-Host "Entrer le path courant"
                $new_path = Read-Host "Entrer le nouveau path"

                Move-ADObject -Identity $old_path -TargetPath $new_path
          }

      
                # 4- Ajouter un groupe
        4 {  
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
          }


          # 5- Créer une GPO
        5 { $result = 'GRO'    }

    

               # 6- Lister l'ensemble des utilisateurs présent dans l'AD
        6 {    
                Get-ADUser -Filter * | Format-Table GivenName,Surname,UserPrincipalName,DistinguishedName 
          }

           
                # 7- Lister les Unitées oragnisationnels
        7 {
                Get-ADOrganizationalUnit -Filter * | Format-Table ObjectClass,Name,DistinguishedName
          }

        8 {   #8- Lister les groupes
          
              Get-ADGroup -Filter * | Format-Table ObjectClass,Name,DistinguishedName,Member
          }

                # 9- Afficher le niveau fonctionnel du windows Server
        9 { 
                Write-Host "`n Le niveau fonctionnel du domain est : " (Get-ADDomain).DomainMode  
                Write-Host "`n Le niveau fonctionnel de la foret est : " (Get-ADForest).ForestMode  
          }

        10 { main }
    }
}


function configuration_server
{
   Menu_configuration_Server

   $user_choice = Read-Host "Veuillez choisir une option"

   switch ( $user_choice )
   {
     1 {  ipconfig;configuration_server }
     2 {  Get-DhcpServerv4Scope;configuration_server }
     3 {  Get-DnsServerResourceRecord -ZoneName "abstergo.local";configuration_server }
     4 {
          Write-Host "`n Le niveau fonctionnel du domain est : " (Get-ADDomain).DomainMode  
          Write-Host "`n Le niveau fonctionnel de la foret est : " (Get-ADForest).ForestMode
          configuration_server
       }
     5 { main }
   }
}


function main
{    
   Write-Host "`n"
   Write-Host "1- Administrer l'Active Directory"
   Write-Host "2- Afficher la configuration du server"
   Write-Host "3- Quitter"
   Write-Host "`n"

   $user_choice = Read-Host "Selectionnez une option"

   switch($user_choice)
   {
       1 {  manageAD }

       2 {  configuration_server }

       3 {  exit(0) }

   }

}

main
