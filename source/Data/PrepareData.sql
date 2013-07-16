TRUNCATE TABLE TBL_CUSTOMERS
DECLARE @sayac INT
SET    @sayac = 0

WHILE (@sayac < 1000000)
BEGIN
 SET @sayac = @sayac + 1
 INSERT INTO TBL_CUSTOMERS(FIRSTNAME,LASTNAME) 
  VALUES
  ('FIRSTNAME'+convert(varchar(max),@sayac),
   'LASTNAME'+convert(varchar(max),@sayac))
END
select count(*) FROM TBL_CUSTOMERS


 