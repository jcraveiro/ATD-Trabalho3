% Devolve a frequencia fundamental

function pnote = fundamental(note)
    pnote = note;

    while pnote < 254
        if pnote == 0
            break;
        end

        pnote = pnote*2;
    end

    while pnote > 539
        pnote = pnote/2;
    end
end