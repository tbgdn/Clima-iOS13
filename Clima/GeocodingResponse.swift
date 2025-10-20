//
//  GeocodingResponse.swift
//  Clima
//
//  Created by Bogdan Teslarasu on 10.10.2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct GeocodingResponse: Codable{
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}
