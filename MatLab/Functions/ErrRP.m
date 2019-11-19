function erp = errRP(FTBO)
% Retourne l'erreur en régime permanent
% param: FTBO - la fonction de transfert
% return: erp - l'erreur en régime permanent

erp = 1/(FTBO.Numerator{:}(end)/FTBO.Denominator{:}(end-GetClass(FTBO)));
end

