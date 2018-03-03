%% -*- mode: prolog -*-
%% file: step1.pl
%% 2018 - iomonad <me@trosa.io>

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
