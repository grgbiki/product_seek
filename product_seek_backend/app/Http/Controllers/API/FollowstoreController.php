<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use App\Store;

class FollowstoreController extends Controller
{
	//follow store function
  public function user_follow(Request $request){
  	$this->validate($request,[
  		'user_id' => 'required',
  		'store_id' => 'required',
  	]);
  	$store=Store::findOrFail($request['store_id']);
  	$store->userFollow()->sync($request['user_id']);
  }
  //follow store function


  // unfollow store funtion
  public function user_unfollow(Request $request){
  	$this->validate($request,[
  		'user_id' => 'required',
  		'store_id' => 'required',
  	]);
		$store=Store::findOrFail($request['store_id']);
		$store->userFollow()->detach($request['user_id']);
  }
  // end unfollow store function
}
