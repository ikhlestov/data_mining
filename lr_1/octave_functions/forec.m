function [z model] = forec(array, win_size, n_pred_points, reg_term)
    % linear prediction for one year
    % очистить от последних NaNов
    array(isnan(array)) = [];
    array = array(:);
    disp("unnormed");
    disp(array(1:5));
    % нормировка данных
    minf = min(array);
    array = array - minf;
    maxf = max(array);
    array = array./maxf;
    disp("normed");
    disp(array(1:5));

    % everything ok till here

    arr_len = length(array); % длина ряда  # n - previously
    disp("length(array):"), disp(arr_len);
    n_chunks = ceil(arr_len / win_size); % кусков для нарезки  # k
    disp("win size:"), disp(win_size);
    disp("n_chunks:"), disp(n_chunks);
    n_entries = n_chunks * win_size;
    % add some nans to array begining so it can be reshaped
    array = [nan([n_entries - arr_len 1]);  array]; % пополнение
    F = reshape (array, win_size, n_chunks);  % size(win_size, n_chinks)
    % relace added nans with second year values

    F(isnan(F(:,1)),1) = F(isnan(F(:,1)),2);
    disp("First column F");
    disp(F(:,1));
    
    % первый год ~ второй год
    % вот такое уравнение
    % A*F(:,1:(end-1)) = F(:,2:end);

    % 
    disp("size(F):"), disp(size(F));

    % all data but last entry
    F1 = F(:,1:(end-1));
    % all data but first entry
    F2 = F(:,2:end);
    disp("size(F1):"), disp(size(F1));
    % disp(F1);
    disp("size(F2):"), disp(size(F2));
    
    % win_size X win_size
    A = (F2 * F1') / ( F1 * F1' + reg_term * eye(size(F1,1)));  % F1.T
    % A = (F2 @ F1.T) / (F1 @ F1.T + reg_term * np.eye(*F1.shape))
    disp("size(A):"), disp(size(A));
    disp("A first row:"), disp(A(1, :));

    
    
    % формирование прогноза
    n_pred_chunks = ceil(n_pred_points / win_size); % кусков для прогноза, k2 pred
    z = [];
    % get data for last year
    Flast = F(:,end);
    disp(size(Flast));
    
    for i=1 : n_pred_chunks
       Flast = A*Flast;  %matrix multiplication
       z = [z; Flast];
    end;

    z = z(1:n_pred_points);
    z = z.*maxf;
    z = z + minf;

    % "модель", actually - restored predictions that should be similar to the train data
        disp("F slice:");
        disp(size(F(:, 1: (end - 1))));
        disp("F(:, 1)")
        disp(size(F(:, 1)));
        disp("A*F(:, 1: (end - 1))");
        disp(size(A*F(:, 1: (end - 1))));
    model = [F(:, 1) A*F(:, 1: (end - 1))];
        disp("model:")
        disp(size(model));
        disp("model first row:"), disp(model(1, :));
        disp("model first column:"), disp(model(:, 1));
    model = model(:);
        disp("model(:):")
        disp(size(model));
        disp("first 5 entries:"), disp(model(1:5));
    model = model(end - arr_len + 1: end);
    model = model.*maxf;
    model = model + minf;
    disp('--');
