function logMarginalLikelihood = logMarginalLikelihood(theta, covarianceFunction, x, y)
N = length(x);

% Gram Matrix
gramMatrixXX = evaluateGramMatrix(covarianceFunction, theta, x, x);

% The data fit term
dataFitTerm = -1*(0.5)*y'*inv(gramMatrixXX)*y;

% The complexity term
jitter = 10^(-6);
L = chol(gramMatrixXX + eye(N)*jitter);
complexityTerm = -1*sum(log(diag(L)));

% Normalization term
normalizationTerm = -1*N*log(2*pi)/2;
logMarginalLikelihood = dataFitTerm + complexityTerm + normalizationTerm;

end

% Optimizing the log marginal likelihood 
theta = [1, 0.2];
% Amplitude hyp = 1
% Length Scale = 0.2

options = optimoptions('fminunc','GradObj','off', 'MaxIter', 100); % indicate gradient is provided
optimizedTheta = fminunc(@(x) -1*logMarginalLikelihood(x, SEKernel, xData, yData), theta, options);