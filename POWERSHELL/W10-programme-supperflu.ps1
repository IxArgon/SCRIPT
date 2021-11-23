#DÃ©sinstaller 3D Builder
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

#DÃ©sinstaller Alarmes et Horloge
Get-AppxPackage *windowsalarms* | Remove-AppxPackage

#DÃ©sinstaller Calculatrice
#Get-AppxPackage *windowscalculator* | Remove-AppxPackage

#DÃ©sinstaller CamÃ©ra
Get-AppxPackage *windowscamera* | Remove-AppxPackage

#DÃ©sinstaller â€œOffice
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage Office.Sway | Remove-AppxPackage

#DÃ©sinstaller OneNote
Get-AppxPackage *onenote* | Remove-AppxPackage

#DÃ©sinstaller â€œObtenir Skype
Get-AppxPackage *skypeapp* | Remove-AppxPackage

#DÃ©sinstaller Groove Musique
Get-AppxPackage *zunemusic* | Remove-AppxPackage

#DÃ©sinstaller Cartes
Get-AppxPackage *windowsmaps* | Remove-AppxPackage

#DÃ©sinstaller Films et TV
Get-AppxPackage *zunevideo* | Remove-AppxPackage

#DÃ©sinstaller Contacts
Get-AppxPackage *people* | Remove-AppxPackage

#DÃ©sinstaller Store
#Get-AppxPackage *windowsstore* | Remove-AppxPackage

#DÃ©sinstaller Sport
Get-AppxPackage *bingsports* | Remove-AppxPackage

#DÃ©sinstaller Enregistreur vocal
Get-AppxPackage *soundrecorder* | Remove-AppxPackage

#DÃ©sinstaller MÃ©tÃ©o
Get-AppxPackage *bingweather* | Remove-AppxPackage

#DÃ©sinstaller Xbox
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage

#Desinstaller News
Get-appxpackage * bingnews * | remove-appxpackage

#Desinstaller Paint 3D
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage

#Desinstaller Visionneur 3D
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage

#Desinstaller Phone
Get-AppxPackage *windowsphone* | Remove-AppxPackage

#Desinstaller Adobe
Get-AppxPackage AdobeSystemsIncorporated.AdobePhotoshopExpress | Remove-AppxPackage

#Desinstaller Help Aide
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage

#Desinstaller Netflix
Get-AppxPackage Netflix | Remove-AppxPackage

#Desinstaller Hub de commentaire
Get-AppxPackage *feedbackhub* | Remove-AppPackage

#Desinstaller Courrier
Get-appxpackage *microsoft.windowscommunicationsapps* | Remove-Appxpackage

#Desinstaller Jeux
Get-AppxPackage king.com.CandyCrushSodaSaga | Remove-AppxPackage
Get-AppxPackage FarmVille2CountryEscape | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage flaregamesGmbH.RoyalRevolt2 | Remove-AppxPackage

#Desinstaller GetStarted
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

#Desinstaller StickyNote
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

#Desinstaller Portail realite
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage

#Desinstaller Wallet
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage

#Desinstaller Microsoft People
Get-AppxPackage Microsoft.People | Remove-AppxPackage

#Desinstaller ONeDrive
taskkill /f /im OneDrive.exe
C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall
