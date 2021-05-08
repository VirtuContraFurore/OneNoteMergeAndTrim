## OneNoteMergeAndTrim

A simple bash script to merge PDF created with one note

This program merges the pages of documents exported to PDF from OneNote

![Alt text](http://github.com/VirtuContraFurore/OneNoteMergeAndTrim/blob/master/example.png?raw=true)7


![solarized vim](https://github.com/altercation/solarized/raw/master/img/solarized-vim.png)

### What you need to install

imagemagick graphicsmagick cpdf

Note: cpdf must be downloaded from www.coherentpdf.com and manually added to  your $PATH
You also may need to edit /etc/ImageMagick-X/policy.xml to allow coder for PDFs

### How to set the CROP REFERENCES

Open your PDF with GIMP and use a bit of trial and error. You can set the ruler to "mm" in order to see distances in millimeters. The cpdf tool also supports different units like inches or points, please refer to the official cpdf documentation. 

### Usage

single file

```
oneNoteTrime ./destination_directory my_file.pdf
```

or multi-file flavour:

```
oneNoteTrime ./destination_directory *.pdf
```

### How to speed up
You can launch the script in parallel

