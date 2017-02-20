function [ outimg,outimg0,im,PU,isNonZero ] = f_distribute( im )
% this function can convert a matrix to an RGB format image, the input is a
% probability matrix, all of the elements should be in [0,1]
[nrow,ncol]=size(im);
minVal = 0.02;
maxVal = 0.2;
im=f_threshold(im,minVal,0);

im=(im-minVal)/(maxVal-minVal);
U8=f_normto01(im);
cm = colormap('hsv');
cdata = interp1(linspace(0,1,length(cm)),cm,1*U8); % H channel

PU=sqrt(1-U8);
cdata(:,:,2)=PU;
isNonZero  = f_cmp( im,0); % S channel

cdata(:,:,3)=isNonZero ;  % V channel
outimg0=hsv2rgb(cdata);
outimg=uint8(outimg0*255);  % conversion from HSV to RGB

end

function  isInf  = f_cmp( src,th1 )
isInf=src;
   isInf(find(src>th1))=1;
   isInf(find(src<=th1))=0;
end

function  out  = f_threshold( src,thres,thresout )
out=src;
out(find(src<=thres))=thresout ;
end

function  out  = f_nromto1( src )
minval=min(src(:));
maxval=max(src(:));
out=(src-minval)/(maxval-minval);
end

function  out  = f_normto01( src )
out=src;
out(find(src>=1))=1;
out(find(src<=0))=0;
end