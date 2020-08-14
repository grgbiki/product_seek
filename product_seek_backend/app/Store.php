<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Product;

class Store extends Model
{
  use SoftDeletes;

	protected $data=['deleted_at'];

	protected $guarded=[];

	public function productStore(){
		return $this->belongsToMany(Product::class);
	}
}
