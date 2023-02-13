function results = quantci(nv)
arguments
    nv.x;
    nv.pquant=0.5; % 0.5 is for median
    nv.prob = 95;
end
% From Probability and Statistical Inference 9th Robert V. Hogg
% xvals=1:12; [ci] = bootci(20000,{@median,xvals},'Type','bca','Alpha',0.05), quantci(x = xvals, pquant =0.5, prob = 95)


y = sort(nv.x);
n = numel(y);
quant_i = ((n+1)*nv.pquant);

%  how to correctly compute quantile?
% https://online.stat.psu.edu/stat415/lesson/19/19.2
% quant_i_lo = floor(quant_i);
% quant_i_hi = ceil(quant_i);
%quantile = y(quant_i_lo) + (quant_i-quant_i_lo)*(y(quant_i_hi) - y(quant_i_lo) );

quant = quantile(y,nv.pquant);

% quant_i = round(quant_i);

width_i = (min(n-quant_i+1,quant_i));

% i =1; j = n;
% 
% ci = [ y(i)  y(j) ];
% probability = nprobij_2prob(n,nv.pquant,i,j);
% results  =struct('i',i,'j',j,'probability',probability,'ci',ci);
% 
% width_i = width_i - 1;

% computation
i = round( quant_i-width_i+1 );
j = round( quant_i+width_i-1 );
ci = [ y(i)  y(j) ];
probability = nprobij_2prob(n,nv.pquant,i,j);
results  =struct('i',i,'j',j,'probability',probability,'ci',ci,'quantile',quant);

while probability > nv.prob/100
        results  =struct('i',i,'j',j,'probability',probability,'ci',ci,'quantile',quant);
        % narrow it
        width_i = width_i - 1;

        % computation
        i = quant_i-width_i+1;
        j = quant_i+width_i-1;
        ci = [ y(i)  y(j) ];
        probability = nprobij_2prob(n,nv.pquant,i,j);

end

    function prob = nprobij_2prob(n,prob_quantile,i,j)
        prob = 0;
        for k = i:(j-1)
            prob_part  = nchoosek(n,k)*(prob_quantile^k)*((1-prob_quantile)^(n-k));
            prob = prob + prob_part;
        end
end



end

