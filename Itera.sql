/*Declaración variables*/
/**********************/
Declare @id int,
        @count int
/*Iniciarlizar las variables @id y @count*/
/**********************/
Set @id=1
select @count=count(*)from NombreTabla 

/*Con un while recorremos los datos sin utilizar un cursor.*/
/**********************/

while @id<=@count
begin
    select * from (select  *,RANK()OVER (ORDER BY campo ASC)AS RANK from NombreTabla) as ji
    where rank=@id
/*recoremos secuencialmente los datos de la tabla al introducir la función rank() e igualar su resultado a nuestra variable @id*/

/*Terminadas las opercaciones incrementamos la variable @id*/
select @id=@id+1
end
