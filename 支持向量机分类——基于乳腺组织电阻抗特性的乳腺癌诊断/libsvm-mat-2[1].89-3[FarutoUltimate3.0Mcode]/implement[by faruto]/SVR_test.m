%% SVR_test

%%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto BNU
%last modified 2010.01.17
%Super Moderator @ www.ilovematlab.cn

%% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2009. 
% Software available at http://www.ilovematlab.cn
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%%
tic;
close all;
clear;
clc;
format compact;
%%
load exchange;
train_y = train_ymax;
train_x = [1:18]';
% load quyingdata;
% train_y = t';
% train_x = p';
% train_y = train_y(1:200,:);
% train_x = train_x(1:200,:);
test_y = train_y;
test_x = train_x;
% load x123;
% train_y = x1(1:17);
% train_x = [1:17]';;
% test_y = x1(18:end,:);
% test_x = [18:20]';
%%
Method_option.plotOriginal = 0;
Method_option.xscale = 1;
Method_option.yscale = 0;
Method_option.plotScale = 0;
Method_option.pca = 0;
Method_option.type = 2;
%%
[predict_Y,mse,r] = SVR(train_y,train_x,test_y,test_x,Method_option);

%%
toc;