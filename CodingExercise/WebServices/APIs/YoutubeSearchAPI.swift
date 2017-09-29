//
//  YoutubeSearchAPI.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import Foundation

class YoutubeSearchAPI: BaseAPI {
    
    var searchString: String?
    
    override func baseUrl() -> String {
        return ""
    }
    
    override func requestUrl() -> String {
        return APIUrl.suffix.youtubeSearch.replacingOccurrences(of: "<searchString>", with: searchString ?? "")
    }
    
    // Call api and get results
    func search(text: String, completion: @escaping (_ response: YoutubeSearchAPIResponse?, _ error: String?) -> Void) {
        searchString = text
        self.execute { (dictionary, error, statusCode) in
            DispatchQueue.main.async {

                guard error == nil else { // there is error
                    completion(nil, error)
                    return
                }
                
                guard let results = dictionary as? Dictionary<String,Any>  else {
                    completion(nil, error)
                    return
                }
                
                let response = YoutubeSearchAPIResponse(dictionary: results)
                completion(response, nil)
            }
        }
    }
    
}
