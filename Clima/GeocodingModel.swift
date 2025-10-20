//
//  GeodecodingModel.swift
//  Clima
//
//  Created by Bogdan Teslarasu on 10.10.2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct GeocodingModel{
    let city: String
    let country: String
    let lat: Double
    let lon: Double
    
    var lonString: String{
        String(format: "%.4f", lon)
    }
    
    var latString: String{
        String(format: "%.4f", lat)
    }
}
