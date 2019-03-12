//
//  ViewController.swift
//  WeatherApp
//
//  Created by Manibhushan Masabattina on 12/03/19.
//  Copyright © 2019 Manibhushan Masabattina. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherLocationLabel : UILabel!
    @IBOutlet weak var weatherDescriptionLabel : UILabel!
    @IBOutlet weak var temparatureLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var sunsetTimeLabel : UILabel!
    @IBOutlet weak var sunriseTimeLabel : UILabel!
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}
extension WeatherViewController :  CLLocationManagerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        // Fetching Today Weather
        APIManger.getResponseAboutWeatherApi(userLocation.coordinate.latitude, userLocation.coordinate.longitude, self){ (Data) in
            if let weather = Data {
                OperationQueue.main.addOperation {
                    self.weatherLocationLabel.text  = String(describing: (weather.name)!)
                    self.weatherDescriptionLabel.text  = String(describing: (weather.weather?.first?.description)!)
                    self.humidityLabel.text  = String(describing: (weather.main?.humidity)!)
                    self.temparatureLabel.text  = String(describing: (weather.main?.temp)!)
                    self.sunriseTimeLabel.text  = Utils.getStringDateFromTimeStamp(longNumber: Double(weather.sys?.sunrise ?? 1552362311), requiredDateFormat: Constants.TimeFormat)
                    self.sunsetTimeLabel.text  = Utils.getStringDateFromTimeStamp(longNumber: Double(weather.sys?.sunset ?? 1552404830), requiredDateFormat: Constants.TimeFormat)
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

