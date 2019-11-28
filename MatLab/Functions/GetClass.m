function class = GetClass(FTBO)
% Retourne la class de la FTBO
% param: FTBO   - la fonction de transfert à compenser
% return: class - la classe de la FTBO

class  = 0;

for i = 0:1:3
    if (FTBO.Denominator{:}(end-i) == 0)
        class = class + 1;
    else
        return
    end
end
end

