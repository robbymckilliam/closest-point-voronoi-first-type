function out = runmontecarlo( matrixgenerator, Ns, L ) 
%runmontecarlo run L Monte-Carlo simulations to estimate the proportion
%of lattices of Voronoi's first kind in a given dimension. For each
%simulation the lattice basis a generated by the function 
%argument matrixgenerator.

    tic
    
    ps = zeros(size(Ns));
    for n = Ns
        for k = 1:L 
            B = to_java_matrix(matrixgenerator(n));
            fck = javaObjectEDT('pubsim.lattices.firstkind.FirstKindCheck',B);
            if(fck.isFirstKind)
                ps(n) = ps(n) + 1;
            end
        end
        disp('.');
    end

    out = ps/L;

    toc

end