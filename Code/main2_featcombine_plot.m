clear all;close all;clc;
%% this script load all of the features and make them together to one file
% it will also plot all of the features.

nrow=216; ncol=384;
for i=1:40
    filename=['./featfolder/','feature_',num2str(i),'.mat']
    load (filename);
    A=featurea;
    B=reshape(A,ncol,nrow);
    C=B';
    featureval(i,:)=featurea;
    
    
    if (i>=2 && i<=9)
       figure(1);
       subplot(2,4,i-1);imagesc(C); 
       if (i-1<=4)
           title('Pavement');
       else
           title('Sidewalk');
       end
    end
    
    if (i>=10 && i<=17)
        figure(2);
        subplot(2,4,i-9);imagesc(C);
        if (i-9<=4)
           title('Person');
       else
           title('Car');
       end
    end
    
    if (i>=18 && i<=25)
       figure(3);
       subplot(2,4,i-17);imagesc(C); 
       if (i-17<=4)
           title('Building');
       else
           title('Grass');
       end
    end
    
    if (i>=26 && i<=33)
       figure(4);
       subplot(2,4,i-25);imagesc(C); 
       if (i-25<=4)
           title('Curb');
       else
           title('fence');
       end
    end
    
    if (i>=34 && i<=40)
       figure(5);
       subplot(2,4,i-33);imagesc(C); 
       if (i-33<=4)
           title('Gravel');
       else
           title('Observation');
       end
    end
    
    
end

save ./featfolder/featureval.mat featureval;