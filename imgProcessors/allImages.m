clc
clear all

inputPath=[cd '\resources\portraits\BioID-FaceDatabase-V1.2\'];
outputPath=[cd '\output\'];
imgDB= [inputPath '*.pgm'];
images = struct;

FileList = dir(imgDB);

N = size(FileList,1)-1500;
wb = waitbar(0,'Initializing Processor');

for k = 1:N
   
   waitbar(k/N,wb,'Processing images...')
   
   filename = FileList(k).name;
   img=imread(strcat(inputPath,filename));
   
   %% Edge Detection
   
   imgOut=edge(img,'Sobel','Horizontal',0.2);
   imwrite(imgOut,strcat(outputPath,filename,'_Hsobel.jpg'),'jpg');
   images(:).(strrep(filename,'.pgm','')).hSobel=imgOut;

end

save(strcat(outputPath,'imageData.mat'),'images');

close(wb);