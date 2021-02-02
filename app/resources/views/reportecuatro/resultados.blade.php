@extends("layouts.app")
@section('content')

<div class="resultados">
<h3>Resultados por numero de equipo</h3>

<div class="w-100 resultados_completo">

<table id="r3" class="table">
    <thead>
        <tr>
            <th scope="col">Año</th>
            <th scope="col">Número Equipo</th>
            <th scope="col">Nacionalidad Equipo</th>
            <th scope="col">Vehículo</th>
            <th scope="col">Categoría</th>
            <th scope="col">Motor</th>
            <th scope="col">Piloto</th>
            <th scope="col">Pais</th>
            <th scope="col">Puesto</th>
            <th scope="col">Vueltas</th>
            <th scope="col">Distancia R.</th>
            <th scope="col">Diferencia Anterior</th>

        </tr>
    </thead>
    <tbody>
          @foreach($data as $item)
            <tr>
                <td>{{$item->ano}}</td>

                <td>{{$item->numero_equipo}}</td>

                <td>{{$item->equipo_nacionalidad}}</td>

                @if($item->auto_foto)
                    <td imagen="{{$item->auto_foto}}" class="desplegar-modal">{{$item->auto_modelo}}</td>
                @else
                    <td>{{$item->auto_modelo}}</td>
                @endif

                <td>{{$item->auto_categoria}}</td>

                <td>{{$item->auto_motor}}</td>


                @if($item->piloto_foto)
                  <td imagen="{{$item->piloto_foto}}" class="desplegar-modal">{{$item->piloto_nombre}}</td>
                @else
                  <td>{{$item->piloto_nombre}}</td>
                @endif
    
                <td>
                @if($item->piloto_foto_pais)
                <span><img style="width: 25px; height: auto; margin:0px" src="data:image/jpeg;base64,{{$item->piloto_foto_pais}}" alt="Base 64 encoded!" /></span>
                @endif
                {{$item->piloto_pais}}
                </td>

                <td>{{$item->puesto_final}}</td>

                <td>{{$item->cantidad_vueltas}}</td>

                <td>{{$item->distancia_recorrida}}</td>

                <td>{{$item->diferencia_puesto_anterior_vueltas}}V - {{$item->diferencia_puesto_anterior_tiempo}}</td>




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