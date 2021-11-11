/*
code eHeadplanation:
https://www.cp.eng.chula.ac.th/~prabhas//teaching/dsys/2004/quick-prolog.htm

http://kti.mff.cuni.cz/~bartak/prolog/sorting.html#quick

https://www.youtube.com/watch?v=JCcNT5KfIl8

source: https://ai.ia.agh.edu.pl/_media/pl:dydaktyka:pp:prolog-lists-advanced.pdf
*/




%main function
graficzny(List, List2) :- %pass arguments
    nl,
    qsort(List,Sorted), %sort array
    write('sorted= '), write(Sorted), nl,
    [First|Tail] = Sorted, %get the First element of the Sorted array
    write('First= '), write(First), nl,
  %difference to be added when the N(First) elements will be decremented (the Sorted Array is divided into two parts -> in the first one the elements are decremeneted; in the second the nubmer remain the smae and are added at the end of the "grafuczny" procedure)
    take(First, Tail, NFirstNum), %take N(First) elements, from Tail array, and save it as NFirstNum array
    write('N(First) elem= '), write(NFirstNum), nl,
    maplist(plus(-1), NFirstNum, DecrementedNumbers), %decremenet all elements of NFirstNum by 1 and save it as DecrementedNumbers array
    write('List after decr= '), write(DecrementedNumbers), nl,
    length(X, First), append(X, ToBeAdded, Tail), %get second list(unchanged) -> save it as ToBeAdded
    combine(DecrementedNumbers, ToBeAdded, NewList),  %connecting two lists
    write('Lists connected= '), write(NewList), nl,
    min_member(@=<, Min, NewList), %if Min will be 0, then tehre is not sufficient positive element in the list to state that the graph is graphic
    max_member(@=<, Max, NewList),
    write('Min= '), write(Min), nl,
    write('Max= '), write(Max), nl,
    checkIfTerminate(NewList, List2, Min, Max).
    

checkIfTerminate(NewList, List2, Min, Max) :-
    Min =:= 0, Max =:= 0, nl, write(' trueee'), retTrue(0); %min and max are both ewaul to 0 (each element in list is 0)
    Min < 0, Max =:= 0, nl, write(' falseee'), retFalse(0); 
    graficzny(NewList, List2).




%connect lists:
combine(A, B, C):-
  append(A1, Common, A),
  append(Common, B1, B),
  !,  % The cut here is to keep the longest common sub-list
  append([A1, Common, B1], C).



%decrementing numbers in array: https://stackoverflow.com/questions/68828686/prolog-write-predicate-that-decrements-all-elements-of-a-list-of-integers


%source: https://stackoverflow.com/questions/27151274/prolog-take-the-first-n-elements-of-a-list/27205600#27205600
take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).




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


    
%retFalse(0),
retFalse(X) :- X =:= 0 -> false.

%retTrue(0),
retTrue(X) :- X =:= 0 -> true.

