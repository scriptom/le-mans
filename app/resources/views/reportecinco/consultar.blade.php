@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Mayores Ganadores en Le Mans</h3>
        <form method="POST" action="{{ route('reportecinco.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                <label for="label-a">Seleccione el Piloto</label>
                <select name="piloto" id="label-a">
                    @foreach ($pilotos as $piloto)
                    <option value="{{$piloto->id}}">{{$piloto->nombre}}</option>
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