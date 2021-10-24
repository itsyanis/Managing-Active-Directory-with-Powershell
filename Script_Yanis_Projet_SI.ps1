
function Menu
{
    Write-Host "`n"                                                       # Saut de ligne
    Write-Host "1- Ajouter un nouvel utilisateur"
    Write-Host "2- Ajouter une nouvelle Unitée Organisationnel"
    Write-Host "3- Déplacer un utilisateur"
    Write-Host "4- Ajouter un groupe"
    Write-Host "5- Créer une GPO"
    Write-Host "6- Lister l'ensemble des utilisateurs présent dans l'AD"
    Write-Host "7- Lister les Unitées oragnisationnels"
    Write-Host "8- Lister les groupe de l'AD"
    Write-Host "9- Afficher le niveau fonctionnel du windows Server"
    Write-Host "`n"
    Write-Host "`n"
}


Menu

$user_choice = Read-Host "Veuillez choisir une option"

switch ( $user_choice )
{
    1 { 
            Write-Host "`n"                                                       # Saut de ligne
            $user_firstName = Read-Host "Entrer le prénom de l'utilisateur"       # Saisie des differentes information du user
            $user_lastName = Read-Host "Entrer le nom de l'utilisateur"     
            $user_fullName = Read-Host "Entrer le nom complet de l'utilisateur"
            $user_initiale = Read-Host "Entrer le nom complet de l'utilisateur"
            $user_email = Read-Host "Entrer l'email de l'utilisateur"  
            $user_connectionName = Read-Host "Entrer le de connection exemple@domain.com" 
            $user_job = Read-Host "Entrer le poste de l'utilisateur"  

            New-ADUser -Name $user_fullName -GivenName $user_firstName -Surname $user_lastName -SamAccountName $user_initiale -UserPrincipalName  $user_connectionName  -Path "DC=abstergo,DC=local" -AccountPassword(Read-Host -AsSecureString "Entrer le mot de passe") -Enabled $true   # Création de l'utilisateur

            Write-Host "`n l'utilisateur a été crée avec succès `n"
        
            Get-ADUser  $user_lastName 
            Write-Host "`n"

      }

      
    2 { 
            $OU_name = Read-Host "Entrer le nom de l'unitée organisationnel"   # Saisie du nom de l'OU

            New-ADOrganizationalUnit -Name $OU_name -Path "DC=abstergo,DC=local" # Création de l'OU
            
            Write-Host "`n L'unitée organisationnel été crée avec succès `n"
            Get-ADOrganizationalUnit -Name = $OU_name
       }


    3 { 
            Get-ADUser $name| Move-ADObject -TargetPath 'OU=nonactive,OU=compny,DC=domain,Dc=net'
      }
      
    4 { $result = 'Thursday'  }
    5 { $result = 'Friday'    }

    6 {    
            Get-ADUser -Filter * | Format-Table Name,UserPrincipalName, -A  
      }

    9 { 
            Write-Host "`n Le niveau fonctionnel du domain est : " (Get-ADDomain).DomainMode  
      }
}

