@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Pilotos que nunca pisaron la meta</h3>
        <form method="POST" action="{{ route('reportecatorce.resultados') }}" enctype="multipart/form-data">
        @csrf          
            <button class="boton-consultar" type="submit">Consultar!</button>
        </form>
    </div>
    <div class="consultar-derecha">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/WiC6qw3YxBw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
</div>

@endsection





@section('scripts')
<script>
$("#check_fabricante").on('click', function() {
    var $box = $(this);
    if ($box.is(":checked")) {
        $("#check_fabricante_cauchos").prop("checked", false);
    }
});
$("#check_fabricante_cauchos").on('click', function() {
    var $box = $(this);
    if ($box.is(":checked")) {
        $("#check_fabricante").prop("checked", false);
    }
});
</script>


@endsection