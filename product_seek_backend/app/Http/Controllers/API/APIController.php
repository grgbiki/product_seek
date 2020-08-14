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
  	$products= Product::latest()->with('productCategory','productStore')->get();

  	foreach ($products as $product){
  		$product->product_image=unserialize($product->product_image);
  	}

  	return $products;
  }

  public function categories(){
  	return Productcategory::latest()->get();
  }

  public function stores(){
  	return Store::latest()->get();
  }


  public function filter_by_cat($id){
  	$cat=Productcategory::findOrFail($id);
 		$products= Product::latest()->with('productCategory')->get();
 		
 		//filtercategory
 		$products=$this->filter_product_cat($products,$cat->id);
 		//filtercategory

 		return $products;
  }

   public function filter_by_store($id){
  	$store=Store::findOrFail($id);
 		$products= Product::latest()->with('productStore')->get();
 		
 		//filtercategory
 		$products=$this->filter_product_store($products,$store->id);
 		//filtercategory

 		return $products;
  }

  public function filter_product_cat($product,$category_id){
  	$filtered_products=[];
  	foreach($product as $p){
  		$productCategory=$p->productCategory;

  		$productCat_id=[];

  		foreach($productCategory as $pc){
  			array_push($productCat_id,$pc->id);
  		}	

  		if(in_array($category_id, $productCat_id)){
  			array_push($filtered_products,$p);
  		}

  	}
  	return $filtered_products;

  }
   public function filter_product_store($product,$category_id){
  	$filtered_products=[];
  	foreach($product as $p){
  		$productCategory=$p->productStore;

  		$productCat_id=[];

  		foreach($productCategory as $pc){
  			array_push($productCat_id,$pc->id);
  		}	

  		if(in_array($category_id, $productCat_id)){
  			array_push($filtered_products,$p);
  		}

  	}
  	return $filtered_products;

  }

  
}
