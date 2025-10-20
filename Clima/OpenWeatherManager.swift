//
//  OpenWeatherManager.swift
//  Clima
//
//  Created by Bogdan Teslarasu on 10.10.2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol OpenWeatherManagerDelegate{
    func processData(_ data: Data)
    func processError(_ error: Error?)
}

struct OpenWeatherManager{
    
    var delegate: OpenWeatherManagerDelegate?
    
    init(delegate: OpenWeatherManagerDelegate?){
        self.delegate = delegate
    }
    
    func performRequest(_ url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    if let safeData = data{
                        delegate?.processData(safeData)
                    }
                }else{
                    DispatchQueue.main.async{
                        delegate?.processError(error)
                    }
                    return
                }
            }
            
            task.resume()
        }
    }
}
