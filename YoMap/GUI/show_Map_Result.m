function show_Map_Result(ax,map, road, way, route, points, parsed_osm, openstreetmap_filename, map_img_filename)

cla reset;

flag = 0;
prepareMap(ax, parsed_osm.bounds);

if map == 1
   if flag == 1 
       hold(ax, 'on');
   end
    prepareMap(ax, parsed_osm.bounds);
    show_map(ax, parsed_osm.bounds, map_img_filename);
    flag = 1;
end

if road == 1
   if flag == 1
       hold(ax, 'on');
   end
   prepareMap(ax, parsed_osm.bounds);
   plot_way(ax, parsed_osm, map_img_filename);
   flag = 1;
end

if way == 1
    if route ~= 0
        if flag == 1
            hold(ax, 'on');
        end
        prepareMap(ax, parsed_osm.bounds);
        plot_optimal_route(ax, route, points, parsed_osm);
        flag = 1;
    end
end
