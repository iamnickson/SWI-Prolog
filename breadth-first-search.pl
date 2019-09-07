

%graph is represented as follows
%
children(a, [b, c, d, e]).
children(b, [f, g]).
children(c, [g, j]).
children(d, [m, i, j]).
children(e, [i, k]).
children(g, [a, d, m]).
/* for other values children(X, _) will fail. */

bfs([Path|_Other_Paths], Gs, FP):-
    equal(Path, [Gs|_]),
    reverse(Path, FP).


/*To find the optimum path*/
bfs([Path|Other_paths], Gs, FP):-
    equal(Path, [Gs|_]),
    bfs(Other_paths, Gs, FP).


bfs([Path|Other_paths], Gs, FP):-
    equal(Path, [Cs|_P]), not(equal(Cs, Gs)),
    extend_path(Path, Paths),
    append(Other_paths, Paths, New_paths),
    bfs(New_paths, Gs, FP).

extend_path([Cs|RPath],Extndd_paths):-
    children(Cs, LCs),!,

    extnd_pth(LCs, [Cs|RPath], [], Extndd_paths).

extend_path(_, []).

extnd_pth([C|RLcs], Path, Paths,  Extndd_paths):-
    (   not(member(C, Path))->
    append(Paths, [[C|Path]], Extended_paths_C); equal(Extended_paths_C, Paths)),
    extnd_pth(RLcs, Path, Extended_paths_C, Extndd_paths).

extnd_pth([],_,P, P).

equal(_1, _1).

solve_by_bfs(Is, Gs, Path):-
    bfs([[Is]], Gs, Path).

/* Try the query as
   solve_by_bfs(a, m, Path).
and
note the values to Path,
to verify that the  shortest comes first
in the breadth-first-search.


Construct the graph represented by children/2 above
Represent the graph, using arc/2 predicate
like
      arc(a, b). arc(b, f).
etc.
and define children(C, LCs) as
            children(C, LCs):- bagof(Child, arc(C, Child), LCs).

It will fail if C has no child
as in the case of children defined at the top in this program
*/

/* Implement River-Crossing-1 (Farmer-Grain-Hen-Wolf) to solve
 *  by breadth-first-search
 */

