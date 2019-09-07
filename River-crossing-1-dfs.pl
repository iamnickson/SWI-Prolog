

/* state s(F, G, H, W)
 *  indicates the sides of the
 *  Farmer, Grain, Hen, and Wolf respectively.
 *  Side is either west (w) or east (e).
 *  -- when they are in the boat it is assumed to
 *  be on the opposite side of leaving side.
 *  thus the initial state is
 *  s(w, w, w, w)
 *  and the Goal state is
 *  s(e, e, e, e)
 */

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


dfs([Gs|_RemainingPath], Gs,  Actionsofar, Actions):-
    reverse(Actionsofar, Actions).

dfs([Cs|Pathsofar], Gs, Actionsofar,  Actions):-
     move(Cs, Ns, Act),
     not(member(Ns, Pathsofar)),  /* This is important, why? */
     dfs([Ns, Cs|Pathsofar], Gs, [Act|Actionsofar], Actions).

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


/*
How to get answer?

Your Query should be:

 find_actions(Acts), write_actions(Acts).

There are two possible sets of Actions.

You could create a predicate run as follows:

   run:- find_actions(Acts), write_actions(Acts).

and make the query as
    run.

But it will give only one answer.
Why?
*/

