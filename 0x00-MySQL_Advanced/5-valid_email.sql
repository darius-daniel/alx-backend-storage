-- 5. Email Validation to sent
-- Remove trigger if it already EXISTS
DROP TRIGGER IF EXISTS after_reset_email;

-- Create new trigger
DELIMITER $$
CREATE TRIGGER after_reset_email
  BEFORE UPDATE
  ON users FOR EACH ROW
BEGIN
  IF NEW.email <> OLD.email THEN
    SET NEW.valid_email = 0;
  END IF;
END
$$
DELIMITER ;