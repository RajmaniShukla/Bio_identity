%% Import file from Root Directory.  Import it as a Table.
uiopen IrisSetosa.xlsx
%% Extract 4 predictor variables and prepare their labels
variables = (1:4);
labels1 = IrisSetosa.Properties.VariableNames(variables);
%% Prepare labels for sample measurements 1 through 50
labels2 = (1:50)';
labels2cell = num2cell(labels2);
%%  Convert to numeric
measurement = IrisSetosa{:,variables};
%% summary statistics_mean
variables_means = mean(measurement);
variables_variance = var (measurement);
variables_standard_deviation = std(measurement);
%% covariance matrix and its eigenvalues
covariance_matrix = cov (measurement);
eigenvalues_covariance_matrix = eig (covariance_matrix);
%% Normalize (set mean = 0 and normalize the scale)
measurementNormal = zscore(measurement);
%% correlation matrix and its eigenvalues
correlation_matrix = corr (measurementNormal);
eigenvalues_correlation_matrix = eig (correlation_matrix);
%% Determine principal components: COVARIANCE P.C.A.
[pcs,scrs,vexp] = pca(measurement);
%  Variance explained (%)
pexp = 100*vexp/sum(vexp);
% disp(cumsum(pexp))
disp(cumsum(pexp))
%% Make Pareto chart of variance explained
figure (1)
figure1=figure(1);
pareto(pexp)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title ('Pareto Chart of Variance Explained')
saveas (figure1,'fig1')
%% View variables in terms of the first three principal components
% Determine principal components: COVARIANCE P.C.A.
% Prin.Comp.1 vs. Prin.Comp.2
figure(2)
figure2=figure(2);
subplot(3,2,1)
biplot(pcs(:,[1,2]),'scores',scrs (:,[1,2]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 1')
ylabel ('Principal Component 2')
title ('Covariance P.C.A. PC-1 vs PC-2')
% Prin.Comp.1 vs. Prin.Comp.3
subplot(3,2,2)
biplot(pcs(:,[1,3]), 'scores', scrs (:,[1,3]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 1')
ylabel ('Principal Component 3')
title ('Covariance P.C.A. PC-1 vs PC-3')
% Prin.Comp.2 vs. Prin.Comp.3
subplot(3,2,3)
biplot(pcs(:,[2,3]), 'scores', scrs (:,[2,3]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 2')
ylabel ('Principal Component 3')
title ('Covariance P.C.A. PC-2 vs PC-3')
saveas (figure2,'fig2')
%% View variables in terms of the first three principal components
% Determine principal components: CORRELATION P.C.A.
[pcs_corr,scrs_corr,vexp_corr] = pca(measurementNormal);
%  Variance explained (%)
pexp_corr = 100*vexp_corr/sum(vexp_corr);
% disp(cumsum(pexp_corr))
disp(cumsum(pexp_corr))
%% View variables in terms of the first three principal components
%CORRELATION P.C.A.
% Prin.Comp.1 vs. Prin.Comp.2
figure (2)
figure2=figure(2);
subplot(3,2,4)
biplot(pcs_corr(:,[1,2]), 'scores', scrs_corr (:,[1,2]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 1')
ylabel ('Principal Component 2')
title ('Correlation P.C.A. PC-1 vs PC-2')
% Prin.Comp.1 vs. Prin.Comp.3
subplot(3,2,5)
biplot(pcs_corr(:,[1,3]), 'scores', scrs_corr (:,[1,3]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 1')
ylabel ('Principal Component 3')
title ('Correlation P.C.A. PC-1 vs PC-3')
% Prin.Comp.2 vs. Prin.Comp.3
subplot(3,2,6)
biplot(pcs_corr(:,[2,3]), 'scores', scrs_corr (:,[2,3]),'VarLabels',labels1)%,'ObsLabels',num2cell(1:50)')
xlabel ('Principal Component 2')
ylabel ('Principal Component 3')
title ('Correlation P.C.A. PC-2 vs PC-3')
saveas (figure2,'fig2')
%%  Save variables in the workspace