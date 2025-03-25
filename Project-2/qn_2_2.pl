% Defining parent-child relationships
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

% Defining gender
male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% Defining birth order
born_before(prince_charles, princess_ann).
born_before(princess_ann, prince_andrew).
born_before(prince_andrew, prince_edward).

% Old succession rule: males inherit first, then females
old_succession(X) :-
    parent(queen_elizabeth, X),
    male(X).

old_succession(X) :-
    parent(queen_elizabeth, X),
    female(X),
    \+ old_succession(_). % Ensures all males are considered first

% Define order based on birth within the gender category
succession_order(X, Y) :-
    old_succession(X), 
    old_succession(Y),
    born_before(X, Y).

% New succession rule: direct birth order
new_succession(X) :-
    parent(queen_elizabeth, X).

% Define order based purely on birth order
new_succession_order(X, Y) :-
    new_succession(X),
    new_succession(Y),
    born_before(X, Y).
