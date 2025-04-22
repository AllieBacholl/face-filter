files = dir('*.jpg') ; 
N = length(files) ; 
iwant = cell(N,1) ; 

for i = 1:N
    thisfile = files(i).name 
    outfile = imgtohex(thisfile) 
end