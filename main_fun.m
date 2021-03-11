function varargout = main_fun(varargin)

addpath('pca_face','Simple_FingerPrint_Matching','IrisRecognition-master');
% MAIN_FUN MATLAB code for main_fun.fig
%      MAIN_FUN, by itself, creates a new MAIN_FUN or raises the existing
%      singleton*.
%
%      H = MAIN_FUN returns the handle to a new MAIN_FUN or the handle to
%      the existing singleton*.
%
%      MAIN_FUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_FUN.M with the given input arguments.
%
%      MAIN_FUN('Property','Value',...) creates a new MAIN_FUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_fun_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_fun_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_fun

% Last Modified by GUIDE v2.5 17-Jun-2019 13:07:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_fun_OpeningFcn, ...
                   'gui_OutputFcn',  @main_fun_OutputFcn, ...
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


% --- Executes just before main_fun is made visible.
function main_fun_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_fun (see VARARGIN)

% Choose default command line output for main_fun
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_fun wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_fun_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

if exist('database.mat', 'file') == 2
     data = load('database.mat');
    f = data.face;
    [r,c] = size(f);
    set(handles.edit10,'String',strcat(num2str(r),' Entries' ));
 else
     set(handles.edit10,'String', 'No Data Found' );
end 
% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)

[i ,folder] = uigetfile({'*.bmp';});
img_f = imread(strcat(folder,i));
axes(handles.axes4);
imshow(img_f);
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
[i ,folder] = uigetfile({'*.bmp';});
img_i = imread(strcat(folder,i));
axes(handles.axes8);
imshow(img_i);
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.

function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)

[i ,folder] = uigetfile({'*.bmp';});
img_p = imread(strcat(folder,i));
axes(handles.axes9);
imshow(img_p);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
data = load('database.mat');
%% Face 
img_f = getimage(handles.axes4);
[Euc_dist , fe_fa] = Recognition(img_f);



[Euc_dist_min , Recognized_index] = min(Euc_dist);
 folder = (Recognized_index./5) + 1;
OutputName = strcat('.\Database\',int2str(folder),'\f (',int2str(mod(Recognized_index,5)),').bmp');
%disp(Euc_dist_min);
%figure;
%imshow(imread(OutputName));
%% IRIS 
 [r,c] = size(data.iris);
 img_i = getimage(handles.axes8);
 gufe_ir = gen_compare(img_i);
 
    f_i=0;
    for l=1:c
     hd=hammingdist(data.iris{round(folder),l}, gufe_ir);

      if(hd <=0.15)
           disp('MATCHED');
           f_i=1;
           break
      else
           disp('NOT MATCHED');
           
      end
    end  

%% Finger Print
[r,c] = size(data.fp);


img_p = getimage(handles.axes9);
fe_fp = main_total(img_p);

%% FOR EACH FINGERPRINT TEMPLATE, CALCULATE MATCHING SCORE IN COMPARISION WITH FIRST ONE
 S=zeros(c,1);
 for k=1:c
     second=['10' num2str(fix((k-1)/8)+1) '_' num2str(mod(k-1,8)+1)];
    %fprintf(['Computing similarity between ' filename ' and ' second ' from DATABASE : ']);
      S(k)=match(fe_fp,data.fp{round(folder),k});
      fprintf([num2str(S(k)) '\n']);
      drawnow
 end
 f_f = 0;
%% OFFER MATCHED FINGERPRINTS
 %Matched_FigerPrints=find(S>0.65)
if find(S>0.65) >0
    f_f = 1;
end    
%% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (f_i== 1 )&&( f_f== 1)
    set(handles.edit13,'ForegroundColor', 'Green' );
    set(handles.edit13,'String',strcat('>>> Matched data with ID:',int2str(folder)));
elseif (f_i== 0 )&&( f_f== 0)
        set(handles.edit13,'ForegroundColor', 'Red' );
        set(handles.edit13,'String',strcat('>>> Not Matched data  with same set' ));
elseif f_i== 0
        set(handles.edit13,'ForegroundColor', 'Blue' );
        set(handles.edit13,'String',strcat('>>> Face and Finger Print Matched data with ID:',int2str(folder),' but IRIS does not Matched data  with same set' ));
else
        set(handles.edit13,'ForegroundColor', 'Blue' );
        set(handles.edit13,'String',strcat('>>> Face and IRIS Matched data with ID:',int2str(folder),' but Finger Print does not Matched data  with same set' ));

        
end    


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
