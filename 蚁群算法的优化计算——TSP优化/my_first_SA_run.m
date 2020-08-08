clear
clc

ObjectiveFunction = @my_first_SA;   % Function handle to the objective function
X0 = [1 1];   % Starting point
lb = [-2 -2];     % Lower bound
ub = [2 2];       % Upper bound

options = saoptimset('MaxIter',500,'StallIterLim',500,'TolFun',1e-100,'AnnealingFcn',@annealingfast,'InitialTemperature',100,'TemperatureFcn',@temperatureexp,'ReannealInterval',500,'PlotFcns',{@saplotbestx, @saplotbestf, @saplotx, @saplotf,@saplottemperature});

[x,fval] = simulannealbnd(ObjectiveFunction,X0,lb,ub,options);