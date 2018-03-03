%% -*- mode: prolog -*-
%% file: step2.pl
%% 2018 - iomonad <me@trosa.io>

:-style_check(-singleton).

% Resolution d'un integramme:

%% Il y a cinq maisons de cinq couleurs différentes, alignées le long d’une route.
%% Dans chacune de ces maisons, vit une personne de nationalité différente.
%% Chacune de ces personnes boit une boisson différente, fume un cigare différent
%% et a un animal domestique différent.
%% - L’Anglais vit dans la maison rouge.
%% - Le Suédois a des chiens.
%% - Le Danois boit du thé.
%% - La maison verte est à gauche de la maison blanche.
%% - Le propriétaire de la maison verte boit du café.
%% - La personne qui fume des Pall Mall a des oiseaux.
%% - Le propriétaire de la maison jaune fume des Dunhill.
%% - La personne qui vit dans la maison du centre boit du lait.
%% - Le Norvégien habite dans la première maison.
%% - L’homme qui fume des Blend vit à côté de celui qui a des chats.
%% - L’homme qui a un cheval est le voisin de celui qui fume des Dunhill.
%% - Le propriétaire qui fume des Blue Master boit de la bière.
%% - L’Allemand fume des prince.
%% - Le Norvégien vit juste à côté de la maison bleue.
%% - L’homme qui fume des Blend a un voisin qui boit de l’eau.
%% Question : Qui a le poisson ?

%% La solution la plus simple est d’avoir une liste de maisons, chacune
%% de ces maisons contenant des variables représentant les différentes
%% caractéristiques d’une maison. Le règle générale qui cherche la
%% solution essaira ainsi d’unifier à chacune de ces variables les
%% indices qu’on lui donne. L’idée c’est "j’ai une liste de maisons
%% telle qu’un de ses éléments a telle et telle caractéristique, un
%% autre de ses éléments a telle et telle caractéristique, etc."

% Dans un premier temps, nous allons creer un structure categorisant
% les informations sur chaques habitants.
personnes(0, []) :- !. % Exemple de guarde par default | Indexage de 0 a N

% Note: http://www.swi-prolog.org/pldoc/doc_for?object=!/0
% Creation d'une liste a index.
% Pour chaques nouvelles connaissances, un index est different.
personnes(N, [(Nationalite, Couleur, Boisson, Cigarettes, Animal) | T]) :- NM1 is N-1, personnes(NM1,T).

% Le premier prédicat, doit se terminer lorsque l'index est 0 et la liste est vide.
% Et le second crée une liste récursive avec l'élément N. Ensuite,
% j'avais besoin d'un prédicat pour obtenir le Nième élément
% s'il correspond à certaines informations de la liste récursive:
personne(1, [H | _], H) :- !.
personne(N, [_ | T], R) :- N1 is N-1, personne(N1, T, R).

% Une fois notre model cree il nous reste plus
% qu'a declarer nos set de connaissances.

% L’Anglais vit dans la maison rouge.
set1([(anglais, rouge, _, _, _) | _]).
set1([_ | T]) :- set1(T).

% Le Suédois a des chiens.
set2([(suedois, _, _, _, chiens) | _]).
set2([_ | T]) :- set2(T).

% Le Danois boit du thé.
set3([(danois, _, the, _, _) | _]).
set3([_ | T]) :- set3(T).

% La maison verte est à gauche de la maison blanche
set4([(_, verte, _, _, _) , (_, blanche, _, _, _) | _]).
set4([_ | T]) :- set4(T).

% Le propriétaire de la maison verte boit du café.
set5([(_, verte, cafe, _, _) | _]).
set5([_ | T]) :- set5(T).

% La personne qui fume des Pall Mall a des oiseaux.
set6([(_, _, _, pallmall, oiseaux) | _]).
set6([_ | T]) :- set6(T).

% Le propriétaire de la maison jaune fume des Dunhill.
set7([(_, jaune, _, dunhill, _) | _]).
set7([_ | T]) :- set7(T).

% La personne qui vit dans la maison du centre boit du lait.
set8(Personnes) :- personne(3, Personnes, (_, _, lait, _, _)).

% Le Norvégien habite dans la première maison.
set9(Personnes) :- personne(1, Personnes, (norvegien, _, _, _, _)).

% L’homme qui fume des Blend vit à côté de celui qui a des chats.
set10([(_, _, _, blend, _) , (_, _, _, _, chat) | _]).
set10([(_, _, _, _, chat) , (_, _, _, blend, _) | _]). % Ne pos oublier de set les doubles correspondances
set10([_ | T]) :- set10(T).

% L’homme qui a un cheval est le voisin de celui qui fume des Dunhill.
set11([(_, _, _, _, cheval) , (_, _, _, dunhill, _) | _]).
set11([(_, _, _, dunhill, _) , (_, _, _, _, cheval) | _]).
set11([_ | T]) :- set11(T).

% Le propriétaire qui fume des Blue Master boit de la bière.
set12([(_, _, bierre, bluemaster, _) | _]).
set12([_ | T]) :- set12(T).

% L’Allemand fume des prince.
set13([(allemand, _, _, prince, _) | _]).
set13([_ | T]) :- set13(T).

% Le Norvégien vit juste à côté de la maison bleue.
set14([(norvegien, _, _, _, _) , (_, bleu, _, _, _) | _]).
set14([(_, bleu, _, _, _) , (norvegien, _, _, _, _) | _]).
set14([_ | T]) :- set14(T).

% L’homme qui fume des Blend a un voisin qui boit de l’eau.
set15([(_, _, _, blend, _) , (_, _, eau, _, _) | _]).
set15([(_, _, eau, _, _) , (_, _, _, blend, _) | _]).
set15([_ | T]) :- set15(T).

% Une fois les set determine, nous sommes en mesure de determiner
% la question:
qui_a_le_poisson([(_, _, _, _, poisson) | _]).
qui_a_le_poisson([ _ | T]) :- qui_a_le_poisson(T).

% Passons alors a la resolution:
solution(Personnes) :-
	personnes(5, Personnes), % On sait qu'il y'a 5 habitants
	set1(Personnes),
	set2(Personnes),
	set3(Personnes),
	set4(Personnes),
	set5(Personnes),
	set6(Personnes),
	set7(Personnes),
	set8(Personnes),
	set9(Personnes),
	set10(Personnes),
	set11(Personnes),
	set12(Personnes),
	set13(Personnes),
	set14(Personnes),
	set15(Personnes),
	qui_a_le_poisson(Personnes).

%% solution(Set) %% -> Allemand
