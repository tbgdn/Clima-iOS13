//
//  WeatherManager.swift
//  Clima
//
//  Created by Bogdan Teslarasu on 06.10.2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(error: Error?)
}

extension WeatherManagerDelegate{
    func didUpdateWeather(_ weather: WeatherModel){
        
    }
    
    func didFailWithError(error: Error?){
        
    }
}

struct WeatherManager: OpenWeatherManagerDelegate{
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=xxx&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(geocoding: GeocodingModel){
        let urlString = "\(weatherUrl)&lat=\(geocoding.latString)&lon=\(geocoding.lonString)"
        let openWeatherManager = OpenWeatherManager(delegate: self)
        openWeatherManager.performRequest(urlString)
    }
    
    func processData(_ data: Data) {
        if let weatherModel = parseData(data){
            delegate?.didUpdateWeather(weatherModel)
        }
    }
    
    func parseData(_ data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let temperature = decodedData.main.temp
            let city = decodedData.name
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(conditionId: id, city: city, temperature: temperature)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            
            return weather
        }catch{
            print(error)
            return nil
        }
    }
    
    func processError(_ error: (any Error)?) {
        delegate?.didFailWithError(error: error)
    }
}
