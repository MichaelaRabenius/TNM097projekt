function [ sidelength ] = SizeOfSwatch( rows, cols, nr_colors )
%SIZEOFSWATCH Summary of this function goes here
%   Detailed explanation goes here
syms x n1 n2
eq1 = x == cols / n1;
eq2 = x == rows / n2;
eq3 = n1 * n2 == nr_colors;

sol = solve([eq1, eq2, eq3], [x, n1, n2]);
sidelength = double(sol.x(2));
end

