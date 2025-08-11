DROP DATABASE IF EXISTS GalaxyCinema;

CREATE DATABASE GalaxyCinema;
USE GalaxyCinema;

-- 1. TABLE CREATION
CREATE TABLE film (
	id INTEGER AUTO_INCREMENT,
    film_name VARCHAR(50) NOT NULL,
    length_min INTEGER NOT NULL,
    genre VARCHAR(25) NOT NULL,
    country CHAR(2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT ck_film_length_min CHECK (length_min > 0)
);

CREATE TABLE room (
	id INTEGER AUTO_INCREMENT,
    room_name VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE customer (
	id INTEGER AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    phone CHAR(10),
    PRIMARY KEY(id)
);

CREATE TABLE screening (
	id INTEGER AUTO_INCREMENT,
    film_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_screening_film_id FOREIGN KEY (film_id) REFERENCES film (id), 
    CONSTRAINT fk_screening_room_id FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE booking (
	id INTEGER AUTO_INCREMENT,
    customer_id INTEGER NOT NULL,
    screening_id INTEGER NOT NULL,
    booking_time DATETIME NOT NULL,
    total INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_booking_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id), 
    CONSTRAINT fk_booking_screening_id FOREIGN KEY (screening_id) REFERENCES screening (id),
    CONSTRAINT ck_booking_total CHECK (total >= 0)
);

CREATE TABLE seat (
	id INTEGER AUTO_INCREMENT,
    room_id INTEGER NOT NULL,
    row_char CHAR(1) NOT NULL,
    col_number INTEGER NOT NULL,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_seat_room_id FOREIGN KEY (room_id) REFERENCES room (id),
    CONSTRAINT uq1_seat UNIQUE(room_id, row_char, col_number),
    CONSTRAINT uq2_seat UNIQUE(room_id, x, y)
);

CREATE TABLE reserved_seat (
	id INTEGER AUTO_INCREMENT,
    booking_id INTEGER NOT NULL,
    seat_id INTEGER NOT NULL,
    price INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_reserved_seat_booking_id FOREIGN KEY (booking_id) REFERENCES booking (id),
    CONSTRAINT fk_reserved_seat_seat_id FOREIGN KEY (seat_id) REFERENCES seat (id),
    CONSTRAINT uq1_reserved_seat UNIQUE(booking_id, seat_id),
    CONSTRAINT ck_reserved_seat_price CHECK (price >= 0)
);

-- 2. DATA INSERTION
INSERT INTO film VALUES
(1, 'Movie A',  120, 'Comedy', 'VN'),
(2, 'Movie B',  125, 'Horror', 'AU'),
(3, 'Movie C',  162, 'Horror', 'JP');

INSERT INTO room VALUES
(1, 'Threater A'),
(2, 'Threater B'),
(3, 'Threater C');

INSERT INTO customer VALUES
('1', 'Leslie', 1234567890),
('2', 'Noah', 1234567890),
('3', 'Ivy', 1234567890),
('4', 'Jayden', 1234567890),
('5', 'Johnathan', 1234567890);

INSERT INTO screening VALUES
('1', '3', '2', '2025-10-10 10:00:00'),
('2', '2', '1', '2025-10-11 8:00:00'),
('3', '2', '1', '2025-10-12 9:00:00'),
('4', '1', '3', '2025-10-13 18:00:00');

INSERT INTO booking VALUES
('1', '1', '2', '2025-10-10 8:30:00', 10),
('2', '1', '3', '2025-10-8 10:10:00', 10),
('3', '3', '4', '2025-10-11 13:53:00', 10),
('4', '4', '4', '2025-10-12 9:32:00', 10);

INSERT INTO seat VALUES
('1', '1', 'A', 1, 1, 1),
('2', '1', 'A', 5, 1, 3),
('3', '2', 'G', 4, 1, 1),
('4', '3', 'F', 6, 2, 1),
('5', '3', 'F', 7, 3, 1);

INSERT INTO reserved_seat VALUES
('1', '1', '1', 5),
('2', '2', '2', 5),
('3', '3', '4', 5),
('4', '3', '3', 5),
('5', '4', '5', 5);