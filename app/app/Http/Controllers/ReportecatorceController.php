<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReportecatorceController extends Controller
{
    public function consultar()
    {
        return view('reportecatorce.consultar');
    }

    public function resultados(Request $request)
    {

        $data= DB::SELECT("select * from reporte_catorce()");
        foreach ($data as $item) {
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
        }


        return view('reportecatorce.resultados')
            ->with('data',$data);
            
    }


}
