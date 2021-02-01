<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportedoceController extends Controller
{
    public function consultar()
    {
        return view('reportedoce.consultar');
    }

    public function resultados(Request $request)
    {
 

        $maximo=$request->maximo;
 
        $data= DB::SELECT("select * from reporte_doce_data(?)", [$maximo]);
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
        return view('reportedoce.resultados')
            ->with('data',$data);
            
    }


}
