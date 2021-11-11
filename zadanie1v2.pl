/*
code eHeadplanation:
https://www.cp.eng.chula.ac.th/~prabhas//teaching/dsys/2004/quick-prolog.htm

http://kti.mff.cuni.cz/~bartak/prolog/sorting.html#quick

https://www.youtube.com/watch?v=JCcNT5KfIl8

source: https://ai.ia.agh.edu.pl/_media/pl:dydaktyka:pp:prolog-lists-advanced.pdf
*/

%count(1, [3,2,3,2,3], Occurences). --> Occurences = 0
count(_, [], 0).
count(X, [X | T], N) :-
  !, count(X, T, N1),
  N is N1 + 1.
count(X, [_ | T], N) :-
  count(X, T, N).


%    list_length(Sorted, ArrSize), %get size of the array
list_length(Xs,L) :-
    list_length(Xs,0,L).

list_length( []     , L , L ) .
list_length( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  list_length(Xs,T1,L).


%connect lists:
combine(A, B, C):-
  append(A1, Common, A),
  append(Common, B1, B),
  !,  % The cut here is to keep the longest common sub-list
  append([A1, Common, B1], C).


%check if any element in the list is 0 or -1
list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

list_intersect([X|Y],Z,[X|W]) :-
   list_member(X,Z), list_intersect(Y,Z,W).
list_intersect([X|Y],Z,W) :-
   \+ list_member(X,Z), list_intersect(Y,Z,W).
list_intersect([],Z,[]).


count_to_10(10).
count_to_10(X) :-
   %write(X),nl,

   Y is X + 1,
   count_to_10(Y).




loop2(1,LoopRep).
loop2(1,LoopRep) :-
between(1,LoopRep,Control),
check(Control),  %writeln(Control),
Control >= LoopRep.

dosomething([]).
 dosomething([H|T]) :- check(H), dosomething(T).

%main function
graficzny(List, NumberToCheckIfPositve) :- %pass arguments
    qsort(List,Sorted), %sort array
    %count(First, Sorted, Counter), % count repetitions of the first number ---> i think it is not  aproblem here
    [First|Tail] = Sorted, %get the First element of the Sorted array
  %difference to be added when the N(First) elements will be decremented (the Sorted Array is divided into two parts -> in the first one the elements are decremeneted; in the second the nubmer remain the smae and are added at the end of the "grafuczny" procedure)
    take(First, Tail, GoodNumbers), %take N(First) elements, from Tail array, and save it as GoodNumbers array
    %loop(1,Counter-1), %add n-1 duplicates of the first number
    maplist(plus(-1), GoodNumbers, DecrementedNumbers), %decremenet all elements of GoodNumbers by 1 and save it as DecrementedNumbers array
    length(X, First), append(X, ToBeAdded, Tail), %get second list(unchanged) -> save it as ToBeAdded
    combine(DecrementedNumbers, ToBeAdded, NewList),  %connecting two lists
    qsort(NewList,NewListSorted),   %sort list again 
    [FirstNew|TailNew] = NewListSorted,  %take new first element
    take(FirstNew, TailNew, NumberToCheckIfPositve), %check if N(FirstNew) elements of the list are positive
    IfPositive is 0,
    write('A= '), write(NumberToCheckIfPositve), nl,
    check_list(NumberToCheckIfPositve, IfPositive),
    write('Pos= '), write(IfPositive).

check(X,P) :- X > 0, P is 2;  X < 0, P is 4.


check_list([],P) :- write('final='), write(P).
check_list([Head|Tail],P) :-
  check(Head,P), nl,
  write('   sp='), write(P), nl,
  check_list(Tail, P).


go:-
 write('enter two numbers:'),nl,
 read(X),read(Y),
 compare(X,Y).
 

 %very nice function, works well
compare(X,Y):-
 X>Y,write(X),write('>'),write(Y),nl, ;
 X<Y,write(X),write('<'),write(Y),nl;
 write(X),write('='),write(Y),nl.




/*

[3, 3,3,3, 3,3,3,2]
*/
/*
check(X,Positive) :- X > 0, Positive is 1.
check(X,Positive) :- X =< 0, Positive is 0.

check_list([], Positive) :- Positive > 0,  write('pos is 1').
check_list([], Positive) :- Positive =< 0,  write('pos is 0').
check_list([], Positive).
check_list([Head|Tail],Positive) :-
  check(Head,Positive), nl,
  check_list(Tail,Positive).
*/


take2(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take2(_, [], []).
take2(N, [X|Xs], [X|Ys]) :- M is N-1, take2(M, Xs, Ys).

%didve list into X nad Y
%length(X, 3), append(X, Y, [a,b,c,d,e,f,g,h])



%for loop, works
loop(1,LoopRep).
loop(1,LoopRep) :-
between(1,LoopRep,Control),
[First|Tail] = NumberToCheckIfPositve,
Positive is 5,
write('a'),nl,
check(First),
%new_head(GoodNumbers, First, [First| GoodNumbers]),  %writeln(Control),
Control >= LoopRep.




%works, add element at the beggining of the list
%new_head([1,2],3,RetArray) --> RetArray = [3, 1, 2].
new_head(Tail, Head, [Head| Tail]).
 
%does not work when the first number repeats

%decrementing numbers in array: https://stackoverflow.com/questions/68828686/prolog-write-predicate-that-decrements-all-elements-of-a-list-of-integers


%source: https://stackoverflow.com/questions/27151274/prolog-take-the-first-n-elements-of-a-list/27205600#27205600
take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).



count_duplicate(In, Out) :-
    maplist(test(In), In, Out).

test(Src, Elem, 1) :-
    select(Elem, Src, Result),
    member(Elem, Result).

test(_Src, _Elem, 0).


qsort([],[]). %return empty array
qsort([H|T],S):- %pass parameters Head | Tail, SortedArray(to be returned)
    partition(H,T,L,R),  %head, tail, leftArray, rightArray
    qsort(L,LS), %leftArrayToBeSorted(passed), LeftSorted(returned)
    qsort(R,RS), %rightArrayToBeSorted(passed), RightSorted(returned)
    append(LS,[H|RS],S).  %merging two arrays into SortedArray

partition(_,[],[],[]). %return empty array          _ = P (Pivot can be anything, we dont care about its value)
partition(H,[A|X],[A|Y],Z):-  %pass parameters A->pivot, 
    A >= H,
    partition(H,X,Y,Z). %parition left side
    partition(H,[A|X],Y,[A|Z]):-
    A < H,
    partition(H,X,Y,Z). %parition right side

