ALTER TABLE units ALTER COLUMN name SET NOT NULL;

ALTER TABLE ingredients ALTER COLUMN unit_id SET NOT NULL;
ALTER TABLE ingredients ALTER COLUMN name SET NOT NULL;
ALTER TABLE ingredients ALTER COLUMN min_quantity SET NOT NULL;
ALTER TABLE ingredients ADD CHECK (min_quantity > 0);

ALTER TABLE locations ALTER COLUMN name SET NOT NULL;
ALTER TABLE locations ALTER COLUMN address SET NOT NULL;

ALTER TABLE shipments ALTER COLUMN date SET NOT NULL;
ALTER TABLE shipments ALTER COLUMN location_id SET NOT NULL;

ALTER TABLE ingredients_in_shipments ALTER COLUMN ingredient_id SET NOT NULL;
ALTER TABLE ingredients_in_shipments ALTER COLUMN shipment_id SET NOT NULL;
ALTER TABLE ingredients_in_shipments ALTER COLUMN price SET NOT NULL;
ALTER TABLE ingredients_in_shipments ADD CHECK (price > 0);
ALTER TABLE ingredients_in_shipments ALTER COLUMN quantity SET NOT NULL;
ALTER TABLE ingredients_in_shipments ADD CHECK (quantity > 0);
ALTER TABLE ingredients_in_shipments ALTER COLUMN date SET NOT NULL;
ALTER TABLE ingredients_in_shipments ALTER COLUMN expiry_days SET NOT NULL;
ALTER TABLE ingredients_in_shipments ADD CHECK (expiry_days >= 0);

ALTER TABLE dishes ALTER COLUMN name SET NOT NULL;

ALTER TABLE dishes_ingredients ALTER COLUMN ingredient_id SET NOT NULL;
ALTER TABLE dishes_ingredients ALTER COLUMN dish_id SET NOT NULL;
ALTER TABLE dishes_ingredients ALTER COLUMN quantity SET NOT NULL;
ALTER TABLE dishes_ingredients ADD CHECK (quantity > 0);

ALTER TABLE dishes_prices ALTER COLUMN dish_id SET NOT NULL;
ALTER TABLE dishes_prices ALTER COLUMN price SET NOT NULL;
ALTER TABLE dishes_prices ADD CHECK (price > 0);
ALTER TABLE dishes_prices ALTER COLUMN set_date SET NOT NULL;

ALTER TABLE orders ALTER COLUMN table_number SET NOT NULL;
ALTER TABLE orders ADD CHECK (table_number > 0);

ALTER TABLE orders_dishes ALTER COLUMN dish_id SET NOT NULL;
ALTER TABLE orders_dishes ALTER COLUMN order_id SET NOT NULL;

ALTER TABLE staff ALTER COLUMN name SET NOT NULL;
ALTER TABLE staff ALTER COLUMN location_id SET NOT NULL;

ALTER TABLE payments ALTER COLUMN order_id SET NOT NULL;
ALTER TABLE payments ALTER COLUMN staff_id SET NOT NULL;
ALTER TABLE payments ALTER COLUMN income SET NOT NULL;
ALTER TABLE payments ADD CHECK (income > 0);