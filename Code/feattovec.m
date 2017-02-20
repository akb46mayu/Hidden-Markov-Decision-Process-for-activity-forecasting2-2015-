function  tmpval  = feattovec( feature_0a )
% convert the string of featrues to a vector
j=1;
istart=0;iend=1;
for i=1:length(feature_0a)
    i
    if(' '==feature_0a(i) && ' '~=feature_0a(i+1) ) 
        iend=i;
        tmpstring=feature_0a(istart+1:iend-1);
        tmpval(j)=str2num(tmpstring);
        j=j+1;
        istart=iend;
    end   
end
tmpstring=feature_0a(istart:length(feature_0a));
tmpval(j)=str2num(tmpstring);
end

