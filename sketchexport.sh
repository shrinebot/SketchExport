#!/bin/sh

echo "Hello, world!"

rm -r export
mkdir export
###################################
###  1X
###################################
sketchtool export slices $1 --output="export/1x" --scales="0.5"
cd export/1x
mkdir -p ../../../Droid/Resources/drawable-mdpi
mkdir -p ../../../iOS/Resources/Images/@1x
for file in *.png
do
mv "$file" "${file//@0.5x/}"
done
for file in *.png
do
cp "${file}" "../../../Droid/Resources/drawable-mdpi/${file}"
cp "${file}" "../../../iOS/Resources/Images/@1x/${file}"
done
cd ../..


###################################
###  2X
###################################
sketchtool export slices $1 --output="export/2x" --scales="1"
cd export/2x
mkdir -p ../../../Droid/Resources/drawable-xhdpi
mkdir -p ../../../iOS/Resources/Images/@2x
for file in *.png
do
cp "${file}" "../../../Droid/Resources/drawable-xhdpi/${file}"
cp "${file}" "../../../iOS/Resources/Images/@2x/${file}"
done
cd ../..

###################################
###  3X
###################################
sketchtool export slices $1 --output="export/3x" --scales="1.5"
cd export/3x
mkdir -p ../../../Droid/Resources/drawable-xxhdpi
mkdir -p ../../../iOS/Resources/Images/@3x
for file in *.png
do
mv "$file" "${file//@1x/}"
done
for file in *.png
do
cp "${file}" "../../../Droid/Resources/drawable-xxhdpi/${file}"
cp "${file}" "../../../iOS/Resources/Images/@3x/${file}"
done
cd ../..

###################################
###  4X
###################################
sketchtool export slices $1 --output="export/4x" --scales="2"
cd export/4x
mkdir -p ../../../Droid/Resources/drawable-xxxhdpi
for file in *.png
do
mv "$file" "${file//@2x/}"
done
for file in *.png
do
cp "${file}" "../../../Droid/Resources/drawable-xxxhdpi/${file}"
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
mkdir -p ../../../../Droid/Resources/drawable-hdpi
for file in *.png
do
cp "${file}" "../../../../Droid/Resources/drawable-hdpi/${file}"
done
cd ../..



