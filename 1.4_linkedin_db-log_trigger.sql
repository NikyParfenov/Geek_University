-- Make the DB is current
USE linkedin;

-- Trigger for writing added information about new unit (user, company, group) in logs archive table
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
   table_name VARCHAR(100)                       COMMENT 'Table name',
   table_id   INT UNSIGNED                       COMMENT 'ID in a table',
   cell_name  VARCHAR(255)                       COMMENT 'Table cell name',
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time"
) COMMENT 'Logs table' ENGINE=ARCHIVE;

DROP TRIGGER IF EXISTS users_log;
DROP TRIGGER IF EXISTS companies_log;
DROP TRIGGER IF EXISTS communities_log;

DELIMITER //
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, table_id, cell_name, created_at)
	     VALUES ('users', NEW.id, CONCAT(NEW.first_name, ' ', NEW.last_name), NOW());
END//

CREATE TRIGGER companies_log AFTER INSERT ON companies
FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, table_id, cell_name, created_at)
	     VALUES ('companies', NEW.id, NEW.name, NOW());
END//

CREATE TRIGGER communities_log AFTER INSERT ON communities
FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, table_id, cell_name, created_at)
	     VALUES ('communities', NEW.id, NEW.name, NOW());
END//
DELIMITER ;

# SELECT * FROM logs;

