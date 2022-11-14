--QUERY SELECT

--1- Selezionare tutte le software house americane (3)

--SELECT *
--FROM software_houses
--WHERE country = 'United States';

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)

--SELECT *
--FROM players
--WHERE city = 'Rogahnland';

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)

--SELECT *
--FROM players
--WHERE name LIKE '%a';

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

--SELECT *
--FROM reviews
--WHERE player_id = 800;

--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)

--SELECT *
--FROM tournaments
--WHERE [year] = 2015;

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

--SELECT *
--FROM awards
--WHERE description LIKE '%facere%';

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG),
--mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)

--SELECT videogame_id
--FROM category_videogame
--WHERE category_id = 2
--OR category_id = 6
--GROUP BY videogame_id;

--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

--SELECT *
--FROM reviews
--WHERE rating >= 2 AND rating <= 4;

--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)

--SELECT *
--FROM videogames
--WHERE DATEPART(year, release_date) = '2020';

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da 5 stelle, mostrandoli una sola volta (443)

--SELECT videogame_id, COUNT(videogame_id) AS counter
--FROM reviews
--WHERE rating = 5
--GROUP BY videogame_id;

--*********** BONUS ***********

--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)

--SELECT COUNT(*) AS number_of_reviews, AVG(rating) AS average_rating
--FROM reviews
--WHERE videogame_id = 412;

--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)

--SELECT COUNT(*)
--FROM videogames
--WHERE software_house_id = 1
--AND DATEPART(year, release_date) = 2018;

--QUERY CON GROUPBY

--1- Contare quante software house ci sono per ogni paese (3)

--SELECT COUNT(*) AS software_houses_per_country
--FROM software_houses
--GROUP BY country;

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)

--SELECT videogame_id, COUNT(videogame_id) AS reviews_count
--FROM reviews
--GROUP BY videogame_id;

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)

--SELECT pegi_label_id, COUNT(videogame_id) AS videogames_count
--FROM pegi_label_videogame
--GROUP BY pegi_label_id
--ORDER BY pegi_label_id ASC

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)

--SELECT DATEPART(year, release_date) AS [year], COUNT(id) AS videogames_count
--FROM videogames
--GROUP BY DATEPART(year, release_date);

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)

--SELECT device_id, COUNT(videogame_id) AS videogames_count
--FROM device_videogame
--GROUP BY device_id

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)

--SELECT videogame_id, AVG(rating) AS average_rating
--FROM reviews
--GROUP BY videogame_id
--ORDER BY average_rating DESC

--QUERY CON JOIN

--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)

--SELECT player_id, name, lastname, nickname, city, COUNT(player_id) AS review_count
--FROM reviews
--INNER JOIN players ON players.id = player_id
--GROUP BY player_id, name, lastname, nickname, city;

--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)

--SELECT [year], videogame_id
--FROM tournaments
--INNER JOIN tournament_videogame ON tournaments.id = tournament_videogame.tournament_id
--WHERE [year] = 2016
--GROUP BY [year], videogame_id;

--3- Mostrare le categorie di ogni videogioco (1718)

--SELECT videogames.name AS videogame, categories.name AS category
--FROM videogames
--INNER JOIN category_videogame ON videogame_id = videogames.id
--INNER JOIN categories ON category_id = categories.id;

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)

--SELECT software_houses.name AS software_house_name, software_houses.tax_id, software_houses.city, COUNT(videogames.id) AS videogames_count
--FROM software_houses
--INNER JOIN videogames ON software_houses.id = videogames.software_house_id
--WHERE DATEPART(year, videogames.release_date) > 2020
--GROUP BY software_houses.name, software_houses.tax_id, software_houses.city

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)

--SELECT software_houses.name AS software_house_name, awards.name AS award_name
--FROM software_houses
--INNER JOIN videogames ON software_houses.id = videogames.software_house_id
--INNER JOIN award_videogame ON videogames.id = videogame_id
--INNER JOIN awards ON award_id = awards.id
--ORDER BY software_houses.name

--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle,
--mostrandole una sola volta (3363)

--SELECT videogames.name AS videogame_name, categories.name AS category, pegi_labels.name AS pegi_label
--FROM videogames
--INNER JOIN category_videogame ON videogames.id = category_videogame.videogame_id
--INNER JOIN categories ON category_videogame.category_id = categories.id
--INNER JOIN pegi_label_videogame ON videogames.id = pegi_label_videogame.videogame_id
--INNER JOIN pegi_labels ON pegi_label_videogame.pegi_label_id = pegi_labels.id
--INNER JOIN reviews ON videogames.id = reviews.videogame_id
--WHERE reviews.rating = 4 OR reviews.rating = 5
--GROUP BY videogames.name, categories.name, pegi_labels.name
--ORDER BY videogames.name

--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)

--SELECT DISTINCT tournaments.name AS tournament_name, players.name AS player_name, videogames.name AS videogame_name
--FROM players
--INNER JOIN player_tournament ON players.id = player_tournament.player_id
--INNER JOIN tournaments ON player_tournament.player_id = tournaments.id
--INNER JOIN tournament_videogame ON tournaments.id = tournament_videogame.tournament_id
--INNER JOIN videogames ON tournament_videogame.videogame_id = videogames.id
--WHERE players.name LIKE 'S%'
--ORDER BY tournaments.name

--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)

--SELECT DISTINCT tournaments.name, tournaments.city, videogames.name, award_videogame.year, awards.name
--FROM tournaments
--INNER JOIN tournament_videogame ON tournaments.id = tournament_videogame.tournament_id
--INNER JOIN videogames ON tournament_videogame.videogame_id = videogames.id
--INNER JOIN award_videogame ON videogames.id = award_videogame.videogame_id
--INNER JOIN awards ON award_videogame.award_id = awards.id
--WHERE award_videogame.year = 2018 AND awards.name = 'Gioco dell''anno';

--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)

--SELECT players.name AS player_name, players.lastname AS player_lastname, players.nickname AS player_nickname, tournaments.name, videogames.name AS videogame, awards.name AS award, award_videogame.year AS award_year, tournaments.year AS tornament_year
--FROM tournaments
--INNER JOIN player_tournament ON tournaments.id = player_tournament.tournament_id
--INNER JOIN players ON player_tournament.player_id = players.id
--INNER JOIN tournament_videogame ON tournaments.id = tournament_videogame.tournament_id
--INNER JOIN videogames ON tournament_videogame.videogame_id = videogames.id
--INNER JOIN award_videogame ON videogames.id = award_videogame.videogame_id
--INNER JOIN awards ON award_videogame.award_id = awards.id
--WHERE award_videogame.year = 2018 AND awards.name = 'Gioco più atteso' AND tournaments.year = 2019
--ORDER BY players.name;

--*********** BONUS ***********

--10- Selezionare i dati della prima software house che ha rilasciato un gioco,
--assieme ai dati del gioco stesso (software house id : 5)

--SELECT TOP 1 software_houses.id, software_houses.name AS software_house_name, software_houses.tax_id AS software_house_tax_id, software_houses.city AS software_house_city, software_houses.country AS software_house_country, videogames.name AS videogame_name, videogames.overview AS videogame_overview, videogames.release_date AS videogame_release_date
--FROM software_houses
--INNER JOIN videogames ON videogames.software_house_id = software_houses.id
--ORDER BY videogames.release_date ASC 

--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)

--SELECT TOP 1 videogames.id, videogames.name, videogames.release_date, COUNT(reviews.id) AS reviews_count
--FROM videogames
--INNER JOIN reviews ON reviews.videogame_id = videogames.id
--GROUP BY videogames.id, videogames.name, videogames.release_date
--ORDER BY COUNT(reviews.id) DESC

--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)

--SELECT software_houses.id, software_houses.name, COUNT(software_houses.id)
--FROM  software_houses
--INNER JOIN videogames ON videogames.software_house_id = software_houses.id
--INNER JOIN award_videogame ON videogames.id = award_videogame.videogame_id
--WHERE award_videogame.year >= 2015 AND award_videogame.year <= 2016
--GROUP BY software_houses.id, software_houses.name

--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)

--SELECT DISTINCT categories.name, AVG(reviews.rating) AS average_rating
--FROM categories
--INNER JOIN category_videogame ON categories.id = category_videogame.category_id
--INNER JOIN videogames ON category_videogame.videogame_id = videogames.id
--INNER JOIN reviews ON videogames.id = reviews.videogame_id
--WHERE reviews.rating <= 1.5
--GROUP BY categories.name