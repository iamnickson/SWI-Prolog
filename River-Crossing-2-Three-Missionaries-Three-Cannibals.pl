/*
Three missionaries and Three cannibals have to cross a river
from the west bank to the east bank with the aid of a small boat that
can carry maximum two people.
At any situation, if the number of cannibals exceeds the number of
missionaries, Missonary's life will be in stake.

How to cross the river, safely */







/* state_w(M, C, B). representing the situation on the west side
 *  The situation on the west can be inferred from this.
 *  state_e(M1, C1, B1) where M + M1 = 3, C + C1 = 3 and B + B1 = 1
 *  If more clarity needed state could have been
 *  state(w(M,C,B)+e(M1, C1, B1))

*/


unsafe(state_w(M, C, _B)):-
       M > 0, C > M       ; C < M, M < 3.
     % unsafe on the west ; unsafe on the east

safe(S):-not(unsafe(S)).

istate(state_w(3,3,1)). %%state_e(0,0,0))).
gstate(state_w(0,0,0)). %%state_e(3,3,1))).

 /*one Missionary and one Cannibal go */
move(state_w(M,C,B), state_w(M1,C1,B1), m11-B):-
       safe(state_w(M,C,B)),
       (  B=1 -> M >= 1, C >= 1, M1 is M-1, C1 is C-1;
                 M =< 2, C =< 2, M1 is M+1, C1 is C+1),
       B1 is 1-B,
       safe(state_w(M1, C1, B1)).

/*two missionaries go */

move(state_w(M,C,B), state_w(M1,C1,B1), m20-B):-
      safe(state_w(M, C, B)),
      (   B=1 -> M > 1, M1 is M-2;    /* M >= 2 */
                 M < 2, M1 is M+2),   /* M =< 1 */
      C1 = C, B1 is 1-B,
      safe(state_w(M1, C1, B1)).



/* two cannibals go */
move(state_w(M,C,B), state_w(M1,C1,B1), m02-B):-
      safe(state_w(M, C, B)),
      M1 = M,
      (   B=1 -> C > 1, C1 is C-2;
                 C < 2, C1 is C+2),
      B1 is 1-B,
      safe(state_w(M1, C1, B1)).




/* One cannibal goes */
move(state_w(M,C,B), state_w(M1,C1,B1), m01-B):-
      safe(state_w(M, C, B)),
      M1 = M,
      (   B=1 -> C > 0, C1 is C-1;
                 C < 3, C1 is C+1),
      B1 is 1-B,
      safe(state_w(M1, C1, B1)).


/* One Missionary goes */

move(state_w(M,C,B), state_w(M1,C1,B1), m10-B):-
      safe(state_w(M, C, B)),
      (   B=1 -> M > 0, M1 is M-1;
                 M < 3, M1 is M+1),
      C1 = C, B1 is 1-B,
      safe(state_w(M1, C1, B1)).



dfs([Gs|Psf]+Actions, Gs, [Gs|Psf]+Actions).

dfs([Cs|PathSofar]+ActSofar, Gs, Path+Actions):-
	move(Cs, Ns, Act), not(member(Ns, PathSofar)),
	dfs([Ns, Cs|PathSofar]+[Act|ActSofar], Gs, Path+Actions).

solve_by_dfs(Path):-istate(Is), gstate(Gs), dfs([Is]+[], Gs, Path+Actions),
	writeActions(Actions).

writeActions([Act|Acts]):- writeActions(Acts), writeAction(Act).

writeActions([]).

writeAction(m10-B):- write('One missionary goes '), writeDir(B).
writeAction(m01-B):- write('One cannibal goes '),   writeDir(B).
writeAction(m11-B):- write('One missionary  and 1 cannibal go '), writeDir(B).
writeAction(m20-B):- write('Two missionaries go '), writeDir(B).
writeAction(m02-B):- write('Two cannibals go '),    writeDir(B).


writeDir(1):-writeln(' from west to east.').
writeDir(0):-writeln(' from east to west.').







