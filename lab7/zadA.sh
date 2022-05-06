#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7 – semestr letni 2020/2021
#
# Celem zajęć jest zapoznanie się z wyrażeniami regularnymi, wykorzystując
# przy tym narzędzia awk i grep oraz wszystkie inne, poznane na zajęciach.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 10.
# Proszę opracować uproszczony konwerter plików z formatu JSON do formatu XML
# i przetworzyć nim plik `dodatkowe/simple.json`. Zakładamy, że wejście stanowi
# zawsze pojedyncza linia, klucze i wartości to proste łańcuchy znaków, złożone
# z liter lub cyfr, pomiędzy cudzysłowami, które są rozdzielone jednym znakiem
# dwukropka i co najmniej jedną spacją, a całe pary klucz-wartość są oddzielone
# od siebie jednym przecinkiem i co najmniej jedną spacją.
#
# Przykład przetworzenia: {"klucz": "wartość"} -> <klucz>wartość</klucz>.
#
# Proszę obsłużyć tworzenie samodomykającego się znacznika (<klucz />), kiedy
# wartość stanowi pusty łańcuch "", a także proszę obsłużyć zagnieżdżenie
# kolejnego zbioru kluczy i wartości.
#

#przeszukiwanie niezachłanne + grupy + petla
awk '
{
	LINE = $0
	
	#pozbadz sie skrajnych {}
	LINE = substr(LINE, 2, length(LINE)-2)

	#konwersja wszystkich znacznikow pustych (<klucz />)
	
	POZ = match(LINE, /"([^":,]+)": +""/, TAB)

	while(POZ!=0){
		#wydziel fragment tekstu do przetworzenia
		PRE = substr(LINE, 1, POZ-1)
		
		POST = substr(substr(LINE, POZ), length(TAB[0])+1)

		TAG = "<"TAB[1]" />"

		LINE = PRE TAG POST

		POZ = match(LINE, /"([^":,]+)": +""/, TAB)
	}

	#konwersja wszystkich znacznikow podwojnych (<klucz>wartosc</klucz>)
	
	POZ = match(LINE, /"([^":,]+)": +"([^":,]+)"/, TAB)
	
	while(POZ!=0){
		#wydziel fragment tekstu do przetworzenia
		PRE = substr(LINE, 1, POZ-1)
		
		POST = substr(substr(LINE, POZ), length(TAB[0])+1)

		TAG = "<"TAB[1]">"TAB[2]"</"TAB[1]">"

		LINE = PRE TAG POST

		POZ = match(LINE, /"([^":,]+)": +"([^":,]+)"/, TAB)
	}

	POZ = match(LINE, /{[^{}]*}/, TAB)			

	while(POZ!=0){
		#substytucja znakow {} na cudzyslowy
		PRE = substr(LINE, 1, POZ-1)
		
		FRAG = TAB[0]
		sub(/{/, "\"", FRAG)
		sub(/}/, "\"", FRAG)
		
		POST = substr(substr(LINE, POZ), length(TAB[0])+1)

		LINE = PRE FRAG POST

		POZ = match(LINE, /"([^":,]+)": +"([^":]+)"/, TAB)
	
		while(POZ!=0){
			#wydziel fragment tekstu do przetworzenia
			PRE = substr(LINE, 1, POZ-1)
	
			POST = substr(substr(LINE, POZ), length(TAB[0])+1)
	
			TAG = "<"TAB[1]">"TAB[2]"</"TAB[1]">"
			
			LINE = PRE TAG POST
			
			POZ = match(LINE, /"([^":,]+)": +"([^":,]+)"/, TAB)
		}
		
		POZ = match(LINE, /{[^{}]*}/, TAB)			
	}

	#usun sekcje "przecinek + przynajmniej 1 spacja"

	gsub(/, +/, "", LINE)
	print LINE

}' dodatkowe/simple.json
