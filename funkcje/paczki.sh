#!/bin/bash
#	Autor pliku gumbicp.
#	Wersja 2.0.1
#	17.07.2013
#	Instrukcja krok po kroku prowadzi do installacji wszystkich
#	zależności koniecznych przy instalacji webcamstudio.
#	Aktualne wersje programu sa na strone serweru PPA. Zanim dodacie
#	PPA do repozytoriow lub ściagniecie spakowany plik z projektem
#	do kompilacji trzeba zainstalować sobie mase pakietów.
#	Testowałem ten program na paru różnych linuxach i jak narazie
#	webcamstudio będzie tak naprawde w pełni śmigać tylko na
#	Ubuntu. Najnowsze wersje mogą być jeszcze nie stabilne.
#** IMPORTS -VARIABLES **#
. ./zmienne/zmienne.sh
#	Strona domowa projektu webcamstudio.
#http://code.google.com/p/webcamstudio/

#	server PPA:
#https://launchpad.net/~webcamstudio/+archive/webcamstudio-dailybuilds

#	Dyskusje z autorem programu wrazie problemow:
#https://plus.google.com/communities/110329269823088092206

#	Pierwsze co musimy zainstalować:
#	Ctrl+Alt+t skr. do terminalu
function func_ubuntu_restricted_extras {
    echo ":: paczki.sh :: func_ubuntu_restricted_extras ::" >&4
    clear
    sudo apt-get install ubuntu-restricted-extras
}
#	Program instalacyjny zapyta nas o potwierdzenie licencji,
#	w terminalu poruszamy się klawiszami Tab i potwierdzenie
#	Enter.
#	Do webcamstudio potrzeba nam przede wszystkim doinstalować
#	java. Można zainstalować WST(webcamstudio) na dwa sposoby.
#	Przez paczki lub skompilować w netbeansie i odpalać go z pliku
#	Webcamstudio.jar z katalogu dist projektu.
#	Aby przetestować dokladnie jak to u nas chodzi lepiej najpierw
#	skompilować program samemu . Więc zaczynamy od podstaw i #	wszystkich
#	brakujących nam do tego zależności.

##	-------- java -------
function func_java7_install {
    echo ":: paczki.sh :: func_java7_install ::" >&4
    clear
    sudo apt-get install openjdk-7-jdk openjdk-7-doc openjdk-7-source openjdk-7-jre
}
##	Najnowsza java jest nam potrzebna do instalacji programu netbeans,
##	choć webcamstudio pracuje i skompilowany będzie na java-6-jdk.
function func_java6_install {
    echo ":: paczki.sh :: func_java6_install ::" >&4
    clear
    sudo apt-get install openjdk-6-jdk openjdk-6-doc openjdk-6-source openjdk-6-jre
}
##	Sprawdzamy wersje javy zainstalowane muszą sią zagadzać.
#
##	Jeżeli wersje się nie zgadzaja to musimy ustawić alternatives java, lub ustawiona jest wersja 7 to przestawiamy na wersje 6
function func_up_alt_java {
    echo ":: paczki.sh :: func_up_alt_java ::" >&4
    echo
    sudo update-alternatives --config java
    echo
    sudo update-alternatives --config javac
    echo ":: paczki.sh :: func_up_alt_java ->> end }::" >&4
}
###
# Funkcja yes_no
##
function func_ask {
    echo ":: paczki.sh :: func_ask ::" >&4
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        read -p "$1 [$prompt] " REPLY

        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
    echo ":: paczki.sh :: func_ask ->> end }::" >&4
}
###
#
##
function func_java_version {
    echo ":: paczki.sh :: func_java_version ::" >&4
    clear
    java -version
    javac -version

    if func_ask "$java_version_info" Y; then
        return 0
    else
        func_up_alt_java
    fi
    echo ":: paczki.sh :: func_java_version  end ->> }::" >&4
}
###
#   Funkcja instaluje :
#	-------------- ant ---------------
#	Jest to kompilator java.
##
function func_ant {
    echo ":: paczki.sh :: func_ant ::" >&4
    clear
    sudo apt-get install ant
}
###
#   Funkcja zapisuje plik .resztainstalacji
##
function func_dodaj_pozostale_do_instalacji
{
    echo ":: paczki.sh :: func_dodaj_pozostale_do_instalacji ::" >&4
    test -f .resztainstalacji || > .resztainstalacji
    echo "func_standart_wbs" >> .resztainstalacji
    echo "func_reszta_pakietow" >> .resztainstalacji
    echo "func_kodeki" >> .resztainstalacji
    echo "func_autoremove" >> .resztainstalacji
    echo "func_ufw" >> .resztainstalacji
}
###
#   Funkcja restartuje program
#   po dkms
#   i -> func_dodaj_pozostale_do_instalacji()
##
function func_restart {
    echo ":: paczki.sh :: func_restart ::" >&4

    $DIALOG --title "Restart ?" --clear \
	--yesno "We need restart system <y/n>" 5 30
    case $? in
	0)
	    func_dodaj_pozostale_do_instalacji
	    sudo shutdown -r 0 ;;
	1)
	   func_dodaj_pozostale_do_instalacji ;;
	255)
	   func_dodaj_pozostale_do_instalacji ;;
    esac
}
##	-------- inne wymagane pakiety pakiety  -------
#
##	Standart podany przez autora tej aplikacji.
##	Build-Depends: debhelper (>= 7.2.7~), cdbs (>= 0.4.69~), dkms (>= 2.1.1.1), devscripts,
# bzip2, subversion, linux-headers-generic, ant, #	default-jdk, libappframework-java, libcommons-cli-java,
# libcommons-codec-java, libcommons-httpclient-java, libcommons-lang3-java,
#	#	libjsr305-java, liblog4j1.2-java, libnb-absolutelayout-java, libnetty-java, libslf4j-java, libswingworker-java,
# junit
# ------------------------------------------------------

###
#   Funkcja instaluje :
#   - debhelper
#   - cdbs
#   - dkms
# i -> func_restart()
##
function func_standart_wbs {
    echo ":: paczki.sh :: func_standart_wbs ::" >&4

    clear
    sudo apt-get install debhelper
    sudo apt-get install cdbs
    sudo apt-get install dkms
    echo
    echo
    read -p "<enter>" enter
    func_restart
    clear
}
##	Po dkms restartujemy system.
#----------------------------------------------------------

###
#
##
function func_reszta_pakietow {
    echo ":: paczki.sh :: func_reszta_pakietow ::" >&4
    clear
    sudo apt-get install devscripts bzip2 subversion linux-headers-generic default-jdk libappframework-java libcommons-cli-java libcommons-codec-java libcommons-httpclient-java libcommons-lang3-java libjsr305-java liblog4j1.2-java libnb-absolutelayout-java libnetty-java libslf4j-java libswingworker-java junit ffmpeg
}
###
#   Bez tych dwóch nie uda wam się puścić stream na zewnątrz.
##
function func_kodeki {
    echo ":: paczki.sh :: func_kodeki ::" >&4
    clear
    sudo apt-get install libavformat-extra*
    sudo apt-get install libavcodec-extra*
}
##	I na koniec
#
function func_autoremove {
    echo ":: paczki.sh :: func_autoremove ::" >&4
    clear
    sudo apt-get autoremove
}
##	--------------- FIREWALL -------------------
##	Aby do jakiego kolwiek połączenia doszło ze stronami Bamusera czy Ustream
# trzeba otworzyć na zewnątrz port transmisji video
##	 numer 1935 . A wię tak po kolei.
##	Odpalamy ufw nakładkę na firewall
function func_ufw {
    echo ":: paczki.sh :: func_ufw ::" >&4
    clear
    sudo ufw enable
    sudo ufw allow out 1935/tcp
    sudo ufw allow out 1935/udp
}
##	Restart systemu dla pełnej aktywacji ufw i sprawdzamy stan
function func_ufw_status
{
echo ":: paczki.sh :: func_ufw_status ::" >&4
clear
cat << EOF
	Wynik powinien być tego typu:

Status: active

To                         Action      From
--                         ------      ----
1935/tcp                   ALLOW OUT   Anywhere
1935/udp                   ALLOW OUT   Anywhere
1935/tcp                   ALLOW OUT   Anywhere (v6)
1935/udp                   ALLOW OUT   Anywhere (v6)
EOF
    sudo ufw status
}

##	-------------- netbeans -------------------
##	Ze strony https://netbeans.org/downloads/ ściągamy pełną instalke.
##	Odpalamy terminal i nadajemy sktyptowi prawa wykonywalne
#
#chmod a+x netbeans-7.3.1-linux.sh
#
##	Wersja pliku może się różnić ale to nie ma znaczenia.
##	Instalacja
#
#./netbeans-7.3.1-linux.sh
#
##	i tu nas za rączke poprowadzi przez instalacje programu.
##	Po zainstalowaniu trzeba dodać w netbeans starą platforme java 6 jdk.
##	Ale to jest na tutorialu --- adress -- dokładnie pokazane jak to zrobić.
#
#
##	------------- DODANIE REPO I INSTALACJA Z SERVERA ----------------
##	--------------------------- WBST ---------------------------------
##	Na stronie PPA wybierzecie włąsną wersje Ubuntu.
##	Moja to Ubuntu Presize(12.4)
#
##	Pobrane ze strony dodajemy do sources.list na sam koniec pliku.
#
#sudo gedit  /etc/apt/sources.list
#
##	i wlejamy tam to save i zamykamy plik:
#
#deb http://ppa.launchpad.net/webcamstudio/webcamstudio-dailybuilds/ubuntu precise main
#deb-src http://ppa.launchpad.net/webcamstudio/webcamstudio-dailybuilds/ubuntu precise main
#
##	Drugi krok to pobranie klucza publicznego.
#
#sudo apt-add-repository ppa:webcamstudio/webcamstudio-dailybuilds
#
##	Update i Upgrade
#
#sudo apt-get update
#sudo apt-get upgrade
#sudo apt-get install webcamstudio
#
##	Osobiście polecam restart po tej instalacji :)