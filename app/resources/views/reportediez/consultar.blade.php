@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Ganadores en su primera participación</h3>
        <form method="POST" action="{{ route('reportediez.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                <label for="label-a">Seleccione el año</label>
                <select class="selectpicker show-menu-arrow" data-live-search="true" name="ano" id="label-a">
                <option value="todos">Todos</option>
                    @foreach ($anos as $ano)
                    <option value="{{$ano->ano}}">{{$ano->ano}}</option>
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