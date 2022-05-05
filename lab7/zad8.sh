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
# Zadanie 8.
# Przetworzyć zawartość pliku `dodatkowe/sensors.txt` i wyświetlić całą jego
# zawartość, ale podmieniając w locie zapisane tam wartości temperatur ze skali
# Celsjusza na Fehrenheita: T[°F] = T[°C] * 9/5 + 32.
#


awk '{
	#poczatek przetwarzania linii
	LINE = $0
	POZ = match(LINE, /([0-9]+.[0-9]+)°C/, TAB)	

	while(POZ!=0)
	{
		#wyswietlenie frgamentu poprzedzajacego
		printf substr(LINE, 1, POZ-1)
		
		#przyciecie zmiennej
		POZ = match(LINE, /°C/)
		LINE = substr(LINE, POZ+2)
		
		#przetworzenie i wyswietlenie temperatury
		printf TAB[1] * 1.8 + 32
		printf "°F"

		POZ = match(LINE, /([0-9]+.[0-9]+)°C/, TAB)	
	}
	print LINE;
}' dodatkowe/sensors.txt
