var geojsonvt = require('geojson-vt');
var fs = require('fs');
var mkdirp = require('mkdirp');
var exec = require('child_process').exec;
var vtpbf = require('vt-pbf');

var geoJSON = require('./press_500_l.json');

var tileIndex = geojsonvt(geoJSON);

// request a particular tile
for (var z = 0; z < 15; z++) {
  var dimension = Math.pow(2, z);
  for (var y = 0; y < dimension; y++) {
    for (var x = 0; x < dimension; x++) {
      var dir = "out/"+z+"/"+x;
      mkdirp.sync(dir);
      var file = dir+"/"+y+".pbf";
      console.log(file);

      var tile = tileIndex.getTile(z, x, y);
      if (tile) {
        var buff = vtpbf.fromGeojsonVt({'geojsonLayer': tile});
        fs.writeFileSync(file, buff);
      }
    }
  }
}
