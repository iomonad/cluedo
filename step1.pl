%% step1.lp
%% 2018 - iomonad <me@trosa.io>

% Creation d'une base de connaissance
% oriente vers un arbre genealogique.


% Base de donne primitive.
femme(GENDER) :- member(GENDER,
						[betty, anne,
						 eve, sylvie,
						 lisa, valerie,
						 julie]).
homme(GENDER) :- member(GENDER,
						[luc, marc,
						 gerard, loic,
						 leon, jules,
						 paul, herve,
						 jacques]).

% Relation conjugales avec des tuples.
mari_de(HOMME, FEMME) :- member((HOMME, FEMME),
								[(luc, betty),
								 (marc, anne),
								 (loic, eve),
								 (leon, sylvie),
								 (jules, lisa),
								 (paul, julie)]).
% Possibilite de 'swapper' et reutiliser d'autres
% bases de connaissances.
femme_de(FEMME, HOMME) :- mari_de(HOMME, FEMME).

% Referencement supplementaire.
beaupere_de(HOMME, FEMME) :- member((HOMME, FEMME),
									[(luc, eve),
									 (luc, jules),
									 (marc, loic),
									 (leon, paul)]).
bellemere_de(HOMME, FEMME) :- member((HOMME, FEMME),
									 [(anne, sylvie),
									  (anne, lisa),
									  (betty, jules),
									  (betty, leon),
									  (sylvie, paul)]).

% Relations des enfants
enfant_de(ENFANT, PARENT) :- member([ENFANT|PARENT],
									[[jean|marc], [jules|marc],
									 [leon|marc]]).
enfant_de(ENFANT, PARENT) :- member([ENFANT|PARENT],
									[[lisa|luc], [loic|luc],
									 [gerard|luc]]).
enfant_de(ENFANT, PARENT) :- member([ENFANT|PARENT], [[jacques|jules]]).
enfant_de(ENFANT, PARENT) :- member([ENFANT|PARENT],
									[[herve|leon], [julie|leon]]).
enfant_de(ENFANT, PARENT) :- member([ENFANT|PARENT],
									[[paul|loic], [valerie|loic]]).
enfant_de(ENFANT, PARENT) :- femme(PARENT),
							 femme_de(PARENT, SUB),
							 enfant_de(ENFANT, SUB).

% Determination des ancetres
ancetre_de(ANCETRE, ENFANCETRENT) :- enfant_de(ENFANCETRENT, ANCETRE).
ancetre_de(ANCETRE, ENFANCETRENT) :- enfant_de(ENFANCETRENT, SUB),
									 ancetre_de(ANCETRE, SUB).
