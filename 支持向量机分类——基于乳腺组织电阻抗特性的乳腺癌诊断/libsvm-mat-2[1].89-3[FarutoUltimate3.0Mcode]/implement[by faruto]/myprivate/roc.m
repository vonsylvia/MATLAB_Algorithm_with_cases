function [tpr,fpr,thresholds] = roc(targets,outputs)
%ROC Receiver operating characteristic.
%
%  Syntax
%
%    [tpr,fpr,thresholds] = roc(targets,outputs)
%
%  Description
%
%    The receiver operating characteristic is a metric used to check
%    the quality of classifiers. For each class of a classifier,
%    threshold values across the interval [0,1] are applied to
%    outputs. For each threshold, two values are calculated, the
%    True Positive Ratio (the number of outputs greater or equal
%    to the threshold, divided by the number of one targets),
%    and the False Positive Ratio (the number of outputs less
%    then the threshold, divided by the number of zero targets).
%
%    The results of this function are often visualized with PLOTROC.
%
%    ROC(TARGETS,OUTPUTS) takes these arguments:
%      TARGETS - SxQ matrix, where each column vector contains a
%        single 1 value, with all other elements 0. The index of the 1
%        indicates which of S categories that vector represents.
%      OUTPUTS - SxQ matrix, where each column contains values in the
%        range [0,1]. The index of the largest element in the column
%        indicates which of S categories that vector presents.
%        Alternately, 1xQ vector, where values greater or equal to 0.5
%        indicate class membership, and values below 0.5, non-membership.
%    and returns these values:
%      TPR - Sx1 cell array of 1xN true-positive/positive ratios.
%      FPR - Sx1 cell array of 1xN false-positive/negative ratios.
%      THRESHOLDS - Sx1 cell array of 1xN thresholds over interval [0,1].
%
%    ROC(TARGETS,OUTPUTS) takes these arguments:
%      TARGETS - 1xQ matrix, of boolean values indicating class membership.
%      OUTPUTS - SxQ matrix, of value in [0.1] interval, where values
%        greater-or-equal to 0.5 indicate class membership.
%    and returns these values:
%      TPR - 1xN vector of true-positive/positive ratios.
%      FPR - 1xN vector of false-positive/negative ratios.
%      THRESHOLDS - 1xN vector of thresholds over interval [0,1].
%
%  Example
%
%    load iris_dataset
%    net = newpr(irisInputs,irisTargets,20);
%    net = train(net,irisInputs,irisTargets);
%    irisOutputs = sim(net,irisInputs);
%    [tpr,fpr,thresholds] = roc(irisTargets,irisOutputs)
%
%  See also PLOTROC, CONFUSION

% Copyright 2007-2008 The MathWorks, Inc.

if nargin < 2, error('NNET:Arguments','Not enough input arguments.'); end

[numClasses,numSamples] = size(targets);
[numClasses2,numSamples2] = size(outputs);
if any([numClasses,numSamples] ~= [numClasses2,numSamples2])
  error('NNET:Arguments','Targets and outputs have different dimensions.');
end

if (numClasses == 1)
  targets = [targets; 1-targets];
  outputs = [outputs; 1-outputs-eps*(outputs==0.5)];
  [tpr,fpr,thresholds] = roc(targets,outputs);
  tpr = tpr{1};
  fpr = fpr{1};
  thresholds = thresholds{1};
  return;
end

fpr = cell(1,numClasses);
tpr = cell(1,numClasses);
thresholds = cell(1,numClasses);

for i=1:numClasses
  [tpr{i},fpr{i},thresholds{i}] = roc_one(targets(i,:),outputs(i,:));
end

%%
function [tpr,fpr,thresholds] = roc_one(targets,outputs)

numSamples = length(targets);
numPositiveTargets = sum(targets);
numNegativeTargets = numSamples-numPositiveTargets;

thresholds = unique([0 outputs 1]);
numThresholds = length(thresholds);

sortedPosTargetOutputs = sort(outputs(targets == 1));
numPosTargetOutputs = length(sortedPosTargetOutputs);
sortedNegTargetOutputs = sort(outputs(targets == 0));
numNegTargetOutputs = length(sortedNegTargetOutputs);

fpcount = zeros(1,numThresholds);
tpcount = zeros(1,numThresholds);

posInd = 1;
negInd = 1;
for i=1:numThresholds
  threshold = thresholds(i);
  while (posInd <= numPosTargetOutputs) && (sortedPosTargetOutputs(posInd) <= threshold)
    posInd = posInd + 1;
  end
  tpcount(i) = numPosTargetOutputs + 1 - posInd;
  while (negInd <= numNegTargetOutputs) && (sortedNegTargetOutputs(negInd) <= threshold)
    negInd = negInd + 1;
  end
  fpcount(i) = numNegTargetOutputs + 1 - negInd;
end

tpr = fliplr(tpcount) ./ numPositiveTargets;
fpr = fliplr(fpcount) ./ numNegativeTargets;
