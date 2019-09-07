initial_state(s(w, w, w, w)).
goal_state(s(e,e,e,e)).

/* A state in which the hen is left with the grain or the wolf
     while the farmer is on the opposite side)
 *  is not a safe state.
 *  East and West are opposite sides.
 */

opp(e, w).
opp(w, e).
equal(X,X).

unsafe(s(F, H, G, W)) :-
    opp(F, H),
    (   equal(H, G) ;     % semicolon indicates "or" - alternate possibilities.
        equal(H, W)).

/* A state is safe if it is not unsafe */

safe(S) :- not(unsafe(S)).

move(s(S,H, G, W), s(S1, H, G, W), A):-
    opp(S, S1),
    safe(s(S1, H, G, W)),
    A='Farmer rows alone from'-S-to-S1.

move(s(S,S, G, W), s(S1, S1, G, W), A):-
    opp(S, S1),
    safe(s(S1, S1, G, W)),
    A='Farmer takes Hen from'-S-to-S1.


move(s(S,H, S, W), s(S1, H, S1, W), A):-
    opp(S, S1),
    safe(s(S1, H, S1, W)),
    A='Farmer takes Grain from'-S-to-S1.

move(s(S,H, G, S), s(S1, H, G, S1), A):-
    opp(S, S1),
    safe(s(S1, H, G, S1)),
    A='Farmer takes Wolf from'-S-to-S1.



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
/*
equal(_1, _1).*/

solve_by_bfs(Is, Gs, Path):-
    bfs([[Is]], Gs, Path).



find_actions(Actions):-
    initial_state(IS),
    goal_state(GS),
    dfs([IS], GS, [], Actions).


write_actions([Act|T]):-
    Act=PartSentence-From-to-_,
    (From=e -> From_as_word = east, To_as_word=west ;
               From_as_word = west, To_as_word=east),
    format('~s ~s to ~s~n', [PartSentence, From_as_word, To_as_word]),
    write_actions(T).

write_actions([]). %What if it were not included?

