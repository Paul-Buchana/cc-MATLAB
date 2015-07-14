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

% Reading in the the tweets line by line from the text file.
fid = fopen('C:\Users\pbuchana\Dropbox\cc-MATLAB\tweet_input\tweets.txt');

tline = fgetl(fid);
uniqueWordsContainer = [];
while ischar(tline)
    tweetWords = textscan(tline, '%s', 'delimiter', ' ');
    uniqueWordsCount = (length(unique(tweetWords{:})));
    uniqueWordsContainer = [uniqueWordsContainer; uniqueWordsCount];
    tline = fgetl(fid);
end

fclose(fid);

% Calculating the median number of unique words per tweet.
% Computing the cummulative sum of unique words per tweet and dividing each
% sum by the correponding number of tweets. 
median = cumsum(uniqueWordsContainer)./(1:length(uniqueWordsContainer))';

% Writting the output to a text file.
fileID = fopen(strcat('C:\Users\pbuchana\Dropbox\cc-MATLAB\', ...
    'tweet_output\ft1.txt'),'w');
% Format specification: Microsoft Notepad requires a newline character 
% sequence of '\r\n' instead of '\n'.
fprintf(fileID, '%f\r\n', median);
fclose(fileID);

computationTime = toc;

% Computation time output to console.
fprintf('Computaion Time: %f \n', computationTime);