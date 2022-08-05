function y = boundi(x,bu)
  % return bounded value to be used as Matlab index
  y=min(max(x,1),bu);
