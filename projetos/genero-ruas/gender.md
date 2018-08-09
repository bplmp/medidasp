## adapted from
https://github.com/mourner/road-orientation-map.git

### todo
- calculate length
- feature popup hover / click
- bar chart
- make it pretty (map color scheme, website)
- brand & about

### note
try first with sample

### data processing steps
0. download from https://download.geofabrik.de/south-america/brazil.html
1. filter where name is not null
2. split type (Rua, Avenida...) OR remove all of these words from string
3. split titles (Doutor, Professora...) OR remove all of these words from string
4. split remaining string by spaces and take first element
5. join gender indices from gender names table
6. compare indices and set gender
7. remove unused fields (osm_id, code, ref, oneway, maxspeed, layer, bridge, tunnel)
8. save to geojson
9. convert to geobuf
10. generate tiles with tippecanoe
11. upload to mapbox as tileset
