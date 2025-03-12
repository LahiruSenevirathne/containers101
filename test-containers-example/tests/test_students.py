import os
import pytest
from testcontainers.postgres import PostgresContainer
import time

from students import students

postgres = PostgresContainer("postgres:16-alpine")


@pytest.fixture(scope="module", autouse=True)
def setup(request):
  postgres.start()

  def remove_container():
      postgres.stop()

  request.addfinalizer(remove_container)
  os.environ["DB_CONN"] = postgres.get_connection_url()
  os.environ["DB_HOST"] = postgres.get_container_host_ip()
  os.environ["DB_PORT"] = postgres.get_exposed_port(5432)
  os.environ["DB_USERNAME"] = postgres.username
  os.environ["DB_PASSWORD"] = postgres.password
  os.environ["DB_NAME"] = postgres.dbname
  students.create_table()


@pytest.fixture(scope="function", autouse=True)
def setup_data():
  students.delete_all_students()


def test_get_all_students():
  time.sleep(10)
  students.create_student("Benjamin", "benjamin@gmail.com", "Male")
  students.create_student("Max", "max@gmail.com", "Male")
  students_list = students.get_all_students()
  assert len(students_list) == 2


def test_get_student_by_email():
  students.create_student("John", "john@gmail.com", "Male")
  student = students.get_student_by_email("john@gmail.com")
  assert student.name == "John"
  assert student.email == "john@gmail.com"
  assert student.gender == "Male"