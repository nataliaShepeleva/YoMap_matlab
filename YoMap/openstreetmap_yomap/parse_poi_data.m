function [ parsed_poi ] = parse_poi_data( poi_xml )
%PARSE_POI_DATA Summary of this function goes here
%   Detailed explanation goes here

parsed_poi.category = parse_category(poi_xml.category);
parsed_poi.poi = parse_poi(poi_xml.poi);
% parsed_poi.category = parse_category(poi_xml.category);
% parsed_poi=0;

function [parsed_category] = parse_category(categories)
Ncategories = size(categories,2);

id = zeros(1, Ncategories);
name = cell(1, Ncategories);
icon_path = cell(1, Ncategories);

for i=1:Ncategories
    id(1,i) = str2double(categories{i}.Attributes.id);
    name(:,i) = {categories{i}.Attributes.name};
    icon_path(:,i) = {categories{i}.Attributes.icon};
end

parsed_category.id = id;
parsed_category.name = name;
parsed_category.icon_path = icon_path;

function [parsed_poi] = parse_poi(pois)
Npoi = size(pois,2);

id = zeros(1, Npoi);
cat_id = zeros(1, Npoi);
xy = zeros(2, Npoi);
name = cell(1, Npoi);
address = cell(1, Npoi);
photo_path = cell(1, Npoi);
user = cell(1, Npoi);

for i=1:Npoi
    id(1,i) = str2double(pois{i}.Attributes.id);
    cat_id(1,i) = str2double(pois{i}.Attributes.cat_id);
    
    xy(:,i) = [str2double(pois{i}.Attributes.lon);...
           str2double(pois{i}.Attributes.lat)];
    
    name(:,i) = {pois{i}.Attributes.name};
    address(:,i) = {pois{i}.Attributes.addr};
    photo_path(:,i) = {pois{i}.Attributes.photo};
    user(:,i) = {pois{i}.Attributes.user};
end

parsed_poi.id = id;
parsed_poi.cat_id = cat_id;
parsed_poi.xy = xy;
parsed_poi.name = name;
parsed_poi.address= address;
parsed_poi.photo_path = photo_path;
parsed_poi.user = user;

