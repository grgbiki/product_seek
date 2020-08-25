<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Order;
use App\Product;

class Ordercontroller extends Controller
{
  
  // make order
	public function store(Request $request){

		$this->validate($request,[
			'user_id'=>'required',
		]);


		$orderno='order-'.strtotime(date('m/d/Y h:i:s a', time()));


		$products=json_decode($request->products);

		foreach ($products as $product){

			$p=$product->product;

			$prod=Product::latest()->with('productCategory','productStore');

			$prod=$prod->findOrFail($p->id);

			$order=Order::create([
				'order_no' => $orderno,
				'products' => serialize($prod),
				'user_id'  => $request['user_id'],
				'quantity' => $product->quantity,
				'status'   => 'Processing',
				'total'    => $product->total_price,
			]);

			$order->usersOrder()->sync($request->user_id);

			$p->product_image=json_decode($p->product_image);
		}


		// return $products;

	}
  // end make order function

  // update order
	public function cancle($id){
		$order=Order::findOrFail($id);

		$order->update([
			'status'=>'cancled'
		]);
	}
  // end update order


  // get orders by user id
	public function get_order($user_id){
		$orders = Order::latest()->where('user_id',$user_id)->get();
		foreach($orders as $order){
			$order->products=unserialize($order->products) ;
			$order->products->product_image=unserialize($order->products->product_image);
		}

		return $orders;
	}
  //end get order by user id
}

// [
//    {
//       "product":{
//          "id":1,
//          "title":"Pant",
//          "price":55.0,
//          "description":"This is pant for male",
//          "product_image":"[\"/images/uploads/pants-1.jpeg\",\"/images/uploads/pants-2.jpeg\"]",
//          "product_category_id":1,
//          "product_store_id":1
//       },
//       "quantity":1,
//       "total_price":55.0
//    },
//    {
//       "product":{
//          "id":4,
//          "title":"Ear Rings",
//          "price":50.0,
//          "description":"This is Ear Rings",
//          "product_image":"[\"/images/uploads/ear-ring-1.jpg\",\"/images/uploads/ear-ring-2.jpg\"]",
//          "product_category_id":2,
//          "product_store_id":3
//       },
//       "quantity":3,
//       "total_price":150.0
//    }
// ]


