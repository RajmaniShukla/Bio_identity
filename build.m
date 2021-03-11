for k=1:50
    for i=1:5
        face{k} = imread(strcat('.\Database\',num2str(k),'\f (',num2str(i),').bmp'));
    end
end   
save('data.mat','face' );