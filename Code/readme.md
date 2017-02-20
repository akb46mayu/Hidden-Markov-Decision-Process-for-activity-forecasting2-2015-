# How to run the code
## 1 Quick run 
The feature folder featfolder includes all the 40 feature files.  The files can also generated from step 1.3, but it will take some time.  If it has been put into the corresponding folder, we can do the following things:
## 2 Activity forecasting for one goal
1) Directly run main3_OC.m, and we will observe the forecasting distribution.
This program runs quickly, because the value function map and the feature maps have been pre-computed. 
2)  If we want to compute new V for different destinations, we have to use the mode valmatmode=0;
## 3 Activity forecasting for multiple goals 
Directly run main4_OC.m, and it will compute the value function map and then predict the trajectory distributions.
## 4 Conversion from the xml file to the mat file 
If we want to convert more xml files for the other experiments, we need to use the scripts in xml_io_tools. The feature files (such as walk_feature_maps.xml in oc_demo) can be downloaded from the author’s webpage  http://www.cs.cmu.edu/~kkitani/datasets/index.html. All of the xml files will be contained in oc_demo.zip and ioc_demo.zip. Then directly run main1_xmlfeat2mat_conversion.m. Because one xml file is large than 30MB, we did not put them in our folder. 
## 5 Combine 40 feature mat files to one mat file, and plot them
After we have done 1.3, we can directly run main2_featcombine_plot.m
## 6 The bugs in the author’s demo
To run the author’s demo, I used Visual studio 2012 and Opencv 2.9.0. The first bug is from the learning phase because there are 37 features not 40 features. The second bug is there is no definition of FLT_MAX which is the maximum value of a float type number. 
