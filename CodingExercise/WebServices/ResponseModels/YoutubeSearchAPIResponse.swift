//
//  YoutubeSearchAPIResponse.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import Foundation

class YoutubeSearchAPIResponse {
    
    var items: [YoutubeSearchItem]?
 
    /**
     * Populate object from dictionary
     */
    init(dictionary: Dictionary<String, Any>) {
       
        self.items = []
        if dictionary[APIKey.items] == nil {
            return
        }
        guard let results = dictionary[APIKey.items] as? [ Dictionary<String,Any> ] else {
            return
        }
        
        for itemDetails in results {
            let identityDetails = itemDetails[APIKey.idKey] as! Dictionary<String, String>
            if identityDetails[APIKey.kind] == "youtube#video" {
                self.items!.append(YoutubeSearchItem(dictionary: itemDetails))

            }
        }
    }
}
