function [parsed_osm, osm_xml] = parse_openstreetmap(dir_path,openstreetmap_filename,parsed_osm_filename,fromMat)
%PARSE_OPENSTREETMAP    parse an OpenStreetMap XML file (OSM XML)
%   [parsed_osm] = PARSE_OPENSTREETMAP(openstreetmap_filename) Parses an
%   OpenStreetMap XML file saved from:
%       http://www.openstreetmap.org/
%   after zooming in the area of interest and using the "Export" option to
%   save it as an OpenStreetMap XML Data file, selecting this from the
%   "Format to Export" options. The OSM XML is specified in:
%       http://wiki.openstreetmap.org/wiki/.osm
%
% usage
%   [parsed_osm, osm_xml] = PARSE_OPENSTREETMAP(openstreetmap_filename)
%
% input
%   openstreetmap_filename = string of OpenStreetMap XML Data file name.
%
% output
%   parsed_osm = MATLAB data structure of parsed OpenStreetMap file
%   osm_xml = MATLAB data structure of XML OpenStreetMap file
%             (before parsing), as loaded by xml2struct (see dependency).
%
% dependency
%   xml2struct, File Exchange ID = 28518, (c) 2010 by Wouter Falkena
%   http://www.mathworks.com/matlabcentral/fileexchange/28518-xml2struct
%
% references
%   http://www.openstreetmap.org/
%   http://wiki.openstreetmap.org/wiki/.osm
%   http://wiki.openstreetmap.org/wiki/Data_Primitives
%   http://www.mathworks.com/matlabcentral/fileexchange/28518-xml2struct
%
% See also PLOT_WAY, EXTRACT_CONNECTIVITY.
%
% File:         parse_openstreetmap.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.09 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      parse OpenStreetMap XML Data file into MATLAB structure
% Copyright:    Ioannis Filippidis, 2010-

%==2 - load parsed matlab .mat
%==1 - read osmfile, parse and save to file
%==anyother - read osmfile and parse
if fromMat==2
    osm_xml=0;
    load(parsed_osm_filename,'parsed_osm');
else    
    map_osm = load_osm_xml(openstreetmap_filename);
    osm_xml = map_osm.osm;
    parsed_osm = parse_osm_modified(osm_xml);
    if fromMat==1
        save(fullfile(dir_path,'data',parsed_osm_filename),'parsed_osm');
    end    
end


