% ------------------------------
% Declare dead/1 as dynamic so that it exists even if no clauses are defined.
% ------------------------------
:- dynamic dead/1.

% ------------------------------
% Facts: Parent-child relationships
% ------------------------------
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

% ------------------------------
% Facts: Gender definitions
% ------------------------------
male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% ------------------------------
% Facts: Numeric birth order
% Lower numbers indicate earlier birth.
% ------------------------------
birth_order(prince_charles, 1).
birth_order(princess_ann, 2).
birth_order(prince_andrew, 3).
birth_order(prince_edward, 4).

% ------------------------------
% Life Status
% ------------------------------
% For example, to declare Prince Andrew as deceased, you would uncomment the line below:
% dead(prince_andrew).
%
% If no fact for dead/1 exists, then \+ dead(X) succeeds.
alive(X) :-
    \+ dead(X).

% ------------------------------
% Eligible Succession Members
% ------------------------------
% Only living children of a given Parent are considered in the succession.
succession_member(Parent, Child) :-
    parent(Parent, Child),
    alive(Child).

% ------------------------------
% Line of Succession: Scalable Version
% ------------------------------
% The old succession rule states that:
%   1. All living male heirs come first (ordered by birth order).
%   2. Then, all living female heirs follow (ordered by birth order).
%
% This predicate finds all living children of Parent, groups them by gender,
% sorts each group by numeric birth order, and then appends the male list before
% the female list.
old_succession_rule(Parent, Succession) :-
    % Collect all living male heirs with their birth order as Key-Value pairs.
    findall(Order-Child,
            ( succession_member(Parent, Child),
              birth_order(Child, Order),
              male(Child) ),
            MalePairs),
    % Collect all living female heirs with their birth order.
    findall(Order-Child,
            ( succession_member(Parent, Child),
              birth_order(Child, Order),
              female(Child) ),
            FemalePairs),
    % Sort each group by the numeric birth order.
    keysort(MalePairs, SortedMalePairs),
    keysort(FemalePairs, SortedFemalePairs),
    % Extract the children from the sorted pairs.
    extract_children(SortedMalePairs, SortedMales),
    extract_children(SortedFemalePairs, SortedFemales),
    % Append the male heirs first, then female heirs.
    append(SortedMales, SortedFemales, Succession).

% Helper predicate: extract the children (values) from a list of Key-Value pairs.
extract_children([], []).
extract_children([_-Child|RestPairs], [Child|RestChildren]) :-
    extract_children(RestPairs, RestChildren).

% ------------------------------
% Example Queries:
% ------------------------------
% To get the current line of succession for Queen Elizabeth:
% ?- old_succession_rule(queen_elizabeth, Succession).  
%
% To simulate a death when prolog is running, you can add a fact:
% ?- assert(dead(prince_andrew)).
% Then, querying the line of succession will exclude prince_andrew.
