//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Manibhushan Masabattina on 12/03/19.
//  Copyright © 2019 Manibhushan Masabattina. All rights reserved.
//

import XCTest
import Alamofire

@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherRequest(){
        
        let exp = expectation(description: "Weather api call expectation")
        
        //api.openweathermap.org/data/2.5/forecast?id=524901&APPID=0a9cf2ecfb78010399afa66ccf3356b6
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=0a9cf2ecfb78010399afa66ccf3356b6").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            let weather = try? JSONDecoder().decode(CurrentWeather.self, from: response.data!)
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10) { error in
            print("desc",error?.asAFError?.localizedDescription)
        }
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
