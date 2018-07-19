CREATE TABLE units(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20)
);

CREATE TABLE ingredients(
  id SERIAL PRIMARY KEY,
  unit_id INT REFERENCES units(id),
  name VARCHAR(50),
  min_quantity DECIMAL(10, 3)
);

CREATE TABLE locations(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(100)
);

CREATE TABLE shipments(
  id SERIAL PRIMARY KEY,
  date DATE,
  location_id INT REFERENCES locations(id)
);

CREATE TABLE ingredients_in_shipments(
  id SERIAL PRIMARY KEY,
  ingredient_id INT REFERENCES ingredients(id),
  shipment_id INT REFERENCES shipments(id),
  price DECIMAL(10, 2),
  quantity DECIMAL(10, 3),
  date DATE,
  expiry_days INT
);


CREATE TABLE dishes(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE dishes_ingredients(
  id SERIAL PRIMARY KEY,
  ingredient_id INT REFERENCES ingredients(id),
  dish_id INT REFERENCES dishes(id),
  quantity DECIMAL(10, 3)
);


CREATE TABLE dishes_prices(
  id SERIAL PRIMARY KEY,
  dish_id INT REFERENCES dishes(id),
  price DECIMAL(10, 2),
  set_date DATE
);

CREATE TABLE orders(
  id SERIAL PRIMARY KEY,
  table_number INT
);

CREATE TABLE orders_dishes(
  id SERIAL PRIMARY KEY,
  dish_id INT REFERENCES dishes(id),
  order_id INT REFERENCES orders(id)
);

CREATE TABLE staff(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  location_id INT REFERENCES locations(id)
);

CREATE TABLE payments(
  id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(id),
  staff_id INT REFERENCES staff(id),
  income DECIMAL(10, 2)
);