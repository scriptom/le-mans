<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteochoController extends Controller
{
    public function consultar()
    {
        $anos= DB::SELECT("select * from consultar_anos()");
        return view('reporteocho.consultar')
            ->with('anos',$anos);
    }

    public function resultados(Request $request)
    {
 

        $ano=$request->ano;
        if($ano=='todos'){
            $ano=NULL;
        }

 
        $data= DB::SELECT("select * from reporte_ocho_data(?)", [$ano]);
        foreach ($data as $item) {
            if($item->piloto_foto){
                try{
                    $hex= $item->piloto_foto;
                    // $hex= substr($hex, 5);
                    // $hex= mb_substr($hex, 0, -2);
                    $bin = hex2bin($hex);
                    $b64 = base64_encode($bin);
                    $item->piloto_foto= $b64;
                }
                catch(Exception $e){
                    $item->piloto_foto=NULL;
                }
            }
        }
        return view('reporteocho.resultados')
            ->with('data',$data);
            
    }


}
