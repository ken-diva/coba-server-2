from flask import Flask, render_template
import sqlite3

app = Flask(__name__)


# Function to create a connection to SQLite database
def get_db_connection():
    conn = sqlite3.connect("database.db")
    conn.row_factory = sqlite3.Row
    return conn


# Initialize the database schema (tables)
def init_db():
    conn = get_db_connection()
    with app.open_resource("schema.sql", mode="r") as f:
        conn.cursor().executescript(f.read())
    conn.commit()
    conn.close()


# Route to display data from the database
@app.route("/")
def index():
    # Initialize database schema on the first request
    if not hasattr(app, "initialized"):
        app.initialized = True
        init_db()

    conn = get_db_connection()
    posts = conn.execute("SELECT * FROM posts").fetchall()
    conn.close()
    return render_template("index.html", posts=posts)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=1444)
