-- 6. Add Bonus
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS AddBonus(
  IN user_id INT,
  IN project_name VARCHAR(255),
  IN score INT)
BEGIN
  CREATE TABLE IF NOT EXISTS project_name (
    'user_id' INT,
    'name' VARCHAR(255),
    'score' INT,
    PRIMARY KEY('user_id')
  );
  SET project_name.score = score WHERE project_name.user_id = user_id; 
END$$
DELIMITER ;
