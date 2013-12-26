function [ poi ] = get_poi_by_id_from_category_id( parsed_poi,cat_id,poi_id )
%GET_POI_FROM_ARRAY_OF_POI Summary of this function goes here
%   Detailed explanation goes here

[pos]= get_ids_of_poi_by_category_id(parsed_poi,cat_id);

poi.id = parsed_poi.poi.id(1,pos(poi_id));
poi.cat_id = parsed_poi.poi.cat_id(1,pos(poi_id));
poi.xy = parsed_poi.poi.xy(:,pos(poi_id));
poi.name = parsed_poi.poi.name{1,pos(poi_id)};
poi.address = parsed_poi.poi.address{1,pos(poi_id)};
poi.photo_path = parsed_poi.poi.photo_path{1,pos(poi_id)};
poi.user = parsed_poi.poi.user{1,pos(poi_id)};



end

