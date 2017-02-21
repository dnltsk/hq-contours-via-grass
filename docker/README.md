docker build -t grass_builder .
docker run --rm -it -v $(pwd):/data -w /data grass_builder ./sample-script.sh

output: sample-data/isolines_sim.json