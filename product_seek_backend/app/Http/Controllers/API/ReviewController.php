<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Review;

class ReviewController extends Controller
{
   
  public function addReview(Request $request){

  	$this->validate($request,[
  		'review'=>'required',
  		'user_id'=>'required',
  		'product_id'=>'required',
  	]);

  	$review = Review::create([
  		'review'=> $request['review'],
  		'user_id'=>$request['user_id']
  	]);


  	$review->productReview()->sync($request['product_id']);
   	
  }
}
