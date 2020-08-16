<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Feedback;

class Feedbackcontroller extends Controller
{
  
	// json for all feedbacks
  public function index(){
  	return Feedback::latest()->with('userFeedback')->paginate(10);
  }
  //json for all feed backs

}
