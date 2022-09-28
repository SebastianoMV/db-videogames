-- Query su singola tabella

-- 1 Selezionare tutte le software house americane (3)

SELECT *
	FROM software_houses
	where country = 'united states';


-- 2  Selezionare tutti i giocatori della città di 'Rogahnland' (2)
SElECT *
FROM players
where city = 'Rogahnland';

-- 3 Selezionare tutti i giocatori il cui nome finisce per "a" (220)

select *
from players
where name like '%a';

-- 4 Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

select *
from reviews
where player_id = 800;

-- 5 Contare quanti tornei ci sono stati nell'anno 2015 (9)

select count(id)
from tournaments
where year = 2015

-- 6 Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

select *
from awards
where description like '%facere%';

-- 7 Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)

select DISTINCT  videogame_id
from category_videogame
where category_id = 2 OR category_id = 6;


-- 8 Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

select * 
from reviews
where rating >= 2 And rating <= 4

-- 9 Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)

select *
from videogames
where YEAR(release_date) = 2020;


-- 10 Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)

select DISTINCT  videogame_id
from reviews
where  rating = 5;

-- 11 Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)

select count(id), AVG(rating)
from reviews
where videogame_id = 412;

-- 12 Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)
select count(id)
from videogames
where software_house_id = 1 and YEAR(release_date) = 2018;