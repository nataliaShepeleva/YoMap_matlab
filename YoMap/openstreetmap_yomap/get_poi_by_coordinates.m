function [ poi ] = get_poi_by_coordinates(parsed_poi, x, y)
n = size(parsed_poi.poi.xy(:,:));
poi = 0;
for poi_id = 1:1:n(2)
    if (abs(parsed_poi.poi.xy(1,poi_id) - x) < 0.0001) & (abs(parsed_poi.poi.xy(2,poi_id) - y) < 0.0001)
            display('here')
            poi.id = parsed_poi.poi.id(1,poi_id);
            poi.cat_id = parsed_poi.poi.cat_id(1,poi_id);
            poi.xy = parsed_poi.poi.xy(:,poi_id);
            poi.name = parsed_poi.poi.name{1,poi_id};
            poi.address = parsed_poi.poi.address{1,poi_id};
            poi.photo_path = parsed_poi.poi.photo_path{1,poi_id};
            poi.user = parsed_poi.poi.user{1,poi_id};
    end
end