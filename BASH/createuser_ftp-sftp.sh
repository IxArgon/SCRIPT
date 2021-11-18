#!/bin/bash
read -p 'Utilisateur : ' utilisateur
read -p "Type d'acces ('ftp' ou 'sftp' ou 'migsftp' / Choisir respectivement 1,2 ou 3): " typedecompte
case $typedecompte in
        "1")
                echo "condition1"
                adduser --home /home/$utilisateur --shell /bin/bash --force-badname $utilisateur || exit $?
                sudo -u $utilisateur mkdir -p /home/$utilisateur/{IN,OUT,TEST} || echo "ERREUR : creation des dossier IN, OUT, TEST"
                echo "FIN"
                ;;
        "2")
                echo "condition2"
                adduser --home /home/$utilisateur --shell /bin/bash --force-badname $utilisateur
                usermod -a -G sftp $utilisateur || echo "ERREUR : ajout de $utilisateur dans le groupe sftp"
                sudo -u $utilisateur mkdir -p /home/$utilisateur/{IN,OUT,TEST} || echo "ERREUR : creation des dossier IN, OUT, TEST"
                mkdir -p /home/sftproot/$utilisateur/$utilisateur || echo "ERREUR : creation du dossier dans /home/sftproot/"
                mount --bind /home/$utilisateur /home/sftproot/$utilisateur/$utilisateur || echo "ERREUR : montage du lien /home/$utilisateur vers /home/sftproot/$utilisateur/$utilisateur"
                echo "/home/$utilisateur /home/sftproot/$utilisateur/$utilisateur none bind 0 0" >> /etc/fstab
                echo "FIN"
                ;;
        "3")
                echo "condition3"
                usermod -a -G sftp $utilisateur > /dev/null 2>&1 || echo "ERREUR : ajout de $utilisateur dans le groupe sftp"
                mkdir -p /home/sftproot/$utilisateur/$utilisateur || echo "ERREUR : creation du dossier dans /home/sftproot/"
                mount --bind /home/$utilisateur /home/sftproot/$utilisateur/$utilisateur || echo "ERREUR : montage du lien /home/$utilisateur vers /home/sftproot/$utilisateur"
                echo "/home/$utilisateur /home/sftproot/$utilisateur/$utilisateur none bind 0 0" >> /etc/fstab
                echo "FIN"
                ;;
        *)
                echo "ERREUR : valeur de type de compte inconnu"
                sleep 10
                exit 1
                ;;
esac
