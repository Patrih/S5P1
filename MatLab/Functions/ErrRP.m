function erp = errRP(FTBO)
% Retourne l'erreur en r�gime permanent
% param: FTBO - la fonction de transfert
% return: erp - l'erreur en r�gime permanent

erp = 1/(FTBO.Numerator{:}(end)/FTBO.Denominator{:}(end-GetClass(FTBO)));

if (GetClass(FTBO) == 0)
   erp = 1/((FTBO.Numerator{:}(end)/FTBO.Denominator{:}(end-GetClass(FTBO)))+1);
end
end

