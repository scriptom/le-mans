<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteseisController extends Controller
{
    public function consultar()
    {
        $autos= DB::SELECT("select * from consultar_modelos_autos()");
        return view('reporteseis.consultar')
            ->with('autos',$autos);
    }

    public function resultados(Request $request)
    {
 

        $auto_id=$request->auto_id;
        // dd($auto_id);
 
        $data= DB::SELECT("select * from reporte_seis_data(?)", [$auto_id]);
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
//   dd($data);
        return view('reporteseis.resultados')
            ->with('data',$data);
            
    }


}
