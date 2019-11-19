function y = InterpolationLagrange(x, pointx, pointy)
% This function do a Lagrange interpolation.
% param: x      - Vector of entries
% param: pointx - Vecotr of x of the points we want to interpolate
% param: pointy - Vecotr of y of the points we want to interpolate
% return: y     - Vector of outputs
%

n = size(pointx, 2);
L = ones(n, size(x, 2));

if (size(pointx, 2) ~= size(pointy, 2))
    disp('X and Y must be the same size');
    y = NaN;
else
    for i = 1:n
        for j = 1:n
            if (i ~= j)
                L(i,:) = L(i,:) .* (x-pointx(j)) / (pointx(i)-pointx(j));
            end
        end
    end
    y = 0;
    
    for i = 1:n
        y = y+pointy(i)*L(i,:);
    end
end
end