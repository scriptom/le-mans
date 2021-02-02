@extends("layouts.app")
@section('content')

<div class="resultados">
<h3>Piloto mas veterano</h3>

<div class="w-75 resultados_completo">

<table id="r3" class="table">
    <thead>
        <tr>
            <th scope="col">Año Carrera</th>
            <th scope="col">Edad</th>
            <th scope="col">Nombre</th>
            <th scope="col">Nacionalidad</th>

        </tr>
    </thead>
    <tbody>

            <tr>
                <td>{{$item->ano}}</td>
                <td>{{$item->piloto_edad}}</td>
                    @if($item->piloto_foto)
                        <td imagen="{{$item->piloto_foto}}" class="desplegar-modal">{{$item->piloto_nombre}}</td>
                    @else
                        <td>{{$item->nombre_piloto}}</td>
                    @endif
                    <td>{{$item->piloto_pais}}</td>
            </tr>

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