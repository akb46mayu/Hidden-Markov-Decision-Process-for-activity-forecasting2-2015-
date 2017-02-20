function [ outimg,outimg0 ] = f_mat2rgb( src,FLT_MAX )
%% this function can convert a value function matrix to RGB format
[nrow,ncol]=size(src);
isInf  = f_cmp( src,-FLT_MAX );

src=f_threshold( src,-FLT_MAX);
minval=min(min(src));
maxval=max(max(src));
out=(src-minval)/(maxval-minval);

cm = colormap('hsv');
cdata = interp1(linspace(0,1,length(cm)),cm,out*0.85);
cdata(:,:,2)=isInf;  % S channel
cdata(:,:,3)=isInf;  % V channel
outimg0=hsv2rgb(cdata); % HSV to RGB
outimg=uint8(outimg0*255); 
end

function  isInf  = f_cmp( src,thres)
isInf=src;
   isInf(find(src>thres))=1;
   isInf(find(src<=thres))=0;
end

function  out  = f_threshold( src,thres )
out=src;
out(find(src<=thres))=0;
end