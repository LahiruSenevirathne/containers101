from db.connection import get_connection

class Student:
  def __init__(self, student_id, name, email, gender):
    self.id = student_id
    self.name = name
    self.email = email
    self.gender = gender

def create_table():
  with get_connection() as conn:
    with conn.cursor() as cur:
      cur.execute("""
        CREATE TYPE gender as Enum('Male','Female');
        CREATE TABLE students (
          id serial PRIMARY KEY,
          name varchar not null,
          email varchar not null unique,
          gender GENDER
        )
        """)
      conn.commit()

def create_student(name, email, gender):
  with get_connection() as conn:
    with conn.cursor() as cur:
      cur.execute(
        "INSERT INTO students (name, email, gender) VALUES (%s, %s, %s)", (name, email, gender))
      conn.commit()


def get_all_students() -> list[Student]:
  with get_connection() as conn:
    with conn.cursor() as cur:
      cur.execute("SELECT * FROM students")
      return [(cid, name, email, gender) for cid, name, email, gender in cur]


def get_student_by_email(email) -> Student:
  with get_connection() as conn:
    with conn.cursor() as cur:
      cur.execute("SELECT id, name, email, gender FROM students WHERE email = %s", (email,))
      (sid, name, email, gender) = cur.fetchone()
      return Student(sid, name, email, gender)


def delete_all_students():
  with get_connection() as conn:
    with conn.cursor() as cur:
      cur.execute("DELETE FROM students")
      conn.commit()