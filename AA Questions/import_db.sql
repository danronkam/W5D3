DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

-- USERS -----------------------------------------------------------------------------------

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT,
  lname TEXT
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Dan', 'Kam'),
  ('Dan', 'Ram'),
  ('Dan', 'Lam');

-- QUESTIONS -----------------------------------------------------------------------------------

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT, -- title format = 'lname Question'
  body TEXT, 
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Kam Question', 'How Could You?', (SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Kam')),
  ('Lam Question', 'Who did this?', (SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Lam'));

-- QUESTION_FOLLOWS -----------------------------------------------------------------------------------

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_follows(question_id, user_id)
VALUES
    ((SELECT id FROM questions WHERE title = 'Kam Question'), (SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Kam')),
  ((SELECT id FROM questions WHERE title = 'Lam Question'), (SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Lam'));

-- REPLIES -----------------------------------------------------------------------------------

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  subject_question INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (subject_question) REFERENCES questions(id)
  FOREIGN KEY (author_id) REFERENCES users(id)
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

INSERT INTO
  replies(subject_question, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Kam Question'), NULL, (SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Ram'), 'I cant believe you''ve done this');

-- -----------------------------------------------------------------------------------

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Dan' AND lname = 'Ram'), (SELECT id FROM questions WHERE title = 'Kam Question'));