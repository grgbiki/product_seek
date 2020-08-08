<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Hash;
class Authcontroller extends Controller
{
    public function register(Request $request){

      $validateUser=$this->validate($request,[
        'name'=>['required'],
        'email'=>['email','required'],
        'password'=>['required','confirmed'],
        'address'=>['required'],
        'phone_number'=>'required',
        'role'=>['required']
      ]);

      $validateUser['password']= Hash::make($validateUser['password']);

      $user=User::create($validateUser);

      $accessToken= $user->createToken('authToken')->accessToken;

      return response(['user'=>$user,'access_token'=>$accessToken]);

    }

    public function login(Request $request){
      $loginData=$this->validate($request,[
        'email'=>'email|required',
        'password'=>'required',
      ]);

      if(!auth()->attempt($loginData)){
        return response(['message'=>'Invalid Credentials']);
      }

      $accessToken= auth()->user()->createToken('authToken')->accessToken;

      return response(['user'=>auth()->user(),'access_token'=>$accessToken]);


    }
}
