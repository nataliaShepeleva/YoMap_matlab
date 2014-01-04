function [ Optimal_path, start_end_points,poi ] = findShortestItinerary( parsed_osm,parsed_poi,start_x,start_y,end_x,end_y,cat_id,max_rad,mode)
%findShortestWayInRadius Finds the shortest way from A to B with stop at shop in some
%category
%   parsed_osm - data about roads
%   parsed_poi - data about poi
%   start_x - start x coordinate
%   start_y - start y coordinate
%   end_x - end x coordinate
%   end_y - end y coordinate
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
    [iS_end,pointOfContact_end] = find_closest_segment(parsed_osm.node,parsed_osm.segments,mode,end_x,end_y);

    
    poi_ids = get_ids_of_poi_by_category_id(parsed_poi,cat_id);
    poi_loc = parsed_poi.poi.xy(:,poi_ids);
    
    %air distance between start and POI
    poi_dist(1,:) = calc_air_distance_byPoint(pointOfContact_start,poi_loc(:,:));
    %air distance beteen POI and end
    poi_dist(2,:) = calc_air_distance_byPoint(poi_loc(:,:),pointOfContact_end);
    
    %sum of both parts has to be smaller than max radius
    poi_ids = poi_ids(sum(poi_dist)<max_rad);
    if ~isempty(poi_ids)
        poi_loc = parsed_poi.poi.xy(:,poi_ids);
    
        dist = zeros(2,size(poi_ids,1));
        routes = cell(2,size(poi_ids,1));
        for ii=1:size(poi_ids)       
           routes(1,ii) = {findShortestWayByPosition(parsed_osm,start_x,start_y,poi_loc(1,ii),poi_loc(2,ii),mode)};
           routes(2,ii) = {findShortestWayByPosition(parsed_osm,poi_loc(1,ii),poi_loc(2,ii),end_x,end_y,mode)};
           dist(1,ii) =  calc_distance_route(routes{1,ii});
           dist(2,ii) =  calc_distance_route(routes{2,ii});
        end

        %get possible distances
        dist_ok = (dist(1,:)>0 & dist(2,:)>0);
        if isempty(dist_ok)
            Optimal_path = [start_x;start_y];
            start_end_points = [start_x start_x;start_y start_y];
            poi=0;
        else
            dist = dist(:,dist_ok);
            routes = routes(:,dist_ok);
            poi_ids = poi_ids(dist_ok);
            [min_v,min_i] = min(sum(dist));
            if min_v<max_rad
                Optimal_path = [routes{2,min_i} routes{1,min_i}]; 
                start_end_points = [end_x start_x;end_y start_y];
                %get info about middle point
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
                poi = 0;
            end
        end
    else
        Optimal_path = [start_x;start_y];
        start_end_points = [start_x start_x;start_y start_y];
        poi = 0;
    end

end
