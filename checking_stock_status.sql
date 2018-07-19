CREATE OR REPLACE FUNCTION checking_stock_status(location_name VARCHAR(50))
  RETURNS TABLE(location_address VARCHAR(100), shipment_id INTEGER, shipment_date DATE,
    ingrediente_name VARCHAR(50), ingediente_quantity DECIMAL(10,3), ingredient_unit VARCHAR(20),
    days_to_expiry_from_today INTERVAL) AS
$BODY$
BEGIN
  RETURN QUERY SELECT l.address, sh.id, sh.date, i.name, ins.quantity, u.name,
        calculate_days_expiry_from_today(ins.expiry_days, ins.date) AS days_to_expiry_from_today
    FROM ingredients_in_shipments ins
      INNER JOIN shipments sh ON ins.shipment_id = sh.id
      INNER JOIN locations l ON sh.location_id = l.id AND l.name = location_name
      INNER JOIN ingredients i ON ins.ingredient_id = i.id
      INNER JOIN units u ON i.unit_id = u.id
    ORDER BY l.address, i.name, days_to_expiry_from_today;
END
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calculate_days_expiry_from_today(days_to_expiry INTEGER, shimpent_date DATE) RETURNS INTERVAL AS
  $BODY$

  BEGIN
    RETURN MAKE_INTERVAL(days := CEIL((days_to_expiry - get_interval_in_days_number(AGE(CURRENT_DATE, shimpent_date)))) :: INTEGER);
  END
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_interval_in_days_number(interval_between_today_and_shipment INTERVAL) RETURNS DOUBLE PRECISION AS
$BODY$
  DECLARE
    seconds_in_hour INTEGER := 3600;
    hours_in_day INTEGER := 24;
  BEGIN
    RETURN EXTRACT(EPOCH FROM interval_between_today_and_shipment) / (seconds_in_hour * hours_in_day);
  END;
$BODY$
LANGUAGE plpgsql;

SELECT checking_stock_status('Olleros');

-- Test for method
-- SELECT calculate_days_expiry_from_today(2, '2018-07-19');

