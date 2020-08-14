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
  	$products= Product::latest()->get();

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


  // public function filter_by_cat($id){
  // 	$cat=Productcategory::findOrFail($id);
 	// 	$products= Product::latest()->with('productCategory')->get();
 		
 	// 	//filtercategory
 	// 	$products=$this->filter_product_cat($products,$cat->id);
 	// 	//filtercategory

 	// 	return $products;
  // }

  //  public function filter_by_store($id){
  // 	$store=Store::findOrFail($id);
 	// 	$products= Product::latest()->with('productStore')->get();
 		
 	// 	//filtercategory
 	// 	$products=$this->filter_product_store($products,$store->id);
 	// 	//filtercategory

 	// 	return $products;
  // }

  // public function filter_product_cat($product,$category_id){
  // 	$filtered_blogs=[];
  // 	$filtered_blogs_count=0;

  // 	foreach($product as $b){

  // 		$blog_categories=[$b->product_category];//blog category
  // 		$blog_cat_ids=[];

  // 		for($i=0;$i<count($blog_categories);$i++){
  // 			$blog_cat_ids[$i]=$blog_categories[$i]['id'];
  // 		}

  // 		if(in_array($category_id, $blog_cat_ids)){
  // 			$filtered_blogs[$filtered_blogs_count]=$b;
  // 			$filtered_blogs_count++;
  // 		}
  // 	}

  // 	return $filtered_blogs;
  // }

  // public function filter_product_store($product,$category_id){
  // 	$filtered_blogs=[];
  // 	$filtered_blogs_count=0;

  // 	foreach($product as $b){

  // 		$blog_categories=[$b->product_store];//blog category
  // 		$blog_cat_ids=[];

  // 		for($i=0;$i<count($blog_categories);$i++){
  // 			$blog_cat_ids[$i]=$blog_categories[$i]->id;
  // 		}

  // 		if(in_array($category_id, $blog_cat_ids)){
  // 			$filtered_blogs[$filtered_blogs_count]=$b;
  // 			$filtered_blogs_count++;
  // 		}
  // 	}

  // 	return $filtered_blogs;
  // }
}
