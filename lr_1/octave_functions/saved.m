addpath('octave_functions')
addpath('/Users/illarion.khliestov/Projects/data_mining/lr_1/octave_functions')
data_t = csvread('tourism2_revision2.csv');
% first 366 columns contain monthly time series
% next 427 time series contain quarterly time series
size(data_t);  % 310, 794 - n_month, n_objects?
myplot(data_t(:, 1), 0);
X = myplot(data_t(:, 1), 12);
size(X)  % 12,14 - 12 month, 14 years

% declare `mase` and `naive`
naive(data_t)  % 1.8525
% declare `forec` and `linear_pred`, step 3
linear_pred(data_t)
% defne `drop_empty` and `plot_linear_pred`, step 4
plot_linear_pred(data_t)
% setup regularizetion terms, step 5, define `reg_setup`
reg_setup(data_t)
