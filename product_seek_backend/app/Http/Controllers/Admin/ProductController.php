<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Product;
use Illuminate\Support\Str;

class ProductController extends Controller

{

	// paginated products
	public function paginated_products(){
		return Product::latest()->with('productCategory','productStore')->paginate(10);
	}

	// end paginated products
	//add product

  public function store(Request $request){
  	$this->validate($request,[
  		'title'=>'required',
  		'price'=>'required',
  	]);

  	$slug=Str::slug($request->title,'-');
  	$images=$request->product_image;

  	if($images){

  		for($i=0; $i<count($images);$i++){
  			$product_images[$i]=$this->makeStoreProductImage($images[$i],$slug,$i);
  		}

  		$request->merge(['product_image'=>serialize($product_images)]);

  	}else{
  		$request->merge(['product_image'=>'no-image.jpg']);
  	}

  	$product=Product::create([

  		'title'=>$request['title'],
  		'price'=>$request['price'],
  		'product_image'=>$request['product_image'],
  		'description'=>$request['description'],

  	]);

  	if($request->category_id){
  		$product->productCategory()->sync($request->category_id);
  	}

  	if($request->store_id){
  		$product->productStore()->sync($request->store_id);
  	}

  }
  //add product

  // make store product image function
  public function makeStoreProductImage($image,$title,$index){
  	if($image){
			$imageName=$title.'-'.$index.'-'.time().'.'.explode('/',explode(':',substr($image,0,strpos($image, ';')))[1])[1];
			$imageExt=explode('.',$imageName);

			preg_match("/data:image\/(.*?);/",$image,$imageExt[1]); // extract the image extension
			$image = preg_replace('/data:image\/(.*?);base64,/','',$image); // remove the type part
			$image = str_replace(' ', '+', $image);

			\File::put(public_path('/images/uploads/') . $imageName, base64_decode($image));
		}else{
			$imageName='no-image.jpg';
		}

		return '/images/uploads/'.$imageName;
  }
  // end make store product image function

  //edit 
  public function show($id){
		$product =  Product::latest()->with('productCategory','productStore');
		$current_product=$product->findOrFail($id);
		if($current_product->product_image!='no-laptop-image.jpg'){
      $current_product->product_image=unserialize($current_product->product_image);
    }
		return $current_product;
	}
	//edit
}
