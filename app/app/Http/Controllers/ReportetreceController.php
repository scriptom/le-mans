<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportetreceController extends Controller
{
    public function consultar()
    {
        $fabricantes_cauchos= DB::SELECT("select * from consultar_fabricantes_cauchos()");
        $fabricantes= DB::SELECT("select * from consultar_fabricantes()");
        return view('reportetrece.consultar')
            ->with('fabricantes',$fabricantes)
            ->with('fabricantes_cauchos',$fabricantes_cauchos);
    }

    public function resultados(Request $request)
    {
 
        // dd($request->all());
        if($request->check_fabricante){
            $data= DB::SELECT("select * from reporte_trece_autos(?)", [$request->fabricante]);
            $b_autos= 1;
        }
        else{
            $data= DB::SELECT("select * from reporte_trece_cauchos(?)", [$request->fabricante_cauchos]);
            $b_autos= 0;           
        }

//   dd($data);
        return view('reportetrece.resultados')
            ->with('data',$data)
            ->with('b_autos',$b_autos);
            
    }


}
