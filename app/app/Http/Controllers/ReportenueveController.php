<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportenueveController extends Controller
{
    public function consultar()
    {
        return view('reportenueve.consultar');
    }

    public function resultados(Request $request)
    {
 
        $data= DB::SELECT("select * from reporte_nueve_data()");
        // dd($data);
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
            if($item->piloto_foto_pais){
                try{
                    $hex= $item->piloto_foto_pais;
                    // $hex= substr($hex, 5);
                    // $hex= mb_substr($hex, 0, -2);
                    $bin = hex2bin($hex);
                    $b64 = base64_encode($bin);
                    $item->piloto_foto_pais= $b64;
                }
                catch(Exception $e){
                    $item->piloto_foto_pais=NULL;
                }
            }
        }
        // dd($data);
        return view('reportenueve.resultados')
            ->with('data',$data);
            
    }


}
