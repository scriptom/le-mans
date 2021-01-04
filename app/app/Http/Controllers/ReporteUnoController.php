<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ReporteUnoController extends Controller
{
    public function index()
    {
        // $prueba= DB::SELECT('SELECT nombre from pais');
        // dd($prueba);
        return view('welcome');
    }
}
