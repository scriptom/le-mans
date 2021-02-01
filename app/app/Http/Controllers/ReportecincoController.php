<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteCincoController extends Controller
{
    public function consultar()
    {
        $pilotos= DB::SELECT("select * from consultar_pilotos()");
        return view('reportecinco.consultar')
            ->with('pilotos',$pilotos);
    }

    public function resultados(Request $request)
    {
 

        $piloto_id=$request->piloto_id;
 
        $data_piloto= DB::SELECT("select * from reporte_cinco_data_piloto(?)", [$piloto_id]);
        foreach ($data_piloto as $item) {
            if($item->foto){
                try{
                    $hex= $item->foto;
                    // $hex= substr($hex, 5);
                    // $hex= mb_substr($hex, 0, -2);
                    $bin = hex2bin($hex);
                    $b64 = base64_encode($bin);
                    $item->foto= $b64;
                }
                catch(Exception $e){
                    $item->foto=NULL;
                }
            }
            if($item->foto_pais){
                try{
                    $hex= $item->foto_pais;
                    // $hex= substr($hex, 5);
                    // $hex= mb_substr($hex, 0, -2);
                    $bin = hex2bin($hex);
                    $b64 = base64_encode($bin);
                    $item->foto_pais= $b64;
                }
                catch(Exception $e){
                    $item->foto_pais=NULL;
                }
            }
        }
        $data_piloto=$data_piloto[0];
 

        $data_participaciones= DB::SELECT("select * from reporte_cinco_data_participaciones(?)", [$piloto_id]);

        foreach ($data_participaciones as $item) {
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


       if(count($data_participaciones)==0){
           $ano_primera_participacion='No Aplica';
           $participaciones_relevantes=array();
       }
       else{
            $ano_primera_participacion= $data_participaciones[0]->ano;
            $participaciones_relevantes= array();
            foreach ($data_participaciones as $item) {
                if($item->ano<$ano_primera_participacion){
                    $ano_primera_participacion=$item->ano;
                }
                if($item->puesto_final==1 or $item->puesto_final==2 or $item->puesto_final==3){
                    array_push($participaciones_relevantes, $item);
                }
            }
        }
        // dd($ano_primera_participacion);

        // dd($participaciones_relevantes);
        
        
        return view('reportecinco.resultados')
            ->with('data_piloto',$data_piloto)
            ->with('data_participaciones',$data_participaciones)
            ->with('ano_primera_participacion',$ano_primera_participacion)
            ->with('participaciones_relevantes',$participaciones_relevantes);
            
    }


}
