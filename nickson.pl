/*get_first_elt(get_first[24,25,27]) --> E = 24*/

get_first_elt(E, [E|_]).

/*get_lst_elt(E, [H|T]) :- E = H. */

get_last_elt(E, [_|T]) :- get_last_elt(E, T), !.
get_last_elt(E, [E]).

get_nth_elt(N, E, [_|T]) :-
    N > 1, N1 is N-1,
    get_nth_elt(N1,E,T), !.
get_nth_elt(1, E, [E|_]).

get_length([_|T], Ln) :-
    get_length(T, Lt), /*non-tail recursive*/
    Ln is Lt+1.

get_length([], 0).

get_length_tr(L, Ln) :-
    get_len_tr(L, 0, Ln).

get_len_tr([_|T], Li, Ln):-
    Lt is Li + 1,
    get_len_tr(T, Lt, Ln). /*tail-recursive */

get_len_tr([], Ln, Ln).


split_into_two([H|T], [H|Left], Right) :-
    split_into_two(T, Right, Left).

split_into_two([], [], []).


get_reverse(L, R) :- get_rv(L, [], R).

get_rv([H|T], Rt, R):-
    get_rv(T, [H|Rt], R).

get_rv([], R, R).

write_list([H]):-write(H),nl.
write_list([H|T]):-
    write(H),write(','),write_list(T).
write_list([]).
%**********************************

write_list_rev([H]):-write(H),!.
write_list_rev([H|T]):-
    write_list_rev(T),
    write('>'),write(H).
write_list_rev([]).
%**********************************
/*How to read user input*/
%read a name
get_name(Nm):-
    prompt(_,'Your Name: '),
    read(Nm).
%*Read User input
get_input(X):-prompt(_,'Your Input: '), read(X).

%Greetings
%Get the NAme
%Get the age
%Hello ....name.... You will be 100 in year....
greetings:-
    prompt(_,'Name : '), read(Nm),
    prompt(_,'Age : '),read(Ag),
    prompt(_,'Sex : '),read(Sx),
    print_message(Nm,Ag,Sx).
print_message(_Nm, Ag, Sex):-
    Year100 is 2119-Ag,
    /*
    write('Hello '),
    write(Nm), write(' '),
    write('You will be 100 in Year '),
    writeln(Year100).*/

/*
print_message(Nm, Ag):-
    Year100 is 100-Ag+2019,

%  write('Hello '),
    % write(Nm), write(' '), write(gender),
    % write('You will be 100 in Year '),
    % writeln(Year100).
    */
    (   Sex=female-> G1='Girl'; G1='Boy'),
/*format('~s ~s ~d ~n', [Nm, 'You will be 100 in Year', Year100]).*/
    format('Hello ~s, You will be 100 in the Year ~d ~n', [G1, Year100]).
