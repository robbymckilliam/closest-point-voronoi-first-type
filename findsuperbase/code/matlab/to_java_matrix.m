function out = to_java_matrix(B)

m = size(B,1)
n = size(B,2)

strObj = javaObjectEDT('Jama.Matrix',m,n);


end