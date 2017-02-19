#! /bin/bash

#
# SCRIPT PREPARATION
#

# path to GRASS binaries and libraries:
export GISBASE=/usr/local/grass-7.3.svn

export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GISBASE/lib

# use process ID (PID) as lock file number:
export GIS_LOCK=$$

# settings for graphical output to PNG file (optional)
export GRASS_PNGFILE=/tmp/grass6output.png
export GRASS_TRUECOLOR=TRUE
export GRASS_WIDTH=900
export GRASS_HEIGHT=1200
export GRASS_PNG_COMPRESSION=1
export GRASS_MESSAGE_FORMAT=plain

echo "GISDBASE: /usr/local/grass-7.3.svn
LOCATION_NAME: demolocation
MAPSET: PERMANENT
GUI: text" > $HOME/.grassrc7
export GISRC=$HOME/.grassrc7

#
# SCRIPT
#

# debug GRASS and GDAL version
g.version
ogrinfo --version

#1. import raster
r.in.gdal input=sample-data/sample-pressure.tif output=raster

#2. extract contours
r.contour --overwrite step=500 input=raster output=contours
v.out.ogr --overwrite type=line input=contours output=sample-data/contours.shp

#3. smooth corners with Chaiken's algorithm to get smoother curves
v.generalize --overwrite method=chaiken threshold=0.1 input=contours output=isolines_all
v.out.ogr --overwrite type=line input=isolines_all output=sample-data/isolines_all.shp

#4. remove too small isolines
ogr2ogr -dialect sqlite -sql "select * from isolines_all where ST_LENGTH(GEOMETRY) >= 1" sample-data/isolines.shp sample-data/isolines_all.shp

echo "DONE."