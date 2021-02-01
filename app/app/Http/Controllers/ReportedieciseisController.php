<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportedieciseisController extends Controller
{
    public function consultar()
    {
        $anos= DB::SELECT("select * from consultar_anos()");
        return view('reportedieciseis.consultar')
            ->with('anos',$anos);
    }

    public function resultados(Request $request)
    {
 

        $ano=$request->ano;
        if($ano=='todos'){
            $ano=NULL;
        }

 
        $data_pilotos= DB::SELECT("select * from reporte_dieciseis_data_piloto(?)", [$ano]);
        foreach ($data_pilotos as $item) {
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

            $item->data_participaciones= DB::SELECT("select * from reporte_cinco_data_participaciones(?)", [$item->id]);
            foreach ($item->data_participaciones as $item2) {
                if($item2->auto_foto){
                    try{
                        $hex= $item2->auto_foto;
                        // $hex= substr($hex, 5);
                        // $hex= mb_substr($hex, 0, -2);
                        $bin = hex2bin($hex);
                        $b64 = base64_encode($bin);
                        $item2->auto_foto= $b64;
                    }
                    catch(Exception $e){
                        $item2->auto_foto=NULL;
                    }
                }
                if($item2->piloto_foto_pais){
                    try{
                        $hex= $item2->piloto_foto_pais;
                        // $hex= substr($hex, 5);
                        // $hex= mb_substr($hex, 0, -2);
                        $bin = hex2bin($hex);
                        $b64 = base64_encode($bin);
                        $item2->piloto_foto_pais= $b64;
                    }
                    catch(Exception $e){
                        $item2->piloto_foto_pais=NULL;
                    }
                }
            }

            if(count($item->data_participaciones)==0){
                $item->ano_primera_participacion='No Aplica';
                $item->participaciones_relevantes=array();
            }
            else{
                 $item->ano_primera_participacion= $item->data_participaciones[0]->ano;
                 $item->participaciones_relevantes= array();
                 foreach ($item->data_participaciones as $item3) {
                     if($item3->ano<$item->ano_primera_participacion){
                         $item->ano_primera_participacion=$item3->ano;
                     }
                     if($item3->puesto_final==1 or $item3->puesto_final==2 or $item3->puesto_final==3){
                         array_push($item->participaciones_relevantes, $item3);
                     }
                 }
             }


        }

        // dd($data_pilotos);
   
        
        return view('reportedieciseis.resultados')
            ->with('data_pilotos',$data_pilotos);
            
    }


}
