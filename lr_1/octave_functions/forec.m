function [z h] = forec(array, win_size, n_pred_points, reg_term)
    % linear prediction for one year
    % очистить от последних NaNов
    array(isnan(array)) = [];
    array = array(:);
    % нормировка данных
    minf = min(array);
    array = array - minf;
    maxf = max(array);
    array = array./maxf;

    arr_len = length(array); % длина ряда  # n - previously
    n_chunks = ceil(arr_len / win_size); % кусков для нарезки  # k
    n_entries = n_chunks * win_size;
    % add some nans to array begining so it can be reshaped
    array = [nan([n_entries - arr_len 1]);  array]; % пополнение
    F = reshape (array, win_size, n_chunks);  % size(win_size, n_chinks)
    % relace added nans with second year values
    F(isnan(F(:,1)),1) = F(isnan(F(:,1)),2);
    % первый год ~ второй год
    % вот такое уравнение
    % A*F(:,1:(end-1)) = F(:,2:end);
    F1 = F(:,1:(end-1));
    F2 = F(:,2:end);
    A = (F2*F1')/(F1*F1'+ reg_term * eye(size(F1,1))); # F1.T

    % формирование прогноза
    n_pred_chunks = ceil(n_pred_points / win_size); % кусков для прогноза, k2 pred
    z = [];
    Flast = F(:,end);
    for i=1 : n_pred_chunks
       Flast = A*Flast;  %matrix multiplication
       z = [z; Flast];
    end;

    z = z(1:n_pred_points);
    z = z.*maxf;
    z = z + minf;

    % "модель"
    h = [F(:, 1) A*F(:, 1: (end - 1))];
    h = h(:);
    h = h(end - arr_len + 1: end);
    h = h.*maxf;
    h = h + minf;
