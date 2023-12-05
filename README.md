Museum Project
Introduction

This project involves the creation of a website connected to a MySQL database, designed to manage and display information about a museum's collections. The website is developed using Flask, a lightweight web framework in Python, and interfaces with a MySQL database to store and retrieve data. This setup is ideal for managing collections, exhibitions, and other museum-related information.


Requirements

    Python 3.x
    Flask
    MySQL

Installation

    Install Dependencies:
        Flask: A lightweight web framework for Python.
        MySQL Connector: A driver for connecting Python to a MySQL database.


pip install flask mysql-connector-python

Database Configuration:

    In main.py, update the database connection details:

    python

    mysql.connector.connect(
      host="your_host",
      user="your_username",
      password="your_password",
      database="your_database"
    )

    Change your_password to the password of your SQL server.

Running the Application:

    Navigate to the project directory and run:
    python main.py


This will start the Flask server and the website can be accessed locally.
