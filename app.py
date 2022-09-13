# IMPORTS
from flask import (
	Flask,
	render_template,
	request,
	session,
	url_for
	)
from flask_mysqldb import MySQL, MySQLdb
import bcrypt

# INITIALIZE
app = Flask(__name__)
sql = MySQL(app)

# DATABASE
app.secret_key = "notsecret"
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "name"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

# ROUTING
@app.route("/home")
def home():
	at_home = True
	is_authenticated = True
	return render_template("home.html", home=at_home, hoth=is_authenticated)

@app.route("/dash")
def dash():
	is_authenticated = True
	return render_template("dash.html", auth=is_authenticated)

# @app.route("/dash/inventory")
# @app.route("/dash/purchasing")
# @app.route("/dash/sales")

# ERROR ROUTES
@app.errorhandler(404)	# invalid url
def page_not_found(error):
	return render_template("error/404.html"), 404

@app.errorhandler(500) # internal server
def server_down(error):
	return render_template("error/500.html"), 500

# RUN
if __name__ == "__main__":
	app.run(debug=True)
