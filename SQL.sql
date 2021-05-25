
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
					       
var data = [{
            "id": "1",
            "nombre": "ITALIA",
            "padre": "1",
            "tipo": "integrador",
            "logo": "efectivo.png",
            "colectores": []
        }, {
            "id": "2",
            "nombre": "OTRO",
            "padre": "1",
            "tipo": "integrador",
            "logo": "efectivo.png",
            "colectores": []
        }, {
            "id": "3",
            "nombre": "PRONET",
            "padre": "1",
            "tipo": "integrador",
            "logo": "efectivo.png",
            "colectores": []
        }, {
            "id": "4",
            "nombre": "TIGO",
            "padre": "1",
            "tipo": "integrador",
            "logo": "efectivo.png",
            "colectores": [{
                "id": "100",
                "nombre": "avon",
                "logo": "imagen.png"
            }, {
                "id": "200",
                "nombre": "jafra",
                "logo": "imagen.png"
            }]
        }, {
            "id": "5",
            "nombre": "PAGO FACIL",
            "padre": "1",
            "tipo": "integrador",
            "logo": "efectivo.png",
            "colectores": [{
                "id": "200",
                "nombre": "jafra",
                "logo": "imagen.png"
            }, {
                "id": "102",
                "nombre": "avon",
                "logo": "imagen.png"
            }]
        }];

function creationElementHTML(arr, val){
    var i, j, k;

    for (i = 0; i < arr.length; i++) {
       if (arr[i].nombre == val.toUpperCase()) {
           var filtered = arr.filter(function(el){ return el.nombre === val.toUpperCase()});
           var colectores = filtered[0].colectores;

           for(k=0; k<colectores.length; k++) {
               $(document).ready(function() {
                   $("#ul-list").append("<li><a id='item-parent' data-colector-length='"+colectores.length+"' data-id='"+colectores[k].id+"' data-name='"+colectores[k].nombre+"'> " + colectores[k].nombre + "</a></li>");
               });
           }

           return;
       }

       // para pintar integradores que no tienen colectores
       if (arr[i].nombre.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
           //para pintar los intregadores que no tienen colectores
           if (arr[i].colectores.length < 1) {
               $(document).ready(function() {
                   $("#ul-list").append("<li><a id='item-parent' data-colector-length='"+arr[i].colectores.length+"' data-id='"+arr[i].id+"' data-name='"+arr[i].nombre+"'> " + arr[i].nombre + "</a></li>");
               });
           }
       }

       //para pintar colectores agrupados
       for (j=0; j<arr[i].colectores.length; j++) {
           if (arr[i].colectores[j].nombre.substr(0, val.length).toUpperCase() == val.toUpperCase()) { 
               $(document).ready(function() {
                   $("#ul-list").append("<li id='item-let-"+ arr[i].id +"'><a id='item-parent' data-colector-length='"+arr[i].colectores.length+"' data-id='"+arr[i].id+"' data-name='"+arr[i].nombre+"'> " + arr[i].nombre + "</a></li>");
               });
                       
               if (arr[i].colectores.length > 0 ) {
                  $(document).ready(function() {
                   $("#item-let-"+arr[i].id).append("<ul><li><a id='item-child' data-id='"+arr[i].colectores[j].id+"' data-name='"+arr[i].colectores[j].nombre+"'> " + arr[i].colectores[j].nombre + "</a></li></ul>");
                  });
               }
           }
       }
    }

    if (i == arr.length) {
        loadTreeViewList(); 
    }
}

function autocomplete(inp, arr){
    var currentFocus;
    arr = (arr == null) ? data : arr;
    
    $(document).on("click", function(e) {
        if(e.target.id === "") {
           closeAllLists();
           return false;
        }

    });

    $("#myInput").unbind("click").click(function(e) {
        var treeDivContent, b, c, treeParentUl, listRer, val = this.value;
        closeAllLists();

        currentFocus = -1;
        treeDivContent = document.createElement("DIV");
        treeDivContent.setAttribute("id", this.id + "autocomplete-list");
        treeDivContent.setAttribute("class", "autocomplete-items tree");
        this.parentNode.appendChild(treeDivContent);
        treeParentUl = document.createElement("ul");
        treeParentUl.setAttribute("id", "ul-list");
        treeDivContent.appendChild(treeParentUl);
        listRer = document.getElementById("ul-list").value;
        creationElementHTML(arr, val);
    });

    inp.addEventListener("input", function (e) {
        var treeDivContent, b, c, treeParentUl, listRer, val = this.value;
        closeAllLists();

        currentFocus = -1;
        treeDivContent = document.createElement("DIV");
        treeDivContent.setAttribute("id", this.id + "autocomplete-list");
        treeDivContent.setAttribute("class", "autocomplete-items tree");
        this.parentNode.appendChild(treeDivContent);
        treeParentUl = document.createElement("ul");
        treeParentUl.setAttribute("id", "ul-list");
        treeDivContent.appendChild(treeParentUl);
        listRer = document.getElementById("ul-list").value;
        creationElementHTML(arr, val);           
    });

    function closeAllLists(element) {
        var ref = document.getElementsByClassName("autocomplete-items");

        for (var i = 0; i < ref.length; i++) {
            if (element != ref[i] && element != inp) {
                ref[i].parentNode.removeChild(ref[i]);
            }
        }
    }
}

autocomplete(document.getElementById("myInput"), data);

$(document).on('click', '#item-parent', function(){
    $('#myInput').val($(this).attr('data-name'));
    alert($(this).attr('data-name')+' '+$(this).attr('data-id'));
});

$(document).on('click', '#item-child', function(){
    $('#myInput').val($(this).attr('data-name'));
    alert($(this).attr('data-name')+' '+$(this).attr('data-id'));
});


function loadTreeViewList(){
    $( document ).ready( function( ) {
        $('.tree li' ).each( function() {
            if($( this ).children( 'ul' ).length > 0 ) {
                $( this ).addClass( 'parent' );   
            }
        });
        
        $('.tree li.parent > a').click( function( ) {
            $( this ).parent().toggleClass( 'active' );
            $( this ).parent().children( 'ul' ).slideToggle( 'fast' );
        });
        
        $( '#all' ).click( function() {
            $('.tree li').each( function() {
                $( this ).toggleClass( 'active' );
                $( this ).children( 'ul' ).slideToggle( 'fast' );
            });
        });

        $('.tree li').each( function() {
                $( this ).toggleClass( 'active' );
                $( this ).children( 'ul' ).slideToggle( 'fast' );
            });
            
    });
}

			   <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <link rel="stylesheet" href="css/style.css">
    <script src="http://code.jquery.com/jquery-1.7.2.min.js" type="text/javascript" > </script>

    <style>
        input {
            padding: 8px;
            font-size: 14px;
            border: 2px solid black;
            width: 250px;
        }

        .container-autocomplete {
            width: 100%; 
            height: 150px; 
            background-color: #e6eaef;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .autocomplete {
            position: relative;
            display: inline-block;
        }

        .autocomplete-items {
            background-color: white;
            position: absolute;
            border: 1px solid #d4d4d4;
            /*border-bottom: none;*/
            border-top: none;
            z-index: 999;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

        .autocomplete-items div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border-bottom: 1px solid #d4d4d4;
            display:block;
        }

        .autocomplete-items div:hover {
            background-color: #e9e9e9;
        }
    </style>

</head>
<body>

    <div class="container-autocomplete">
        <div class="autocomplete tree">
            <input type="text" id="myInput" placeholder="servicio">
        </div>
    </div>
    
    <script src="js/main.js" type="text/javascript"></script>
</body>
</html>


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





