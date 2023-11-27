from flask import Flask, render_template, request, jsonify
import psycopg2 as pg

app = Flask(__name__)

# Connect to the PostgreSQL database
conn = pg.connect(
    dbname='postgres',
    user='postgres',
    password='admin',
    host='127.0.0.1',
    port='5432'
)

@app.route('/fetch_course_details', methods=['GET'])
def fetch_course_details():
    course_input = request.args.get('course_input')

    cur = conn.cursor()

    # Fetch course details based on the user input
    cur.execute("""
        SELECT course.course_title, review.professor, review.rating, review.review_text
        FROM course
        LEFT JOIN review ON course.id = review.course_id
        WHERE course.course_number = %s
    """, (course_input,))
    
    course_details = cur.fetchall()

    cur.close()

    # Process fetched data and prepare the response
    if course_details:
        course_title, professor, rating, review_text = course_details[0]  # Assuming a single row is returned
        course_info = {
            'course_title': course_title,
            'professor': professor,
            'rating': rating,
            'review_text': review_text
        }
        return jsonify(course_info)
    else:
        return jsonify({'error': 'Course details not found'})

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        cur = conn.cursor()

        # Query to check user credentials
        cur.execute("SELECT * FROM users WHERE email = %s AND password = %s", (email, password))
        user = cur.fetchone()

        cur.close()

        if user:
            # Successful login, redirect to 'HawkEyeReviews.html' page
            return redirect(url_for('landing_page'))  # Ensure 'landing_page' matches your route

        else:
            return "Invalid credentials. Please try again."

    return render_template('Login.html')

@app.route('/HawkEyeReviews.html')
def landing_page():
    return render_template('HawkEyeReviews.html')

if __name__ == '__main__':
    app.run(debug=True)