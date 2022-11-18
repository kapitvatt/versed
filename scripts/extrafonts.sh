#!/bin/sh


FONTS_HOME=/usr/share/fonts/truetype/msttcorefonts/

function download_src() {
    FONTSRC=$1
    if [ ! -f /tmp/$FONTSRC ]; then
        echo "Downloading ${FONTSRC}"
        wget https://archive.org/download/ftp.microsoft.com/ftp.microsoft.com.zip/ftp.microsoft.com/Softlib/MSLFILES/${FONTSRC} -O ./tmp/${FONTSRC}
    fi
    if [ ! -f /tmp/$FONTSRC ]; then 
        echo "Failed to download $FONTSRC"
        exit 1
    fi
    cabextract -d /tmp -F *.TTF /tmp/${FONTSRC}
}

function install_font() {
    FONTFILE=$1
    FONTSRC=$2
    echo -n "Checking for ${FONTFILE} in ${FONTS_HOME}"
    if [ ! -f "${FONTS_HOME}/${FONTFILE}" ]; then
        echo "    - MISSING"
        echo ""
        download_src ${FONTFILE}
        echo "Moving fonts into ${FONTS_HOME}"
        mv /tmp/*.TTF $FONTS_HOME
    else 
        echo "    - EXISTS"
    fi
}

install_font Tahoma.TTF TAHOMA32.EXE

echo "Updating font cache"
fc-cache -f
