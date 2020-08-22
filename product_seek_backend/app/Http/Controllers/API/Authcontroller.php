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

    public function update(Request $request,$id){
       $validateUser=$this->validate($request,[
        'name'=>['required'],
        'email'=>['email','required'],
        'password'=>['sometime','confirmed'],
        'address'=>['required'],
        'phone_number'=>'required',
      ]);

       $user=User::findOrFail($id);
         if($request->password){
           $user->update( [
                        'name'=>$request['name'],
                     'email'=>$request['email'],
                     'password'=>$request['password'],
                     'address'=>$request['address'],
                     'phone_number'=>$request['phone_number'],
                     'role'=>$request['role']
                   ]);
         }else{
           $user->update(  ['name'=>$request['name'],
                     'email'=>$request['email'],
                     'address'=>$request['address'],
                     'phone_number'=>$request['phone_number'],
                     'role'=>$request['role']
                     ]);
         }
      

        $accessToken= $user->createToken('authToken')->accessToken;

        return response(['user'=>$user,'access_token'=>$accessToken]);
    }
}
