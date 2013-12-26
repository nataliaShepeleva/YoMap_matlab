function [ parsed_poi ] = parse_poi_xml( poi_data_filename, parsed_poi_filename, fromMat )
%PARSE_POI_DATA Summary of this function goes here
%   Detailed explanation goes here
%==2 - load parsed matlab .mat
%==1 - read osmfile, parse and save to file
%==anyother - read osmfile and parse
if fromMat==2
    load(parsed_poi_filename,'parsed_poi');
else    
    poi_xml = load_osm_xml(poi_data_filename);
    poi_xml = poi_xml.data;
    parsed_poi = parse_poi_data(poi_xml);
    if fromMat==1
        save(parsed_poi_filename,'parsed_poi');
    end    
end


end

