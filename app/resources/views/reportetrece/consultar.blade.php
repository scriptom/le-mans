@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Logros por fabricante de vehiculos/cauchos</h3>
        <form method="POST" action="{{ route('reportetrece.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                
                <label for="label-a"><input id="check_fabricante" name="check_fabricante" class="mr-1" type="checkbox">Filtrar por Fabricante de autos</label>
                <select class="selectpicker show-menu-arrow" data-live-search="true" name="fabricante" id="label-a">
                    @foreach ($fabricantes as $fabricante)
                    <option value="{{$fabricante->fabricante}}">{{$fabricante->fabricante}}</strong></option>
                    @endforeach
                </select>
            </div>

            <div class="input-group">
            <label for="label-a"><input id="check_fabricante_cauchos" name="check_fabricante_cauchos" class="mr-1" type="checkbox">Filtrar por Fabricante de cauchos</label>
                <select class="selectpicker show-menu-arrow" data-live-search="true" name="fabricante_cauchos" id="label-a">
                    @foreach ($fabricantes_cauchos as $fabricante)
                    <option value="{{$fabricante->fabricante_caucho}}">{{$fabricante->fabricante_caucho}}</strong></option>
                    @endforeach
                </select>
            </div>            
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