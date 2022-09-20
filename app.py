# IMPORTS
from flask import (Flask, flash, render_template, request, session, url_for)
from flask_mysqldb import MySQL, MySQLdb
import bcrypt


# INITIALIZATIONS
app = Flask(__name__)
sql = MySQL(app)


# CONFIGURATIONS
app.config["SECRET_KEY"] = "notsecret"
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "cs301_project_invsys"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


# ROUTES
@app.route("/home", methods=["GET", "POST"])
def home():
	at_home = True
	if request.method == "POST":
		username = request.form["username"]
		password = request.form["password"].encode("utf-8")

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM admin WHERE adm_username=%s", [username])
		adm_exist = cur.fetchone()
		cur.close

		if adm_exist is None:
			adm_exist = []

		if len(adm_exist) > 0:
			if bcrypt.hashpw(password, adm_exist["adm_password"].encode("utf-8")) == adm_exist["adm_password"].encode("utf-8"):
				session["username"] = adm_exist["adm_username"]
				session["logged_in"] = True
				flash("Logged in successfully!", "info")
				return render_template ("dash.html")
			else:
				flash("Incorrect username or password!", "error")
				return render_template("home.html", at_home=at_home)
		else:
			flash("User not found!", "error")
			return render_template("home.html", at_home=at_home)
	else:
		return render_template("home.html", at_home=at_home)

@app.route("/signup", methods=["GET", "POST"])
def signup():
	at_home = True
	if request.method == "POST":
		username = request.form["username"]
		password = request.form["password"].encode("utf-8")
		hashword = bcrypt.hashpw(password, bcrypt.gensalt())

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM admin WHERE adm_username=%s", [username])
		adm_exist = cur.fetchone()
		cur.close()

		if adm_exist is None:
			adm_exist = []

		if len(adm_exist) > 0:
			flash("Username is already taken!", "error")
			return render_template("signup.html")
		else:
			cur = sql.connection.cursor()
			cur.execute("INSERT INTO admin(adm_username, adm_password) VALUES (%s, %s)", (username, hashword))
			sql.connection.commit()
			flash("User created successfully!", "info")
			return render_template("home.html", at_home=at_home)
	else:
		return render_template("signup.html")

@app.route("/logout")
def logout():
	at_home = True
	session["logged_in"] = False
	session.clear()
	flash("Logged out successfully!", "info")
	return render_template("home.html", at_home=at_home)

@app.route("/dash", methods=["GET", "POST"])
def dash():
	# put here database to collect data for lists
	return render_template("dash.html")

@app.route("/dash/inventory", methods=["GET", "POST"])
def product_list():
	at_products = True
	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM products")
	products = cur.fetchall()
	cur.close

	if request.method == "POST":
		barcode = request.form["barcode"]
		category = request.form["category"]
		description = request.form["description"]
		image = request.form["image"]
		name = request.form["name"]
		price = request.form["price"]
		quantity = request.form["quantity"]
		sku = request.form["sku"]

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM products WHERE sku=%s OR pro_barcode=%s", [sku, barcode])
		product_exist = cur.fetchone()
		cur.close()

		if product_exist is None:
			product_exist = []

		if len(product_exist) > 0:
			flash("There's a product with this SKU or barcode already.", "error")
			return render_template("dash/products.html", at_products=at_products, products=products)
		else:
			cur = sql.connection.cursor()
			cur.execute( "INSERT INTO products(\
				pro_image, pro_name, sku, pro_barcode, pro_category, pro_description, pro_price, pro_quantity)\
				VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
				(image, name, sku, barcode, category, description, price, quantity)
			)
			sql.connection.commit()
			flash("New product has been added!", "info")
			return render_template("dash/products.html", at_products=at_products, products=products)
	else:
		return render_template("dash/products.html", at_products=at_products, products=products)

@app.route("/dash/purchasing/vendors", methods=["GET", "POST"])
def vendor_list():
	at_vendors = True
	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM vendors")
	vendors = cur.fetchall()
	cur.close

	if request.method == "POST":
		address = request.form["address"]
		billcon = request.form["billcon"]
		email = request.form["email"]
		name = request.form["name"]
		phone = request.form["phone"]
		website = request.form["website"]

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM vendors WHERE ven_email=%s", [email])
		vendor_exist = cur.fetchone()
		cur.close()

		if vendor_exist is None:
			vendor_exist = []

		if len(vendor_exist) > 0:
			flash("There's a vendor with this email already.", "error")
			return render_template("dash/vendors.html", at_vendors=at_vendors, vendors=vendors)
		else:
			cur = sql.connection.cursor()
			cur.execute( "INSERT INTO vendors(\
				ven_name, ven_phone, ven_email, ven_website, ven_address, ven_billcon)\
				VALUES (%s, %s, %s, %s, %s, %s)",
				(name, phone, email, website, address, billcon)
			)
			sql.connection.commit()
			flash("New vendor has been added!", "info")
			return render_template("dash/vendors.html", at_vendors=at_vendors, vendors=vendors)
	else:
		return render_template("dash/vendors.html", at_vendors=at_vendors, vendors=vendors)

@app.route("/dash/sales/customers", methods=["GET", "POST"])
def customer_list():
	at_customers = True
	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM customers")
	customers = cur.fetchall()
	cur.close

	if request.method == "POST":
		billadd = request.form["billadd"]
		email = request.form["email"]
		name = request.form["name"]
		phone = request.form["phone"]
		shipadd = request.form["shipadd"]
		website = request.form["website"]

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM customers WHERE cus_email=%s", [email])
		customer_exist = cur.fetchone()
		cur.close()

		if customer_exist is None:
			customer_exist = []

		if len(customer_exist) > 0:
			flash("There's a customer with this email already.", "error")
			return render_template("dash/customers.html", at_customers=at_customers, customers=customers)
		else:
			cur = sql.connection.cursor()
			cur.execute( "INSERT INTO customers(\
				cus_name, cus_phone, cus_email, cus_website, cus_shipadd, cus_billadd)\
				VALUES (%s, %s, %s, %s, %s, %s)",
				(name, phone, email, website, shipadd, billadd)
			)
			sql.connection.commit()
			flash("New customer has been added!", "info")
			return render_template("dash/customers.html", at_customers=at_customers, customers=customers)
	else:
		return render_template("dash/customers.html", at_customers=at_customers, customers=customers)

@app.route("/dash/purchasing/orders", methods=["GET", "POST"])
def po_list():
	at_purchasing = True

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM vendors")
	po_vendors = cur.fetchall()
	cur.close

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM products")
	po_products = cur.fetchall()
	cur.close

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM purchase_orders")
	purch_orders = cur.fetchall()
	cur.close

	if request.method == "POST":
		number = request.form["number"]
		date = request.form["date"]
		vendor = request.form["vendor"]
		phone = request.form["phone"]
		email = request.form["email"]
		venadd = request.form["venadd"]
		location = request.form["location"]

		product = request.form["po-product"]
		qty = request.form["po-qty"]
		unprice = request.form["po-unprice"]
		total = request.form["po-total"]

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM purchase_orders WHERE po_ordnum=%s", [number])
		po_exist = cur.fetchone()
		cur.close()

		if po_exist is None:
			po_exist = []

		if len(po_exist) > 0:
			flash("There's a purchase order with this order number already.", "error")
			return render_template(
				"dash/purch-orders.html",
				at_purchasing=at_purchasing,
				po_vendors=po_vendors,
				po_products=po_products,
				purch_orders=purch_orders
			)
		else:
			cur = sql.connection.cursor()
			cur.execute("INSERT INTO purchase_orders(\
				po_ordnum, po_orddate, po_vendor, po_phone, po_email, po_venadd, po_location)\
				VALUES (%s, %s, %s, %s, %s, %s, %s)",
				(number, date, vendor, phone, email, venadd, location)
			)
			sql.connection.commit()

			# cur = sql.connection.cursor()
			# cur.execute("INSERT INTO po_products(\
			# 	po_ordnum, po_product, po_qty, po_unprice, po_total",
			# 	(number, product, qty, unprice, total)
			# )
			# sql.connection.commit()

			flash("New purchase order has been added!", "info")
			return render_template(
				"dash/purch-orders.html",
				at_purchasing=at_purchasing,
				po_vendors=po_vendors,
				po_products=po_products,
				purch_orders=purch_orders
			)
	else:
		return render_template(
			"dash/purch-orders.html",
			at_purchasing=at_purchasing,
			po_vendors=po_vendors,
			po_products=po_products,
			purch_orders=purch_orders
		)

@app.route("/dash/sales/orders", methods=["GET", "POST"])
def so_list():
	at_sales = True

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM customers")
	so_customers = cur.fetchall()
	cur.close

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM products")
	so_products = cur.fetchall()
	cur.close

	cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
	cur.execute("SELECT * FROM sales_orders")
	sales_orders = cur.fetchall()
	cur.close

	if request.method == "POST":
		number = request.form["number"]
		date = request.form["date"]
		customer = request.form["customer"]
		phone = request.form["phone"]
		email = request.form["email"]
		billadd = request.form["billadd"]
		location = request.form["location"]

		product = request.form["so-product"]
		qty = request.form["so-qty"]
		unprice = request.form["so-unprice"]
		total = request.form["so-total"]

		cur = sql.connection.cursor(MySQLdb.cursors.DictCursor)
		cur.execute("SELECT * FROM sales_orders WHERE so_ordnum=%s", [number])
		so_exist = cur.fetchone()
		cur.close()

		if so_exist is None:
			so_exist = []

		if len(so_exist) > 0:
			flash("There's a sales order with this order number already.", "error")
			return render_template(
				"dash/sales-orders.html",
				at_sales=at_sales,
				so_customers=so_customers,
				so_products=so_products,
				sales_orders=sales_orders
			)
		else:
			cur = sql.connection.cursor()
			cur.execute("INSERT INTO sales_orders(\
				so_ordnum, so_orddate, so_customer, so_phone, so_email, so_billadd, so_location)\
				VALUES (%s, %s, %s, %s, %s, %s, %s)",
				(number, date, customer, phone, email, billadd, location)
			)
			sql.connection.commit()

			cur = sql.connection.cursor()
			cur.execute("INSERT INTO so_products(\
				so_ordnum, so_product, so_qty, so_unprice, so_total",
				(number, product, qty, unprice, total)
			)
			sql.connection.commit()

			flash("New sales order has been added!", "info")
			return render_template(
				"dash/sales-orders.html",
				at_sales=at_sales,
				so_customers=so_customers,
				so_products=so_products,
				sales_orders=sales_orders
			)
	else:
		return render_template(
			"dash/sales-orders.html",
			at_sales=at_sales,
			so_customers=so_customers,
			so_products=so_products,
			sales_orders=sales_orders
		)

# ERROR HANDLERS
@app.errorhandler(404)	# invalid url error
def page_not_found(error):
	return render_template("error/404.html"), 404

@app.errorhandler(500) # internal server error
def server_down(error):
	return render_template("error/500.html"), 500


# RUN APP
if __name__ == "__main__":
	app.run(debug=True)
