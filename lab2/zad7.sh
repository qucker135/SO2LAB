#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 2
#
# Celem zajęć jest nabranie doświadczenia w podstawowej pracy z powłoką Bash,
# w szczególności w nawigowaniu po drzewie katalogów i sprawdzaniu uprawnień.
# Proszę unikać wykorzystywania narzędzia `find` w ramach bieżących zajęć.
#
# Nie przywiązujemy wagi do środowiska roboczego – zakładamy, że jego pliki,
# inne niż te podane wprost w treści zadań, mogą ulec zmianie, a przygotowane
# rozwiązania nadal powinny działać poprawnie (robić to, o czym zadanie mówi).
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 7.
# Odnaleźć plik w katalogu `dane/kontrola/`, którego zawartość pokrywa się
# z wnętrzem pliku `dane/poszukiwany`. Jako wynik, wyświetlić wyłącznie nazwę
# pasującego pliku. Jeśli takiego pliku nie ma, nie wyświetlać zupełnie nic.
# Proszę pamiętać o każdorazowym upewnieniu się, że zawartość pliku możemy
# przeczytać (mamy prawo do odczytu – aby uniknąć błędów).
#

#IFS=$'\n'
#find $(grep -l $(find dane/kontrola -type f -perm -g=r) -e "^"$(cat dane/poszukiwany)"$") -exec basename {} \;
#cat dane/poszukiwany
#74236617e4807bb430d602d49ee50701
#find dane/kontrola -type f 
#find dane/kontrola -type f -perm -g=r

content=$(cat dane/poszukiwany)

for file in dane/kontrola/*; do
	if [[ -r "$file" && $(cat "$file") == $content ]]; then
		echo "${file#*/*/}" # alternatywnie basename - skrypt dojdzie do jego wywołania tylko dla jednego pliku, więc wydajność raczej nie stanowi problemu
	fi
done
