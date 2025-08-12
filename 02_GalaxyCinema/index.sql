USE GalaxyCinema;

CREATE INDEX idx_film_name ON film (film_name);

SELECT * FROM film 
WHERE film_name = 'Movie B';