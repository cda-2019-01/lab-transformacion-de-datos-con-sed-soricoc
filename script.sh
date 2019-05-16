sed 's!/!-!g' data.csv > 1.out   # Cambia los '/' por '-'
sed 's#^\([0-9]\)-#0\1-#' 1.out > 2.out # Pone un cero donde encuentra un dígito único al principio de la línea seguido por '-'
sed 's#-\([0-9]\)-#-0\1-#' 2.out > 3.out # Pone un cero donde encuentra un dígito único entre '-' y '-'
sed 's/-\([0-9][0-9]\);/-20\1;/' 3.out > 4.out # Agrega un 20 al inicio del a�o
sed -r 's|(..)-(..)-(....)|\3-\2-\1|' 4.out > 5.out # Cambia el formato de DD-MM-YYYY a YYYY-MM-DD
sed 's!;;!;\\N;!g' 5.out > 6.out # Reemplaza los vacíos por '/N'
sed 's/[a-c,n]/\U&/g' 6.out > 7.out # Convierte las minúsculas en mayúsculas
sed 's!;N!;\\N!g' 7.out > 8.out # Hay algunas Ns que deben corresponder a nulos, se les agrega el '\'
sed 's/,/./' 8.out > 9.out # Las ',' de los decimales pasan a '.'
sed 's/;/,/g' 9.out > 10.out # Reemplaza ';' por ','
sed -e "s/,$/,\\\N/g" 10.out > 11.out # Reemplaza por ',\N' las filas que terminan en ','
sed -e 's!,200.0!,200,0!' 11.out > 12.out # Cascarita 1
sed -e 's!2013-08-02,!2014-08-02,!' 12.out > result.csv # Cascarita 2
rm -rf *.out
cat result.csv
