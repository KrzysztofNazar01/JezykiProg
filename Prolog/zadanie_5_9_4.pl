polacz_listy([],[],[]).
polacz_listy(L,[],L).
polacz_listy(L,[H|T],[H|X]) :- polacz_listy(L,T,X).

wypisz_liste([]).
wypisz_liste([H|T]) :- write(H), nl, wypisz_liste(T).

wpisz_strategie([P],P,[]).
wpisz_strategie([[P|T]], P, [T]).     % P - Stan planszy do wpisania, T - jeden z wariantów strategii, [P|T] - dopisany stan gry na pocz¹tek listy
wpisz_strategie([X|S],P,[H|T]) :- polacz_listy(H,[P],X), wpisz_strategie(S,P,T).    % X - aktualnie tworzony stan gry, S - lista pozosta³ych strategii

czy_wygrywa(Plansza) :- gracz(Plansza,G,P),( ( G\=[],write('Gracz: '),wypisz_liste(G)); ( P\=[],write('Przeciwnik: '),wypisz_liste(P),!,fail ) ).

/*GRACZ: przesuniêcie jednego pionka w lewo o jedno pole i jednego pionka w prawo o dwa pola, albo przesuniêcie jednego pionka w prawo o jedno pole z
zastrze¿eniem, ¿e na jednym polu mo¿e znajdowaæ siê maksymalnie 1 pionek, ponadto mo¿e on przeskakiwaæ inny pionek*/

%gracz(plansza, strategie_wygr_gracza, strategie_wygr_przeciwnika)
gracz([1,0],[[0,1]],[]).
gracz([1,0,0],[[1,0,0],[0,1,0]],[]).
gracz([0,1,0],[[0,1,0],[0,0,1]]).
gracz([0,0|A],G,P) :- generuj_ruchy_gracza([0],[0|A],0,0,G1,P1),		
		( ( ( G1\=[],wpisz_strategie(G,[0,0|A],G1) ) ; G =G1 ),			
		( ( P1\=[], wpisz_strategie(P,[0,0|A],P1) ) ; P = P1 ) ).		
gracz([1,1,1|A],G,P) :- generuj_ruchy_gracza([1],[1,1|A],0,0,G1,P1),	
		( ( ( G1\=[],wpisz_strategie(G,[1,1,1|A],G1) ) ; G =G1 ),		
		( ( P1\=[], wpisz_strategie(P,[1,1,1|A],P1) ) ; P = P1 ) ).
gracz([1,1,0|A],G,P) :-  ( generuj_ruchy_gracza([],[0,1,1|A],0,1,G1,P1), generuj_ruchy_gracza([1],[1,0|A],0,0,G2,P2) ) ,	
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,1,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,1,0|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,1,0|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[1,1,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,1,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,1,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,1,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,1,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
gracz([1,0,0|A],G,P) :-  ( generuj_ruchy_gracza([0],[0,1|A],0,1,G1,P1), generuj_ruchy_gracza([1,0],[0|A],0,0,G2,P2) ) ,		
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,0,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,0,0|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,0,0|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[1,0,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,0,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,0,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,0,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,0,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
gracz([0,1|A],G,P) :-  ( generuj_ruchy_gracza([1,0],A,1,0,G1,P1), generuj_ruchy_gracza([1],[0|A],0,0,G2,P2) ) ,				
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[0,1|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[0,1|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[0,1|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[0,1|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[0,1|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[0,1|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[0,1|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[0,1|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
gracz([1,0|A],G,P) :-  (przeciwnik([0,1|A],G1,P1), generuj_ruchy_gracza([1],[0|A],0,0,G2,P2)) ,					
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,0|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,0|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[1,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
gracz([X|A],G,P) :- generuj_ruchy_gracza([X],A,0,0,G,P).

%generuj_ruchy_gracza(sprawdzony_fragment_planszy, fragment_planszy_do_spr., czy_by³_ruch_w_lewo, czy_by³_ruch_w_prawo, strategie_wygr_gracza, strategie_wygr_przeciwnika)
generuj_ruchy_gracza(S,[],L,R,[],[[]]).
generuj_ruchy_gracza(S,[1],L,R,[],[[]]).
generuj_ruchy_gracza(S,[0,1,0],0,0,G,P) :- polacz_listy([0,0,1],S,B), przeciwnik(B,G,P).
generuj_ruchy_gracza(S,[0,0|A],L,R,G,P) :-  polacz_listy([0],S,B),generuj_ruchy_gracza(B,[0|A],L,R,G,P).      % w przypadki gdy na pocz¹tku s¹ dwa 0, to trzeba je przewin¹æ, aby znaleŸæ ruch
generuj_ruchy_gracza(S,[1,1,1|A],L,R,G,P) :-  polacz_listy([1],S,B),generuj_ruchy_gracza(B,[1,1|A],L,R,G,P).  % trzy 1 pod rz¹d oznaczaj¹ brak mo¿liwego ruchu, wiêc trzeba przewin¹æ
generuj_ruchy_gracza(S,A,1,1,G,P) :- polacz_listy(A,S,B), przeciwnik(B,G,P).								  % gdy by³ ruch w lewo i w prawo, to gracz nie mo¿e ju¿ nic zrobiæ i trzeba wywo³aæ przeciwnika
generuj_ruchy_gracza(S,[1,1,0|A],L,0,G,P) :- polacz_listy([1],S,B), 
		(generuj_ruchy_gracza(S,[0,1,1|A],L,1,G1,P1), generuj_ruchy_gracza(B,[1,0|A],L,0,G2,P2) ), 
		( (G1 = [[]], G2 = [[]], G = G1); (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ),
		( (P1 = [[]], P2 = [[]], P = P1); (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ). 
generuj_ruchy_gracza(S,[1,0,0|A],L,0,G,P) :- polacz_listy([0],S,B), polacz_listy([1,0],S,C), 
		(generuj_ruchy_gracza(B,[0,1|A],L,1,G1,P1), generuj_ruchy_gracza(C,[0|A],L,0,G2,P2) ), 
		( (G1 = [[]], G2 = [[]], G = G1); (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ),
		( (P1 = [[]], P2 = [[]], P = P1); (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ). 
generuj_ruchy_gracza(S,[0,1|A],0,R,G,P) :- polacz_listy([1,0],S,B), polacz_listy([0],S,C), 
		(generuj_ruchy_gracza(B,A,1,R,G1,P1), generuj_ruchy_gracza(C,[1|A],0,R,G2,P2) ), 
		( (G1 = [[]], G2 = [[]], G = G1); (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ),
		( (P1 = [[]], P2 = [[]], P = P1); (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ). 
generuj_ruchy_gracza(S,[1,0|A],0,0,G,P) :- polacz_listy([0,1|A],S,B), polacz_listy([1],S,C),
		( przeciwnik(B,G1,P1), generuj_ruchy_gracza(C,[0|A],0,0,G2,P2) ), 
		( (G1 = [[]], G2 = [[]], G = G1); (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ),
		( (P1 = [[]], P2 = [[]], P = P1); (P1\=[], P2=[[]], P=P1);(P1\=[], polacz_listy(P2,P1,P)); P=[] ).
generuj_ruchy_gracza(S,[X|A],L,R,G,P) :- polacz_listy([X],S,B), generuj_ruchy_gracza(B,A,L,R,G,P).


/*PRZECIWNIK: przesuniêcie dowolnej liczby pionków ³¹cznie o 3 pola w prawo (jeden pionek o dok³adnie 3 pola, jeden o jedno i drugi o dwa albo trzy 
pionki – ka¿dy o jedno pole), z zastrze¿eniem, ¿e na jednym polu mo¿e znajdowaæ siê maksymalnie 1 pionek, ponadto mo¿e on przeskakiwaæ inny pionek*/

%przeciwnik(plansza, strategie_wygr_gracza, strategie_wygr_przeciwnika)

przeciwnik([0|A],G,P) :- generuj_ruchy_przeciwnika([0],A,3,G1,P1),
		( ( ( G1\=[],wpisz_strategie(G,[0|A],G1) ) ; G =G1 ),
		( ( P1\=[], wpisz_strategie(P,[0|A],P1) ) ; P = P1 ) ).
przeciwnik([1,1,1,1|A],G,P) :- generuj_ruchy_przeciwnika([1],[1,1,1|A],1,G1,P1),
		( ( ( G1\=[],wpisz_strategie(G,[1,1,1,1|A],G1) ) ; G =G1 ),
		( ( P1\=[], wpisz_strategie(P,[1,1,1,1|A],P1) ) ; P = P1 ) ). %JEDYNEK MA BYÆ 4
przeciwnik([1,X,Y,0|A],G,P) :- polacz_listy([0,X,Y,1|A],S,B), 
		(gracz(B,G1,P1), generuj_ruchy_przeciwnika([1],[X,Y,0|A],3,G2,P2)), 
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,X,Y,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,X,Y,0|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,X,Y,0|A],G1) ) ; G3=G1 ), ( ( G1\=[], G2\=[], wpisz_strategie(G4,[1,X,Y,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,X,Y,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,X,Y,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,X,Y,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,X,Y,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
przeciwnik([1,X,0|A],G,P) :- (generuj_ruchy_przeciwnika([0,X,1],A,1,G1,P1), generuj_ruchy_przeciwnika([1],[X,0|A],3,G2,P2)), 
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,X,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,X,0|A],P1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,X,0|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[1,X,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,X,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,X,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,X,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,X,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
przeciwnik([1,0|A],G,P) :- (generuj_ruchy_przeciwnika([0,1],A,2,G1,P1), generuj_ruchy_przeciwnika([1,0],A,3,G2,P2)),
		( (G1 = [[]], G2 = [[]], wpisz_strategie(G,[1,0|A],G1)); (G1\=[], G2=[[]], wpisz_strategie(G,[1,0|A],G1)); ( ( ( G1\=[], wpisz_strategie(G3,[1,0|A],G1) ) ; G3=G1 ), ( ( G2\=[], wpisz_strategie(G4,[1,0|A],G2) ) ; G4 = G2 ), polacz_listy(G4,G3,G) ) ),
		( (P1 = [[]], P2 = [[]], wpisz_strategie(P,[1,0|A],P1)); (P1\=[], P2=[[]], wpisz_strategie(P,[1,0|A],P1)); ( ( ( P1\=[], wpisz_strategie(P3,[1,0|A],P1) ) ; P3=P1 ), ( ( P2\=[], wpisz_strategie(P4,[1,0|A],P2) ) ; P4 = P2 ), polacz_listy(P4,P3,P) ) ).
przeciwnik([X|A],G,P) :- generuj_ruchy_przeciwnika([X],A,3,G,P).


%generuj_ruchy_przeciwnika(sprawdzony_fragment_planszy, fragment_planszy_do_spr., licza_pozosta³ych_ruchów, strategie_wygr_gracza, strategie_wygr_przeciwnika)
generuj_ruchy_przeciwnika([1],[0,1,0],3,[],[[]]).
generuj_ruchy_przeciwnika([],[1,0,0,1],2,[],[[]]).
generuj_ruchy_przeciwnika([],[0,1,1,0],2,[],[[]]).

generuj_ruchy_przeciwnika(S,[],R,[[]],[]) :- R>0.
generuj_ruchy_przeciwnika(S,[1],R,[[]],[]) :- R>0.
generuj_ruchy_przeciwnika(S,[0|A],R,G,P) :- polacz_listy([0],S,L), generuj_ruchy_przeciwnika(L,A,R,G,P).
generuj_ruchy_przeciwnika(S,[1,1,1,1|A],R,G,P) :-  polacz_listy([1],S,L),generuj_ruchy_przeciwnika(L,[1,1,1|A],R,G,P). %JEDYNEK MA BYÆ 4
generuj_ruchy_przeciwnika(S,[1,X,Y,0|A],3,G,P) :- polacz_listy([0,X,Y,1|A],S,B), polacz_listy([1],S,C), 
		(gracz(B,G1,P1), generuj_ruchy_przeciwnika(C,[X,Y,0|A],3,G2,P2)), 
		( (G1 = [[]], G2 = [[]], G = G1); ( (G1\=[], G2=[[]], G=G1); (G1\=[], polacz_listy(G2,G1,G)); G=[] )),
		( (P1 = [[]], P2 = [[]], P = P1); ( (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) )).
generuj_ruchy_przeciwnika(S,[1,X,0|A],2,G,P) :- polacz_listy([0,X,1|A],S,B), polacz_listy([1],S,C), 
		(gracz(B,G1,P1), generuj_ruchy_przeciwnika(C,[X,0|A],2,G2,P2)), 
		( (G1 = [[]], G2 = [[]], G = G1); ( (G1\=[], G2=[[]], G=G1); (G1\=[], polacz_listy(G2,G1,G)); G=[] ) ),
		( (P1 = [[]], P2 = [[]], P = P1); ( (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ) ).
generuj_ruchy_przeciwnika(S,[1,X,0|A],3,G,P) :- polacz_listy([0,X,1|A],S,B), polacz_listy([1],S,C), 
		(generuj_ruchy_przeciwnika([],B,1,G1,P1), generuj_ruchy_przeciwnika(C,[X,0|A],3,G2,P2)), 
		( (G1 = [[]], G2 = [[]], G = G1); ( (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ) ),
		( (P1 = [[]], P2 = [[]], P = P1); ( (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ) ).
generuj_ruchy_przeciwnika(S,[1,0|A],1,G,P) :- polacz_listy([0,1|A],S,B), polacz_listy([1,0],S,C), 
		(gracz(B,G1,P1), generuj_ruchy_przeciwnika(C,A,1,G2,P2)), 
		( (G1 = [[]], G2 = [[]], G = G1); ( (G1\=[], G2=[[]], G=G1); (G1\=[], polacz_listy(G2,G1,G)); G=[] ) ),
		( (P1 = [[]], P2 = [[]], P = P1); ( (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ) ).
generuj_ruchy_przeciwnika(S,[1,0|A],R,G,P) :- polacz_listy([0,1|A],S,B), polacz_listy([1,0],S,C), T is R - 1,
		(generuj_ruchy_przeciwnika([],B,T,G1,P1), generuj_ruchy_przeciwnika(C,A,R,G2,P2)), 
		( (G1 = [[]], G2 = [[]], G = G1); ( (G1\=[], G2=[[]], G=G1); polacz_listy(G2,G1,G) ) ),
		( (P1 = [[]], P2 = [[]], P = P1); ( (P1\=[], P2=[[]], P=P1); polacz_listy(P2,P1,P) ) ).
generuj_ruchy_przeciwnika(S,[X|A],R,G,P) :- polacz_listy([X],S,L), generuj_ruchy_przeciwnika(L,A,R,G,P).