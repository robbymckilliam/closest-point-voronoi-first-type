%approximates the proportion of lattices of Voronoi's first kind

clear all;

if( usejava('jvm') == 0 )
    disp(['It appears you do not have a java virtual machine installed. ' ...
          ' This is not going to work.']);
end

%add java libraries in lib folder to matlab
javaclasspath('./lib/PubSim.jar');
javaaddpath('./lib/JGraphT.jar');
javaaddpath('./lib/Jama-1.0.3.jar');
javaaddpath('./lib/bignums.jar');
javaaddpath('./lib/flanagan.jar');
javaaddpath('./lib/junit-4.11.jar');
javaaddpath('./lib/RngPack.jar');
javaaddpath('./lib/colt.jar');
javaaddpath('./lib/jtransforms-2.4.jar');

addpath('./matlab') %add the matlab functions we will use

javaclasspath('-dynamic')

z = 1.96; %corresponds with 95% confidence interval
L = 10; %number of Monte-Carlo trials
Ns = [1,2,3,4]; %the dimensions we will run simulations for

%start simulations for uniform, gaussian and MIMO matrices
runmontecarlo( @(n) rand(n), Ns, L, z, 'uniform' ); 
runmontecarlo( @(n) randn(n), Ns, L, z, 'gaussian' ); 

