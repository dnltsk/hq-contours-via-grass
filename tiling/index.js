var geojsonvt = require('geojson-vt');
var fs = require('fs');
var geobuf = require('geobuf');
var Pbf = require('pbf');
var mkdirp = require('mkdirp');

var geoJSON = require('./press_500_l.json');

var tileIndex = geojsonvt(geoJSON);

// request a particular tile
for (var z = 0; z < 5; z++) {
  var dimension = Math.pow(2, z);
  for (var y = 0; y < dimension; y++) {
    for (var x = 0; x < dimension; x++) {
      var tile = tileIndex.getTile(z, x, y);
      var dir = "out/"+z+"/"+x;
      mkdirp.sync(dir);
      var file = dir+"/"+y+".pbf";
      console.log(file);
      fs.writeFileSync(dir+"/"+y+".pbf", geobuf.encode(tile, new Pbf()));
      //process.exit();
    }
  }
}
