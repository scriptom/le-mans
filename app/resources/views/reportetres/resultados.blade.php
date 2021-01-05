@extends("layouts.app")
@section('content')

<div class="resultados">
    <h3>Mayores Ganadores Le Mans</h3>

    <table id="example" class="table">
        <thead>
            <tr>
                <th scope="col">Año</th>
                <th scope="col">Equipo</th>
                <th scope="col">Numero Equipo</th>
                <th scope="col">Piloto</th>
                <th scope="col">Nacionalidad</th>
                <th scope="col">Vehiculo</th>
                <th scope="col">Tipo Vehiculo</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($data as $item)
                <tr>
                    <td>{{$item->ano}}</td>
                    <td>{{$item->nombre_equipo}}</td>
                    <td>{{$item->numero_equipo}}</td>
                    <td>{{$item->nombre_piloto}}</td>
                    <td>{{$item->nacionalidad_piloto}}</td>
                    <td>{{$item->nombre_vehiculo}}</td>
                    <td>{{$item->tipo_vehiculo}}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

</div>

@endsection