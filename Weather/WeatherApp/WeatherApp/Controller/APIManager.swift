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
    class func getResponseAboutWeatherApi(_ latitude : Double , _ longitude : Double , _ currentViewcontroller : UIViewController , callback : @escaping (CurrentWeather? ,Bool,String?) -> ()){
        AF.request(Constants.weatherApi + "&lat=\(latitude)&lon=\(longitude)").responseJSON { response in
        
            if response.response?.statusCode != 200 {
                callback(nil , false,"Request failed plsease check network.")
                return
            }
            let weather = try? JSONDecoder().decode(CurrentWeather.self, from: response.data!)
            if let json = weather {
                print("JSON: \(json)") // serialized json response
                callback(nil , true,"")
                return
            }
            callback(nil , false,"Failed in Json Parsing/Decoding")
        }
    }
}

