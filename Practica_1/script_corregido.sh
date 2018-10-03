#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#1. Comprobar que exista mytar en el directorio actual
if [ ! -f mytar ]; then
	echo "Programa mytar no encontrado"
	exit
#Comprobar que mytar sea ejecutable
elif [ ! -x mytar ]; then
	echo "Programa mytar no es ejecutable"
	exit
fi

#2. Comprobar si existe el directorio tmp dentro del directorio actual, si existe lo borra
if [ -d tmp ]; then
	rm -r tmp;
fi

#3. Creamos tmp y cambiaremos a este directorio 
mkdir tmp;
cd tmp;

#4. Crear ficheros
echo Hello world! > file1.txt;
echo | head /etc/passwd > file2.txt;
echo | head -c1024 /dev/urandom > file3.dat;

#5. Crear el tar
../mytar -cf filetar.mtar file1.txt file2.txt file3.dat;

#6. Crear directorio out y copiamos el tar en el
mkdir out
cp filetar.mtar out/

#7. Cambiamos al directorio out y extraemos los ficheros del tar
cd out
../../mytar -xf filetar.mtar

#8. Comparamos los ficheros extraidos con los ficheros originales

diff -q file1.txt ../file1.txt
if [ $? = 1 ]; then
	cd ../..
	pwd
	exit 1
fi

diff -q file2.txt ../file2.txt
if [ $? = 1 ]; then
	cd ../..
	pwd
	exit 1
fi

diff -q file3.dat ../file3.dat
if [ $? = 1 ]; then
	cd ../..
	pwd
	exit 1
fi

#9. Si los ficheros extraidos son iguales a los originales
cd ../..
echo Correcto
exit 0

