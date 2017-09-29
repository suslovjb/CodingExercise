//
//  BaseAPI.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import Foundation

/**
 Base API class
 
 To make a new api request, create a subclass of this class and override 'requestUrl()', 'baseUrl()'  methods to pass the url suffix
 
 # Advanced Options:
 * Base Url can be overrided - **baseUrl()**
 * Url suffix can be overrided - **requestUrl()**
 * Entire request url to be passed can be overrided - **buildUrl()**
 */
class BaseAPI: NSObject {
    
    typealias RequestCompletion = (_ data: AnyObject?, _ error: String?, _ statusCode:Int?) -> Void
    
    /**
     * Override this method in the subclass.
     * - returns : baseUrl string
     */
    func baseUrl() -> String {
        assert(false, "\(#function) must be overridden in '\(NSStringFromClass(type(of: self)))' class")
    }
    
    /**
     * Override this method in the subclass.
     * - returns : requestUrl string
     */
    func requestUrl() -> String {
        assert(false, "\(#function) must be overridden in '\(NSStringFromClass(type(of: self)))' class")
    }
    
    /**
     * Build request url
     * - returns: full url string
     */
    func buildUrl() -> String {
        return baseUrl() + requestUrl()
    }
    
    /**
     * Start a data task
     */
    func execute(completion:@escaping RequestCompletion) {
        
        if Reachability.isConnectedToNetwork() == false {
            completion(nil, "No Internet connectivity".localize(), APIError.noInternet) // return with no internet status
            return
        }
        
        let endPoint = self.buildUrl()
        guard let url = URL(string: endPoint) else {
            completion(nil, "Invalid Url".localize(), APIError.invalidUrl) // Unable to create URL from string provided
            return
        }
        
        // create request with session and start a data task
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }).resume()
    }
    
    /**
     * Process response received
     */
    func processResponse(data: Data?, response: URLResponse?, error: Error?, completion:@escaping RequestCompletion) {
        // Check for errors
        guard error == nil else {
            completion(nil, "Unable to fetch data.".localize(), APIError.generic)
            return
        }
        
        // Check for data is available
        guard let data = data else {
            completion(nil, "Unable to fetch data.".localize(), APIError.invalidData)
            return
        }
        
        // Check if valid status
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != HTTPStatus.ok {
                completion(nil, error?.localizedDescription, httpResponse.statusCode)
                return
            }
        }
        
        // Parse data
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                completion(nil, "Unable to fetch data.".localize(), APIError.invalidData)
                return
            }
            completion(json, nil, nil)
            
        } catch let error as NSError {
            completion(nil, error.localizedDescription, APIError.generic)
        }
    }
    
}
