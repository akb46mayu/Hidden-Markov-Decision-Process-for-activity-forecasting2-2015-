clear all;close all;clc;
% written by Bo Fan
% 
% OC:Optimal control
nrow=216; 
ncol=384;
valmatmode=0; % if 1 use saved valmat
FLT_MAX=100000000;
FLT_MIN=1e-20;
load ./featfolder/featureval.mat;
load walk_reward_weights.txt;
weights=walk_reward_weights;
img1 = imread('birdview_resize.jpg');
figure(1);
imagesc(img1);
startptx=[94,20];
startpty=[28,20];
endptx=[160,120,100];
endpty=[330,200,320];
%% Reward function
weightsmat=repmat(weights,1,nrow*ncol);
Rtmp=featureval(1:37,:).*weightsmat;
Rsum=sum(Rtmp);
B=reshape(Rsum,ncol,nrow);
R=B';
Rshow=R;
figure(2);
imagesc(Rshow);

%% Value function

if valmatmode==0
% we will do symmetric padding
    V=ones(nrow,ncol)*-FLT_MAX;
    V0=V;
     ct1=0;
     niter=0;
    while(1)
        niter=niter+1;
        ct1=ct1+1
        V_paddedtmp=wextend('2D','sym',V,1);
        %V_padded=V_paddedtmp(2:end-1,2:end-1);
        V_padded= V_paddedtmp;
        for i=1:nrow
            for j=1:ncol
                sub=V_padded(i:i+2,j:j+2);
                if max(sub(:))==FLT_MAX
                   continue; 
                end
                % softmax
                for i0=1:3
                   for j0=1:3
                       if(i0==2&&j0==2)
                          continue; 
                       end        
                       minv=min(V(i,j),sub(i0,j0));
                       maxv=max(V(i,j),sub(i0,j0));
                       softmax = maxv + log(1.0 + exp(minv-maxv));
                       V(i,j)=softmax;
                   end
                end
                V(i,j)= R(i,j)+V(i,j);        
            end       
        end
        V(startptx(1),startpty(1))=0;
       % V(endptx(2),endpty(2))=0;
        diffV=abs(V-V0);
        maxdiff=max(diffV(:));   
        if maxdiff<0.9

           break; 
        end
        if niter>=400       
            break;  
        end
        V0=V;
        figure(3);
        [ outimg,outimg0 ]=f_mat2rgb(V,FLT_MAX);
        Vshow=0.5*f_mat2rgb(V,FLT_MAX)+0.5*img1;
        
        imagesc(Vshow);    
    end
    save V.mat V;
else
    load V.mat;
end
%% Policy
na=9;
for i=1:na
   Pax{i}=zeros(nrow,ncol);     
end
V_padded=wextend('2D','sym',V,1);
for i=1:nrow
    for j=1:ncol
        
        
        sub=V_padded(i:i+2,j:j+2);
       
        p=sub-max(max(sub));
        
        p=exp(p);
        
        p(2,2)=0;
        sump=sum(p(:));
        if sump>0
           p=p./sump; 
        else
           pval=1/(na-1);
           p=ones(3,3)*pval;
        end
        
        pt=p';
        
        pvect=pt(:);
        
        for a=1:na
            
           Pax{a}(i,j)=pvect(a); 
            
        end
        
    end
end

%% distribution MC
D=zeros(nrow,ncol);
N0=D;N1=D;
% N0(startptx(1),startpty(1))=1;
N0(endptx(1),endpty(1))=1;
N0(endptx(2),endpty(2))=1;
N0(endptx(3),endpty(3))=1;

niter=0;
while(1)
    niter=niter+1;
    N1=zeros(nrow,ncol);
   for i=1:nrow
       for j=1:ncol
           if (i==startptx(1) && j==startpty(1))               
               continue;              
           end
%            if (i==endptx(1) && j==endpty(1))               
%                continue;              
%            end
%            if (i==endptx(2) && j==endpty(2))
%                continue;              
%            end
%            if (i==endptx(3) && j==endpty(3))
%                continue;              
%            end
           if N0(i,j)>FLT_MIN
              if(i>1 && j>1)
                 N1(i-1,j-1)=N1(i-1,j-1)+N0(i,j)*Pax{1}(i,j); 
              end
               
              if(i>1)
                 N1(i-1,j)= N1(i-1,j)+N0(i,j)*Pax{2}(i,j); 
              end
               
              if(i>1 && j<ncol)
                 N1(i-1,j+1)=N1(i-1,j+1)+N0(i,j)*Pax{3}(i,j); 
              end
              
              if(j>1)
                 N1(i,j-1)=N1(i,j-1)+N0(i,j)*Pax{4}(i,j); 
              end
              
              if(j<ncol)
                 N1(i,j+1)=N1(i,j+1)+N0(i,j)*Pax{6}(i,j); 
              end
              
              if(i<nrow && j>1)
                 N1(i+1,j-1)=N1(i+1,j-1)+N0(i,j)*Pax{7}(i,j); 
              end
              
              if(i<nrow)
                 N1(i+1,j)=N1(i+1,j)+N0(i,j)*Pax{8}(i,j); 
              end
                                     
              if(i<nrow && j<ncol)
                 N1(i+1,j+1)=N1(i+1,j+1)+N0(i,j)*Pax{9}(i,j); 
              end
               
           end
           
           
       end
   end
   N1(startptx(1),startpty(1))=0;
%    N1(endptx(1),endpty(1))=0;
% N1(endptx(2),endpty(2))=0;
% N1(endptx(3),endpty(3))=0;


   D=D+N1;
   N0=N1;
   niter
   if niter>400
       
       break;
   end
   figure(4);
%    Dshow=f_distribute(D);
 [ outimg,outimg0,im,PU,isNonZero ]  = f_distribute(D);
   Dshow=0.3*f_distribute(D)+0.7*img1;
   %Dshow=0.5*f_mat2rgb(D,FLT_MAX)+0.5*img1;
   imagesc(Dshow);
%    imagesc(D);
end

