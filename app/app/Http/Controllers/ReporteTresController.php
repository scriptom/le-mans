<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteTresController extends Controller
{
    public function consultar()
    {
        $anos= DB::SELECT("select * from consultar_anos()");
        // dd($anos);
        $categorias= DB::SELECT("select * from consultar_vehiculos_tipo()");
        return view('reportetres.consultar')
        ->with('anos',$anos)
        ->with('categorias',$categorias);
    }

    public function resultados(Request $request)
    {
        // dd($request->ano);
        if($request->ano=='Todos'){
            $ano=NUll;
        }
        else{
            $ano=$request->ano;
        }
        $data= DB::SELECT("select * from reporte_tres(?, ?)", [$ano,$request->categoria]);
        // dd($data);
        return view('reportetres.resultados')
        ->with('data',$data);
    }


}
