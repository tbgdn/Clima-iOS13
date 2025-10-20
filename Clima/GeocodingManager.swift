//
//  GeodecodingManager.swift
//  Clima
//
//  Created by Bogdan Teslarasu on 10.10.2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol GeocodingManagerDelegate{
    func didUpdateGeocoding(_ geocoding: GeocodingModel)
    func didEndWithError(error: Error?)
}

extension GeocodingManagerDelegate{
    func didUpdateWeather(_ geocoding: GeocodingModel){
        
    }
    
    func didEndWithError(error: Error?){
        
    }
}


struct GeocodingManager: OpenWeatherManagerDelegate{
    
    let geodecodingUrl = "https://api.openweathermap.org/geo/1.0/direct?limit=1&appid=xxx&units=metric"
    var delegate: GeocodingManagerDelegate?
    
    func fetchGeocodingLocation(cityName: String){
        let urlString = "\(geodecodingUrl)&q=\(cityName)"
        let openWeatherManager = OpenWeatherManager(delegate: self)
        openWeatherManager.performRequest(urlString)
    }
    
    func processData(_ data: Data){
        if let geocodingModel = parseData(data){
            delegate?.didUpdateGeocoding(geocodingModel)
        }
    }
    
    func parseData(_ data: Data) -> GeocodingModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([GeocodingResponse].self, from: data)
            if let firstLocation = decodedData.first{
                let cityName = firstLocation.name
                let countryName = firstLocation.country
                let lat = firstLocation.lat
                let long = firstLocation.lon
                return GeocodingModel(city: cityName, country: countryName, lat: lat, lon: long)
            }else{
                return nil
            }
            
        }catch{
            print(error)
            return nil
        }
    }
    
    func processError(_ error: (any Error)?) {
        delegate?.didEndWithError(error: error)
    }
}
