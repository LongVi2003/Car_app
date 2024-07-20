<?php

namespace App\Http\Controllers;

use App\Models\Address;
use Illuminate\Http\Request;

class AddressController extends Controller
{
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'address_type' => 'required',
            'contact_person_name' => 'required',
            'contact_person_number' => 'required',
            // 'address' => 'required',
        ]);

        $address = Address::create($validatedData);

        return response()->json(['message' => 'Address saved successfully', 'address' => $address], 201);
    }
}

