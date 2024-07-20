<?php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\CustomerAddress;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller{
    
     public function address_list(Request $request)
    {
        return response()->json(CustomerAddress::where('user_id', $request->user()->id)->latest()->get(), 200);
    }

    public function info(Request $request)
    {
        $data = $request->user();
        
        $data['order_count'] =0;//(integer)$request->user()->orders->count();
        $data['member_since_days'] =(integer)$request->user()->created_at->diffInDays();
        //unset($data['orders']);
        return response()->json($data, 200);
    }
        public function add_new_address(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'contact_person_name' => 'nullable',
            'contact_person_number' => 'nullable',
            // 'address' => 'nullable',
          
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => "Error with the address"], 403);
        }


        $address = [
            'user_id' => $request->user()->id,
            'contact_person_name' => $request->contact_person_name,
            'contact_person_number' => $request->contact_person_number,
            // 'address' => $request->address,
            // 'longitude' => $request->longitude,
            // 'latitude' => $request->latitude,
            'created_at' => now(),
            'updated_at' => now()
        ];
        DB::table('customer_addresses')->insert($address);
        return response()->json(['message' => trans('messages.successfully_added')], 200);
    }
        public function update_address(Request $request,$id)
    {
        $validator = Validator::make($request->all(), [
            'contact_person_name' => 'nullable',
            'address_type' => 'nullable',
            'contact_person_number' => 'nullable',
            // 'address' => 'nullable',
            // 'longitude' => 'nullable',
            // 'latitude' => 'nullable',
        ]);

            if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }
        $user = User::create([
            'f_name' => $request->f_name,
            'email' => $request->f_email,
            'phone' => $request->phone,
            'password' => bcrypt($request->password),
        ]);
        /*$point = new Point($request->latitude,$request->latitude);
        $zone = Zone::contains('coordinates', $point)->first();
        if(!$zone)
        {
            $errors = [];
            array_push($errors, ['code' => 'coordinates', 'message' => trans('messages.out_of_coverage')]);
            return response()->json([
                'errors' => $errors
            ], 403);
        }*/
        $token = $user->createToken('RestaurantCustomerAuth')->accessToken;
        $address = [
            'user_id' => $request->user()->id,
            'contact_person_name' => $request->contact_person_name,
            'contact_person_number' => $request->contact_person_number,
            'address_type' => $request->address_type,
            // 'address' => $request->address,
            // 'longitude' => $request->longitude,
            // 'latitude' => $request->latitude,
            'zone_id' => 1,
            'created_at' => now(),
            'updated_at' => now()
        ];
        DB::table('customer_addresses')->where('user_id', $request->user()->id)->update($address);
        return response()->json(['message' => trans('messages.updated_successfully'),'zone_id'=>$zone->id], 200);
    }
}