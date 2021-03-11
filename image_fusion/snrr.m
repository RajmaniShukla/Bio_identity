function r = snrr(in, est)
%% Signal-to-noise ratio rate
error = in - est;
r = 10 * log10((255^2)/ mean(error(:).^2));