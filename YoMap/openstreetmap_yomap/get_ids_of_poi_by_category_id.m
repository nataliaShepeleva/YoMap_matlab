function [ pos_of_poi ] = get_ids_of_poi_by_category_id( parsed_poi,cat_id )
%GET_POI_BY_CATEGORY_ID Summary of this function goes here
%   Detailed explanation goes here

%Get position (index in table) of poi of cat_id
pos_of_poi = find(parsed_poi.poi.cat_id(:)==cat_id);


end

