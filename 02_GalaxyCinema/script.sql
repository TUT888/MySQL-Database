DROP DATABASE IF EXISTS GalaxyCinema;

CREATE DATABASE GalaxyCinema;
USE GalaxyCinema;

-- 1. TABLE CREATION
CREATE TABLE film (
	id CHAR(5),
    film_name VARCHAR(50),
    length_min INTEGER,
    genre VARCHAR(25),
    country CHAR(2),
    PRIMARY KEY(id)
);

CREATE TABLE room (
	id CHAR(4),
    room_name VARCHAR(20),
    PRIMARY KEY(id)
);

CREATE TABLE customer (
	id CHAR(4),
    customer_name VARCHAR(50),
    phone CHAR(10),
    PRIMARY KEY(id)
);

CREATE TABLE screening (booking
	id CHAR(5),
    film_id CHAR(5),
    room_id CHAR(4),
    start_time DATETIME,
    PRIMARY KEY(id),
    CONSTRAINT screening_film_id_fk FOREIGN KEY (film_id) REFERENCES film (id), 
    CONSTRAINT screening_room_id_fk FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE booking (
	id CHAR(4),
    customer_id CHAR(4),
    screening_id CHAR(5),
    booking_time DATETIME,
    total INTEGER,
    PRIMARY KEY(id),
    CONSTRAINT booking_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customer (id), 
    CONSTRAINT booking_screening_id_fk FOREIGN KEY (screening_id) REFERENCES screening (id)
);

CREATE TABLE seat (
	id CHAR(4),
    room_id CHAR(4),
    row_char CHAR(1),
    col_number INTEGER,
    x INTEGER,
    y INTEGER,
    PRIMARY KEY(id),
    CONSTRAINT seat_room_id_fk FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE reserved_seat (
	id CHAR(5),
    booking_id CHAR(4),
    seat_id CHAR(4),
    price INTEGER,
    PRIMARY KEY(id),
    CONSTRAINT reserved_seat_booking_id_fk FOREIGN KEY (booking_id) REFERENCES booking (id),
    CONSTRAINT reserved_seat_seat_id_fk FOREIGN KEY (seat_id) REFERENCES seat (id)
);

-- 2. DATA INSERTION
INSERT INTO film VALUES
('FM001', 'Movie A',  120, 'Comedy', 'VN'),
('FM002', 'Movie B',  125, 'Horror', 'AU'),
('FM003', 'Movie C',  162, 'Horror', 'JP');

INSERT INTO room VALUES
('T001', 'Threater A'),
('T002', 'Threater B'),
('T003', 'Threater C');

INSERT INTO customer VALUES
('C001', 'Leslie', 1234567890),
('C002', 'Noah', 1234567890),
('C003', 'Ivy', 1234567890),
('C004', 'Jayden', 1234567890),
('C005', 'Johnathan', 1234567890);

INSERT INTO screening VALUES
('SC001', 'FM003', 'T002', '2025-10-10 10:00:00'),
('SC002', 'FM002', 'T001', '2025-10-11 8:00:00'),
('SC003', 'FM002', 'T001', '2025-10-12 9:00:00'),
('SC004', 'FM001', 'T003', '2025-10-13 18:00:00');

INSERT INTO booking VALUES
('B001', 'C001', 'SC002', '2025-10-10 8:30:00', 10),
('B002', 'C001', 'SC003', '2025-10-8 10:10:00', 10),
('B003', 'C003', 'SC004', '2025-10-11 13:53:00', 10),
('B004', 'C004', 'SC004', '2025-10-12 9:32:00', 10);

INSERT INTO seat VALUES
('S001', 'T001', 'A', 1, 1, 1),
('S002', 'T001', 'A', 5, 1, 3),
('S003', 'T002', 'G', 4, 1, 1),
('S004', 'T003', 'F', 6, 2, 1),
('S005', 'T003', 'F', 7, 3, 1);

INSERT INTO reserved_seat VALUES
('RS001', 'B001', 'S001', 5),
('RS002', 'B002', 'S002', 5),
('RS003', 'B003', 'S004', 5),
('RS004', 'B003', 'S003', 5),
('RS005', 'B004', 'S005', 5);