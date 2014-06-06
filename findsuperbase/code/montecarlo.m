%approximates the proportion of lattices of Voronoi's first kind

if( usejava('jvm') == 0 )
    disp(['It appears you do not have a java virtual machine installed. ' ...
          ' This is not going to work.']);
end
javaclasspath('./lib/Jama-1.0.3.jar'); %add java libraries in lib folder to matlab
addpath('./matlab') %add the matlab functions we will use

mat = [1,2,3;4,5,6];
jmat = to_java_matrix(mat)

z = 1.96; %corresponds with 95% confidence interval
L = 100; %number of Monte-Carlo trials
Ns = [1,2,3,4]; %the dimensions we will run simulations for

