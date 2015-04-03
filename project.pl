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