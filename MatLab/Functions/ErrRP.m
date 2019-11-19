function erp = errRP(FTBO)
% Retourne l'erreur en r�gime permanent
% param: FTBO - la fonction de transfert
% return: erp - l'erreur en r�gime permanent

erp = 1/(FTBO.Numerator{:}(end)/FTBO.Denominator{:}(end-GetClass(FTBO)));
end

