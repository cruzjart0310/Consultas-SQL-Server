
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

			
