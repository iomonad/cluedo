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

% fonction pour swap
swap(a, b).
swap(b, a).
