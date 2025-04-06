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
% (These remain in case they are needed for other queries.)
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
% Old Succession Rule (for reference)
% Males inherit first, then females (ordered by birth order).
% ------------------------------
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

% ------------------------------
% New Succession Rule:
% The throne is passed solely according to the order of birth, irrespective of gender.
% ------------------------------
new_succession_rule(Parent, Succession) :-
    % Collect all living children with their birth order as Key-Value pairs.
    findall(Order-Child,
            ( succession_member(Parent, Child),
              birth_order(Child, Order) ),
            Pairs),
    % Sort the list by birth order.
    keysort(Pairs, SortedPairs),
    % Extract the children from the sorted pairs.
    extract_children(SortedPairs, Succession).

% Helper predicate: extract the children (values) from a list of Key-Value pairs.
extract_children([], []).
extract_children([_-Child|RestPairs], [Child|RestChildren]) :-
    extract_children(RestPairs, RestChildren).

% ------------------------------
% Example Queries:
% ------------------------------
% 1. To get the old line of succession for Queen Elizabeth:
%    ?- old_succession_rule(queen_elizabeth, Succession).
%
% 2. To simulate a death during runtime (e.g., Prince Andrew dies):
%    ?- assert(dead(prince_andrew)).
%
%    Then the respective line of succession predicates will exclude Prince Andrew.
%
% 3. To get the new line of succession (by birth order irrespective of gender):
%    ?- new_succession_rule(queen_elizabeth, NewSuccession).
