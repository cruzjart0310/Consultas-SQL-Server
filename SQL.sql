ALTER PROCEDURE [dbo].[spReporteKPIHistorico](@fechaInicio datetime,@fechaFin datetime)
--declare @fechaInicio datetime='20160801',@fechaFin datetime='20160831'
AS
BEGIN

declare @tblReporteMKPHistorico table(tipo varchar(50),fecha date,valor money,Programa varchar(50),ordenPrograma smallint,ordenTipo smallint)

delete from @tblReporteMKPHistorico where DATEPART(YEAR,fecha)= DATEPART(YEAR,@fechaInicio) and DATEPART(MONTH,fecha)=DATEPART(MONTH,@fechaInicio) and valor = 0

DECLARE @tCRM TABLE (IdCRM Integer, Calif VARCHAR(50))
--INSERT INTO @tCRM
--SELECT * FROM OPENQUERY(LK_NET, 'SELECT r.id, c.name FROM reserva r INNER JOIN calificacion c ON r.calificacion_id = c.id')

insert into @tblReporteMKPHistorico
select 'SHOWS' Tipo , @fechaInicio, COUNT(*) Total  ,case when m.Nombre = 'OUTSITE' then 'OFFSIDE' else m.Nombre end as Programa ,0,0
--select  a.IdHotel, Invitado, IdPromInvito, FechaInv, RsInvitado, RsIdPromInvito, RsFechaInv, a.Folio,BeBack,BeBackFecCap
from Premanifiesto a  inner join SalasVta b on b.idSalaVta = a.IdSalaVta 
                      inner join Hoteles c on a.IdHotel = c.idHotel
                      inner join Calificaciones d on a.idCalif = d.idCalif
                      left join Segmento2 k on k.idSegmento2 = a.IdSegmento2
                      left join Segmento1 m on m.idSegmento1 = k.idSegmento1
   where CAST(a.ShowInFecCap as DATE) BETWEEN CAST(@fechaInicio as date) AND CAST(@fechaFin as date) AND d.GrupoTRM IN('A','B','C','D','EX','EX1')
    and CAST(CASE WHEN RsInvitado = 'True' THEN a.RsFechaInv ELSE a.FechaInv END as DATE) BETWEEN CAST(@fechaInicio as date) AND CAST(@fechaFin as date) 
    --and (CAST(a.BeBackFecCap as DATE) BETWEEN CAST(@fechaInicio as date) AND CAST(@fechaFin as date) or BeBackFecCap is null )  
    --and m.idSegmento1 not in(1,9,4)
	and m.idSegmento1 in (2,3,5)
	and a.Show = 'True' and a.inOut = 'False' and a.WalkOut = 'False' 
  group by m.Nombre
  
  
  
   insert into @tblReporteMKPHistorico
select 'VENTAS',@fechaInicio, COUNT(*) TotalVentas , case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas
group by Programa

insert into @tblReporteMKPHistorico
select 'VOLUMEN',@fechaInicio, SUM(Precio)as Volumen,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas
group by Programa


--calcula de ventas en pesos
insert into @tblReporteMKPHistorico
select 'VENTAS MXN',@fechaInicio, COUNT(*) TotalVentas,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=1 
group by Programa


--Calcula  total de ventas en dolares.
insert into @tblReporteMKPHistorico
select 'VENTAS USD',@fechaInicio, COUNT(*) TotalVentas,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=2 
group by Programa



declare @v as int 
set @v=100

--para sacar el % ventas en pesos
insert into @tblReporteMKPHistorico
select 'PORCENTAJE VENTAS MXN',@fechaInicio, @v * COUNT(*) TotalVentas,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=1 
group by Programa


--para sacar el % ventas en dolares.
insert into @tblReporteMKPHistorico
select 'PORCENTAJE VENTAS USD',@fechaInicio, @v * COUNT(*) TotalVentas,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=2 
group by Programa


--calcula de volumen en pesos
insert into @tblReporteMKPHistorico
select 'VOLUMEN MXN',@fechaInicio, SUM(Precio)as Volumen ,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=1 
group by Programa


--Calcula   volumen en dolares.
insert into @tblReporteMKPHistorico
select 'VOLUMEN USD',@fechaInicio, SUM(Precio)as Volumen,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=2 
group by Programa


declare @i as int 
set @i=100

--para sacar el % volumen en pesos
insert into @tblReporteMKPHistorico
select 'PORCENTAJE VOLUMEN MXN',@fechaInicio, @i * SUM(Precio)as Volumen,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=1 
group by Programa


--para sacar el % volumen en dolares.
insert into @tblReporteMKPHistorico
select 'PORCENTAJE VOLUMEN USD',@fechaInicio, @i  * SUM(Precio)as Volumen,
case when Programa = 'OUTSITE' then 'OFFSIDE' else Programa end as Programa, 0, 0 from @tblVentas as v
where v.IdMoneda=2 
group by Programa
  
  END
  

  
  
 ALTER PROCEDURE [dbo].[spReporteKPIHistoricoOnlineTest](@fechaInicio datetime,@fechaFin datetime)
--declare @fechaInicio datetime='20160801',@fechaFin datetime='20160831'
AS
BEGIN
	
	
	declare @anio int
set @anio= year(@fechaInicio)


declare @tblReporteMKPHistorico table(tipo varchar(50),fecha date,valor money,Programa varchar(50),ordenPrograma smallint,ordenTipo smallint)--, Promedio money


insert into @tblReporteMKPHistorico
		select 
		tipo =
		case  tipo
			when 'LLEGADAS TRABAJABLES' then 'LLEGADAS TRABAJABLES ' + convert(varchar,  year(th.fecha)) 
			when 'CONTACTOS' then 'CONTACTOS ' + convert(varchar,  year(th.fecha)) 
			when 'PENETRACION' then 'PENETRACION ' + convert(varchar,  year(th.fecha)) 
			when 'INVITACIONES' then 'INVITACIONES ' + convert(varchar,  year(th.fecha)) 
			when 'CONVERSION' then 'CONVERSION ' + convert(varchar,  year(th.fecha)) 
			when 'SHOWS' then 'SHOWS ' + convert(varchar,  year(th.fecha)) 
			when 'SHOW FACTOR' then 'SHOW FACTOR ' + convert(varchar,  year(th.fecha)) 
			when 'COSTO TOTAL SHOW' then 'COSTO TOTAL SHOW ' + convert(varchar,  year(th.fecha)) 
			when 'COSTO POR SHOW' then 'COSTO POR SHOW ' + convert(varchar,  year(th.fecha)) 
			when 'VENTAS' then 'Ventas / % Cierre '+ convert(varchar,  year(th.fecha)) 
			when '% Cierre' then '% Cierre '+ convert(varchar,  year(th.fecha)) 
			when 'VENTAS MXN' then 'Ventas en pesos ' + convert(varchar,  year(th.fecha)) 
			when '% Ventas MXN' then '% ventas en pesos '+ convert(varchar, year(th.fecha)) 
			when 'VENTAS USD' then 'Ventas en dólares ' + convert(varchar,  year(th.fecha)) 
			when '% Ventas USD' then '% ventas en dólares ' + convert(varchar, year(th.fecha))  
			when 'VOLUMEN' then 'VOLUMEN ' + convert(varchar,  year(th.fecha)) as varchar)
			when 'VOLUMEN MXN' then 'Volumen en pesos ' + convert(varchar,  year(th.fecha)) 
			when '% VOLUMEN MXN' then '% volumen en pesos '+ convert(varchar, year(th.fecha)) 
			when 'VOLUMEN USD' then 'Volumen en dólares ' + convert(varchar,  year(th.fecha)) 
			when '% VOLUMEN USD' then '% volumen en dólares '+ convert(varchar, year(th.fecha)) 
			when 'VENTA PROMEDIO' then 'VENTA PROMEDIO ' + convert(varchar,  year(th.fecha)) 
			when 'EFICIENCIA' then 'EFICIENCIA '+ convert(varchar,  year(th.fecha)) 
			end      
		 
		,th.fecha, sum(round(th.valor,2,0)) ,th.Programa,th.ordenPrograma, th.ordenTipo  from [dbTC].[dbo].[tblReporteMKPHistorico] th --, sum(valor) as Promedio

		where th.fecha between CONVERT(datetime,@fechaInicio) and CONVERT(datetime,@fechaFin) 
		--and programa =@Programa or programa ='OUTHOUSE' or programa ='OFFSIDE' or programa ='ACUMULADO'or programa ='MINIVACS'
		AND ordenTipo !=0 
		and not tipo='INVITACIONES PREMANIFESTADAS'
		and not tipo='INVITACIONES PREMANIFESTADAS'
		and not tipo='PORCENTAJE VENTAS MXN'
		and not tipo='PORCENTAJE VENTAS USD'
		and not tipo='PORCENTAJE VOLUMEN MXN'
		and not tipo='PORCENTAJE VOLUMEN USD'
		and not tipo='SHOWS PREMANIFESTADOS'
		--and not tipo='% CIERRE'
		--and not tipo='% VENTAS MXN'
		--and not tipo='% VENTAS USD'
		--and not tipo='% VOLUMEN MXN'
		--and not tipo='% VOLUMEN USD'
		
	group by 
		tipo,
		fecha,
		Programa,
		ordenPrograma, 
		OrdenTipo
	order by th.fecha, th.tipo, th.Programa, th.ordenPrograma, th.ordenTipo desc


	--update @tblReporteMKPHistorico set valor=Round(valor,2,0) 

	

	declare @tableDatos table(Tipo varchar(50), Programa varchar(50), 
					Enero money,Febrero money,Marzo money,Abril money,Mayo money,Junio money ,Julio money,Agosto money,Septiembre money,Octubre money,Noviembre money,Diciembre money,Total money)
					

					

--------------------------------------------------------------------------------



declare @TableProgramas table(	Nombre varchar(50))
		
insert into @TableProgramas		
select distinct Programa from tblReporteMKPHistorico

declare @Programa varchar(50)
declare @idPrograma varchar(50)  


DECLARE csTablaTemp1_1 CURSOR FOR	
	select Nombre from @TableProgramas

OPEN csTablaTemp1_1
FETCH NEXT FROM csTablaTemp1_1 INTO @Programa

WHILE @@FETCH_STATUS = 0
 BEGIN	
		--Llegadas trabajables
		insert into @tableDatos select [tipo],[programa],[2010-01-01] ,[2010-02-01],[2010-03-01],[2010-04-01],[2010-05-01],[2010-06-01] ,[2010-07-01],[2010-08-01],[2010-09-01],[2010-10-01],[2010-11-01],[2010-12-01],[2010-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor) for [fecha] in ([2010-01-01] ,[2010-02-01],[2010-03-01],[2010-04-01],[2010-05-01],[2010-06-01] ,[2010-07-01],[2010-08-01],[2010-09-01],[2010-10-01],[2010-11-01],[2010-12-01],[2010-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2010'
			order by  ordenPrograma,ordenTipo asc

		insert into @tableDatos select [tipo],[programa],[2011-01-01] ,[2011-02-01],[2011-03-01],[2011-04-01],[2011-05-01],[2011-06-01] ,[2011-07-01],[2011-08-01],[2011-09-01],[2011-10-01],[2011-11-01],[2011-12-01],[2011-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor) for [fecha] in ([2011-01-01] ,[2011-02-01],[2011-03-01],[2011-04-01],[2011-05-01],[2011-06-01] ,[2011-07-01],[2011-08-01],[2011-09-01],[2011-10-01],[2011-11-01],[2011-12-01],[2011-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2011'
			order by  ordenPrograma,ordenTipo asc

		insert into @tableDatos select [tipo],[programa],[2012-01-01] ,[2012-02-01],[2012-03-01],[2012-04-01],[2012-05-01],[2012-06-01] ,[2012-07-01],[2012-08-01],[2012-09-01],[2012-10-01],[2012-11-01],[2012-12-01],[2012-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor)
		for [fecha] in ([2012-01-01] ,[2012-02-01],[2012-03-01],[2012-04-01],[2012-05-01],[2012-06-01] ,[2012-07-01],[2012-08-01],[2012-09-01],[2012-10-01],[2012-11-01],[2012-12-01],[2012-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2012'
			order by  ordenPrograma,ordenTipo asc

		insert into @tableDatos select [tipo],[programa],[2013-01-01] ,[2013-02-01],[2013-03-01],[2013-04-01],[2013-05-01],[2013-06-01] ,[2013-07-01],[2013-08-01],[2013-09-01],[2013-10-01],[2013-11-01],[2013-12-01],[2013-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor)
		for [fecha] in ([2013-01-01] ,[2013-02-01],[2013-03-01],[2013-04-01],[2013-05-01],[2013-06-01] ,[2013-07-01],[2013-08-01],[2013-09-01],[2013-10-01],[2013-11-01],[2013-12-01],[2013-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2013'
			order by  ordenPrograma,ordenTipo asc


		insert into @tableDatos select [tipo],[programa],[2014-01-01] ,[2014-02-01],[2014-03-01],[2014-04-01],[2014-05-01],[2014-06-01] ,[2014-07-01],[2014-08-01],[2014-09-01],[2014-10-01],[2014-11-01],[2014-12-01],[2014-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor)
		for [fecha] in ([2014-01-01] ,[2014-02-01],[2014-03-01],[2014-04-01],[2014-05-01],[2014-06-01] ,[2014-07-01],[2014-08-01],[2014-09-01],[2014-10-01],[2014-11-01],[2014-12-01],[2014-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2014'
			order by  ordenPrograma,ordenTipo asc


		insert into @tableDatos select [tipo],[programa],[2015-01-01] ,[2015-02-01],[2015-03-01],[2015-04-01],[2015-05-01],[2015-06-01] ,[2015-07-01],[2015-08-01],[2015-09-01],[2015-10-01],[2015-11-01],[2015-12-01],[2015-12-31]
			from @tblReporteMKPHistorico 
		pivot (sum(valor)
		for [fecha] in ([2015-01-01] ,[2015-02-01],[2015-03-01],[2015-04-01],[2015-05-01],[2015-06-01] ,[2015-07-01],[2015-08-01],[2015-09-01],[2015-10-01],[2015-11-01],[2015-12-01],[2015-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2015'
			order by  ordenPrograma,ordenTipo asc


		insert into @tableDatos select [tipo],[programa],[2016-01-01] ,[2016-02-01],[2016-03-01],[2016-04-01],[2016-05-01],[2016-06-01] ,[2016-07-01],[2016-08-01],[2016-09-01],[2016-10-01],[2016-11-01],[2016-12-01],[2016-12-31]
			from @tblReporteMKPHistorico 
			pivot (sum(valor)
		for [fecha] in ([2016-01-01] ,[2016-02-01],[2016-03-01],[2016-04-01],[2016-05-01],[2016-06-01] ,[2016-07-01],[2016-08-01],[2016-09-01],[2016-10-01],[2016-11-01],[2016-12-01],[2016-12-31])) as p
			where Programa =@Programa and tipo='LLEGADAS TRABAJABLES 2016'
			order by  ordenPrograma,ordenTipo asc
			
		FETCH NEXT FROM csTablaTemp1_1 INTO @Programa
 END
  
CLOSE csTablaTemp1_1
DEALLOCATE csTablaTemp1_1

END



--Consultas ejecutadas en pequeñas aplicaciones
RS = ST.executeQuery("SELECT pr.IdPrestamo,pr.FechaPrestamo,ej.ISBN,ej.Titulo,us.Nombre,dp.CantidadPrestada,\n"
                    + "	dd.CantidadDevuelta,(dp.CantidadPrestada-dd.CantidadDevuelta)\n"
                    + " AS CantidadPorDevolver FROM prestamo AS pr\n"
                    + " INNER JOIN detalleprestamo AS dp ON dp.IdPrestamo=pr.IdPrestamo \n"
                    + "	INNER JOIN usuario AS us ON us.idUsuario=pr.IdUsuario\n"
                    + "	INNER JOIN ejemplar AS ej ON ej.ISBN=dp.ISBN\n"
                    + "	INNER JOIN detalledevoluciON AS dd ON dd.IdPrestamo=dp.IdPrestamo\n"
                    + " WHERE us.Nombre='" + nombre + "'"
                    + "	ORDER BY pr.IdPrestamo");
					
					
					
RS = ST.executeQuery("SELECT pr.IdPrestamo,pr.FechaPrestamo,ej.ISBN,ej.Titulo,us.Nombre,dp.CantidadPrestada\n"
                    + " FROM prestamo AS pr\n"
                    + " INNER JOIN detalleprestamo AS dp on dp.IdPrestamo=pr.IdPrestamo \n"
                    + " INNER JOIN usuario AS us ON us.idUsuario=pr.IdUsuario\n"
                    + " INNER JOIN ejemplar AS ej ON ej.ISBN=dp.ISBN"
                    + " WHERE us.Nombre='" + nombre + "' AND CantidadPrestada>0"
                    + "	ORDER BY pr.IdPrestamo");	
		    
;MERGE INTO user_permission AS Destino
    USING ( select p.id as permission_id, u.id as user_id from users as u inner join permission as p on p.id = u.id	) as Origen
            ON Origen.permission_id <> Destino.permission_id
    --WHEN MATCHED AND Destino.user_id <> Origen.id
	    --  THEN UPDATE
	    --  SET Destino.idCatalogoHorario = Origen.idCatalogoHorario, Destino.idHorarioZKT = Origen.idHorario,  Destino.actualizado = 1
    WHEN NOT MATCHED THEN INSERT
        VALUES(Origen.user_id,
        Origen.permission_id)
    WHEN NOT MATCHED BY SOURCE THEN DELETE;

			
