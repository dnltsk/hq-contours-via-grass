# High Quality Contours via GRASS

Sample environment and script to create high quality contours via GRASS and GDAL/OGR. Typical use cases are isobar maps for weather- and elevation maps

It is inspired from an answer on StackOverflow.<br/> 
http://gis.stackexchange.com/questions/87505/grass-v-generalize-method-douglas-not-working-as-expected

![sample result](sample-result.gif "sample result")

## environment

* GRASS 7.3.svn (2017)
* GDAL 2.2.0dev, released 2016/99/99

## build docker image

* `docker build -t grass .`

## run sample script

* `docker run -it --rm -v $(pwd):$(pwd) -w $(pwd) grass ./sample-script.sh`

## references

* GRASS and Shell<br/>
https://grasswiki.osgeo.org/wiki/GRASS_and_Shell