#!/bin/bash
#########################################################################
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#   @author gumbicp                                                     #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#																		#
#   funkcje.sh                                                          #
#             Plik z funkcjami dla terminator_for_wbs.sh                #
#                                                                       #
# This program is free software; you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation; either version 2 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program; if not, write to the Free Software           #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,            #
# MA 02110-1301, USA.                                                   #
#                                                                       #
#########################################################################

#
# Funkcja kończy program
# - czyszczenie ekranu
# - wypisanie wiadomosci
# - exit 0
#
function koniec
{
    clear
    echo
    echo
    echo -e "\t\tMam na dzieję że nie było błędów w działaniu programu."
    echo -e "\tJeżeli  tak  proszę  dać  mi  znać  na  --> pracacp@gmail.com"
    echo -e "\tLub w issues na https://github.com/gumbicp/TERMINATOR_WBS.git"
    echo
    echo -e "\t\tPozd. gumbicp"
    echo
    echo
    exit 0
}
# 
# Funkcja startuje dialog
#
function func_start
{
    dialog --checklist "Odznacz pakiety do instalacji \n odznacz - spacja\n dół/góra - strzałki\n tab,enter " 15 35 5\
    1 "Java 7" off\
    2 "Java 6" off\
    3 Netbeans off\
    4 "Dodatki ubuntu" off\

    koniec
}
#
# Funckja instaluje pakiet dialog
# i startuje program
# @see func_start
#
function func_install_dialog
{
    sudo apt-get update
    sudo apt-get install dialog
    func_start
}
