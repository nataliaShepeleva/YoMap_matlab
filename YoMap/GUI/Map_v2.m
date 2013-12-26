function varargout = Map_v2(varargin)
% MAP_V2 MATLAB code for Map_v2.fig
%      MAP_V2, by itself, creates a new MAP_V2 or raises the existing
%      singleton*.
%
%      H = MAP_V2 returns the handle to a new MAP_V2 or the handle to
%      the existing singleton*.
%
%      MAP_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAP_V2.M with the given input arguments.
%
%      MAP_V2('Property','Value',...) creates a new MAP_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Map_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Map_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Map_v2

% Last Modified by GUIDE v2.5 25-Dec-2013 21:17:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Map_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @Map_v2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% End initialization code - DO NOT EDIT


% --- Executes just before Map_v2 is made visible.
function Map_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Map_v2 (see VARARGIN)

% Choose default command line output for Map_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.addPoint, 'UserData', 0);

%define global variables
global valueA;
global categoryA
global poiA;

global valueB;
global categoryB
global poiB;

global valueC;
global valueD;
global valueE;
global valueF;
global radius;
global transport;
global hdotA;
global hdotB;

global xA;
global yA;
global xB;
global yB;
global xC;
global yC;
global xD;
global yD;
global xE;
global yE;
global xF;
global yF;

global cat;
global poi1;
global poi2;
global poi3;
global poi4;

global parsed_osm;
global route;
global h;
global hshowMap;
global hshowWay;
global hshowRoute;
global points;
global openstreetmap_filename;
global map_img_filename;
global parsed_poi;

valueA = '';
valueB = '';
valueC = '';
valueD = '';
valueE = '';
valueF = '';
radius = '';
transport = 2;

hdotA = 0;
hdotB = 0;
points = 0;

%draw a map
h = gca;
route = 0;
openstreetmap_filename = 'LeCreusotWaysFF.osm';%'genoa.osm';
parsed_osm_filename = 'data/LeCreusotWaysFF.mat'; %'osm file with data';
map_img_filename = 'map40000.png'; % image file saved from online, if available
poi_filename = 'data/LeCreusot_POI.xml'; %'osm file with data';
parsed_poi_filename = 'data/LeCreusot_POI.mat'; %'osm file with data';

[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename, parsed_osm_filename ,2);
[parsed_poi] = parse_poi_xml(poi_filename,parsed_poi_filename,2);
cat = ['choose category', parsed_poi.category.name];
%hshowMap = show_map(h, bounds, map_img_filename);
%plot_way(h, parsed_osm, map_img_filename);
%set(handles.showMapBtn, 'Value', 1);
show_Map_Result(h, 1, 0, 0, 0, 0, parsed_osm, openstreetmap_filename, map_img_filename);
set(handles.showMapBtn, 'Value', 1);
set(handles.footBtn, 'Value', 1);

% UIWAIT makes Map_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Map_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function timeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function timeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function userEnterA_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterA as text
%        str2double(get(hObject,'String')) returns contents of userEnterA as a double
global valueA;
valueA = get(hObject,'String');



% --- Executes during object creation, after setting all properties.
function userEnterA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function userEnterB_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterB as text
%        str2double(get(hObject,'String')) returns contents of userEnterB as a double
global valueB;
valueB = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function userEnterB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in busBtn.
function busBtn_Callback(hObject, eventdata, handles)
% hObject    handle to busBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of busBtn
global transport;
if get(handles.busBtn, 'Value')
    set(handles.footBtn, 'Value', 0);
    set(handles.carBtn, 'Value', 0);
    set(handles.bikeBtn, 'Value', 0);
    transport = 4;
end


% --- Executes on button press in bikeBtn.
function bikeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bikeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bikeBtn
global transport;
if get(handles.bikeBtn, 'Value')
    set(handles.footBtn, 'Value', 0);
    set(handles.carBtn, 'Value', 0);
    set(handles.busBtn, 'Value', 0);
    transport = 3;
end




% --- Executes on button press in carBtn.
function carBtn_Callback(hObject, eventdata, handles)
% hObject    handle to carBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of carBtn
global transport;
if get(handles.carBtn, 'Value')
    set(handles.footBtn, 'Value', 0);
    set(handles.bikeBtn, 'Value', 0);
    set(handles.busBtn, 'Value', 0);
    transport = 1;
end


% --- Executes on button press in footBtn.
function footBtn_Callback(hObject, eventdata, handles)
% hObject    handle to footBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of footBtn
global transport;
if get(handles.footBtn, 'Value')
    set(handles.carBtn, 'Value', 0);
    set(handles.bikeBtn, 'Value', 0);
    set(handles.busBtn, 'Value', 0);
    transport = 2;
end



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in distanceBtn.
function distanceBtn_Callback(hObject, eventdata, handles)
% hObject    handle to distanceBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of distanceBtn
if (get(hObject,'Value') == get(hObject,'Max'))
   % Checkbox is checked-take appropriate action
   set(handles.maxDistance, 'Visible', 'on');
else
   % Checkbox is not checked-take appropriate action
   set(handles.maxDistance, 'Visible', 'off');
end



function maxDistance_Callback(hObject, eventdata, handles)
% hObject    handle to maxDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxDistance as text
%        str2double(get(hObject,'String')) returns contents of maxDistance as a double


% --- Executes during object creation, after setting all properties.
function maxDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in searchBtn.
function searchBtn_Callback(hObject, eventdata, handles)
% hObject    handle to searchBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global valueA;
global categoryA;
global poiA;

global valueB;
global categoryB;
global poiB;

global valueC;
global valueD;
global valueE;
global valueF;
global h;
global radius;
global transport
global xA;
global yA;
global xB;
global yB;
global parsed_osm; 
global route;
global points;
global openstreetmap_filename;
global map_img_filename;
global parsed_poi;

route = 0;
%enC = get(handles.panelC, 'Visible');
%enD = get(handles.panelD, 'Visible');
%enE = get(handles.panelE, 'Visible');
%enF = get(handles.panelF, 'Visible');
set(handles.tInstr, 'String', '');

enRadSrch = get(handles.radiusBtn, 'Value');

enEnterA = get(handles.enterBtnA, 'Value');
enListA = get(handles.listBtnA, 'Value');
enMapA = get(handles.mapBtnA, 'Value');
enEnterB = get(handles.enterBtnB, 'Value');
enListB = get(handles.listBtnB, 'Value');
enMapB = get(handles.mapBtnB, 'Value');
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
set(handles.showWayBtn, 'Value', 1);
btnWay = get(handles.showWayBtn, 'Value');
if enRadSrch == 0
    %any search
    if enEnterA == 1
        if strcmp(valueA, '') == 0
            [xA, yA] = enter2coordinates(valueA);
        else
            warn(2);            
            xA = 0;
            yA = 0;
        end
    else if enListA == 1
            if categoryA ~= 1
                if poiA ~= 1
                    resultA = get_poi_by_id_from_category_id(parsed_poi,categoryA-1, poiA-1);
                    xA = resultA.xy(1);
                    yA = resultA.xy(2);
                else
                    warn(5);
                    xA = 0;
                    yA = 0;
                end
            else
                warn(4); 
                xA = 0;
                yA = 0;
            end
        end
    end
    
    if enEnterB == 1
        if strcmp(valueB, '') == 0
            [xB, yB] = enter2coordinates(valueB);
        else
            warn(3);            
            xB = 0;
            yB = 0;
        end
    else if enListB == 1
            if categoryB ~= 1
                if poiB ~= 1
                    resultB = get_poi_by_id_from_category_id(parsed_poi,categoryB-1, poiB-1);
                    xB = resultB.xy(1);
                    yB = resultB.xy(2);
                else
                    warn(5);
                    xB = 0;
                    yB = 0;
                end
            else
                warn(4);
                xB = 0;
                yB = 0;
            end
        end
    end 
    
    if xA ~= 0 & yA ~=0
        if xB ~= 0 & yB ~=0
            if transport ~=0
                route = findShortestWayByPosition(parsed_osm, xA, yA, xB, yB, transport);
                points = [xB xA; yB yA];
                if size(route,2) < 2
                	warn(6); 
                else
                    btA = get(handles.drawBtnA, 'Value');
                    btB = get(handles.drawBtnB, 'Value');
                    if btA == 1 & btB == 1
                        set(handles.drawBtnA, 'Value',0);
                        drawBtnA_Callback(hObject, eventdata, handles);
                        set(handles.drawBtnB, 'Value',0);
                        drawBtnB_Callback(hObject, eventdata, handles);
                        show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
                        set(handles.drawBtnA, 'Value',1);
                        drawBtnA_Callback(hObject, eventdata, handles);
                        set(handles.drawBtnB, 'Value',1);
                        drawBtnB_Callback(hObject, eventdata, handles);
                    end
                    if btA == 1 & btB == 0
                        set(handles.drawBtnA, 'Value',0);
                        drawBtnA_Callback(hObject, eventdata, handles);
                        show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
                        set(handles.drawBtnA, 'Value',1);
                        drawBtnA_Callback(hObject, eventdata, handles);
                    end
                    if btA == 0 & btB == 1
                        set(handles.drawBtnB, 'Value',0);
                        drawBtnB_Callback(hObject, eventdata, handles);
                        show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
                        set(handles.drawBtnB, 'Value',1);
                        drawBtnB_Callback(hObject, eventdata, handles);
                    end
                    if btA == 0 & btB == 0
                        show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
                    end 
                end
                
                %stringOut = searchAB(xA, yA, xB, yB, transport);
                %set(handles.tInstr, 'String', stringOut, 'HorizontalAlignment', 'left');
            else
                warn(1);
            end
        else
            warn(3);
        end
    else
        warn(2);
    end
else
    %only radius search
end


% --- Executes on button press in addPoint.
function addPoint_Callback(hObject, eventdata, handles)
% hObject    handle to addPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
counter_add = get(hObject, 'UserData') + 1;
set(hObject, 'UserData', counter_add);
switch counter_add
    case 1
        set(handles.panelC, 'Visible', 'on');      
        set(handles.swapBtn, 'Visible', 'off');
        set(handles.inOrder, 'Visible', 'on');
    case 2
        set(handles.panelD, 'Visible', 'on');
    case 3
        set(handles.panelE, 'Visible', 'on');
    case 4
        set(handles.panelF, 'Visible', 'on');
end



% --- Executes on button press in radiusBtn.
function radiusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to radiusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiusBtn
if (get(hObject,'Value') == get(hObject,'Max'))
   % Checkbox is checked-take appropriate action
   if strcmp(get(handles.panelB, 'Visible'), 'on') == 1
       set(handles.panelB, 'Visible', 'off');
   end
   if strcmp(get(handles.panelC, 'Visible'), 'on') == 1
       set(handles.panelC, 'Visible', 'off');
   end
   if strcmp(get(handles.panelD, 'Visible'), 'on') == 1
       set(handles.panelD, 'Visible', 'off');
   end
   if strcmp(get(handles.panelE, 'Visible'), 'on') == 1
       set(handles.panelE, 'Visible', 'off');
   end
   if strcmp(get(handles.panelF, 'Visible'), 'on') == 1
       set(handles.panelF, 'Visible', 'off');
   end
   
   set(handles.radiusSearch, 'Visible', 'on');
   set(handles.addPoint, 'UserData', 0);
   set(handles.addPoint, 'Visible', 'off');   
   set(handles.inOrder, 'Visible', 'off');
   set(handles.swapBtn, 'Visible', 'off');
else
    if strcmp(get(handles.panelB, 'Visible'), 'off') == 1
       set(handles.panelB, 'Visible', 'on');
    end
   set(handles.addPoint, 'Visible', 'on'); 
   set(handles.swapBtn, 'Visible', 'on');
   % Checkbox is not checked-take appropriate action
   set(handles.radiusSearch, 'Visible', 'off');
end



function radiusSearch_Callback(hObject, eventdata, handles)
% hObject    handle to radiusSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radiusSearch as text
%        str2double(get(hObject,'String')) returns contents of radiusSearch as a double
global radius;
radius = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function radiusSearch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiusSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showWayBtn.
function showWayBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showWayBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showWayBtn
global h;
global parsed_osm;
global route;
global points;
global openstreetmap_filename;
global map_img_filename;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btA = get(handles.drawBtnA, 'Value');
btB = get(handles.drawBtnB, 'Value');
if btA == 1 & btB == 1
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 1 & btB == 0
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 1
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
end 


% --- Executes on button press in showMapBtn.
function showMapBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showMapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showMapBtn
global h;
global parsed_osm;
global route; 
global points;
global openstreetmap_filename;
global map_img_filename
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btA = get(handles.drawBtnA, 'Value');
btB = get(handles.drawBtnB, 'Value');
if btA == 1 & btB == 1
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 1 & btB == 0
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 1
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
end 


% --- Executes on button press in showRoadsBtn.
function showRoadsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showRoadsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showRoadsBtn
global h;
global parsed_osm;
global route;
global points;
global openstreetmap_filename;
global map_img_filename;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btA = get(handles.drawBtnA, 'Value');
btB = get(handles.drawBtnB, 'Value');
if btA == 1 & btB == 1
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 1 & btB == 0
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 1
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end
if btA == 0 & btB == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, route,  points, parsed_osm, openstreetmap_filename, map_img_filename);
end 


% --- Executes on button press in layer4.
function layer4_Callback(hObject, eventdata, handles)
% hObject    handle to layer4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of layer4


% --- Executes on button press in enterBtnA.
function enterBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnA
global hdotA;
global categoryA;
global poiA;
global xA;
global yA;
if get(handles.enterBtnA, 'Value')
    set(handles.listBtnA, 'Value', 0);
    set(handles.mapBtnA, 'Value', 0);
    
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'on');
    set(handles.userEnterA, 'String', '');
    categoryA = 1;
    poiA = 1;
    xA = 0;
    yA = 0;
    
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    set(handles.showBtnA, 'Visible', 'off');
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off')
    if (get(handles.drawBtnA, 'Value') == 1)
        if hdotA == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            set(handles.drawBtnA, 'Value', 0);
        end
    end
else
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
end



% --- Executes on button press in listBtnA.
function listBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnA
global hdotA;
global cat;
global xA;
global yA;
if get(handles.listBtnA, 'Value')
    set(handles.enterBtnA, 'Value', 0);
    set(handles.mapBtnA, 'Value', 0);
    
    set(handles.categoryMenuA, 'Visible', 'on');
    set(handles.categoryMenuA,'Value', 1);
    set(handles.categoryMenuA,'String',cat);
    set(handles.poiMenuA, 'Visible', 'on');
    set(handles.poiMenuA,'Value', 1);
    set(handles.poiMenuA,'String','choose category first');
    xA = 0;
    yA = 0;
    
    set(handles.userEnterA, 'Visible', 'off');
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    set(handles.showBtnA, 'Visible', 'off');
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    if (get(handles.drawBtnA, 'Value') == 1)
        if hdotA == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            set(handles.drawBtnA, 'Value', 0);
        end
    end
else
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off')
    
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
end

% --- Executes on button press in prefBtnA.
function mapBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnA
global hdotA;
global categoryA;
global poiA;
if get(handles.mapBtnA, 'Value')
    set(handles.enterBtnA,  'Value', 0);
    set(handles.listBtnA,  'Value', 0);
    
    set(handles.coordXA, 'Visible', 'on');
    set(handles.coordYA, 'Visible', 'on');
    set(handles.showBtnA, 'Visible', 'on');
    set(handles.drawBtnA, 'Visible', 'on');
    set(handles.tXA, 'Visible', 'on');
    set(handles.tYA, 'Visible', 'on');
    set(handles.coordXA, 'Enable', 'on');
    set(handles.coordYA, 'Enable', 'on');
    set(handles.coordXA, 'String', '');
    set(handles.coordYA, 'String', '');
    categoryA = 1;
    poiA = 1;
    
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off')
    set(handles.userEnterA, 'Visible', 'off');
    
else
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    set(handles.showBtnA, 'Visible', 'off');
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    if (get(handles.drawBtnA, 'Value') == 1)
        if hdotA == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            set(handles.drawBtnA, 'Value', 0);
        end
    end
    
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
end


% --- Executes on button press in enterBtnB.
function enterBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnB
global hdotB;
global categoryB;
global poiB;
global xB;
global yB;
if get(handles.enterBtnB, 'Value')
    set(handles.listBtnB, 'Value', 0);
    set(handles.mapBtnB, 'Value', 0);
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'on');
    set(handles.userEnterB, 'String', '');
    
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    set(handles.showBtnB, 'Visible', 'off');
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off')
    categoryB = 1;
    poiB = 1;
    xB = 0;
    yB = 0;
    if (get(handles.drawBtnB, 'Value') == 1)
        if hdotB == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            set(handles.drawBtnB, 'Value', 0);
        end
    end
else
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
end


% --- Executes on button press in listBtnB.
function listBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnB
global hdotB;
global cat;
global xB;
global yB;
if get(handles.listBtnB, 'Value')
    set(handles.enterBtnB, 'Value', 0);
    set(handles.mapBtnB, 'Value', 0);
    
    set(handles.categoryMenuB, 'Visible', 'on');
    set(handles.categoryMenuB,'Value', 1);
    set(handles.categoryMenuB,'String',cat);
    set(handles.poiMenuB, 'Visible', 'on');
    set(handles.poiMenuB,'Value', 1);
    set(handles.poiMenuB,'String','choose category first');
    
    set(handles.userEnterB, 'Visible', 'off');
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    set(handles.showBtnB, 'Visible', 'off');
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    xB = 0;
    yB = 0;
    if (get(handles.drawBtnB, 'Value') == 1)
        if hdotB == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            set(handles.drawBtnB, 'Value', 0);
        end
    end
else
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off')
    
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
end


% --- Executes on button press in prefBtnB.
function mapBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnB
global hdotB;
global categoryB;
global poiB;
if get(handles.mapBtnB, 'Value')
    set(handles.enterBtnB,  'Value', 0);
    set(handles.listBtnB,  'Value', 0);
    
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off')
    set(handles.userEnterB, 'Visible', 'off');
    
    set(handles.coordXB, 'Visible', 'on');
    set(handles.coordYB, 'Visible', 'on');
    set(handles.showBtnB, 'Visible', 'on');
    set(handles.drawBtnB, 'Visible', 'on');
    set(handles.tXB, 'Visible', 'on');
    set(handles.tYB, 'Visible', 'on');
    set(handles.coordXB, 'Enable', 'on');
    set(handles.coordYB, 'Enable', 'on');
    set(handles.coordXB, 'String', '');
    set(handles.coordYB, 'String', '');
    categoryB = 1;
    poiB = 1;
    
else
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    set(handles.showBtnB, 'Visible', 'off');
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    if (get(handles.drawBtnB, 'Value') == 1)
        if hdotB == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            set(handles.drawBtnB, 'Value', 0);
        end
    end
    
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
end


% --- Executes on button press in swapBtn.
function swapBtn_Callback(hObject, eventdata, handles)
% hObject    handle to swapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global valueA;
global valueB;
global h;
global xA;
global yA;
global xB;
global yB;
global hdotA;
global hdotB;
if (get(handles.enterBtnA, 'Value') == 1 & get(handles.enterBtnB, 'Value') == 1)
    valueA = get(handles.userEnterA, 'String');
    valueB = get(handles.userEnterB, 'String');
    set(handles.userEnterA, 'String', valueB);
    set(handles.userEnterB, 'String', valueA);
    valueA = get(handles.userEnterA, 'String');
    valueB = get(handles.userEnterB, 'String');
end
if (get(handles.mapBtnA, 'Value') == 1 & get(handles.mapBtnB, 'Value') == 1)
    xAstr = get(handles.coordXA, 'String');
    xBstr = get(handles.coordXB, 'String');
    yAstr = get(handles.coordYA, 'String');
    yBstr = get(handles.coordYB, 'String');
    if strcmp(xAstr,'') == 0 & strcmp(yAstr,'') == 0 & strcmp(xBstr,'') == 0 & strcmp(yBstr,'') == 0 
        set(handles.coordXA, 'String', xBstr);
        set(handles.coordXB, 'String', xAstr);
        set(handles.coordYA, 'String', yBstr);
        set(handles.coordYB, 'String', yAstr);
        xAstr = get(handles.coordXA, 'String');
        xBstr = get(handles.coordXB, 'String');
        yAstr = get(handles.coordYA, 'String');
        yBstr = get(handles.coordYB, 'String');

        xA = str2num(xAstr);
        xB = str2num(xBstr);
        yA = str2num(yAstr);
        yB = str2num(yBstr);

        if get(handles.drawBtnA, 'Value') == 0 & get(handles.drawBtnB, 'Value') == 0
            htemp = hdotA;
            hdotA = hdotB;
            hdotB = htemp;
        end
        if get(handles.drawBtnA, 'Value') == 1 & get(handles.drawBtnB, 'Value') == 1
            delete(hdotA);
            delete(hdotB);
            hold (h, 'on')
            hdotA = plot(h, xB,yB, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            hold (h, 'off')
            hold (h, 'on')
            hdotB = plot(h, xA,yA, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
            hold (h, 'off')
        end;
        if get(handles.drawBtnB, 'Value') == 1 & get(handles.drawBtnA, 'Value') == 0
            hdotA = hdotB;
            delete(hdotB);
            hold (h, 'on')
            hdotB = plot(h, xA,yA, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
            hold (h, 'off')
        end;
        if get(handles.drawBtnB, 'Value') == 0 & get(handles.drawBtnA, 'Value') == 1
            hdotB = hdotA;
            delete(hdotA);
            hold (h, 'on')
            hdotA = plot(h, xB,yB, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            hold (h, 'off')
        end
    end
end

% --- Executes on key press with focus on timeSlider and none of its controls.
function timeSlider_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in enterBtnC.
function enterBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnC



% --- Executes on button press in listBtnC.
function listBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnC



% --- Executes on button press in prefBtnC.
function mapBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnC




function userEnterC_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterC as text
%        str2double(get(hObject,'String')) returns contents of userEnterC as a double


% --- Executes during object creation, after setting all properties.
function userEnterC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enterBtnE.
function enterBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnE




function userEnterE_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterE as text
%        str2double(get(hObject,'String')) returns contents of userEnterE as a double


% --- Executes during object creation, after setting all properties.
function userEnterE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in listBtnE.
function listBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnE



% --- Executes on button press in prefBtnE.
function mapBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnE




function userEnterD_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterD as text
%        str2double(get(hObject,'String')) returns contents of userEnterD as a double


% --- Executes during object creation, after setting all properties.
function userEnterD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function userEnterF_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterF as text
%        str2double(get(hObject,'String')) returns contents of userEnterF as a double


% --- Executes during object creation, after setting all properties.
function userEnterF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enterBtnD.
function enterBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnD


% --- Executes on button press in enterBtnF.
function enterBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnF



% --- Executes on button press in listBtnF.
function listBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnF



% --- Executes on button press in prefBtnF.
function mapBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnF




% --- Executes on key press with focus on distanceBtn and none of its controls.
function distanceBtn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to distanceBtn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in inOrder.
function inOrder_Callback(hObject, eventdata, handles)
% hObject    handle to inOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of inOrder


% --- Executes on selection change in categoryMenuA.
function categoryMenuA_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuA
global categoryA;
global parsed_poi;
%contents = cellstr(get(hObject,'String'));
%categoryA = contents{get(hObject,'Value')};
categoryA = get(hObject,'Value');
switch categoryA
    case 1
        set(handles.poiMenuA,'String', 'choose the category first');
    otherwise
        poi = ['choose poi'; get_names_poi_by_category_id( parsed_poi,categoryA-1)];
        set(handles.poiMenuA,'Value', 1);
        set(handles.poiMenuA,'String', poi);
end



% --- Executes during object creation, after setting all properties.
function categoryMenuA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuB.
function categoryMenuB_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuB
global categoryB;
global parsed_poi;
%contents = cellstr(get(hObject,'String'));
%categoryA = contents{get(hObject,'Value')};
categoryB = get(hObject,'Value');
switch categoryB
    case 1
        set(handles.poiMenuB,'String', 'choose the category first');
    otherwise
        poi = ['choose poi'; get_names_poi_by_category_id( parsed_poi,categoryB-1)];
        set(handles.poiMenuB,'Value', 1);
        set(handles.poiMenuB,'String', poi);
end


% --- Executes during object creation, after setting all properties.
function categoryMenuB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuD.
function popupMenuD_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuD


% --- Executes during object creation, after setting all properties.
function popupMenuD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuC.
function popupMenuC_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuC


% --- Executes during object creation, after setting all properties.
function popupMenuC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuE.
function popupMenuE_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuE


% --- Executes during object creation, after setting all properties.
function popupMenuE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuF.
function popupMenuF_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuF


% --- Executes during object creation, after setting all properties.
function popupMenuF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hidePanel.
function hidePanel_Callback(hObject, eventdata, handles)
% hObject    handle to hidePanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.hidePanel, 'Value')
    set(handles.uipanelMain, 'Visible', 'off');
    set(handles.uipanelInstr, 'Position', [0.177 -0.001 0.652 0.057]);
    set(handles.hidePanel, 'String', 'Show all')
else
    set(handles.uipanelMain, 'Visible', 'on');
    set(handles.uipanelInstr, 'Position', [0.177 0.217 0.652 0.057]); 
    set(handles.hidePanel, 'String', 'Hide all')
end


% --- Executes on selection change in poiMenuA.
function poiMenuA_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuA
global poiA;
poiA = get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function poiMenuA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function coordXA_Callback(hObject, eventdata, handles)
% hObject    handle to coordXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXA as text
%        str2double(get(hObject,'String')) returns contents of coordXA as a double


% --- Executes during object creation, after setting all properties.
function coordXA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYA_Callback(hObject, eventdata, handles)
% hObject    handle to coordYA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYA as text
%        str2double(get(hObject,'String')) returns contents of coordYA as a double


% --- Executes during object creation, after setting all properties.
function coordYA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showBtnA.
function showBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xA;
global yA;
global hdotA;
if (get(handles.drawBtnA, 'Value') == 1 & hdotA == 0)
    set(handles.drawBtnA, 'Value', 0);
end
xA = 0;
yA = 0;
[xA,yA] = ginput(1)
x = num2str(xA);
y = num2str(yA);
set(handles.coordXA, 'String', x);
set(handles.coordYA, 'String', y);
if get(handles.drawBtnA, 'Value') == 1
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
else
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
end

% --- Executes on button press in drawBtnA.
function drawBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnA
global xA;
global yA;
global h;
global hdotA;
if (strcmp(get(handles.coordXA, 'String'),'') == 0 & strcmp(get(handles.coordYA, 'String'),'') == 0)
    if (get(handles.drawBtnA, 'Value') == 1)
        hold (h, 'on')
        hdotA = plot(h, xA,yA, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
        hold (h, 'off')
    end;
    if (get(handles.drawBtnA, 'Value') == 0)
        delete(hdotA);
    end
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterB as text
%        str2double(get(hObject,'String')) returns contents of userEnterB as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterC as text
%        str2double(get(hObject,'String')) returns contents of userEnterC as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterD as text
%        str2double(get(hObject,'String')) returns contents of userEnterD as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterE as text
%        str2double(get(hObject,'String')) returns contents of userEnterE as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterF as text
%        str2double(get(hObject,'String')) returns contents of userEnterF as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYF_Callback(hObject, eventdata, handles)
% hObject    handle to coordYF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYF as text
%        str2double(get(hObject,'String')) returns contents of coordYF as a double


% --- Executes during object creation, after setting all properties.
function coordYF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXF_Callback(hObject, eventdata, handles)
% hObject    handle to coordXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXF as text
%        str2double(get(hObject,'String')) returns contents of coordXF as a double


% --- Executes during object creation, after setting all properties.
function coordXF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnF.
function drawBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnF


% --- Executes on button press in showBtnF.
function showBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in listBtnF.
function togglebutton57_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnF


% --- Executes on selection change in poiMenuF.
function poiMenuF_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuF


% --- Executes during object creation, after setting all properties.
function poiMenuF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuF.
function categoryMenuF_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuF


% --- Executes during object creation, after setting all properties.
function categoryMenuF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYE_Callback(hObject, eventdata, handles)
% hObject    handle to coordYE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYE as text
%        str2double(get(hObject,'String')) returns contents of coordYE as a double


% --- Executes during object creation, after setting all properties.
function coordYE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXE_Callback(hObject, eventdata, handles)
% hObject    handle to coordXE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXE as text
%        str2double(get(hObject,'String')) returns contents of coordXE as a double


% --- Executes during object creation, after setting all properties.
function coordXE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnE.
function drawBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnE


% --- Executes on button press in showBtnE.
function showBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in listBtnE.
function togglebutton53_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnE


% --- Executes on selection change in poiMenuE.
function poiMenuE_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuE


% --- Executes during object creation, after setting all properties.
function poiMenuE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuE.
function categoryMenuE_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuE


% --- Executes during object creation, after setting all properties.
function categoryMenuE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYD_Callback(hObject, eventdata, handles)
% hObject    handle to coordYD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYD as text
%        str2double(get(hObject,'String')) returns contents of coordYD as a double


% --- Executes during object creation, after setting all properties.
function coordYD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXD_Callback(hObject, eventdata, handles)
% hObject    handle to coordXD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXD as text
%        str2double(get(hObject,'String')) returns contents of coordXD as a double


% --- Executes during object creation, after setting all properties.
function coordXD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnD.
function drawBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnD


% --- Executes on button press in showBtnD.
function showBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mapBtnD.
function mapBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to mapBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mapBtnD


% --- Executes on button press in listBtnD.
function togglebutton49_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnD


% --- Executes on selection change in poiMenuD.
function poiMenuD_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuD


% --- Executes during object creation, after setting all properties.
function poiMenuD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuD.
function categoryMenuD_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuD


% --- Executes during object creation, after setting all properties.
function categoryMenuD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYC_Callback(hObject, eventdata, handles)
% hObject    handle to coordYC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYC as text
%        str2double(get(hObject,'String')) returns contents of coordYC as a double


% --- Executes during object creation, after setting all properties.
function coordYC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXC_Callback(hObject, eventdata, handles)
% hObject    handle to coordXC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXC as text
%        str2double(get(hObject,'String')) returns contents of coordXC as a double


% --- Executes during object creation, after setting all properties.
function coordXC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnC.
function drawBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnC


% --- Executes on button press in showBtnC.
function showBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in listBtnC.
function togglebutton45_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnC


% --- Executes on selection change in poiMenuC.
function poiMenuC_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuC


% --- Executes during object creation, after setting all properties.
function poiMenuC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuC.
function categoryMenuC_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuC


% --- Executes during object creation, after setting all properties.
function categoryMenuC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYB_Callback(hObject, eventdata, handles)
% hObject    handle to coordYB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYB as text
%        str2double(get(hObject,'String')) returns contents of coordYB as a double


% --- Executes during object creation, after setting all properties.
function coordYB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXB_Callback(hObject, eventdata, handles)
% hObject    handle to coordXB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXB as text
%        str2double(get(hObject,'String')) returns contents of coordXB as a double


% --- Executes during object creation, after setting all properties.
function coordXB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnB.
function drawBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnB
global xB;
global yB;
global h;
global hdotB;
if (strcmp(get(handles.coordXB, 'String'),'') == 0 & strcmp(get(handles.coordYB, 'String'),'') == 0)
    if (get(handles.drawBtnB, 'Value') == 1)
        hold (h, 'on')
        hdotB = plot(h, xB,yB,'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
        hold (h, 'off')
    end;
    if (get(handles.drawBtnB, 'Value') == 0)
        delete(hdotB);
    end
end



% --- Executes on button press in showBtnB.
function showBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xB;
global yB;
global hdotB;
if (get(handles.drawBtnB, 'Value') == 1 & hdotB == 0)
    set(handles.drawBtnB, 'Value', 0);
end
xB = 0;
yB = 0;
[xB,yB] = ginput(1)
x = num2str(xB);
y = num2str(yB);
set(handles.coordXB, 'String', x);
set(handles.coordYB, 'String', y);
if get(handles.drawBtnB, 'Value') == 1
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
else
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
end


% --- Executes on button press in listBtnB.
function togglebutton41_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnB


% --- Executes on selection change in poiMenuB.
function poiMenuB_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuB
global poiB;
poiB = get(hObject,'Value');


% --- Executes during object creation, after setting all properties.
function poiMenuB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function showWayBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showWayBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
