/*
code eHeadplanation:
https://www.cp.eng.chula.ac.th/~prabhas//teaching/dsys/2004/quick-prolog.htm

http://kti.mff.cuni.cz/~bartak/prolog/sorting.html#quick

https://www.youtube.com/watch?v=JCcNT5KfIl8

source: https://ai.ia.agh.edu.pl/_media/pl:dydaktyka:pp:prolog-lists-advanced.pdf
*/


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


