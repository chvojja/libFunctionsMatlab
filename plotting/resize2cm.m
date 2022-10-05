function resize2cm(width_cm,heigth_cm)
arguments
    width_cm;
    heigth_cm;
end


set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 width_cm heigth_cm]);
set(gcf,'Units','centimeters','Position',[4 1  width_cm heigth_cm]);





end