<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Order;

class OrderController extends Controller
{
  // paginated orders
  public function paginated_orders(){
  	$orders = Order::latest()->with('usersOrder')->paginate(10);

  	foreach($orders as $order){
  		$order->products=unserialize($order->products);
      $order->products->product_image=unserialize($order->products->product_image);
  	}

  	return $orders;
  }
  //get paginated orders


  // show particular order
  public function show($id){
  	$orders = Order::latest()->with('usersOrder');

  	$orders = $orders->findOrFail($id);
  	
  	$orders->products=unserialize($orders->products) ;
    $orders->products->product_image=unserialize($orders->products->product_image);

  	return  $orders ;
  }
  // end show particular order

   // update order
	public function update(Request $request,$id){
		$order=Order::findOrFail($id);

		$order->update([
			'status'=>$request['status']
		]);
	}
  // end update order



  //return requested orders
  public function requested_orders(){
    $orders = Order::latest()->with('usersOrder')->where('return_request',true)->paginate(10);

    foreach($orders as $order){
      $order->products=unserialize($order->products);
      $order->products->product_image=unserialize($order->products->product_image);
    }

    return $orders;
  }
  //end return requested orders

  // approve return  
  public function approve_return($id){
    $order=Order::findOrFail($id);

    $order->update([
      'status'=>'Returned',
      'returned'=>true,
    ]);
  }
  // approve return

   // approve return  
  public function disapprove_return($id){
    $order=Order::findOrFail($id);

    $order->update([
      'status'=>'Processing',
      'returned'=>false,
    ]);
  }
  // approve return
}
