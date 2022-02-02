function Create-Passwd{
    function Get-RandomCharacters($length, $characters) {#fonction trouver random caractere
        $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
        $private:ofs=""
        return [String]$characters[$random]
    }
    function Scramble-String([string]$inputString){#fonction melange / popote
        $characterArray = $inputString.ToCharArray()   
        $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
        $outputString = -join $scrambledStringArray
        return $outputString 
    }
    #QUOI & COMBIEN
    $password = Get-RandomCharacters -length 5 -characters 'abcdefghiklmnoprstuvwxyz'
    $password += Get-RandomCharacters -length 1 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
    $password += Get-RandomCharacters -length 1 -characters '1234567890'
    $password += Get-RandomCharacters -length 1 -characters '!"§$%&/()=?}][{@#*+'
    $password = Scramble-String $password #melange / popote
    return $password #extrait la valeur
}
$mdp = Create-Passwd
Write-Host $mdp -ForegroundColor Yellow
