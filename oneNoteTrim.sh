#!/bin/bash

#
# This program merges the pages of documents exported to PDF from OneNote
#
# What you need to install: imagemagick graphicsmagick cpdf
# Note: cpdf must be downloaded from www.coherentpdf.com and manually added to  your $PATH
# You also may need to edit /etc/ImageMagick-X/policy.xml to allow coder for PDFs

# How to set the CROP REFERENCES below: open the PDF with GIMP and use a bit of trial and error

### CONFIGURATION

# Crop references, read the cpdf's manual to learn more
PDF_CROP_TOP="14.5mm"
PDF_CROP_BOTTOM="188.7mm"
PDF_CROP_RIGHT="0mm"
PDF_CROP_LEFT="296mm"

# DPI resolution to render the PDF to a PNG file
PDF_RENDER_DENSITY="200"
# Overall quality of converted image
PDF_RENDER_QUALITY="100"


print_usage(){
	echo ""
	echo "Usage: oneNoteTrim [DESTINATION FOLDER] [INPUT FILE]..."
	echo ""
	echo "Do not omit the destination folder"
	echo ""
	echo "> OneNote Trimming script to adjust PDFs exported with OneNote <"
	echo ""
	exit 0
}

convert_file(){

	if [[ ! -f $1 ]]
	then
		echo "Error: input file named '$1' does not exist!"
		exit 0
	fi
	tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
	cpdf -mediabox "$PDF_CROP_RIGHT $PDF_CROP_TOP $PDF_CROP_LEFT $PDF_CROP_BOTTOM" $1 -o $tmp_dir/out.pdf
	echo "Input PDF Cropped"
	convert -density $PDF_RENDER_DENSITY $tmp_dir/out.pdf -quality $PDF_RENDER_QUALITY $tmp_dir/out.png
	echo "Pages converted to PNG"
	gm convert $tmp_dir/out-*.png -append $tmp_dir/out-merged.png
	echo "Pages merged to PGN"
	gm convert $tmp_dir/out-merged.png "$2/$1"
	echo "File $1 has been converted"
	rm -rf $tmp_dir
}

echo ""

if [[ -z "$1" || -z "$2" ]]
then
	print_usage
fi

if [[ ! -d "$1" ]]
then
	echo "Error: destination directory '$1' is not a directory"
	print_usage
	exit
fi

dest="$1"

shift

while [[ ! -z "$1" ]]
do
                echo ""
                echo "*************************"
                echo "Processing: $1"
                convert_file $1 $dest
		shift

done
