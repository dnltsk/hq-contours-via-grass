#! /bin/bash

#
# SCRIPT PREPARATION
#
export GISRC=$HOME/.grassrc7

# path to GRASS binaries and libraries:
export GISBASE=/usr/lib/grass72

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

#
# SCRIPT
#

# debug GRASS and GDAL version
g.version
ogrinfo --version

#1. extract contours as lines every 5 hPa
gdal_contour -i 5 -off 0 -a value sample-data/gfs-pressure.grb sample-data/contours.shp

#2. import contours to GRASS
v.in.ogr input=sample-data/contours.shp output=contours

#3. smooth corners (two times to get even more smoother lines)
v.generalize --overwrite method=sliding_averaging threshold=1.0 input=contours output=isolines_all
v.generalize --overwrite method=sliding_averaging threshold=1.0 input=isolines_all output=isolines_all2

#4. simplify to third digit
v.generalize --overwrite method=douglas threshold=0.005 input=isolines_all2 output=isolines_all2_sim

#5. export as GeoJSON
v.out.ogr --overwrite type=line input=isolines_all2_sim output=sample-data/isolines_all2_sim.shp
ogr2ogr -f "GeoJSON" -lco COORDINATE_PRECISION=2 -dialect sqlite -sql "select * from isolines_all2_sim where ST_LENGTH(GEOMETRY) >= 1" sample-data/isolines.geojson sample-data/isolines_all2_sim.shp

#6. clean up
rm -rf sample-data/*.dbf
rm -rf sample-data/*.prj
rm -rf sample-data/*.shp
rm -rf sample-data/*.shx

echo "DONE."