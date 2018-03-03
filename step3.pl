%% -*- mode: prolog -*-
%% file: step3.pl
%% 2018 - iomonad <me@trosa.io>

%% Un brave peon est sur le bord d’une rivière en compagnie de sa chèvre, son loup,
%% et un chou. Il n’a qu’une barque maigrelette pour traverser la rivière, et cette
%% barque ne peut supporter que deux êtres/objets à la fois. Evidemment, il faut
%% toujours quelqu’un capable de ramer pour faire avancer la barque.
%% A cela s’ajoute la dure loi de la nature: il ne peut pas laisser la chèvre et
%% le chou ensemble sans surveillance (la chèvre mangerait le chou), ni laisser
%% la chèvre avec le loup (la chèvre mangerait le loup - quoi, vous avez pas vu
%% BlackSheep ?).

% Regles de base:
% chevre + loup -> impossible
% chevre + chou -> impossible

% cc
swap(gauche, droite).
swap(droite, gauche).

se_mouvoir([X, Loup, X, Chou], chevre,[Y, Loup, Y, Chou]) :-
	swap(X, Y). % ------------------------------------------ %
se_mouvoir([X, X, Chevre, Chou], loup, [Y, Y, Chevre, Chou]) :-
	swap(X, Y). % ------------------------------------------ %
se_mouvoir([X, Loup, Chevre, X], chou,[Y, Loup, Chevre, Y]) :-
	swap(X, Y). % ------------------------------------------ %
se_mouvoir([X, Loup, Chevre, Chou], peon_solo, [Y, Loup, Chevre, Chou]) :-
	swap(X, Y). % ------------------------------------------ %

% Positions possibles
coexists(X, X, _).
coexists(X, _, X).

% Set de positions viables
pas_de_carnage([Peon, Loup, Chevre, Chou]) :-
	coexists(Peon, Chevre, Loup),
	coexists(Peon, Chevre, Chou).

% Etapes de la scene 🤔
steps([droite, droite, droite, droite], []).
steps(Berge, [Deplacement | ProchainDeplacements]) :-
	se_mouvoir(Berge, Deplacement, ProchainMouvement), % Execute le mouvement
	pas_de_carnage(ProchainMouvement), % Determine un mouvement viable
	steps(ProchainMouvement, ProchainDeplacements). % as-tu vu la recursive ?

% Display solution
solution :-
	length(Deplacements, 7), % Assertion
	steps([gauche, gauche, gauche, gauche], Deplacements),
	maplist(format("Deplacement: ~w~n"), Deplacements), !. % cuz design matter

%% ?- solution.
%% Deplacement: chevre
%% Deplacement: peon_solo
%% Deplacement: loup
%% Deplacement: chevre
%% Deplacement: chou
%% Deplacement: peon_solo
%% Deplacement: chevre
%% true.
