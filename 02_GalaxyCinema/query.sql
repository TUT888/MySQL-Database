USE cinema;

-- 1. Show film over 100 mins
SELECT * 
FROM film
WHERE length_min > 100;

-- 2. Which film over average length of all films
SELECT *
FROM film
WHERE length_min > (
	SELECT AVG(length_min)
    FROM film
);

-- 3. Which film has name start with letter 't'
SELECT * 
FROM film
WHERE name LIKE 't%';

-- 4. Which film contain letter 'a'
SELECT * 
FROM film
WHERE name LIKE '%a%';

-- 5. How many film in US?
SELECT * 
FROM film
WHERE country_code = 'US';

-- 6. What is the longest, and shortest length of all film
SELECT MAX(length_min), MIN(length_min) 
FROM film;

-- 7. Show unique film types of all film (NO DUPLICATE)
SELECT DISTINCT(type)
FROM film;

-- 8. What is the distance (in days) of the 1st and the last film
SELECT film_id, DATEDIFF(MAX(start_time), MIN(start_time)) AS distance_in_day
FROM screening
GROUP BY film_id;

-- 9. Show all Screening Information including film name, room name, time of film "Tom&Jerry"
SELECT f.name, r.name, s.start_time
FROM screening AS s
JOIN (SELECT id, name FROM film WHERE name LIKE '%Tom&Jerry%') AS f 
ON s.film_id = f.id
JOIN (SELECT id, name FROM room) AS r 
ON s.room_id = r.id;

-- 10. Show all screening in 2 day '2022-05-24' and '2022-05-25'
SELECT *
FROM screening
WHERE DATE(start_time) = '2022-05-24' OR DATE(start_time) = '2022-05-25';

-- Show film which dont have any screening
SELECT *
FROM film AS f
LEFT JOIN screening AS s ON f.id = s.film_id 
WHERE s.film_id IS NULL;

-- 11. Who book more than 1 seat in 1 booking
-- SELECT first_name, last_name, booking_id, count_seat
-- FROM (SELECT booking.id, first_name, last_name FROM booking, customer WHERE booking.customer_id = customer.id) AS b, 
-- 	(SELECT booking_id, COUNT(seat_id) as count_seat FROM reserved_seat GROUP BY booking_id HAVING count_seat > 1) AS s
-- WHERE s.booking_id = b.id;

SELECT first_name, last_name, booking_id, count_seat
FROM (SELECT booking.id, first_name, last_name FROM booking, customer WHERE booking.customer_id = customer.id) AS b
JOIN (SELECT booking_id, COUNT(seat_id) as count_seat FROM reserved_seat GROUP BY booking_id HAVING count_seat > 1) AS s
ON s.booking_id = b.id;

-- 12. Show room show more than 2 film in one day
SELECT r.*, s.count_film
FROM room AS r
JOIN (SELECT room_id, COUNT(film_id) AS count_film
	FROM screening
	GROUP BY room_id
	HAVING count_film > 2) AS s
ON r.id = s.room_id;

-- 13. Which room show the least film ?
-- SELECT r.*, s.count_film
-- FROM room AS r
-- JOIN (SELECT room_id, COUNT(film_id) AS count_film 
-- 	FROM screening GROUP BY room_id) AS s 
-- ON r.id = s.room_id
-- WHERE count_film = (
-- 	SELECT MIN(count_film)
-- 	FROM (SELECT COUNT(film_id) AS count_film
-- 		FROM screening
-- 		GROUP BY room_id) AS S
-- );

WITH count_tb AS (SELECT room_id, COUNT(film_id) AS count_film
				FROM screening
				GROUP BY room_id),
	min_tb AS (SELECT MIN(count_film) AS min_count
				FROM count_tb)
SELECT r.*, ctb.count_film
FROM count_tb AS ctb
JOIN min_tb AS mtb ON ctb.count_film = mtb.min_count
JOIN room AS r ON ctb.room_id = r.id;

-- 14. What film don't have booking
SELECT f.*
FROM film AS f
LEFT JOIN (
	SELECT DISTINCT(film_id)
	FROM booking, screening
	WHERE booking.screening_id = screening.id
) AS s
ON f.id = s.film_id
WHERE s.film_id IS NULL;

-- 15. What film have show the biggest number of room?
WITH count_tb AS (SELECT film_id, COUNT(room_id) AS count_room
					FROM (SELECT film_id, room_id
						FROM screening
						GROUP BY film_id, room_id) s
					GROUP BY film_id),
	max_tb AS (SELECT MAX(count_room) AS max_count
				FROM count_tb)
SELECT f.*, ctb.count_room
FROM count_tb AS ctb
JOIN max_tb AS mtb ON ctb.count_room = mtb.max_count
JOIN film AS f ON ctb.film_id = f.id;

-- 16. Show number of film that show in every day of week and order descending
SELECT WEEKDAY(start_time) AS weekday, COUNT(film_id) AS count_film
FROM screening
GROUP BY weekday
ORDER BY count_film DESC;

-- 17. Show total length of each film that showed in 28/5/2022
SELECT f.id, f.name, SUM(length_min)
FROM film AS f
JOIN (SELECT *
    FROM screening
    WHERE DATE(start_time) = '2022-05-28') AS s
ON f.id = s.film_id
GROUP BY film_id;

-- 18. What film has showing time above and below average show time of all film
WITH count_tb AS (SELECT film_id, COUNT(start_time) AS show_count
				FROM screening
				GROUP BY film_id),
	avg_tb AS (SELECT AVG(show_count) AS avg_show_count
				FROM count_tb)
SELECT f.*, ctb.show_count
FROM count_tb AS ctb
JOIN film AS f ON ctb.film_id = f.id
JOIN avg_tb AS atb ON ctb.show_count > atb.avg_show_count;

-- 19. What room have least number of seat?
WITH count_tb AS (SELECT room_id, COUNT(id) AS count_seat
					FROM seat
					GROUP BY room_id),
	min_tb AS (SELECT MIN(count_seat) AS min_seat
				FROM count_tb)
SELECT r.*, ctb.count_seat
FROM count_tb AS ctb
JOIN min_tb AS mtb ON ctb.count_seat = mtb.min_seat
JOIN room AS r ON ctb.room_id = r.id;

-- 20. what room have number of seat bigger than average number of seat of all rooms
WITH count_tb AS (SELECT room_id, COUNT(id) AS count_seat
					FROM seat
					GROUP BY room_id),
	min_tb AS (SELECT AVG(count_seat) AS avg_seat
				FROM count_tb)
SELECT r.*, ctb.count_seat
FROM count_tb AS ctb
JOIN min_tb AS mtb ON ctb.count_seat > mtb.avg_seat
JOIN room AS r ON ctb.room_id = r.id;

-- 21. Ngoai nhung seat mà Ong Dung booking duoc o booking id = 1 thi ong CÓ THỂ (CAN) booking duoc nhung seat nao khac khong?
-- 22. Show Film with total screening and order by total screening. BUT ONLY SHOW DATA OF FILM WITH TOTAL SCREENING > 10
-- 23. TOP 3 DAY OF WEEK based on total booking
-- 24. CALCULATE BOOKING rate over screening of each film ORDER BY RATES.
-- 25. CONTINUE Q15 -> WHICH film has rate over/below/equal average ?.
-- 26. TOP 2 people who enjoy the least TIME (in minutes) in the cinema based on booking info - only count who has booking info (example : Dũng book film tom&jerry 4 times -> Dũng enjoy 90 mins x 4)