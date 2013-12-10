#!/bin/bash
#########################################################################
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#   @author gumbicp                                                     #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#																		#
#   zmienne.sh                                                          #
#             Plik ze zmiennymi dla terminator_for_wbs.sh               #
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
opcje=$#
brak_t_op="Nie ma takiej opcji .. "
bool_brak_t_op=False
opis="

                TERMINATOR PAKIETOWY

        Program do instalacji róźnych pakietów potrzebnych do webcamstudio.
    Tą wiadomość zobaczysz tylko przy pierwszym uruchomieniu  tego skryptu,
    aby to menu pomijać uruchom skrypt z opcja :

    ./terminator_for_wbs.sh -m

    Aby program wystartował musi być doinstalowany pakiet dialog do obsługi
    okienek w terminalu.
    Przy braku tego pakietu programik nie wystartuje !!!


"
# dla menu tekstowego
pierwsza="Instaluj-dialog"
druga="Zainstalowany"
koniec="Zamknij"
tab_menu_start=("$pierwsza" "$druga" "$koniec")
dl_tms=${#tab_menu_start[@]}
