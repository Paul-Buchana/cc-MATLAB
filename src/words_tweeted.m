%{
Author: Paul Buchana
E-Mail: pbuchana@andrew.cmu.edu
Last Modified: 14th/June/2014
%}

tic

cd('C:\Users\pbuchana\Dropbox\cc-MATLAB\src');

% Clearing active console, closing all figures and removing historical list
% of commands.
clear all; close all; clc;

% Importing the text file containing tweets.
fileID = fopen('C:\Users\pbuchana\Dropbox\cc-MATLAB\tweet_input\tweets.txt');
formatSpec = '%s';
tweetData = textscan(fileID, formatSpec, 'delimiter', ' ');

% Assigning tweetData{1} array to array variable tweetWords as to avoid
% unneccessary communication overhead within parfor loop.

tweetWords = tweetData{:};

% Extracting unique words and sorting them.
uniqueWords = sort(unique(tweetWords));

% Performning a word count. Using a parfor loop as to take advantage of 
% Parallel Computing Toolbox capabilities for solving computationally and 
% data-intensive problems using multicore processors, GPUs, and computer 
% clusters in case of large text file feeds.
wordCount = zeros(length(uniqueWords), 1);
parfor i = 1:length(uniqueWords)
    % Frequency of occurence of each word.
    count = size(find(strcmpi(uniqueWords(i), tweetWords)), 1);
    wordCount(i) = count;
end

% Writting the output to a table.
Table = table(uniqueWords, wordCount, 'VariableNames', {'Word', ...
    'Frequency'});

% Displaying table in the console.
disp(Table);

% Writting the result to a text file and removing column names.
writetable(Table, strcat('C:\Users\pbuchana\Dropbox\cc-MATLAB\', ...
    'tweet_output\ft2.txt'), 'WriteVariableNames', 0, 'Delimiter', ' ');

computationTime = toc;

fprintf('Computaion Time: %f \n', computationTime);