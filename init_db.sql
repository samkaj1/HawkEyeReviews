-- Active: 1701096533892@@127.0.0.1@5432@postgres
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS email CASCADE;
DROP TABLE IF EXISTS password CASCADE;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) ,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) ,
    role VARCHAR(255) DEFAULT 'user'
);
CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    initials VARCHAR(255)   NOT NULL,
    course_number VARCHAR(255) NOT NULL,
    course_title VARCHAR(255) NOT NULL
);

CREATE TABLE review (       
    id SERIAL PRIMARY KEY,
    course_id INTEGER REFERENCES course(id),
    user_id INTEGER REFERENCES users(id),
    professor VARCHAR(255) NOT NULL,
    rating INTEGER NOT NULL,
    review_text TEXT NOT NULL
);

CREATE TABLE email (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    email VARCHAR(255) NOT NULL
);

CREATE TABLE password (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    password VARCHAR(255) NOT NULL
);

INSERT INTO users(name, email, password) VALUES ('Shayan', 'sbaig7@hawk.iit.edu', '12345');

INSERT INTO users(name, email, password) VALUES ('admin', 'admin', 'admin');

INSERT INTO course (initials, course_number, course_title) VALUES ('CS', '100', 'Introduction to Profession');
INSERT INTO course (initials, course_number, course_title) VALUES ('CS', '201', 'Accelerated Introduction to Computer Science');
INSERT INTO course (initials, course_number, course_title) VALUES ('CS', '450', 'Operating Systems');
INSERT INTO course (initials, course_number, course_title) VALUES ('CS', '480', 'Introduction to Artificial Intelligence');

INSERT INTO review (course_id, user_id, professor, rating, review_text) VALUES (1, 1, 'Michael Lee', 5, 'This is a review');



