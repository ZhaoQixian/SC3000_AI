% Facts
competitor(sumsum, appy).
developed_smart_phone(sumsum, galactica_s3).
steal(stevey, galactica_s3).
boss(stevey, appy).
smart_phone_technology(galactica_s3).

% Rules
business(T) :-
    smart_phone_technology(T).

unethical(X) :-
    boss(X, C),
    steal(X, T),
    developed_smart_phone(Y, T),
    competitor(Y, C),
    business(T).

rival(Y, C) :-
    competitor(Y, C).

% Query
% ?- [ 'absolute path' ].
% ?- unethical(stevey).