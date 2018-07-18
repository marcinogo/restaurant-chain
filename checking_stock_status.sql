CREATE OR REPLACE FUNCTION checking_stock_status(location_name VARCHAR(50))
  RETURNS TABLE(location_address VARCHAR(100), shipment_id INTEGER, shipment_date DATE,
    ingrediente_name VARCHAR(50), ingediente_quantity DECIMAL(10,3), ingredient_unit VARCHAR(20),
    days_to_experince_from_today INTEGER) AS
$BODY$
BEGIN
  RETURN QUERY SELECT l.address, sh.id, sh.date, i.name, ins.quantity, u.name,
      MAKE_INTERVAL(days := ins.expiry_days) - AGE(NOW(),ins.date) AS days_to_experince_from_today
    FROM ingredients_in_shipments ins
      INNER JOIN shipments sh ON ins.shipment_id = sh.id
      INNER JOIN locations l ON sh.location_id = l.id AND l.name = location_name
      INNER JOIN ingredients i ON ins.ingredient_id = i.id
      INNER JOIN units u ON i.unit_id = u.id
    ORDER BY l.address, i.name, days_to_experince_from_today;
END
$BODY$
LANGUAGE plpgsql;

SELECT checking_stock_status('Kraków');
