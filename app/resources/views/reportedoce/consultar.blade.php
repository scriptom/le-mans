@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Distancias mas largas</h3>
        <form method="POST" action="{{ route('reportedoce.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                <label for="label-a">Número de participaciones</label>
                <input name="maximo" min="1" max="500" required type="number">
            </div>
            <button class="boton-consultar" type="submit">Consultar!</button>
        </form>
    </div>
    <div class="consultar-derecha">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/WiC6qw3YxBw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
</div>

@endsection