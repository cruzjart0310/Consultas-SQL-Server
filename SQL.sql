
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

			
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>pay</title>
    <link rel="stylesheet" href="">
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        .container {
            /*opcion 1*/
            min-width: 400px;
            max-width: 800px;

            /*opcion 2*/
            /*width: 800px;*/
            height: 600px;
            margin: 0 auto;
            margin-top: 5px;

            /*opcion 3*/
            /*media query*/
        }

        .container-card {
            /*opcion 1*/
            /*min-width: 80%;
            max-width: 96%;*/

            /*opcion 2*/
            width: 100%;

            height: 100%;
            background-color: #FFFFFF;
            border: 1px solid rgb(223, 223, 223);
            border-radius: 10px;
            padding: 5px;
        }
        
        /*header*/
        .card-header {
            width: 100%;
            height: 50px;
            padding: 5px;
        }

        .card-header-left {
            display: inline-block;
            float: left;
        }
        
        .card-header-right {
            display: inline-block;
            float: right;
        }

        .card-header-right img{
            width: 150px;
            height: 30px;
            padding: 10px;
        }
    
        /*section*/
        .card-section {
            border-top: 2px solid rgb(223, 223, 223);
            border-bottom: 2px solid rgb(223, 223, 223);
            height: 450px;
            padding: 5px;
        }

        .card-section-button {
            text-align: center;
            padding: 5px;
        }

        .card-section-grid {

        }

        .card-section-detail {

        }

        .card-section-pay {

        }
        
        /*footer*/
        .card-footer {
            height: 100px;
            padding: 5px;
        }

        .card-footer-company {
            display: inline-block;
            float: left;
        }

        .card-footer-company strong {
            display:block;
        }

        .card-footer-information {
            display: inline-block;
            float: right;
        }

        .card-footer-information strong {
            display: block;
        }
    
        /*button*/
        .button-add-pay {
            color:#FFF;
            background-color: #28a748;
            border-color: #28a748;
            padding: 8px;
            border:none;
            font-size: 14px;
        }

        .button-pay {
            color:#FFF;
            background-color: #28a748;
            border-color: #28a748;
            padding: 8px;
            border:none;
            font-size: 14px;
        }

        .button-next {
            color:#FFF;
            background-color: #28a748;
            border-color: #28a748;
            padding: 8px;
            border:none;
            font-size: 14px;
        }
        
        /*modal*/

        /* The Modal (background) */
        .modal {
          display: none; /* Hidden by default */
          position: fixed; /* Stay in place */
          z-index: 1; /* Sit on top */
          padding-top: 100px; /* Location of the box */
          left: 0;
          top: 0;
          width: 100%; /* Full width */
          height: 100%; /* Full height */
          overflow: auto; /* Enable scroll if needed */
          background-color: rgb(0,0,0); /* Fallback color */
          background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
          position: relative;
          background-color: #fefefe;
          margin: auto;
          padding: 0;
          border: 1px solid #888;
          width: 80%;
          box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
          -webkit-animation-name: animatetop;
          -webkit-animation-duration: 0.4s;
          animation-name: animatetop;
          animation-duration: 0.4s
        }

        /* Add Animation */
        @-webkit-keyframes animatetop {
          from {top:-300px; opacity:0} 
          to {top:0; opacity:1}
        }

        @keyframes animatetop {
          from {top:-300px; opacity:0}
          to {top:0; opacity:1}
        }

        /* The Close Button */
        .close {
          color: white;
          float: right;
          font-size: 28px;
          font-weight: bold;
        }

        .close:hover,
        .close:focus {
          color: #000;
          text-decoration: none;
          cursor: pointer;
        }

        .modal-header {
          padding: 2px 16px;
          background-color: #5cb85c;
          color: white;
        }

        .modal-body {padding: 2px 16px;}

        .modal-footer {
          padding: 2px 16px;
          background-color: #5cb85c;
          color: white;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="container-card">

            <div class="card-header">
                <div class="card-header-left">
                    <h3>Pago de servicios</h3>
                </div>

                <div class="card-header-right">
                    <img src="azteca.png" alt="image">
                </div>
            </div>

            <div class="card-section">
                <div class="card-section-button">
                    <button type="button"
                            class="button-add-pay"
                            id="myBtn">
                            Agregar Pago
                    </button>
                </div> 

                <div class="card-section-grid">
                    <!-- tabla -->
                </div>

                <div class="card-section-pay">

                </div>

                <div class="card-section-detail">
                    <h3>Informacion pago</h3>

                    <div>
                        <span>Subtotal</span>
                        <span>Total</span>
                    </div>
                    
                    <button type="button" 
                            class="button-pay">
                            pagar
                    </button>
                </div>
            </div>

            <div class="card-footer">
                <div class="card-footer-company">
                    <strong>sucursal</strong>
                    <strong>sucursal</strong>
                </div>

                <div class="card-footer-information">
                    <strong>empleado</strong>
                    <strong>empleado</strong>
                </div>
            </div>
            
        </div>
    </div>

    <!-- modal -->
    <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
            <div class="modal-header">
              <span class="close">&times;</span>
              <h2>Modal Header</h2>
            </div>
            
            <div class="modal-body">
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
              <p>banco azteca</p>
            </div>
            
            <div class="modal-footer">
              <h3>Modal Footer</h3>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    // Get the modal
    var modal = document.getElementById('myModal');

    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks the button, open the modal 
    btn.onclick = function() {
      modal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
      modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
</script>
