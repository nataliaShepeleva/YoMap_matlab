%% name file
dir_path = 'E:\Developing\Vibot\SE\GIT\YoMap_matlab\YoMap';

openstreetmap_filename = 'LeCreusotWaysFF.osm';%'genoa.osm';
parsed_osm_filename = 'LeCreusotWaysFF.mat'; %'osm file with data';
map_img_filename = 'map40000.png'; % image file saved from online, if available
poi_filename = 'LeCreusot_POI.xml'; %'osm file with data';
parsed_poi_filename = 'LeCreusot_POI.mat'; %'osm file with data';

%% convert XML -> MATLAB struct 
%read and save to parsed_osm_filename
[parsed_osm, osm_xml] = parse_openstreetmap(dir_path,openstreetmap_filename,parsed_osm_filename,2);
[parsed_poi] = parse_poi_xml(poi_filename,parsed_poi_filename,2);
%% plot
%global figure
fig = figure;
ax = axes();


%% plot road layer
prepareMap(ax,parsed_osm.bounds);
show_map(ax, parsed_osm.bounds, map_img_filename)
plot_way(ax, parsed_osm)
%plot_way(ax, parsed_osm,map_img_filename)

[x,y] = ginput(2)

points = [x(2) x(1); y(2) y(1)]

%% plot routelayer
%route = findShortestWayByPosition(parsed_osm,x(1),y(1),x(2),y(2),2);
[route,points,POI] = findShortestWayInRadius(parsed_osm,parsed_poi,x(1),y(1),2,3,2);
[route,points,POI] = findShortestWayInRadius(parsed_osm,parsed_poi,x(1),y(1),2,0,2);
%[route,points,POI] = findShortestItinerary(parsed_osm,parsed_poi,x(1),y(1),x(2),y(2),2,6,2);
plot_optimal_route(ax, route, points, parsed_osm);

