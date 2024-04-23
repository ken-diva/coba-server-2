import sqlite3
from faker import Faker
import random


# Function to generate and insert dummy data into the posts table
def populate_posts(num_records):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    # Create Faker instance
    fake = Faker()

    for _ in range(num_records):
        title = fake.sentence()
        content = fake.paragraphs(nb=3)
        author = fake.name()
        created_at = fake.date_time_between(start_date="-30d", end_date="now")

        # Insert dummy record into posts table
        cursor.execute(
            "INSERT INTO posts (title, content, author, created_at) VALUES (?, ?, ?, ?)",
            (title, "\n".join(content), author, created_at),
        )

    conn.commit()
    conn.close()


if __name__ == "__main__":
    num_records = 25
    populate_posts(num_records)
    print(f"Successfully inserted {num_records} dummy records into the database.")
