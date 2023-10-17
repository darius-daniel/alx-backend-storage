-- 4. Buy buy buy
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_order_insert
  AFTER INSERT 
  ON orders FOR EACH ROW
BEGIN
  UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END $$
DELIMITER ;
