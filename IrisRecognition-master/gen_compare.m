 function [temp2 ] = gen_compare(filename)
 %filename = 'D:\New folder (2)\Matlab\bin\bio\new\IrisRecognition-master\1.bmp';
%addpath('D:\New folder (2)\Matlab\bin\bio\new\Database');
 %fig=imread(strcat(filename));
 fig = filename;

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=fig;
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp2 th tv]=gen_templateVVV(parr);
%% Database 

   % file = strcat('D:\New folder (2)\Matlab\bin\bio\new\Database\1\l.bmp');
   % eye=imread(file);
    %[local xc yc time]=localisation2(eye,0.2);
    %%[ci cp out time]=thresh(local,50,200);
  %  [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
   % [temp_l th tv]=gen_templateVVV(parr);
   % hd_l=hammingdist(temp_l, temp2);

   % file = strcat('D:\New folder (2)\Matlab\bin\bio\new\Database\1\r.bmp');
   % eye=imread(file);
   % [local xc yc time]=localisation2(eye,0.2);
   % [ci cp out time]=thresh(local,50,200);
    %[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
   % [temp_r th tv]=gen_templateVVV(parr);
   % hd_r=hammingdist(temp_r, temp2);

    
%% Matching

%hd=hammingdist(temp1, temp2);

   % if(hd_l <=0.2 || hd_r <=0.2)
   %     disp('MATCHED');
   % else
   %     disp('NOT MATCHED');
   % end
    