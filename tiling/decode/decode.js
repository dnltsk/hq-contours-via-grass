var VectorTile = require('vector-tile').VectorTile;
var Protobuf = require('pbf');
var fs = require('fs');

var data = fs.readFileSync(process.argv[2] + '.pbf');

var tile = new VectorTile(new Protobuf(data));
var features = [];
for (var i = 0; i < tile.layers.geojsonLayer.length; i++) {
  features.push(tile.layers.geojsonLayer.feature(i).toGeoJSON(0,0,0));
}

fs.writeFileSync(process.argv[2] + '.geojson', JSON.stringify({type: 'FeatureCollection', features: features}));
