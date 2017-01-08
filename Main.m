clc;
close all;
clear all;

global write; % Ū�� input panel ��J

matDim    = 16; % ��J������
middleNum = 26; % hidden layer neural �Ӽ�
outputNum = 10; % output layer neural �ӼơA�P�ɤ]�O alphabet �Ӽ�

% training, get the weight
sumMSE = trainingNN(middleNum, outputNum);
weight = dlmread(['weight' int2str(middleNum) '.txt']);
weight1 = weight(1:middleNum, 1:matDim*matDim);
weight2 = weight(middleNum+1:middleNum+outputNum, 1:middleNum);

%cmd = input('Choice your test data input type:\n1. file\n2. witre panel\n:');
cmd = 1;
if cmd == 1 % ���ո�Ʊq�ɮ׿�J
    data = dlmread('testData.txt'); 
    targetData = data(:, 1:10);
    inputData = data(:, 11:266);
    [row, col] = size(inputData);
    parfor i = 1:row
        result(i, :) = identifyNum(inputData(i, :)', weight1, weight2);
    end
    result = targetData & result;
    idenResult = find(result);
    fprintf('���üh�Ӽ� = %d, MSE = %E, ���Ѳv = %3.2f%%\n', middleNum, sumMSE, length(idenResult)/row*100);
elseif cmd == 2 % ���ո�Ʊq��g��J
    while(true)
        write = zeros(matDim, matDim);
        inputPanel('start');
        cmd = input('What do you want?\n1. Start identify number\n2. Exit the program\n:');
        if cmd == 2
            fprintf('Bye Bye!\n');
            close all;
            break;
        else
            [value, idx] = max(identifyNum(write(:), weight1, weight2));
            if value == 1
                fprintf(2, 'Identification result is: %d\n', idx-1);
                
                cmd = input('Is identify correctly?\n1. correct\n2. error\n:');
                if cmd ~= 1
                    cmd = input('Input the correct number:');
                    temp = [zeros(1, cmd) 1 zeros(1, outputNum - cmd - 1) write(:)'];
                    dlmwrite('trainData.txt', temp, '-append');
                    fprintf('Add training data successfully\n');
                end
            else
                fprintf(2, 'Unrecognized...\n');
                
                cmd = input('Input the correct number:');
                temp = [zeros(1, cmd) 1 zeros(1, outputNum - cmd - 1) write(:)'];
                dlmwrite('trainData.txt', temp, '-append');
                fprintf('Add training data successfully\n');
            end
        end
    end
end

