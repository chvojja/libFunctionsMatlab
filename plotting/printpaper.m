function printpaper(fpname,nv)
arguments
    fpname
    nv.dpi = 900;
    nv.close = true;
end

[~,~,ext] = fileparts(fpname);

switch ext(2:end)
    case 'png'
        print(fpname, '-dpng' , ['-r' num2str(nv.dpi)] );
    case 'eps'
        print('-vector','-depsc',fpname);
end
if nv.close
    close(gcf);
end

end