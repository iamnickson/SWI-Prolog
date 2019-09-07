equal(X,X).
opp(w,e).
opp(e,w).
%state(F, G, H, W)
% F represents the side of Farmer,
% G represents the side of Grain
% H represents side of Hen
% W represents side of Wolf
% Initial State state(w, w, w, w) - All are on the west bank
% Goal State: state(e, e, e, e) - All are on the east bank
%

unsafe(state(F, G, G, _W)):- % Grain and Hen on are the same side while Farmer is  on the opposite side.
   opp(F, G).
unsafe(state(F, _G, W, W)) :- % Hen and Fox are on the same side while Farmer is on the opposite side.
    opp(F, W).

safe(S):- not(unsafe(S)).


move(state(F, G, H, W), state(F1, G, H, W), act(none, F, F1)):-
    opp(F, F1),
    safe(state(F1, G, H, W)).

move(state(F,F,H,W), state(F1, F1, H,W), act(grain, F, F1)):-
    opp(F, F1),
    safe(state(F1, F1, H, W)).

move(state(F, G, F, W), state(F1, G, F1, W), act(hen, F, F1)):-
    opp(F,F1),
    safe(state(F1, G, F1, W)).

move(state(F, G, H, F), state(F1, G, H, F1), act(wolf, F, F1)):-
    opp(F,F1),
    safe(state(F1, G, H, F1)).

init(state(w, w, w, w)).
goal(state(e, e, e, e)).


find_path([Gs|P], Gs, FinalPath):-
    reverse([Gs|P], FinalPath).

find_path(PathSf, Gs, FinalPath):-  %performing depth-first search
 equal(PathSf, [Cs|RP]),
 move(Cs, Ns, _Act),
 not(member(Ns, RP)),
 find_path([Ns|PathSf], Gs, FinalPath).



find_path_act([Gs|P], Gs, FinalPath, Asf, Actions):-
    reverse([Gs|P], FinalPath),
    reverse(Asf, Actions).

find_path_act([Cs|RP], Gs, FinalPath, Asf, Actions):-
 move(Cs, Ns, Act),
 not(member(Ns, RP)),
 find_path_act( [Ns,Cs|RP], Gs, FinalPath, [Act|Asf], Actions).



writeAct(act(Item, S1, _S2)):-
    not(equal(Item, none)), !,
    (   S1 = e -> S1s = east, S2s = west;
                  S1s = west, S2s = east),
    format('Farmer takes ~s from ~s to ~s \n', [Item, S1s, S2s]).


writeAct(act(none, S1, _S2)):-
    (   S1 = e -> S1s = east, S2s = west;
                  S1s = west, S2s = east),
    format('Farmer rows alone from ~s to ~s \n', [S1s, S2s]).

writeActs([H|T]):-
    writeAct(H),
    writeActs(T).

writeActs([]).



solve_RC1(FinalPath):-
    init(IS), goal(GS),
    find_path([IS], GS, FinalPath).
/*solve_RC1x(P,A)*/
solve_RC1x(FP, Actions):- init(IS), goal(GS),
    find_path_act([IS], GS, FP, [], Actions),
    writeActs(Actions).



%=================================================
% Try the following predicates and write their purpose.
% What will happen if Rule-1.2 is removed.
% What will happen if Rule-2.2 is removed.
%

%Rule-1.1
writeList([H|T]):-
   write(H), nl,
   writeList(T).

%Rule-1.2
writeList([ ]).


%Rule-2.1
writeListRev([H|T]):-
    writeListRev(T),
    write(H), nl.

%Rule 2.2
writeListRev([ ]).
















