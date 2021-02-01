@extends("layouts.app")
@section('content')

<div class="consultar">
    <div class="consultar-izquierda">
        <h3 class="offest-top">Logros por modelo de auto</h3>
        <form method="POST" action="{{ route('reporteseis.resultados') }}" enctype="multipart/form-data">
        @csrf
            <div class="input-group">
                <label for="label-a">Seleccione el Modelo del auto</label>
                <select class="selectpicker show-menu-arrow" data-live-search="true" name="auto_id" id="label-a">
                    @foreach ($autos as $auto)
                    <option value="{{$auto->id}}">{{$auto->nombre}} - <strong>{{$auto->fabricante}}</strong></option>
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