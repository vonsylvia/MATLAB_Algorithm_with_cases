%% a_template_flow_usingSVM_regress
%for regression

%%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto BNU
%last modified 2010.01.17
%Super Moderator @ www.ilovematlab.cn

%% 若转载请注明：
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2009. 
% Software available at http://www.ilovematlab.cn
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%%
close all;
clear;
clc;
format compact;
%% 
% load x123
% load windspeed.mat;
% load traffic;
load test1;
%%
train_x = X;
train_y = Y;

% train_x = traffic(1:4,:)';;
% train_y = traffic(5,:)';
% 
% test_x = [18;19;20];
% test_y = x1(test_x);
%% 归一化预处理
% [train_x,test_x] = scaleForSVM(train_x,test_x,0,1);
[train_x,test_x] = scaleForSVM(train_x,train_x,0,1);
% [train_y_scale,test_y_scale,ps] = scaleForSVM(train_y,test_y,0,1);
[train_y_scale,test_x,ps] = scaleForSVM(train_y,train_y,0,1);
% train_y_scale = train_y;
% test_y_scale = test_y;
%% pca
% [train_x,test_x] = pcaForSVM(train_x,test_x,93);
% [train_x,train_x] = pcaForSVM(train_x,train_x,90);
%% 参数寻优
[bestmse,bestc,bestg] = SVMcgForRegress(train_y_scale,train_x)

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
%% 训练并对训练集回归预测
model = svmtrain(train_y_scale, train_x,cmd);
[ptrain, train_mse] = svmpredict(train_y_scale, train_x, model);
ptrain = mapminmax('reverse',ptrain',ps);
ptrain = ptrain';
%% 可视化
figure;
% subplot(2,1,1);
plot(train_y,'-o');
hold on;
plot(ptrain,'r-s');
grid on;
legend('original','predict');
title('Train Set Regression Predict by SVM');
%% predict on test set
% [ptest, test_mse] = svmpredict(test_y_scale,test_x, model);
% ptest = mapminmax('reverse',ptest',ps);
% ptest = ptest';
% test_y
% ptest
%% 可视化
% subplot(2,1,2);
% plot(test_y,'-d');
% hold on
% plot(ptest,'r-*');
% legend('original','predict');
% title('Test Set Regression Predict by SVM');
% grid on;

