@extends("layouts.app")
@section('content')

<div class="resultados">
<h3>Piloto {{$data_piloto->nombre}}</h3>

<div class="mb-3 resultados_bloque">
  <img src="data:image/jpeg;base64,{{$data_piloto->foto}}" alt="Base 64 encoded!" />
  <h5>Datos Personales</h5>
  <p><strong>Nombre:</strong> {{$data_piloto->nombre}}</p>

  <p><strong>Fecha de Nacimiento:</strong> {{$data_piloto->fecha_nacimiento}}</p>

  <p><strong>Fecha de Muerte:</strong> {{$data_piloto->fecha_muerte}}</p>

  <p><strong>Edad:</strong> {{$data_piloto->edad}}</p>

  <p><strong>Género:</strong> 
  @if($data_piloto->genero == 'F')
  Femenino
  @else
  Masculino
  @endif
  </p>


  <p><strong>País de Origen:</strong> 
  <span><img style="width: 25px; height: auto; margin:0px" src="data:image/jpeg;base64,{{$data_piloto->foto_pais}}" alt="Base 64 encoded!" /></span>
  {{$data_piloto->pais_origen}}</p>

  <p><strong>Nacionalidad:</strong> {{$data_piloto->nacionalidad}}</p>
</div>

<div class="mb-3 resultados_bloque">
  <h5>Datos Relevantes</h5>
  <p><strong>Año Primera Participación:</strong> {{$ano_primera_participacion}}</p>
  <p><strong>Pódium</strong></p>
  <ul></ul>
  @foreach($participaciones_relevantes as $item)
    <li style="width:100%"><p>Año: {{$item->ano}} -- Puesto Final: {{$item->puesto_final}}</p></li>
  @endforeach
  </ul>
</div>


<div class="resultados_completo">

<h5>Participaciones</h3>

<table id="r3" class="table">
    <thead>
        <tr>
            <th scope="col">Año</th>
            <th scope="col">Numero Equipo</th>
            <th scope="col">Equipo</th>
            <th scope="col">Piloto Acompañante</th>
            <th scope="col">Nacionalidad Acompañante</th>
            <th scope="col">Vehiculo</th>
            <th scope="col">Categoría Vehiculo</th>
            <th scope="col">Puesto Final</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($data_participaciones as $item)
            <tr>
                <td>{{$item->ano}}</td>
                <td>{{$item->numero_equipo}}</td>
                <td>{{$item->equipo_nombre}}</td>
                <td>{{$item->piloto_nombre}}</td>
                <td>
                @if($item->piloto_foto_pais)
                <span><img style="width: 25px; height: auto; margin:0px" src="data:image/jpeg;base64,{{$item->piloto_foto_pais}}" alt="Base 64 encoded!" /></span>
                @endif
                {{$item->piloto_pais}}
                </td>
                @if($item->auto_foto)
                    <td imagen="{{$item->auto_foto}}" class="desplegar-modal">{{$item->auto_modelo}}</td>
                @else
                    <td>{{$item->auto_modelo}}</td>
                @endif
                <td>{{$item->auto_categoria}}</td>
                <td>{{$item->puesto_final}}</td>
            </tr>
        @endforeach
    </tbody>
</table>

</div>



<div id="myModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</div>

@endsection

@section('scripts')
<script>
$(document).ready(function(){
    $(".desplegar-modal").on("click", function(){
      $(".modal-body").html("");
      $(".modal-title").html($(this).html());
      let srcimagen='data:image/jpeg;base64,' + $(this).attr('imagen');
      let tag='<img src="'+ srcimagen +'" alt="Base 64 encoded!" />';
      $(".modal-body").html(tag);
      $('#myModal').modal('show');
    });
  });
</script>

<script>
$(document).ready( function () {
    $('#r3').DataTable();
} );
</script>
@endsection