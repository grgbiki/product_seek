<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/register','API\Authcontroller@register');
Route::post('/login','API\Authcontroller@login');


Route::get('/products','API\APIcontroller@products');
Route::get('/categories','API\APIcontroller@categories');
Route::get('/categories/show/{id}','API\APIcontroller@show_store');
Route::get('/stores','API\APIcontroller@stores');
Route::get('/stores/show/{id}','API\APIcontroller@show_category');
Route::get('/products/category/{id}','API\APIcontroller@filter_by_cat');
Route::get('/products/store/{id}','API\APIcontroller@filter_by_store');