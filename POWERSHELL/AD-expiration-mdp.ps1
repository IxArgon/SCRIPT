function Get-Expirationmdp() {
    #Importation des modules
    import-module activedirectory

    #Formulaire et variable
    $myuser = Read-Host "Login de l'utilisateur a tester "
    $domaine = Read-Host "Serveur :
    LISTES A COMPLETER PAR LES NOM DE DOMAINE
    " # RENSEIGNER LE DOMAINE
    #Gestion aleatoire du mot de passe + récuperation de l'utilisateur
    $identifiant_utilisateur = Get-aduser -Identity $myuser -Server $domaine -properties *
    $myuser_mdp= ($myuser.Substring(0,1)).ToUpper() + ($myuser.Substring(1,1)).ToLower() + (Get-Random -Minimum 100000 -Maximum 999999)#generation mdp aleatoire

    #Verification des conditions du compte de l'utilisateur
    if ($identifiant_utilisateur.SamAccountName -eq $myuser) #check si existe
    {
        Write-Debug "Compte existant"
        if ($identifiant_utilisateur.Enabled -eq "True") #check si actif
        {
            Write-Debug "Compte actif"
            if ( $identifiant_utilisateur.passwordneverexpires -like '*False*' ) #check mdp expiration
            {
                Write-Debug "Compte avec expiration de mot de passe activee"
                #Recherche du mot de passe expire
                if ($identifiant_utilisateur.passwordexpired -eq "True")
                {
                    Write-Warning "Le mot de passe a expiré, voulez vous le réinitialiser (A pour AUTOMATIQUE / M pour MANUEL / AUTRE pour NON) ?"
                    $resetmdp = Read-Host "Votre choix "
                    #Choix de reset du mot de passe ; manuel / automatique / aucune modification
                    if ($resetmdp -ieq "a") #reset le mdp à Default
                    {
                        Set-ADAccountPassword -Identity $myuser -Server $domaine -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$myuser_mdp" -Force)
                        Write-Host "Le mot de passe est :" $myuser_mdp 
                    }
                    if ($resetmdp -ieq "m") #demande le mdp manuel et le modif
                    {
                        $myuser_mdp=Read-Host "Renseigner le mot de passe "
                        Set-ADAccountPassword -Identity $myuser -Server $domaine -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$myuser_mdp" -Force)
                        Write-Host "Le mot de passe est :" $myuser_mdp
                    } #Sinon aucune action
                }
                else
                {
                    Write-Host -ForegroundColor Green "Le mot de passe est valide, il expirera le : " ([datetime]::FromFileTime((Get-ADUser -Identity $myuser -Properties "msDS-UserPasswordExpiryTimeComputed")."msDS-UserPasswordExpiryTimeComputed"))
                }
            }
            else
            {
                Write-Warning "Compte avec mdp n'expire jamais"
            }
        }
        else
        {
            Write-Warning "Compte desactiver"
        }
    }
    else
    {
        Write-Warning "Compte inexistant"
    }
}#fin fonction

$executionb1 ="o"
while ($executionb1 -eq "o"){
    Get-Expirationmdp
}#fin while executionb1
