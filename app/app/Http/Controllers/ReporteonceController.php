<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteonceController extends Controller
{
    public function consultar()
    {
        $anos= DB::SELECT("select * from consultar_anos()");
        return view('reporteonce.consultar')
            ->with('anos',$anos);
    }

    public function resultados(Request $request)
    {
 

        $ano=$request->ano;
        if($ano=='todos'){
            $ano=NULL;
        }
 
        $data= DB::SELECT("select * from reporte_once_data(?)", [$ano]);
        // dd($data);
        foreach ($data as $item) {
            if($item->auto_foto){
                try{
                    $hex= $item->auto_foto;
                    // $hex= substr($hex, 5);
                    // $hex= mb_substr($hex, 0, -2);
                    $bin = hex2bin($hex);
                    $b64 = base64_encode($bin);
                    $item->auto_foto= $b64;
                }
                catch(Exception $e){
                    $item->auto_foto=NULL;
                }
            }
        }
//   dd($data);
        return view('reporteonce.resultados')
            ->with('data',$data);
            
    }


}
