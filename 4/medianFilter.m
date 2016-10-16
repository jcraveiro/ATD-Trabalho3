function y = medianFilter(x,n)
    start = round(n/2);
    y = zeros(1,length(x));
    for i=1:start
        y(i) = x(i);
    end
    for i=start:length(x)-start
        y(i) = median(x(i-start+1):x(i+start-1));
    end
    for i=length(x)-start+1:length(x)
        y(i) = x(i);
    end
end
