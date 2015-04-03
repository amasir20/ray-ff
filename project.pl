:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').  

search_variable(N,V,V) :- member(N,[0,1]),!.    


search_variable(X,Vin,Vout) :- atom(X), 
                         (member(X,Vin) -> Vout = Vin ;   
                            Vout = [X|Vin]).                 
search_variable(X and Y,Vin,Vout) :- search_variable(X,Vin,Vtemp),
                               search_variable(Y,Vtemp,Vout).
search_variable(X or Y,Vin,Vout) :-  search_variable(X,Vin,Vtemp),
                               search_variable(Y,Vtemp,Vout).
search_variable(not X,Vin,Vout) :-   search_variable(X,Vin,Vout).

initial_assign([],[]).
initial_assign([X|R],[0|S]) :- initial_assign(R,S).

successor(A,S) :- reverse(A,R),
                  next(R,N),
                  reverse(N,S).

next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).

find_answer(N,_,_,N) :- member(N,[0,1]).

find_answer(X,Vars,A,Answer) :- atom(X),
                             lookup(X,Vars,A,Answer).
							 
find_answer(X and Y,Vars,A,Answer) :- find_answer(X,Vars,A,ValueX),
                                   find_answer(Y,Vars,A,ValueY),
                                   logic_and(ValueX,ValueY,Answer).
								   
find_answer(X or Y,Vars,A,Answer) :-  find_answer(X,Vars,A,ValueX),
                                   find_answer(Y,Vars,A,ValueY),
                                   logic_or(ValueX,ValueY,Answer).
find_answer(not X,Vars,A,Answer) :-   find_answer(X,Vars,A,ValueX),
                                   logic_not(ValueX,Answer).
								   
								   
logic_and(0,0,0). 
logic_and(0,1,0). 
logic_and(1,0,0).  
logic_and(1,1,1). 
    
logic_or(0,0,0). 
logic_or(0,1,1).
logic_or(1,0,1).
logic_or(1,1,1).

     
logic_not(0,1).      
logic_not(1,0).

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).