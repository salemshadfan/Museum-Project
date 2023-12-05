from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'seckey1'  


cnx = mysql.connector.connect(
    host="127.0.0.1",
    port=3306,
    user="root",
    password="salem123",
    database="museum"  
)
cur = cnx.cursor()

@app.route('/')
def index():
    print("test")
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    
    query = "SELECT Role, is_blocked FROM users WHERE username = %s AND password = %s"
    cur.execute(query, (username, password))
    result = cur.fetchone()

    if result:
        user_role, is_blocked = result

        if is_blocked:
            flash('Your account is blocked. Please contact the administrator.')
            return redirect(url_for('index'))

        session['username'] = username
        session['role'] = user_role

        return redirect(url_for('dashboard'))
    else:
        flash('Invalid username or password.')
        return redirect(url_for('index'))

@app.route('/dashboard')
def dashboard():
    if 'role' in session:
        if session['role'] == 'admin':
            return redirect(url_for('admin_dashboard'))
        elif session['role'] == 'data_entry':
            return redirect(url_for('data_entry_dashboard'))
        elif session['role'] == 'end_user':
            return redirect(url_for('end_user_dashboard'))
    return redirect(url_for('index'))

@app.route('/admin_dashboard')
def admin_dashboard():
    if 'role' in session and session['role'] == 'admin':
        return render_template('admin_dashboard.html')
    else:
        return redirect(url_for('index'))

@app.route('/add_user', methods=['POST'])
def add_user():
    if 'role' in session and session['role'] == 'admin':
        username = request.form['username']
        password = request.form['password'] 
        role = request.form['role']
        query = "INSERT INTO users (username, password, role) VALUES (%s, %s, %s)"
        try:
            cur.execute(query, (username, password, role))
            cnx.commit()
            flash('User added successfully!') 
            return redirect(url_for('admin_dashboard'))
            
        except mysql.connector.Error as err:
            print("Error: ", err)
            flash('Error') 
            return redirect(url_for('admin_dashboard'))

    else:
        return redirect(url_for('index'))
    
@app.route('/delete_user', methods=['POST'])
def delete_user():
    if 'role' in session and session['role'] == 'admin':
        delete_username = request.form['delete_username']

        try:
            query = "DELETE FROM users WHERE username = %s"
            cur.execute(query, (delete_username,))
            cnx.commit()
            flash('User removed successfully!') 
            return redirect(url_for('admin_dashboard'))
        except mysql.connector.Error as err:
            flash("Error")
            return redirect(url_for('admin_dashboard'))
    else:
        return redirect(url_for('index'))

@app.route('/edit_user_role', methods=['POST'])
def edit_user_role():
    if 'role' in session and session['role'] == 'admin':
        username = request.form['edit_username']
        new_role = request.form['new_role']

        try:
            query = "UPDATE users SET role = %s WHERE username = %s"
            cur.execute(query, (new_role, username))
            cnx.commit()
            flash('User role updated successfully!') 
            return redirect(url_for('admin_dashboard'))
        except mysql.connector.Error as err:
            flash("Error updating role")
            return redirect(url_for('admin_dashboard'))
    else:
        return redirect(url_for('index'))

@app.route('/block_unblock_user', methods=['POST'])
def block_unblock_user():
    if 'role' in session and session['role'] == 'admin':
        username = request.form['block_username']
        action = request.form['block_status']

        try:
            if action == 'block':
                query = "UPDATE users SET is_blocked = TRUE WHERE username = %s"
            else:
                query = "UPDATE users SET is_blocked = FALSE WHERE username = %s"

            cur.execute(query, (username,))
            cnx.commit()
            flash(f'User {action}ed successfully!') 
            return redirect(url_for('admin_dashboard'))
        except mysql.connector.Error as err:
            flash("Error in updating user status")
            return redirect(url_for('admin_dashboard'))
    else:
        return redirect(url_for('index'))

@app.route('/modify_database', methods=['POST'])
def modify_database():
    if 'role' in session and session['role'] == 'admin':
        sql_query = request.form['sql_query']

        try:
            cur.execute(sql_query)
            cnx.commit()
            flash("Query executed successfully.")
        except mysql.connector.Error as err:
            flash(f"Error in database operation: {err}")

        return redirect(url_for('admin_dashboard'))
    else:
        return redirect(url_for('index'))







@app.route('/data_entry_dashboard')
def data_entry_dashboard():
    cur.execute("SELECT * FROM ART_OBJECTS")
    art_objects = cur.fetchall()
    cur.execute("SELECT * FROM PERMANENT_COLLECTION")
    permanent_collection = cur.fetchall()
    cur.execute("SELECT * FROM BORROWED")
    borrowed = cur.fetchall()
    cur.execute("SELECT * FROM EXHIBITIONS")
    exhibitions = cur.fetchall()
    cur.execute("SELECT * FROM COLLECTIONS")
    collections = cur.fetchall()
    cur.execute("SELECT * FROM OTHER_ART_OBJECTS")
    other_art_objects = cur.fetchall()
    cur.execute("SELECT * FROM PAINTING")
    paintings = cur.fetchall()
    cur.execute("SELECT * FROM sculpture_statue")
    sculptures = cur.fetchall()
 
    return render_template('data_entry_dashboard.html', art_objects=art_objects, permanent_collection = permanent_collection, borrowed=borrowed, exhibitions =exhibitions, collections = collections, paintings=paintings, sculptures=sculptures, other_art_objects=other_art_objects)

@app.route('/add_art_object', methods=['POST'])
def add_art_object():
    if request.method == 'POST':
        # Extract data from form
        id_no = request.form['id_no']
        title = request.form['title']
        artist = request.form['artist']
        year = request.form['year']
        descrip = request.form['descrip']
        type = request.form['type']
        category = request.form['category']
        origin = request.form['origin']
        epoch = request.form['epoch']
        ex_no = request.form['ex_no']
        # Add to database
        cur.execute("INSERT INTO ART_OBJECTS (Id_no, Title, Artist, Year, Descrip, Type, Category, Origin, Epoch, Ex_no) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", 
                    (id_no, title, artist, year, descrip, type, category, origin, epoch, ex_no))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))


@app.route('/remove_art_object/<int:id_no>', methods=['POST'])
def remove_art_object(id_no):
    cur.execute("DELETE FROM ART_OBJECTS WHERE Id_no = %s", (id_no,))
    cnx.commit()
    return redirect(url_for('data_entry_dashboard'))

@app.route('/modify_art_object/<int:id_no>', methods=['POST'])
def modify_art_object(id_no):
    if request.method == 'POST':
        # Extract data from form
        data = (
            request.form['title'],
            request.form['artist'],
            request.form['year'],
            request.form['descrip'],
            request.form['type'],
            request.form['category'],
            request.form['origin'],
            request.form['epoch'],
            request.form['ex_no'],
            id_no
        )
        cur.execute("UPDATE ART_OBJECTS SET Title=%s, Artist=%s, Year=%s, Descrip=%s, Type=%s, Category=%s, Origin=%s, Epoch=%s, Ex_no=%s WHERE Id_no=%s", data)
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))

@app.route('/remove_permanent_item/<int:id_no>', methods=['POST'])
def remove_permanent_collection(id_no):
    cur.execute("DELETE FROM PERMANENT_COLLECTION WHERE Id_no = %s", (id_no,))
    cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/modify_permanent_item/<int:id_no>', methods=['POST'])
def modify_permanent_item(id_no):
    if request.method == 'POST':
        cost = request.form['cost']
        date_acquired = request.form['date_acquired']
        status = request.form['status']
        cur.execute("UPDATE PERMANENT_COLLECTION SET Cost=%s, Date_acquired=%s, Status=%s WHERE Id_no=%s", 
                    (cost, date_acquired, status, id_no))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
    
@app.route('/remove_borrowed_item/<int:id_no>', methods=['POST'])
def remove_borrowed_item(id_no):
    cur.execute("DELETE FROM BORROWED WHERE Id_no = %s", (id_no,))
    cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/modify_borrowed_item/<int:id_no>', methods=['POST'])
def modify_borrowed_item(id_no):
    if request.method == 'POST':
        borrowed_from = request.form['borrowed_from']
        date_borrowed = request.form['date_borrowed']
        date_returned = request.form['date_returned']
        cur.execute("UPDATE BORROWED SET Borrowed_from=%s, Date_borrowed=%s, Date_returned=%s WHERE Id_no=%s", 
                    (borrowed_from, date_borrowed, date_returned, id_no))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))


@app.route('/add_exhibition', methods=['POST'])
def add_exhibition():
    if request.method == 'POST':
        ex_no = request.form['ex_no']
        name = request.form['name']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        cur.execute("INSERT INTO EXHIBITIONS (Ex_no, Name, Start_date, End_date) VALUES (%s, %s, %s, %s)", 
                    (ex_no, name, start_date, end_date))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/remove_exhibition/<int:ex_no>', methods=['POST'])
def remove_exhibition(ex_no):
    cur.execute("DELETE FROM EXHIBITIONS WHERE Ex_no = %s", (ex_no,))
    cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/modify_exhibition/<int:ex_no>', methods=['POST'])
def modify_exhibition(ex_no):
    if request.method == 'POST':
        name = request.form['name']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        cur.execute("UPDATE EXHIBITIONS SET Name=%s, Start_date=%s, End_date=%s WHERE Ex_no=%s", 
                    (name, start_date, end_date, ex_no))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))

@app.route('/add_collection', methods=['POST'])
def add_collection():
    if request.method == 'POST':
        col_id = request.form['col_id']
        name = request.form['name']
        type = request.form['type']
        description = request.form['description']
        address = request.form['address']
        phone = request.form['phone']
        contact_person = request.form['contact_person']
        cur.execute("INSERT INTO COLLECTIONS (Col_id, Name, Type, Description, Address, Phone, Contact_person) VALUES (%s, %s, %s, %s, %s, %s, %s)", 
                    (col_id, name, type, description, address, phone, contact_person))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/remove_collection/<int:col_id>', methods=['POST'])
def remove_collection(col_id):
    cur.execute("DELETE FROM COLLECTIONS WHERE Col_id = %s", (col_id,))
    cnx.commit()
    return redirect(url_for('data_entry_dashboard'))
@app.route('/modify_collection/<int:col_id>', methods=['POST'])
def modify_collection(col_id):
    if request.method == 'POST':
        name = request.form['name']
        type = request.form['type']
        description = request.form['description']
        address = request.form['address']
        phone = request.form['phone']
        contact_person = request.form['contact_person']
        cur.execute("UPDATE COLLECTIONS SET Name=%s, Type=%s, Description=%s, Address=%s, Phone=%s, Contact_person=%s WHERE Col_id=%s", 
                    (name, type, description, address, phone, contact_person, col_id))
        cnx.commit()
    return redirect(url_for('data_entry_dashboard'))

@app.route('/modify_other_art_object/<int:id_no>', methods=['POST'])
def modify_other_art_object(id_no):
    if request.method == 'POST':
        type = request.form['type']
        style = request.form['style']
        try:
            cur.execute("UPDATE OTHER_ART_OBJECTS SET Type=%s, Style=%s WHERE Id_no=%s", 
                        (type, style, id_no))
            cnx.commit()
        except Exception as e:
            print("Error occurred:", e)

    return redirect(url_for('data_entry_dashboard'))
@app.route('/remove_other_art_object/<int:id_no>', methods=['POST'])
def remove_other_art_object(id_no):
    try:
        cur.execute("DELETE FROM OTHER_ART_OBJECTS WHERE Id_no = %s", (id_no,))
        cnx.commit()
    except Exception as e:
        print("Error occurred:", e)
    return redirect(url_for('data_entry_dashboard'))

@app.route('/modify_painting/<int:id_no>', methods=['POST'])
def modify_painting(id_no):
    if request.method == 'POST':
        paint_type = request.form['paint']
        drawn_on = request.form['drawn']
        style = request.form['style']
        try:
            cur.execute("UPDATE PAINTING SET Paint_type=%s, Drawn_on=%s, Style=%s WHERE Id_no=%s", 
                        (paint_type, drawn_on, style, id_no))
            cnx.commit()
        except Exception as e:
            print("Error occurred:", e)
    return redirect(url_for('data_entry_dashboard'))
@app.route('/remove_painting/<int:id_no>', methods=['POST'])
def remove_painting(id_no):
    try:
        cur.execute("DELETE FROM PAINTING WHERE Id_no = %s", (id_no,))
        cnx.commit()
    except Exception as e:
        print("Error occurred:", e)
    return redirect(url_for('data_entry_dashboard'))

@app.route('/modify_sculpture/<int:id_no>', methods=['POST'])
def modify_sculpture(id_no):
    if request.method == 'POST':
        material = request.form['material']
        height = request.form['height']
        weight = request.form['weight']
        try:
            cur.execute("UPDATE SCULPTURE_STATUE SET Material=%s, Height=%s, Weight=%s WHERE Id_no=%s", 
                        (material, height, weight, id_no))
            cnx.commit()
        except Exception as e:
            print("Error occurred:", e)
    return redirect(url_for('data_entry_dashboard'))
@app.route('/remove_sculpture/<int:id_no>', methods=['POST'])
def remove_sculpture(id_no):
    try:
        cur.execute("DELETE FROM SCULPTURE_STATUE WHERE Id_no = %s", (id_no,))
        cnx.commit()
    except Exception as e:
        print("Error occurred:", e)
    return redirect(url_for('data_entry_dashboard'))





@app.route('/end_user_dashboard')
def end_user_dashboard():
    if 'role' in session and session['role'] == 'end_user':
        cur = cnx.cursor(dictionary=True)  
        cur.execute("SELECT * FROM ART_OBJECTS")
        art_objects = cur.fetchall()
        cur.execute("SELECT * FROM EXHIBITIONS")
        exhibitions = cur.fetchall()
        cur.execute("SELECT * FROM COLLECTIONS")
        collections = cur.fetchall()
        return render_template('end_user_dashboard.html', art_objects=art_objects, exhibitions=exhibitions, collections=collections)
    else:
        return redirect(url_for('index'))

    


if __name__ == '__main__':
    app.run(debug=True)
