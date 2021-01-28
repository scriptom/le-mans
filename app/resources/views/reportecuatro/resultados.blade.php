@extends("layouts.app")
@section('content')

<div class="resultados">
    <h3>Mayores Ganadores Le Mans</h3>

    <table id="r3" class="table">
        <thead>
            <tr>
                <th scope="col">Año</th>
                <th scope="col">Equipo</th>
                <th scope="col">Numero Equipo</th>
                <th scope="col">Nacionalidad Equipo</th>
                <th scope="col">Piloto</th>
                <th scope="col">Nacionalidad Piloto</th>
                <th scope="col">Vehiculo</th>
                <th scope="col">Tipo Vehiculo</th>
                <th scope="col">Motor Vehiculo</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($data as $item)
                <tr>
                    <td>{{$item->ano}}</td>
                    <td>{{$item->nombre_equipo}}</td>
                    <td>{{$item->numero_equipo}}</td>
                    <td>{{$item->nacionalidad_equipo}}</td>
                    @if($item->foto_piloto)
                        <td imagen="{{$item->foto_piloto}}" class="desplegar-modal">{{$item->nombre_piloto}}</td>
                    @else
                        <td>{{$item->nombre_piloto}}</td>
                    @endif
                    <td>{{$item->nacionalidad_piloto}}</td>
                    @if($item->foto_vehiculo)
                        <td imagen="{{$item->foto_vehiculo}}" class="desplegar-modal">{{$item->vehiculo}}</td>
                    @else
                        <td>{{$item->vehiculo}}</td>
                    @endif
                    <td>{{$item->tipo_vehiculo}}</td>
                    <td>{{$item->motor_vehiculo}}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

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

    <!-- <img src="data:image/jpeg;base64,{{$data[0]->foto_piloto}}" alt="Base 64 encoded!" /> -->

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