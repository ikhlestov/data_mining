function X = myplot(x, freq)
    % x(isnan(x)) = [];
    x = x(~isnan(x));
    x = x(~x == 0);
    if (freq == 0)
        plot(x_cleaned);
    else
        k = ceil(length(x_cleaned) / freq);
        x_cleaned(end: k * freq) = NaN;   % add up to square matrix
        X = reshape(x_cleaned, freq, k);  % reshape to required matrix
        plot(X);
    end
