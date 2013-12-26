function varargout = Map_v1(varargin)
% MAP_V1 MATLAB code for Map_v1.fig
%      MAP_V1, by itself, creates a new MAP_V1 or raises the existing
%      singleton*.
%
%      H = MAP_V1 returns the handle to a new MAP_V1 or the handle to
%      the existing singleton*.
%
%      MAP_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAP_V1.M with the given input arguments.
%
%      MAP_V1('Property','Value',...) creates a new MAP_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Map_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Map_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Map_v1

% Last Modified by GUIDE v2.5 22-Dec-2013 17:39:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Map_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @Map_v1_OutputFcn, ...
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


% --- Executes just before Map_v1 is made visible.
function Map_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Map_v1 (see VARARGIN)

% Choose default command line output for Map_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.addPoint, 'UserData', 0);

global valueA;
global valueB;
global valueC;
global valueD;
global valueE;
global valueF;
global radius;
global h;

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


valueA = '';
valueB = '';
valueC = '';
valueD = '';
valueE = '';
valueF = '';
radius = '';
n = 4;
text{1} = 'name1';
text{2} = 'name2';
text{3} = 'name3';
text{4} = 'name4';
text{5} = 'name5';
set(handles.popupMenuA,'String',text);
set(handles.popupMenuB,'String',text);
set(handles.popupMenuC,'String',text);
set(handles.popupMenuD,'String',text);
set(handles.popupMenuE,'String',text);
set(handles.popupMenuF,'String',text);

%draw a map
h = gca;
openstreetmap_filename = 'map.osm';%'genoa.osm';
map_img_filename = 'map.png'; % image file saved from online, if available
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);
%plot_way(h, parsed_osm);
plot_way(h, parsed_osm, map_img_filename)



% UIWAIT makes Map_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Map_v1_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in byBus.
function byBus_Callback(hObject, eventdata, handles)
% hObject    handle to byBus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of byBus
if get(handles.byBus, 'Value')
    set(handles.byFoot, 'Enable', 'off');
    set(handles.byCar, 'Enable', 'off');
    set(handles.byBike, 'Enable', 'off');
else
    set(handles.byFoot, 'Enable', 'on');
    set(handles.byCar, 'Enable', 'on');
    set(handles.byBike, 'Enable', 'on');
end


% --- Executes on button press in byBike.
function byBike_Callback(hObject, eventdata, handles)
% hObject    handle to byBike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of byBike
if get(handles.byBike, 'Value')
    set(handles.byFoot, 'Enable', 'off');
    set(handles.byCar, 'Enable', 'off');
    set(handles.byBus, 'Enable', 'off');
else
    set(handles.byFoot, 'Enable', 'on');
    set(handles.byCar, 'Enable', 'on');
    set(handles.byBus, 'Enable', 'on');
end




% --- Executes on button press in byCar.
function byCar_Callback(hObject, eventdata, handles)
% hObject    handle to byCar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of byCar
if get(handles.byCar, 'Value')
    set(handles.byFoot, 'Enable', 'off');
    set(handles.byBike, 'Enable', 'off');
    set(handles.byBus, 'Enable', 'off');
else
    set(handles.byFoot, 'Enable', 'on');
    set(handles.byBike, 'Enable', 'on');
    set(handles.byBus, 'Enable', 'on');
end


% --- Executes on button press in byFoot.
function byFoot_Callback(hObject, eventdata, handles)
% hObject    handle to byFoot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of byFoot
if get(handles.byFoot, 'Value')
    set(handles.byCar, 'Enable', 'off');
    set(handles.byBike, 'Enable', 'off');
    set(handles.byBus, 'Enable', 'off');
else
    set(handles.byCar, 'Enable', 'on');
    set(handles.byBike, 'Enable', 'on');
    set(handles.byBus, 'Enable', 'on');
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


% --- Executes on button press in BTNmaxDistance.
function BTNmaxDistance_Callback(hObject, eventdata, handles)
% hObject    handle to BTNmaxDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BTNmaxDistance
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
global valueB;
global valueC;
global valueD;
global valueE;
global valueF;
global h;
global radius;
enC = get(handles.panelC, 'Visible');
enD = get(handles.panelD, 'Visible');
enE = get(handles.panelE, 'Visible');
enF = get(handles.panelF, 'Visible');
enMaxDist = get(handles.BTNmaxDistance, 'Value');
enRadSrch = get(handles.BTNradSearch, 'Value');
enAEnter = get(handles.enterBtnA, 'Value');
enAList = get(handles.listBtnA, 'Value');
enBEnter = get(handles.enterBtnB, 'Value');
enBList = get(handles.listBtnB, 'Value');
if enRadSrch == 0
    %any search
    if strcmp(enC,'off')==1 & strcmp(enD,'off')==1 & strcmp(enC,'off')==1 & strcmp(enC,'off')==1
        %without middle points
        if enMaxDist == 0
            %without max distance 
            if (enAEnter==1 | enAList==1)& (enBEnter==1 | enBList==1)
                searchAB(valueA, valueB, h);
            end
        else
            %with max distance
        end
    else
        %with middle ponts
    end
else
    %only radius search
    if (enAEnter==1 | enAList==1) & (strcmp(radius, '') == 0)
        rad = str2num(radius);
        radiusSearch(valueA, rad);
    end
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
        %set(handles.tC, 'Visible', 'on');
        %set(handles.userEnterC, 'Visible', 'on');
        %set(handles.enterBtnC, 'Visible', 'on');
        %set(handles.listBtnC, 'Visible', 'on');
        %set(handles.prefBtnC, 'Visible', 'on');
        
        set(handles.swapBtn, 'Visible', 'off');
        set(handles.inOrder, 'Visible', 'on');
        
    case 2
        set(handles.panelD, 'Visible', 'on');
        %set(handles.tD, 'Visible', 'on');
        %set(handles.userEnterD, 'Visible', 'on');
        %set(handles.enterBtnD, 'Visible', 'on');
        %set(handles.listBtnD, 'Visible', 'on');
        %set(handles.prefBtnD, 'Visible', 'on');
    case 3
        set(handles.panelE, 'Visible', 'on');
        %set(handles.tE, 'Visible', 'on');
        %set(handles.userEnterE, 'Visible', 'on');
        %set(handles.enterBtnE, 'Visible', 'on');
        %set(handles.listBtnE, 'Visible', 'on');
        %set(handles.prefBtnE, 'Visible', 'on');
    case 4
        set(handles.panelF, 'Visible', 'on');
        %set(handles.tF, 'Visible', 'on');
        %set(handles.userEnterF, 'Visible', 'on');
        %set(handles.enterBtnF, 'Visible', 'on');
        %set(handles.listBtnF, 'Visible', 'on');
        %set(handles.prefBtnF, 'Visible', 'on');
end



% --- Executes on button press in BTNradSearch.
function BTNradSearch_Callback(hObject, eventdata, handles)
% hObject    handle to BTNradSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BTNradSearch
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


% --- Executes on button press in zoomIn.
function zoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to zoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zoomOut.
function zoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to zoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in printMap.
function printMap_Callback(hObject, eventdata, handles)
% hObject    handle to printMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in layer1.
function layer1_Callback(hObject, eventdata, handles)
% hObject    handle to layer1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of layer1


% --- Executes on button press in layer2.
function layer2_Callback(hObject, eventdata, handles)
% hObject    handle to layer2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of layer2


% --- Executes on button press in layer3.
function layer3_Callback(hObject, eventdata, handles)
% hObject    handle to layer3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of layer3


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
if get(handles.enterBtnA, 'Value')
    set(handles.listBtnA, 'Enable', 'off');
    set(handles.prefBtnA, 'Enable', 'off');
    
    set(handles.userEnterA, 'Enable', 'on');
else
    set(handles.listBtnA, 'Enable', 'on');
    set(handles.prefBtnA, 'Enable', 'on');
    
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
end



% --- Executes on button press in listBtnA.
function listBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnA
if get(handles.listBtnA, 'Value')
    set(handles.enterBtnA, 'Enable', 'off');
    set(handles.prefBtnA, 'Enable', 'off');
    
    set(handles.popupMenuA, 'Visible', 'on');
    set(handles.userEnterA, 'Visible', 'off');
else
    set(handles.enterBtnA, 'Enable', 'on');
    set(handles.prefBtnA, 'Enable', 'on');
    
    set(handles.popupMenuA, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'on');
end

% --- Executes on button press in prefBtnA.
function prefBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnA
if get(handles.prefBtnA, 'Value')
    global xA;
    global yA;
    set(handles.enterBtnA, 'Enable', 'off');
    set(handles.listBtnA, 'Enable', 'off');
    
    set(handles.popupMenuA, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'on');
    [xA,yA] = ginput(1)
    x = num2str(xA);
    y = num2str(yA);
    coordinates = ['x=' x ' y=' y]
    set(handles.userEnterA, 'String', coordinates);
else
    set(handles.enterBtnA, 'Enable', 'on');
    set(handles.listBtnA, 'Enable', 'on');
    
    set(handles.popupMenuA, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'on');
end


% --- Executes on button press in enterBtnB.
function enterBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnB
if get(handles.enterBtnB, 'Value')
    set(handles.listBtnB, 'Enable', 'off');
    set(handles.prefBtnB, 'Enable', 'off');
    
    set(handles.userEnterB, 'Enable', 'on');
else
    set(handles.listBtnB, 'Enable', 'on');
    set(handles.prefBtnB, 'Enable', 'on');
    
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
end


% --- Executes on button press in listBtnB.
function listBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnB
if get(handles.listBtnB, 'Value')
    set(handles.enterBtnB, 'Enable', 'off');
    set(handles.prefBtnB, 'Enable', 'off');
    
    set(handles.popupMenuB, 'Visible', 'on');
    set(handles.userEnterB, 'Visible', 'off');
else
    set(handles.enterBtnB, 'Enable', 'on');
    set(handles.prefBtnB, 'Enable', 'on');
    
    set(handles.popupMenuB, 'Visible', 'off');
    set(handles.userEnterB, 'Visible', 'on');
end


% --- Executes on button press in prefBtnB.
function prefBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnB
if get(handles.prefBtnB, 'Value')
    set(handles.enterBtnB, 'Enable', 'off');
    set(handles.listBtnB, 'Enable', 'off');
    
    set(handles.popupMenuB, 'Visible', 'off');
    set(handles.userEnterB, 'Visible', 'off');
else
    set(handles.enterBtnB, 'Enable', 'on');
    set(handles.listBtnB, 'Enable', 'on');
    
    set(handles.popupMenuB, 'Visible', 'off');
    set(handles.userEnterB, 'Visible', 'on');
end


% --- Executes on button press in swapBtn.
function swapBtn_Callback(hObject, eventdata, handles)
% hObject    handle to swapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global valueA;
global valueB;
if (get(handles.enterBtnA, 'Value') & get(handles.enterBtnB, 'Value'))
    valueA = get(handles.userEnterA, 'String');
    valueB = get(handles.userEnterB, 'String');
    set(handles.userEnterA, 'String', valueB);
    set(handles.userEnterB, 'String', valueA);
    valueA = get(handles.userEnterA, 'String');
    valueB = get(handles.userEnterB, 'String');
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
if get(handles.enterBtnC, 'Value')
    set(handles.listBtnC, 'Enable', 'off');
    set(handles.prefBtnC, 'Enable', 'off');
    
    set(handles.userEnterC, 'Enable', 'on');
else
    set(handles.listBtnC, 'Enable', 'on');
    set(handles.prefBtnC, 'Enable', 'on');
    
    set(handles.userEnterC, 'Enable', 'off');
    set(handles.userEnterC, 'String', '');
end


% --- Executes on button press in listBtnC.
function listBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnC
if get(handles.listBtnC, 'Value')
    set(handles.enterBtnC, 'Enable', 'off');
    set(handles.prefBtnC, 'Enable', 'off');
    
    set(handles.popupMenuC, 'Visible', 'on');
    set(handles.userEnterC, 'Visible', 'off');
else
    set(handles.enterBtnC, 'Enable', 'on');
    set(handles.prefBtnC, 'Enable', 'on');
    
    set(handles.popupMenuC, 'Visible', 'off');
    set(handles.userEnterC, 'Visible', 'on');
end


% --- Executes on button press in prefBtnC.
function prefBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnC
if get(handles.prefBtnC, 'Value')
    set(handles.enterBtnC, 'Enable', 'off');
    set(handles.listBtnC, 'Enable', 'off');
    
    set(handles.popupMenuC, 'Visible', 'off');
    set(handles.userEnterC, 'Visible', 'off');
else
    set(handles.enterBtnC, 'Enable', 'on');
    set(handles.listBtnC, 'Enable', 'on');
    
    set(handles.popupMenuC, 'Visible', 'off');
    set(handles.userEnterC, 'Visible', 'on');
end



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
if get(handles.enterBtnE, 'Value')
    set(handles.listBtnE, 'Enable', 'off');
    set(handles.prefBtnE, 'Enable', 'off');
    
    set(handles.userEnterE, 'Enable', 'on');
else
    set(handles.listBtnE, 'Enable', 'on');
    set(handles.prefBtnE, 'Enable', 'on');
    
    set(handles.userEnterE, 'Enable', 'off');
    set(handles.userEnterE, 'String', '');
end



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
if get(handles.listBtnE, 'Value')
    set(handles.enterBtnE, 'Enable', 'off');
    set(handles.prefBtnE, 'Enable', 'off');
    
    set(handles.popupMenuE, 'Visible', 'on');
    set(handles.userEnterE, 'Visible', 'off');
else
    set(handles.enterBtnE, 'Enable', 'on');
    set(handles.prefBtnE, 'Enable', 'on');
    
    set(handles.popupMenuE, 'Visible', 'off');
    set(handles.userEnterE, 'Visible', 'on');
end


% --- Executes on button press in prefBtnE.
function prefBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnE
if get(handles.prefBtnE, 'Value')
    set(handles.enterBtnE, 'Enable', 'off');
    set(handles.listBtnE, 'Enable', 'off');
    
    set(handles.popupMenuE, 'Visible', 'off');
    set(handles.userEnterE, 'Visible', 'off');
else
    set(handles.enterBtnE, 'Enable', 'on');
    set(handles.listBtnE, 'Enable', 'on');
    
    set(handles.popupMenuE, 'Visible', 'off');
    set(handles.userEnterE, 'Visible', 'on');
end



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
if get(handles.enterBtnD, 'Value')
    set(handles.listBtnD, 'Enable', 'off');
    set(handles.prefBtnD, 'Enable', 'off');
    
    set(handles.userEnterD, 'Enable', 'on');
else
    set(handles.listBtnD, 'Enable', 'on');
    set(handles.prefBtnD, 'Enable', 'on');
    
    set(handles.userEnterD, 'Enable', 'off');
    set(handles.userEnterD, 'String', '');
end


% --- Executes on button press in listBtnD.
function listBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnD
if get(handles.listBtnD, 'Value')
    set(handles.enterBtnD, 'Enable', 'off');
    set(handles.prefBtnD, 'Enable', 'off');
    
    set(handles.popupMenuD, 'Visible', 'on');
    set(handles.userEnterD, 'Visible', 'off');
else
    set(handles.enterBtnD, 'Enable', 'on');
    set(handles.prefBtnD, 'Enable', 'on');
    
    set(handles.popupMenuD, 'Visible', 'off');
    set(handles.userEnterD, 'Visible', 'on');
end


% --- Executes on button press in prefBtnD.
function prefBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnD
if get(handles.prefBtnD, 'Value')
    set(handles.enterBtnD, 'Enable', 'off');
    set(handles.listBtnD, 'Enable', 'off');
    
    set(handles.popupMenuD, 'Visible', 'off');
    set(handles.userEnterD, 'Visible', 'off');
else
    set(handles.enterBtnD, 'Enable', 'on');
    set(handles.listBtnD, 'Enable', 'on');
    
    set(handles.popupMenuD, 'Visible', 'off');
    set(handles.userEnterD, 'Visible', 'on');
end


% --- Executes on button press in enterBtnF.
function enterBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnF
if get(handles.enterBtnF, 'Value')
    set(handles.listBtnF, 'Enable', 'off');
    set(handles.prefBtnF, 'Enable', 'off');
    
    set(handles.userEnterF, 'Enable', 'on');
else
    set(handles.listBtnF, 'Enable', 'on');
    set(handles.prefBtnF, 'Enable', 'on');
    
    set(handles.userEnterF, 'Enable', 'off');
    set(handles.userEnterF, 'String', '');
end


% --- Executes on button press in listBtnF.
function listBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnF
if get(handles.listBtnF, 'Value')
    set(handles.enterBtnF, 'Enable', 'off');
    set(handles.prefBtnF, 'Enable', 'off');
    
    set(handles.popupMenuF, 'Visible', 'on');
    set(handles.userEnterF, 'Visible', 'off');
else
    set(handles.enterBtnF, 'Enable', 'on');
    set(handles.prefBtnF, 'Enable', 'on');
    
    set(handles.popupMenuF, 'Visible', 'off');
    set(handles.userEnterF, 'Visible', 'on');
end


% --- Executes on button press in prefBtnF.
function prefBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnF
if get(handles.prefBtnF, 'Value')
    set(handles.enterBtnF, 'Enable', 'off');
    set(handles.listBtnF, 'Enable', 'off');
    
    set(handles.popupMenuF, 'Visible', 'off');
    set(handles.userEnterF, 'Visible', 'off');
else
    set(handles.enterBtnF, 'Enable', 'on');
    set(handles.listBtnF, 'Enable', 'on');
    
    set(handles.popupMenuF, 'Visible', 'off');
    set(handles.userEnterF, 'Visible', 'on');
end



% --- Executes on key press with focus on BTNmaxDistance and none of its controls.
function BTNmaxDistance_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to BTNmaxDistance (see GCBO)
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


% --- Executes on selection change in popupMenuA.
function popupMenuA_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuA
global valueA;
contents = cellstr(get(hObject,'String'));
valueA = contents{get(hObject,'Value')};



% --- Executes during object creation, after setting all properties.
function popupMenuA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuB.
function popupMenuB_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuB
global valueB;
contents = cellstr(get(hObject,'String'));
valueB = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function popupMenuB_CreateFcn(hObject, eventdata, handles)
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
    set(handles.uipanelInstr, 'Visible', 'off');
    set(handles.hidePanel, 'String', 'Show all')
else
    set(handles.uipanelMain, 'Visible', 'on');
    set(handles.uipanelInstr, 'Visible', 'on'); 
    set(handles.hidePanel, 'String', 'Hide all')
end
