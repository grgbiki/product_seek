<?php

use Illuminate\Database\Seeder;
use App\User;
use Illuminate\Support\Facades\Hash;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      $users=array(
      	[
      		'name'         =>'Suraj Thapa Magar',
      		'email'        =>'suraj.mazar@gmail.com',
      		'phone_number' =>'9860151059',
      		'address'      =>'Budhanilkantha',
      		'role'				 =>'admin',
      		'password'		 =>'123456789'
      	],
      	[
      		'name'         =>'Bikram Gurung',
      		'email'        =>'gbikram53@gmail.com',
      		'phone_number' =>'9860151059',
      		'address'      =>'Gongabu',
      		'role'				 =>'admin',
      		'password'		 =>'123456789'
      	],
      );

      foreach ($users as $user){
      	User::create([
	      	'name'         =>$user['name'],
      		'email'        =>$user['email'],
      		'phone_number' =>$user['phone_number'],
      		'address'      =>$user['address'],
      		'role'				 =>$user['role'],
      		'password'		 =>Hash::make($user['password'])
	      ]);
	    }
    }
}
