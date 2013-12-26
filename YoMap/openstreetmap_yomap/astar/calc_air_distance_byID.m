function [distance] = calc_air_distance_byID (parsed_nodes,id_a,id_b)
    distance = calc_air_distance(parsed_nodes.xy(1,id_a),parsed_nodes.xy(2,id_a),parsed_nodes.xy(1,id_b),parsed_nodes.xy(2,id_b));
end
