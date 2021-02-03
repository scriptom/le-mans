<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportecuatroController extends Controller
{
    public function consultar()
    {
        $anos= DB::SELECT("select * from consultar_anos()");
        return view('reportecuatro.consultar')
            ->with('anos',$anos);
    }

    public function resultados(Request $request)
    {
 
        $ano=$request->ano;
        if($ano=='todos'){
            $ano=NULL;
        }

 
        $data= DB::SELECT("select * from reporte_cuatro_data(?)", [$ano]);
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
//   dd($data);
        return view('reportecuatro.resultados')
            ->with('data',$data);
            
    }


}