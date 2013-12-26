function [ icon_path ] = get_icon_path( pre,icon,size )
%GET_ICON_PATH Summary of this function goes here
%   Detailed explanation goes here

if size==1
    size_postfix = '-12';
elseif size==2
    size_postfix = '-12@2x';
elseif size==3
    size_postfix = '-18';
elseif size==4
    size_postfix = '-18@2x';
elseif size==5
    size_postfix = '-24';
elseif size==6
    size_postfix = '-24@2x';
end

icon_path = [pre '/' icon size_postfix '.png'];


end

