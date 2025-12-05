% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Ana Flynn
%
% Documentation: I used the functions and logic from HW 7 and adapted it for this problem
% No other outside resources used
%

% The query to get the answer(s) or that there is no answer
%each 4deg that saw a ufo
cadet(smith).
cadet(garcia).
cadet(jones).
cadet(chen).

%tues through fri where ufo was sighted
day(tue).
day(wed).
day(thurs).
day(fri).

%the objects
object(weatherballoon).
object(kite).
object(fighter).
object(cloud).

solve :-
    %each cadet saw an object on a certain day
    cadet(TueCadet), cadet(WedCadet), cadet(ThursCadet), cadet(FriCadet),
    all_different([TueCadet,WedCadet,ThursCadet,FriCadet]),
    
    %each object seen on a different day
    object(TueObject), object(WedObject), object(ThursObject), object(FriObject),
    all_different([TueObject,WedObject,ThursObject,FriObject]),
    
    %triples cadet day and object
    Triples = [ [TueCadet, tue, TueObject],
                [WedCadet, wed, WedObject],
                [ThursCadet, thurs, ThursObject],
                [FriCadet, fri, FriObject] ],
    
    %constraints
    \+ member([smith, _, weatherballoon], Triples),
    \+ member([smith, _, kite], Triples),
    
    \+ member([garcia, _, kite], Triples),
    
    %fridays sighting was made by c4c chen or the one who saw the fighter
    (   member([chen, fri, _], Triples);
    member([_, fri, fighter], Triples)),
    
    \+ member([_, tue, kite], Triples),
    
    \+ member([garcia, _, weatherballoon], Triples),
    \+ member([jones, _, weatherballoon], Triples),
    
    member([smith, _, cloud], Triples),
    
    member([_, fri, fighter], Triples),
    
    \+ member([_, wed, weatherballoon], Triples),
    
    tell(tue, TueCadet, TueObject),
    tell(wed, WedCadet, WedObject),
    tell(thurs, ThursCadet, ThursObject),
    tell(fri, FriCadet, FriObject).
    
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(Day, Cadet, Object) :-
    write(Day), write(': '), write(Cadet), write(' saw the '),
    write(Object), write('.'), nl.

% ?- solve.
