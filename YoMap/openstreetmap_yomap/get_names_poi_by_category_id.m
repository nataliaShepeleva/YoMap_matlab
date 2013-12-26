function [ array_of_names ] = get_names_poi_by_category_id( parsed_poi,cat_id )
%GET_NAMES_POI_BY_CATEGORY_ID Summary of this function goes here
%   Detailed explanation goes here

pos_of_poi = get_ids_of_poi_by_category_id(parsed_poi,cat_id);

%Get names of this pois
array_of_names = parsed_poi.poi.name{pos_of_poi};

end

