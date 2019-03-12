//
//  APIManager.swift
//  WeatherApp
//
//  Created by user147463 on 3/12/19.
//  Copyright © 2019 Manibhushan Masabattina. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIManger : NSObject {
    class func getResponseAboutWeatherApi(_ latitude : Double , _ longitude : Double , _ currentViewcontroller : UIViewController , callback : @escaping (CurrentWeather?) -> ()){
        AF.request(Constants.weatherApi + "&lat=\(latitude)&lon=\(longitude)").responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            let weather = try? JSONDecoder().decode(CurrentWeather.self, from: response.data!)
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                callback(weather)
            }
        }
    }
}

