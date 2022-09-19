
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

create table Users(
	Id int not null primary key identity(1,1),
	Name varchar(50),
	LastName varchar(50)
)

create table Survey(
	Id int not null primary key identity(1,1),
	Name varchar(50)
)

create table Question(
	Id int not null primary key identity(1,1),
	SurveyId int not null,
	Title varchar(50)
)

ALTER TABLE Question
ADD FOREIGN KEY (SurveyId) REFERENCES Survey(Id);


create table Answer(
	Id int not null primary key identity(1,1),
	QuestionId int not null,
	Title varchar(50),
	Points int
)

ALTER TABLE Answer
ADD FOREIGN KEY (QuestionId) REFERENCES Question(Id);

create table AnswerUser(
	Id int not null primary key identity(1,1),
	SurveyId int not null,
	QuestionId int not null,
	AswerId int not null,
	UserId int not null,
)

ALTER TABLE AnswerUser
ADD FOREIGN KEY (SurveyId) REFERENCES Survey(Id);

ALTER TABLE AnswerUser
ADD FOREIGN KEY (QuestionId) REFERENCES Question(Id);

ALTER TABLE AnswerUser
ADD FOREIGN KEY (AswerId) REFERENCES Answer(Id);

ALTER TABLE AnswerUser
ADD FOREIGN KEY (UserId) REFERENCES Users(Id);

create table SurveryUser(
	Id int not null primary key identity(1,1),
	UserId int not null,
	SurveyId int not null,
	Dates varchar(20),
	Result varchar(10)
)

ALTER TABLE SurveryUser
ADD FOREIGN KEY (UserId) REFERENCES Users(Id);

ALTER TABLE SurveryUser
ADD FOREIGN KEY (SurveyId) REFERENCES Survey(Id);


create table Estudiantes(
	Id int not null primary key identity(1,1),
	Nombre varchar(60) not null,
	FechaNacimiento datetime
)

create table Asignaciones(
	Id int not null primary key identity(1,1),
	Nombre varchar(60) not null
);

create table AsignacionEstudiante(
	Id int not null primary key identity(1, 1),
	IdAsignacion int not null ,
	IdEstudiente int not null
)

ALTER TABLE AsignacionEstudiante
ADD FOREIGN KEY (IdAsignacion) REFERENCES Asignaciones(Id);
ALTER TABLE AsignacionEstudiante
ADD FOREIGN KEY (IdEstudiente) REFERENCES Estudiantes(Id);





