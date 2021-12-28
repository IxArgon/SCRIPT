#VARIABLE
$entreeOUbase = "OU=,DC=,DC="
$gestionOU = $entreeOUbase
$oudernierchoix = "REPLACE BY OU BASE IN ENTREEOUBASE" #exemple : $entreeOUBASE = "OU=test,DC=local,DC=fr" donc $oudernierchoix = "test"
$execution_bloc1 = "o"
$serveurAD = ""

function GetPF-OUuEntite #fonction gestion d'entité
{
while ($element -eq $null){
    $commande1 = Get-ADOrganizationalUnit -Filter * -Server $serveurAD -SearchBase $gestionOU -SearchScope OneLevel #recuperation de la liste d'OU
        try{ #pour chaque element, comptage pour faire une liste dynamique pour plusieurs OU
            ForEach($element in $commande1){
                '{0} - {1}' -f ($commande1.IndexOf($element) +1 ), $element.Name
            }
        }
        catch{ #liste dynamique pour un seul OU
            '{0} - {1}' -f "1", $element.Name
        }

        Write-Host "X - Creer l'utilisateur à la racine de" $oudernierchoix #proposition de ne plus descendre dans l'arbo
        if ($commande1.Count -eq "0") {
            break
        }
        $Choice = '' #reset de la variable
        while ([string]::IsNullOrEmpty($Choice)) #tant que choix est vide
        {
            $Choice = Read-Host 'Choisir un numero '
            if ($Choice -eq "X") #si le numero du choix est X alors arreter le parcours de l'arboressence
            {
                Write-Host "D'accord, fin du parcours de l'arboressence"
                break
            }
            try{
            if ($Choice -notin 1..$commande1.Count) #si le numero du choix est en dehors de la plage
            {
                [console]::Beep(1000, 300) #genere un BIP pour l'utilisateur
                Write-Warning (' Choix invalide' -f $Choice) #indique un mauvais choix
                Write-Warning (' Les choix valides sont de 1 à {0}.' -f $commande1.Count) #enonce les choix possible
                $Choice = '' #retourne à la boucle
                $execution_bloc1 = "n"
            }
            }
            catch{
            $execution_bloc1 = "n"
            $gestionOU = "OU="+$element.Name+","+$gestionOU
            Write-Debug $gestionOU + $oudernierchoix #debeugage
            }
            if ($execution_bloc1 -eq "o"){ #regul l'execution du script, protection erreur
                'Vous avez choisi {0}' -f $commande1.Name[$Choice - 1]
                $gestionOU = "OU="+$commande1.Name[$Choice - 1]+","+$gestionOU
                $oudernierchoix = $commande1.Name[$Choice - 1]
                Write-Debug $gestionOU + $oudernierchoix #debeugage
            }
            $element = $null #reset de la variable
            $execution_bloc1 = "o" #reset de la variable

        }
        Write-Host "IF - avant dernier" #a but pedagogique pour comprendre quand le script pousuit son traitement
        }
        Write-Host "IF - last level" #a but pedagogique pour comprendre quand le script pousuit son traitement
}
GetPF-OUuEntite
Write-Host "On continue" #a but pedagogique pour comprendre quand le script pousuit son traitement