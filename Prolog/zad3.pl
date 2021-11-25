%Code Author = Jędrzej Niemiera 

qsort([],[]). %return empty array
qsort([Head|Tail],Sorted):- %pass parameters Head | Tail, SortedArray(to be returned)
    partition(Head,Tail,Left,Right),  %head, tail, leftArray, rightArray
    qsort(Left,LeftSorted), %leftArrayToBeSorted(passed), LeftSorted(returned)
    qsort(Right,RightSorted), %rightArrayToBeSorted(passed), RightSorted(returned)
    append(LeftSorted,[Head|RightSorted],Sorted).  %merging two arrays into SortedArray

partition(_,[],[],[]). %return empty array          _ = P (Pivot can be anything, we dont care about its value)
partition(Head,[A|X],[A|Y],Z):-  %pass parameters A->pivot, 
    A >= Head,
    partition(Head,X,Y,Z). %parition left side
    partition(Head,[A|X],Y,[A|Z]):-
    A < Head,
    partition(Head,X,Y,Z). %parition right side


non_negative(X) :- X>=0.


check_zero([0|_]).
check_zero([_|T]) :- check_zero(T).


check_ones([_|[]]).
check_ones([H|T]) :- 
    H=:=1,
    check_ones(T).


check_pairs(Seq) :-
    check_ones(Seq),
    length(Seq,L),
    0 is L mod 2,
    L =\= 2.


decrement(Head, 0, Head).
decrement([Head|Tail], K, Result) :-
	L is K-1,
	decrement(Tail, L, Decr),
	G is Head-1,
    non_negative(G),
	append([G], Decr, Result).


check_graphical([0|_]).
check_graphical([SortedHead|SortedTail]) :-
	SortedHead > 0,
	decrement(SortedTail, SortedHead, DecreasedTail),
	append([0], DecreasedTail, New),
	qsort(New, SortedNew),
	check_graphical(SortedNew).


findLastNumber([0|A],[0|A],R,R,N,N).
findLastNumber([Head|Tail],[NewElement|NewList],Result,X,L,N) :- 
    K is L + 1, 
    findLastNumber(Tail,NewList,Head,X, K, N), 
    ((X = Head, K = N, NewElement is 0); NewElement is Head).


check_connected([0|_]).
check_connected([SortedHead|SortedTail]) :-
    SortedHead>0,
    findLastNumber([SortedHead|SortedTail],NewList,1,LastNumber,0,N),
    decrement(NewList,LastNumber,DecreasedSeq),
    qsort(DecreasedSeq,NewSeq),
    check_connected(NewSeq).

is_connected(Seq) :-
	qsort(Seq, SortedSeq),
	check_graphical(SortedSeq),
    not(check_zero(Seq)),
    not(check_pairs(Seq)),
    append(SortedSeq,[0],NewSortedSeq),
    check_connected(NewSortedSeq).