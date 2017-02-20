/*
 *  ioc.h
 *  IOC_DEMO
 *
 *  Created by Kris Kitani on 11/28/12.
 *  Copyright 2012 Carnegie Mellon University. All rights reserved.
 *
 */
#include <iostream>
#include <fstream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;

class IOC
{
public:
	
	IOC(){}
	~IOC(){}
	
	void loadBasenames	(string input_filename);
	void loadDemoTraj	(string input_file_prefix);
	void loadFeatureMaps(string input_file_prefix);
	void loadImages		(string input_file_prefix);
	
	void computeEmpiricalStatistics();
	void initialize(bool verbose,bool visualize);
	
	void backwardPass		();
	void forwardPass		();
	//void computeLikelihood	();
	void gradientUpdate		();
	
	bool _converged;
	
	void saveParameters	(string output_filename);
	
private:
	
	vector < string >				_basenames;			// file basenames
	vector < vector<cv::Point> >	_trajgt;			// ground truth trajectory
	vector < vector<cv::Point> >	_trajob;			// observed tracker output
	vector < vector<cv::Mat> >		_featmap;			// (physical) feature maps 
	vector < cv::Mat >				_image;				// (physical) feature maps 
	
	vector < vector <cv::Mat> >		_pax;				// policy [_nd _na ]
	vector <Mat>					_R;					// Reward Function
	vector <Mat>					_V;					// Soft Value Function
	vector <float>					_w;					// reward parameters
	vector <float>					_f_empirical;		// empirical feature count
	vector <float>					_f_expected;		// expected feature count
	vector <float>					_f_gradient;		// gradient
	
	vector <float>					_w_best;			// reward parameters
	vector <float>					_f_gradient_best;	// gradient
	
	vector <cv::Point>				_end;				// terminal states
	vector <cv::Point>				_start;				// start states
	int								_nf;				// number of feature types
	int								_nd;				// number of training data
	int								_na;				// number of actions [3x3]
	cv::Size						_size;				// current state space size
	float							_loglikelihood;		//
	float							_minloglikelihood;	//
	float							_lambda;			// exp-gradient descent step size

	int								_error;				// bad parameters
	
	bool							VISUALIZE;
	bool							VERBOSE;
	float							DELTA;
	
	void accumilateEmpiricalFeatureCounts(int data_i, cv::Point pt);
	void accumilateExpectedFeatureCounts(Mat D, vector<Mat> featmap);
	
	void computeStateVisDist(vector<Mat> pax,Point start,Point end,Mat img, Mat &D);
	
	void computeRewardFunction	(int data_i);							//
	void computePolicy			(vector<Mat> &pax, Mat VF, int na);		// one policy at a time
	void computeSoftValueFunc	(Mat R, Point end, Mat img, Mat &VF);	//
	
	void computeTrajLikelihood(vector<Mat> pax, vector<Point> trajgt, float &loglikelihood);
	
	void colormap(Mat _src, Mat &dst);									// visualization function
	void colormap_CumilativeProb(Mat src, Mat &dst);					// visualization function
};

