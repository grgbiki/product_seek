<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Store;

class StoreController extends Controller
{

	// get paginated stores
	public function paginated_store(){
		return Store::latest()->with('productStore')->paginate(10);
	}
	//get paginated stores

	// get all stores
	public function all_stores(){
		return Store::latest()->with('productStore')->get();
	}
	//get all stores


	// create new store
  public function store(Request $request){
  	$this->validate($request,[
			'name'=>'required',
			'email'=>'required|email',
			'contact'=>'required',
			'address'=>'required',
			'google_maps_url'=>'required',
		]);

		Store::create([
			'name'=>$request['name'],
			'email'=>$request['email'],
			'contact'=>$request['contact'],
			'address'=>$request['address'],
			'google_maps_url'=>$request['google_maps_url'],
		]);
  }
  // create new store	 

  public function show($id){
		$store =  Store::latest();
		return $store->findOrFail($id);
	}

	// create new store
  public function update(Request $request,$id){
  	$store=Store::findOrFail($id);
  	$this->validate($request,[
			'name'=>'required',
			'email'=>'required|email',
			'contact'=>'required',
			'address'=>'required',
			'google_maps_url'=>'required',
		]);

		$store->update([
			'name'=>$request['name'],
			'email'=>$request['email'],
			'contact'=>$request['contact'],
			'address'=>$request['address'],
			'google_maps_url'=>$request['google_maps_url'],
		]);
  }
  // create new store	 
}
