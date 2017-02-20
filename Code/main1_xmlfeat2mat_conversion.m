clear all;close all;clc;
%% This script extract featrues from the author's XML file 
% and convert it to mat file in the folder called "featfolder"

%%
addpath('./xml_io_tools');% add the XML reading toolbox
Video = xml_read('walk_feature_maps.xml');%XML

featureall{1}=Video.feature_0.data;
featureall{2}=Video.feature_1.data;
featureall{3}=Video.feature_2.data;
featureall{4}=Video.feature_3.data;
featureall{5}=Video.feature_4.data;

featureall{6}=Video.feature_5.data;
featureall{7}=Video.feature_6.data;
featureall{8}=Video.feature_7.data;
featureall{9}=Video.feature_8.data;
featureall{10}=Video.feature_9.data;
% 
featureall{11}=Video.feature_10.data;
featureall{12}=Video.feature_11.data;
featureall{13}=Video.feature_12.data;
featureall{14}=Video.feature_13.data;
featureall{15}=Video.feature_14.data;
% 
featureall{16}=Video.feature_15.data;
featureall{17}=Video.feature_16.data;
featureall{18}=Video.feature_17.data;
featureall{19}=Video.feature_18.data;
featureall{20}=Video.feature_19.data;
%%
featureall{21}=Video.feature_20.data;
featureall{22}=Video.feature_21.data;
featureall{23}=Video.feature_22.data;
featureall{24}=Video.feature_23.data;
featureall{25}=Video.feature_24.data;

featureall{26}=Video.feature_25.data;
featureall{27}=Video.feature_26.data;
featureall{28}=Video.feature_27.data;
featureall{29}=Video.feature_28.data;
featureall{30}=Video.feature_29.data;
% 
featureall{31}=Video.feature_30.data;
featureall{32}=Video.feature_31.data;
featureall{33}=Video.feature_32.data;
featureall{34}=Video.feature_33.data;
featureall{35}=Video.feature_34.data;
% 
featureall{36}=Video.feature_35.data;
featureall{37}=Video.feature_36.data;
featureall{38}=Video.feature_37.data;
featureall{39}=Video.feature_38.data;
featureall{40}=Video.feature_39.data;


%%
for i=1:40

featurea  = feattovec(featureall{i});
% featurea  = 0;
filename=['./featfolder/','feature_',num2str(i),'.mat'];
varname=['featurea'];
save (filename, varname);


end