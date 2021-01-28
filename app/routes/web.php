<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');    
});

Route::get('/Reporte_tres', 'ReportetresController@consultar')->name('reportetres.consultar');
Route::post('/Reporte_tres/Resultados', 'ReportetresController@resultados')->name('reportetres.resultados');

Route::get('/Reporte_cuatro', 'ReportecuatroController@consultar')->name('reportecuatro.consultar');
Route::post('/Reporte_cuatro/Resultados', 'ReportecuatroController@resultados')->name('reportecuatro.resultados');

Route::get('/Reporte_cinco', 'ReportecincoController@consultar')->name('reportecinco.consultar');
Route::post('/Reporte_cinco/Resultados', 'ReportecincoController@resultados')->name('reportecinco.resultados');

Route::get('/Reporte_seis', 'ReporteseisController@consultar')->name('reporteseis.consultar');
Route::post('/Reporte_seis/Resultados', 'ReporteseisController@resultados')->name('reporteseis.resultados');

Route::get('/Reporte_siete', 'ReportesieteController@consultar')->name('reportesiete.consultar');
Route::post('/Reporte_siete/Resultados', 'ReportesieteController@resultados')->name('reportesiete.resultados');

Route::get('/Reporte_ocho', 'ReporteochoController@consultar')->name('reporteocho.consultar');
Route::post('/Reporte_ocho/Resultados', 'ReporteochoController@resultados')->name('reporteocho.resultados');

Route::get('/Reporte_nueve', 'ReportenueveController@consultar')->name('reportenueve.consultar');
Route::post('/Reporte_nueve/Resultados', 'ReportenueveController@resultados')->name('reportenueve.resultados');

Route::get('/Reporte_diez', 'ReportediezController@consultar')->name('reportediez.consultar');
Route::post('/Reporte_diez/Resultados', 'ReportediezController@resultados')->name('reportediez.resultados');

Route::get('/Reporte_once', 'ReporteonceController@consultar')->name('reporteonce.consultar');
Route::post('/Reporte_once/Resultados', 'ReporteonceController@resultados')->name('reporteonce.resultados');

Route::get('/Reporte_doce', 'ReportedoceController@consultar')->name('reportedoce.consultar');
Route::post('/Reporte_doce/Resultados', 'ReportedoceController@resultados')->name('reportedoce.resultados');

Route::get('/Reporte_trece', 'ReportetreceController@consultar')->name('reportetrece.consultar');
Route::post('/Reporte_trece/Resultados', 'ReportetreceController@resultados')->name('reportetrece.resultados');

Route::get('/Reporte_catorce', 'ReportecatorceController@consultar')->name('reportecatorce.consultar');
Route::post('/Reporte_catorce/Resultados', 'ReportecatorceController@resultados')->name('reportecatorce.resultados');

Route::get('/Reporte_quince', 'ReportequinceController@consultar')->name('reportequince.consultar');
Route::post('/Reporte_quince/Resultados', 'ReportequinceController@resultados')->name('reportequince.resultados');

Route::get('/Reporte_dieciseis', 'ReportedieciseisController@consultar')->name('reportedieciseis.consultar');
Route::post('/Reporte_dieciseis/Resultados', 'ReportedieciseisController@resultados')->name('reportedieciseis.resultados');

