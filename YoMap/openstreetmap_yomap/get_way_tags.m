function [ key,val ] = get_way_tags( tag )
%GET_WAY_TAGS Summary of this function goes here
%   Detailed explanation goes here

    Ntags = size(tag,2);

    key = cell(1,Ntags);
    val = cell(1,Ntags);

if isstruct(tag) == 1
    key{1} = tag.Attributes.k;
    val{1} = tag.Attributes.v;
elseif iscell(tag) == 1
    for i=1:Ntags
        key{i} = tag{i}.Attributes.k;
        val{i} = tag{i}.Attributes.v;
    end

else    
    key = '';
    val = '';

end

