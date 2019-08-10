arc(a,b). arc(a,c). arc(a,d).
arc(b,e). arc(b,f).
arc(c, g). arc(c,h).
arc(d,i). arc(i,j).
arc(f,k).
arc(g,l). arc(g,m).
arc(h,n).
arc(i,o).
arc(j,p). arc(j,q).
equal(X,X).

dfs([Goal|P], Goal, Path):-reverse([Goal|P], Path).
dfs([Cs|Psofar], Goal, Path):-
    not(equal(Cs,Goal)),
    arc(Cs, Child),
    not(member(Child, Psofar)), /*it is not nessessary for tree*/
    dfs([Child, Cs|Psofar], Goal, Path).
