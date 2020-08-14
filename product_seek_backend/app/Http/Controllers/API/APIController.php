<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Product;
use App\Productcategory;
use App\Store;

class APIController extends Controller
{
  public function products(){
  	return Product::latest()->get();
  }

  public function categories(){
  	return Productcategory::latest()->get();
  }

  public function stores(){
  	return Store::latest()->get();
  }
}
