@extends("layouts.app")
@section('content')

@foreach ($data_pilotos as $item)

<div class="resultados">
<h3>Piloto {{$item->nombre}}</h3>

<div class="mb-3 resultados_bloque">
  <img src="data:image/jpeg;base64,{{$item->foto}}" alt="Base 64 encoded!" />
  <h5>Datos Personales</h5>
  <p><strong>Nombre:</strong> {{$item->nombre}}</p>

  <p><strong>Fecha de Nacimiento:</strong> {{$item->fecha_nacimiento}}</p>

  <p><strong>Fecha de Muerte:</strong> {{$item->fecha_muerte}}</p>

  <p><strong>Edad:</strong> {{$item->edad}}</p>


  <p><strong>País de Origen:</strong> 
  <span><img style="width: 25px; height: auto; margin:0px" src="data:image/jpeg;base64,{{$item->foto_pais}}" alt="Base 64 encoded!" /></span>
  {{$item->pais_origen}}</p>

  <p><strong>Nacionalidad:</strong> {{$item->nacionalidad}}</p>
</div>

<div class="mb-3 resultados_bloque">
  <h5>Datos Relevantes</h5>
  <p><strong>Año Primera Participación:</strong> {{$item->ano_primera_participacion}}</p>
  <p><strong>Pódium</strong></p>
  <ul></ul>
  @foreach($item->participaciones_relevantes as $item2)
    <li style="width:100%"><p>Año: {{$item2->ano}} -- Puesto Final: {{$item2->puesto_final}}</p></li>
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
        @foreach ($item->data_participaciones as $item2)
            <tr>
                <td>{{$item2->ano}}</td>
                <td>{{$item2->numero_equipo}}</td>
                <td>{{$item2->equipo_nombre}}</td>
                <td>{{$item2->piloto_nombre}}</td>
                <td>
                @if($item2->piloto_foto_pais)
                <span><img style="width: 25px; height: auto; margin:0px" src="data:image/jpeg;base64,{{$item2->piloto_foto_pais}}" alt="Base 64 encoded!" /></span>
                @endif
                {{$item2->piloto_pais}}
                </td>
                @if($item2->auto_foto)
                    <td imagen="{{$item2->auto_foto}}" class="desplegar-modal">{{$item2->auto_modelo}}</td>
                @else
                    <td>{{$item2->auto_modelo}}</td>
                @endif
                <td>{{$item2->auto_categoria}}</td>
                <td>{{$item2->puesto_final}}</td>
            </tr>
        @endforeach
    </tbody>
</table>

</div>

</div>
@endforeach


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