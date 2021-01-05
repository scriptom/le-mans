@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Mayores Ganadores en Le Mans</h3>
        <form method="POST" action="{{ route('reportetres.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                <label for="ano">Seleccione el Año</label>
                <select name="ano" id="ano">
                <option value="Todos">Todos</option>
                    @foreach ($anos as $ano)
                    <option value="{{$ano->ano}}">{{$ano->ano}}</option>
                    @endforeach
                </select>
            </div>
            <div class="input-group">
                <label for="ano">Seleccione la Categoría</label>
                <select name="categoria" id="ano">
                    @foreach ($categorias as $categoria)
                    <option value="{{$categoria->tipo}}">{{$categoria->tipo}}</option>
                    @endforeach
                </select>
            </div>
            <button type="submit">Consultar!</button>
        </form>
    </div>
    <div class="consultar-derecha">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/WiC6qw3YxBw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
</div>

@endsection