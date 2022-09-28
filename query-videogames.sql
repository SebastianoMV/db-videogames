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


-- Query con group by

-- 1 Contare quante software house ci sono per ogni paese (3)
select count(id)
from software_houses
group by country;

-- 2 Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
select count(id)
from reviews
group by videogame_id;

-- 3 Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
select COUNT(videogame_id)
from pegi_label_videogame
group by pegi_label_id;

-- 4 Mostrare il numero di videogiochi rilasciati ogni anno (11)
select COUNT(id)
from videogames
group by YEAR( release_date);

-- 5 Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
select COUNT(videogame_id)
from device_videogame
group by device_id;

-- 6 Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
select AVG(rating)
from reviews
group by videogame_id
order by AVG(rating) asc;

-- Query con join

-- 1 Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
select Distinct players.*
from players JOIN reviews ON reviews.player_id = players.id; 


-- 2 Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
select Distinct videogames.name
from videogames JOIN tournament_videogame ON videogames.id = tournament_videogame.videogame_id
	JOIN tournaments ON tournaments.id = tournament_videogame.tournament_id
where tournaments.year = 2016;


-- 3 Mostrare le categorie di ogni videogioco (1718)
select categories.*, videogames.name
from categories JOIN category_videogame on categories.id = category_videogame.category_id
	 JOIN videogames on category_videogame.videogame_id = videogames.id;

-- 4 Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
select DISTINCT software_houses.*
from software_houses join videogames on software_houses.id = videogames.software_house_id
where YEAR(videogames.release_date) > 2020;

-- 5 Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
select awards.* , videogames.name
from awards JOIN award_videogame ON awards.id = award_videogame.award_id
	JOIN videogames ON award_videogame.videogame_id = videogames.id;

-- 6 Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
select DISTINCT  categories.name , pegi_labels.name
from videogames JOIN category_videogame ON videogames.id = category_videogame.videogame_id
	JOIN categories ON categories.id = category_videogame.category_id
	JOIN pegi_label_videogame ON pegi_label_videogame.videogame_id = videogames.id
	JOIN pegi_labels ON pegi_label_videogame.pegi_label_id = pegi_labels.id
	JOIN reviews ON reviews.videogame_id = videogames.id
where reviews.rating = 4 OR reviews.rating = 5;

-- 7 Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
select DISTINCT videogames.name
from videogames JOIN tournament_videogame ON tournament_videogame.videogame_id = videogames.id
	JOIN tournaments ON tournaments.id = tournament_videogame.tournament_id
	JOIN player_tournament ON player_tournament.tournament_id = tournaments.id
	JOIN players ON player_tournament.player_id = players.id
where players.nickname like 'S%';


-- 8 Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
select tournaments.city
from tournaments JOIN tournament_videogame ON tournament_videogame.tournament_id = tournaments.id
	JOIN videogames ON tournament_videogame.videogame_id = videogames.id
	JOIN award_videogame ON award_videogame.videogame_id = videogames.id
	JOIN awards ON awards.id = award_videogame.award_id
where award_videogame.year = 2018 AND awards.id = 1;


-- 9 Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
select players.*
from players JOIN player_tournament ON players.id = player_tournament.player_id
	JOIN tournaments ON tournaments.id = player_tournament.tournament_id
	JOIN tournament_videogame ON tournament_videogame.tournament_id = tournaments.id
	JOIN videogames ON tournament_videogame.videogame_id = videogames.id
	JOIN award_videogame ON award_videogame.videogame_id = videogames.id
	JOIN awards ON awards.id = award_videogame.award_id
where awards.id = 5 AND award_videogame.year = 2018 AND tournaments.year = 2019;

-- *********** BONUS ***********

-- 10 Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
select  videogames.* , software_houses.* 
from videogames JOIN software_houses ON videogames.software_house_id = software_houses.id
where (videogames.release_date = (select min(videogames.release_date) from videogames));


-- 11 Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)



-- 12 Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)

-- 13 Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)