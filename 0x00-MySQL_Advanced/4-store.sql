-- 4. Buy buy buy

DROP TRIGGER IF EXISTS after_order_insert;

CREATE TRIGGER after_order_insert
  AFTER INSERT 
  ON ordersFOR EACH ROW
UPDATE items
  SET quantity = quantity - NEW.number WHERE name = NEW.item_name;
