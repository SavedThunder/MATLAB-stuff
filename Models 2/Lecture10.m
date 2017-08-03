%Kyle O'Connor
%
%Lecture 10
%
%3/15/2016

home;
clear all;
close all;
clc;

t = [0 30 60 90 120 150 180];
flow_rate = [0 0.5 0.7 0.3 0.5 0.5 0.3];

integ = MyTrap(flow_rate,t,0,120);
integ = sum(integ)

% num = input('What number would you like to find the 5th root of?');
% guess = input('What is your initial guess?');
% 
% ans = FifthRoot(num,guess);