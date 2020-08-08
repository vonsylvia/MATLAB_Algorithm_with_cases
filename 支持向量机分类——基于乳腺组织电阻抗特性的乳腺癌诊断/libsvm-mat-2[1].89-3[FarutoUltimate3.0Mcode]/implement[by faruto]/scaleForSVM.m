function [train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,ymin,ymax)
% scaleForSVM 

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
if nargin < 3
    ymin = 0;
    ymax = 1;
end
if nargin < 2
    test_data = train_data;
end
%%
[mtrain,ntrain] = size(train_data);
[mtest,ntest] = size(test_data);

dataset = [train_data;test_data];

[dataset_scale,ps] = mapminmax(dataset',ymin,ymax);

dataset_scale = dataset_scale';
train_scale = dataset_scale(1:mtrain,:);
test_scale = dataset_scale( (mtrain+1):(mtrain+mtest),: );
