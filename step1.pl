%% -*- mode: prolog -*-
%% file: step1.pl
%% 2018 - iomonad <me@trosa.io>

% Prolog is based on the ideal of logic programming.
% A subprogram (called a predicate) represents a state of the world.
% A command (called a goal) tells Prolog to make that state of the world
%   come true, if possible.
% ~
% This is Prolog's central operation: unification. Unification is
% essentially a combination of assignment and equality! It works as
% follows:
%  If both sides are bound (ie, defined), check equality.
%  If one side is free (ie, undefined), assign to match the other side.
%  If both sides are free, the assignment is remembered. With some luck,
%    one of the two sides will eventually be bound, but this isn't
%    necessary.

% member - http://www.swi-prolog.org/pldoc/man?predicate=member/2
% The member predicate works like memberchk if both arguments are bound,
% but can accept free variables and thus can be used to loop through
% lists.

% Creation base de connaissance des femmes
femme(F) :- member(F, [anne, lisa, sylvie, julie, betty, eve, valerie]).

% -? femme(eve). %% -> true
% -? femme(karine). %% -> false
% On encore en mappant une liste:
% maplist(femme, [anne, betty, lisa, sylvie, julie, eve, valerie]). %% -> true

% Creation base connaissance des hommes.
homme(H) :- member(H, [jean, marc, jules, jacques, leon, herve, paul, luc, loic, gerard]).

% -? homme(luc). %% -> true
% -? homme(celestin). %% -> false
% maplist(homme, [jean, marc, jules, paul, loic]). %% -> true

% Generation des couples en utilisant des pseudos tuples
mari_de(H, F) :- member([H, F], [[marc, anne], [jules, lisa], [leon, sylvie], [paul, julie], [luc, betty], [loic, eve]]).

% -? mari_de(jules, lisa). %% -> true
% -? mari_de(jean, kevin). %% -> false

% Prolog est pragmatique. Il est possible de swapper les assignations
% grace aux variables. (Chaines de characteres commencant par une majuscule)
femme_de(F, H) :- mari_de(H, F).

% -? femme_de(eve, loic). %% -> true
% -? femme_de(julie, luc). %% -> false

% Ici on reseigne les enfants des peres
enfant_de(E, P) :- member([E, P], [[jean, marc], [jules, marc], [leon, marc], [jacques, jules], [herve, leon], [paul, loic], [paul, leon], [valerie, loic], [jules, luc], [lisa, luc], [leon, luc], [sylvie, luc], [loic, luc], [gerard, luc]]).
% Puis en determine la mere en utilisant le predicat mari_de
enfant_de(E, P) :- mari_de(F, P), enfant_de(E, F).

% -? enfant_de(jules, marc). %% -> true
% -? enfant_de(valerie, leon). %% -> true
% -? enfant_de(jean, luc). %% -> false

% Il est desormais possible de reutiliser les set de connaissances pour en
% faire des predicats encore plus complexes en utilisant des conditions
beaupere_de(E, BP) :- enfant_de(BP, F), mari_de(E, F), homme(BP).
beaupere_de(E, BP) :- enfant_de(BP, X), mari_de(E, X), homme(BP).

% todo ~ Fix beaupere

% Il est possible d'utiliser des lambda pour executer des
% recherches recursives
ancetre_de(A, E) :- enfant_de(E, A). % Condition simple
% Connexion des branches en inconnu
ancetre_de(A, E) :- enfant_de(E, X), ancetre_de(A, X).

% -?  ancetre_de(luc, paul). %% -> true
% -?  ancetre_de(betty, jacques). %% -> true
% -?  ancetre_de(marc, gerard). %% -> false
