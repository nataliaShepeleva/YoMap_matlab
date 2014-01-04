function [ Optimal_path, start_end_points,poi ] = findShortestWayInRadius( parsed_osm,parsed_poi,start_x,start_y,cat_id,max_rad,mode)
%findShortestWayInRadius Finds the shortest way from A to a shop in some
%category
%   parsed_osm - data about roads
%   parsed_poi - data about poi
%   start_x - start x coordinate
%   start_y - start y coordinate
%   cat_id - id of category we want the shop to be in
%   max_rad - max distance of the road
%   mode - type of transportation (1-car, 2-foot)
%   RETURN: 
%   Optimal_path - optimal path (from last to first point)
%   start_end_points - end and start point of the road (points of contact)
%   poi - returns information about POI that is at the end point (0 if
%   search fails)
    
    % Find closest segment for start
    [iS_start,pointOfContact_start] = find_closest_segment(parsed_osm.node,parsed_osm.segments,mode,start_x,start_y);

    poi_ids = get_ids_of_poi_by_category_id(parsed_poi,cat_id);
    poi_loc = parsed_poi.poi.xy(:,poi_ids);
    
    poi_dist = calc_air_distance(pointOfContact_start(1),pointOfContact_start(2),poi_loc(1,:),poi_loc(2,:));
    poi_ids = poi_ids(poi_dist<max_rad);
    poi_loc = parsed_poi.poi.xy(:,poi_ids);
    
    start_pos = [start_x;start_y];
    
    dist = zeros(size(poi_ids,1));
    routes = cell(size(poi_ids,1));
    for ii=1:size(poi_ids)       
       routes(ii) = {findShortestWayByPosition(parsed_osm,start_pos(1,1),start_pos(2,1),poi_loc(1,ii),poi_loc(2,ii),mode)};
       dist(ii) =  calc_distance_route(routes{ii});
    end
    
    %get possible distances
    dist_ok = dist>0;
    if isempty(dist_ok)
        Optimal_path = [start_x;start_y];
        start_end_points = [start_x start_x;start_y start_y];
        poi=0;
    else
        dist = dist(dist_ok);
        routes = routes(dist_ok);
        poi_loc = poi_loc(:,dist_ok);
        poi_ids = poi_ids(dist_ok);
        [min_v,min_i] = min(dist);
        if min_v<max_rad
            Optimal_path = routes{min_i}; 
            start_end_points = [poi_loc(1,min_i) start_x;poi_loc(2,min_i) start_y];
            %get info about POI
            poi.id = parsed_poi.poi.id(1,poi_ids(min_i));
            poi.cat_id = parsed_poi.poi.cat_id(1,poi_ids(min_i));
            poi.xy = parsed_poi.poi.xy(:,poi_ids(min_i));
            poi.name = parsed_poi.poi.name{1,poi_ids(min_i)};
            poi.address = parsed_poi.poi.address{1,poi_ids(min_i)};
            poi.photo_path = parsed_poi.poi.photo_path{1,poi_ids(min_i)};
            poi.user = parsed_poi.poi.user{1,poi_ids(min_i)};
            
        else
            Optimal_path = [start_x;start_y];
            start_end_points = [start_x start_x;start_y start_y];
            poi=0;
        end
    end
end
