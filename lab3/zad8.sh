#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3 – semestr letni 2020/2021
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
#
# Przygotowane rozwiązania nie muszą być całkowicie uniwersalne. Zakładamy,
# że ogólna struktura katalogów się nie zmienia (nie będzie już więcej/mniej
# poziomów podkatalogów), jednakże same nazwy i zawartości plików (o ile
# nie są podane wprost w treści zadań) mogą być dowolne i ulegać zmianie,
# a przygotowane rozwiązania nadal powinny działać.
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 8. 
# Odszukać w katalogu `ccc` wiszące dowiązania i podjąć próbę ich naprawy
# – zakładamy, że wskazywane przez nie nazwy plików są poprawne, ale doszło
# do jakiegoś zamieszania w strukturze katalogów. Należy odszukać pasujących
# plików w katalogach `aaa` i `bbb`, a jeśli odpowiednie pliki istnieją
# to wyświetlić nazwę dowiązania i po dwukropku proponowaną poprawną ścieżkę
# (na przykład: bravo:../aaa/bravo).
#

#IFS=$'\n'
#for path in $(find ccc -xtype l -exec readlink {} + 2> /dev/null)
#do
#	echo $path
#	[[ $path == ../* ]] && echo $path":"$path
#	[[ $path == aaa/* ]] && echo $path":../"$path
#	[[ $path == bbb/* ]] && echo $path":../"$path
#	[[ ! $path == */* && ( -h bbb/$path || -e bbb/$path ) ]] && echo $path":../bbb/"$path
#	[[ ! $path == */* && ( -h aaa/$path || -e aaa/$path ) ]] && echo $path":../aaa/"$path
#
#	#[[ ! $path == */* ]] && [ -h bbb/$path ] || [ -e bbb/$path ] && echo $path
#	#[[ $path == */* ]] || [ ! -h ../aaa/$path ] || echo $path #|| [ ! -h ../aaa/$path ] || echo $path":../aaa/"$path
#	#[[ $path == */* ]] || [ ! -e ../bbb/$path ] || [ ! -h ../bbb/$path ] || echo $path":../bbb/"$path
#done
#for link in ccc/*; do 
#	if [ -h "$link" ]; then #&& [ -e "$(readlink "$link")" ]; then
#		path="$(readlink "$link")"
#		if [ ! -e ccc/"$path" ]; then
#			for file in aaa/*; do
#				if [[ "$(basename "$file")" == "$(basename "$file")" ]]; then
#					echo $path":"$file
#				fi
#			done
#			for file in bbb/*; do
#				if [[ "$(basename "$file")" == "$(basename "$file")" ]]; then
#					echo $path":"$file
#				fi
#			done
#		fi
#	fi
#done

for link in ccc/*; do 
	if [ -h "$link" ]; then
		path=$(readlink "$link")
		if [ ! -e ccc/"$path" ] && [ ! -h ccc/"$path" ]; then
			bname="$(basename "$path")"
			if [ -e aaa/"$bname" ] || [ -h aaa/"$bname" ]; then
				echo "$link:../aaa/$bname"
			fi
			if [ -e bbb/"$bname" ] || [ -h bbb/"$bname" ]; then
				echo "$link:../bbb/$bname"
			fi
		fi
	fi
done
