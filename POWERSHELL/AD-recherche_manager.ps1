	function Get-ManagerGUID
{
param (
[Parameter(Position= 0, Mandatory= $true)]$serveurAD
)
#VARIABLE
$manager_name = ""
$manager_guid = ""
$i=0
$execution_bloc1 = "o"
$choix_nb_manager = ""

    while ([string]::IsNullOrEmpty($manager_guid)) { #controle si vide alors boucle
        $manager_name = Read-Host -Prompt "Quelle est le nom du manager " #question
        Write-Host "La recherche peut-être longue 20sec max, merci de patientez." -ForegroundColor cyan
        $manager_name = "*"+$manager_name+"*" #formatage de la recherche
        $manager_guid = @{}#mise en forme DICTIONNAIRE
        $manager_guid = Get-ADUser -filter {(name -like $manager_name)} -server $serveurAD -Properties * | Select cn,sAMAccountName,objectguid #requete vers variable

        try{ #pour chaque element, comptage pour faire une liste dynamique pour plusieurs OU
            ForEach($element in $manager_guid){
                $i++ #compteur
                #'{0} - {1} // Login : {2} ' -f ($i), $manager_guid.cn[$i-1], $manager_guid.sAMAccountName[$i-1]
                '{0} - {1} // Login : {2} ' -f ($manager_guid.IndexOf($element)+1), $manager_guid.cn[$i-1], $element.sAMAccountName #[$i-1]
            }#eachfor
        }
        catch{ #liste dynamique pour un seul OU
        Write-Host "Catch" #a supprimer
            '{0} - {1} // Login : {2} ' -f "1", $element.cn, $element.sAMAccountName
        }
        
        if ($manager_guid.Count -eq "0") { #si no result alors fin de fonction, donc boucle possible
            break
        }

        while ([string]::IsNullOrEmpty($choix_nb_manager)) #tant que choix est vide
            {
                $choix_nb_manager = Read-Host 'Choisir un numero '
                try{
                if ($choix_nb_manager -notin 1..$manager_guid.Count) #si le numero du choix est en dehors de la plage
                {
                    Write-Warning (' Choix invalide' -f $choix_nb_manager) #indique un mauvais choix
                    Write-Warning (' Les choix valides sont de 1 à {0}.' -f $manager_guid.Count) #enonce les choix possible
                    $choix_nb_manager = '' #retourne à la boucle
                    $execution_bloc1 = "n"
                }
                }
                catch{
                $execution_bloc1 = "n"
                Write-Debug "CATCH" #debeugage
                }
                if ($execution_bloc1 -eq "o"){ #regul l'execution du script, protection erreur
                    'Vous avez choisi : {0}' -f $element.cn
                    $global:manager_guid_sorti = $manager_guid.objectguid[$choix_nb_manager-1]
                    Write-Debug "N : $choix_nb_manager + GUID : $global:manager_guid_sorti" #debeugage
                }
                $element = $null #reset de la variable
                $execution_bloc1 = "o" #reset de la variable
            }#fin while choice
    }#fin while global

}#fin fonction Get-ManagerGUID


while ([string]::IsNullOrEmpty($global:manager_guid_sorti))
{
Get-ManagerGUID -serveurAD $serveurAD
}#elihw
Get-ManagerGUID -serveurAD $serveurAD #appel de la fonction
Write-Debug "$global:manager_guid_sorti" #preuve de fonctionnement, contient le GUID du manager
