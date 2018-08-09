echo '--->sourcing env variables'
. .env

echo '--->dropping tables'
psql -d $DB_NAME -U $DB_USER -p 5432 -f drop_tables.sql

echo '--->creating road titles table'
psql -d $DB_NAME -U $DB_USER -p 5432 -f create_road_titles.sql

echo '--->copying road titles'
psql -d $DB_NAME -U $DB_USER -p 5432 -f copy_road_titles.sql

echo '--->extracting osm roads names'
psql -d $DB_NAME -U $DB_USER -p 5432 -f extract_osm_roads_names.sql

echo '--->setting osm roads genders'
psql -d $DB_NAME -U $DB_USER -p 5432 -f set_osm_roads_gender.sql

echo '--->exporting geojson from postgis'
ogr2ogr -f GeoJSON osm_roads_clean_gender.geojson \
  "PG:host=localhost dbname=$DB_NAME user=$DB_USER password=$DB_PASS" \
  -sql "select geom, name, gender, fclass, road_type, road_title, first_name from osm_roads_clean_gender" \

echo '--->creating mbtiles'
tippecanoe -o osm_roads_clean_gender.mbtiles --simplification=10 --maximum-zoom=15 --drop-densest-as-needed osm_roads_clean_gender.geojson \

echo '--->uploading to mapbox'
mapbox --access-token $MAPBOX_TOKEN \
  upload bernardosp.osm_roads_clean_gender osm_roads_clean_gender.mbtiles

echo '--->deleting osm_roads_clean_gender.geojson'
rm osm_roads_clean_gender.geojson

echo '--->all done.'
