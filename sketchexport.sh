#!/bin/sh
 
echo "Hello, world!"

rm -r export
mkdir export
###################################
###  1X
###################################
sketchtool export slices Create_Match.sketch --output="export/1x" --scales="0.5"
cd export/1x
mkdir -p ../android/mdpi
mkdir -p ../iphone/@1x
for file in *.png
do
  mv "$file" "${file//@0.5x/}"
done
for file in *.png
do
  cp "${file}" "../android/mdpi/${file}"
  cp "${file}" "../iphone/@1x/${file}"
done
cd ../..


###################################
###  2X
###################################
sketchtool export slices Create_Match.sketch --output="export/2x" --scales="1"
cd export/2x
mkdir -p ../android/xhdpi
mkdir -p ../iphone/@2x
for file in *.png
do
  cp "${file}" "../android/xhdpi/${file/@2x.png/-xhdpi.png}"
  cp "${file}" "../iphone/@2x/${file/.png/@2x.png}"
done
cd ../..

###################################
###  3X
###################################
sketchtool export slices Create_Match.sketch --output="export/3x" --scales="1.5"
cd export/3x
mkdir -p ../android/xxhdpi
mkdir -p ../iphone/@3x
for file in *.png
do
  mv "$file" "${file//@1.5x/}"
done
for file in *.png
do
  cp "${file}" "../android/xxhdpi/${file}"
  cp "${file}" "../iphone/@3x/${file}"
done
cd ../..

###################################
###  4X
###################################
sketchtool export slices Create_Match.sketch --output="export/4x" --scales="2"
cd export/4x
mkdir -p ../android/xxxhdpi
for file in *.png
do
  mv "$file" "${file//@2x/}"
done
for file in *.png
do
  cp "${file}" "../android/xxxhdpi/${file}"
done
cd ../..


###################################
###  1.5X (use 50% of our exported 3x) 
###################################
cd export/3x
mkdir -p ../android/hdpi
for file in *.png
do
  cp "${file}" "../android/hdpi/${file}"
done
cd ../android/hdpi
mogrify -verbose -resize 50% *.png
cd ../..



