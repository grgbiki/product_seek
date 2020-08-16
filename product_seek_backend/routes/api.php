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

Route::post('/register','API\Authcontroller@register');//api route for register
Route::post('/login','API\Authcontroller@login');//api route for login


Route::get('/products','API\APIcontroller@products');
//api route for all products

Route::get('/products/search/{search_term}','API\APIcontroller@product_search');
//api route for products search

Route::get('/categories','API\APIcontroller@categories');
//api route for all products category

Route::get('/categories/show/{id}','API\APIcontroller@show_store');
//api route products category by id

Route::get('/stores','API\APIcontroller@stores');//api route for all stores


Route::get('/stores/show/{id}','API\APIcontroller@show_category');
//api route for products store by id

Route::get('/products/category/{id}','API\APIcontroller@filter_by_cat');
//api route for products filtered by category id

Route::get('/products/store/{id}','API\APIcontroller@filter_by_store');
//api route for products filtered by store id


Route::post('/feedback/create','API\FeedbackController@store');//create feedback

Route::put('/feedback/update/{id}','API\FeedbackController@update');//update feedback

Route::get('/feedback/{user_id}','API\FeedbackController@getFeedback');//update feedback