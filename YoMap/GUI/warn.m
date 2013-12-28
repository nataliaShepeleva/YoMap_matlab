function warn(numb)
switch numb
    case 1 
        error = 'Please choose type of transport';
    case 2
        error = 'Enter pooint A';
    case 3
        error = 'Enter pooint B';
    case 4
        error = 'Choose the category';
    case 5
        error = 'Choose the point of interest';
    case 6
        error = 'Sorry, no path found';
    case 7
        error = 'Sorry, this object does not exist or written not correctly';
end

hand = errordlg(error, 'YoMap');