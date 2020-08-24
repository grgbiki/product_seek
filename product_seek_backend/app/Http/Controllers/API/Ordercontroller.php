<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Order;

class Ordercontroller extends Controller
{
  
  // make order
	public function store(Request $request){

		$this->validate($request,[
			'user_id'=>'required',
			'total_amount'=>'required'
		]);


		$orderno='order-'.strtotime(date('m/d/Y h:i:s a', time()));


		$products=json_decode($request->products);

		foreach ($products as $product){
			$p=$product->product;
			$p->product_image=json_decode($p->product_image);
		}

		$order=Order::create([
			'order_no' => $orderno,
			'products'  => serialize($products),
			'user_id'  => $request['user_id'],
			'status'   => 'processing',
			'total'    => $request['total_amount'],
		]);

		$order->usersOrder()->sync($request->user_id);

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
		}

		return $orders;
	}
  //end get order by user id
}


