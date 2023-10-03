function rankcon = PBHobtest(Ad,Cd)
    eig_Ad=(eig(Ad))';
    n = size(Ad,1);
    rankcon=zeros(n,1);
    for i=1:n
        con_1 = [Ad - eig_Ad(i) * eye(n); Cd]; 
        rankcon(i) = rank(con_1);
    end
end