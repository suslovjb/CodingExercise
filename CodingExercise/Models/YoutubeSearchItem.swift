//
//  YoutubeSearchItem.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import UIKit

class YoutubeSearchItem: NSObject {
    
    var title: String?
    var videoDescription: String?
    var channelTitle: String?
    var videoId: String?
    var thumbnailUrl: URL?
    
    /**
     * Populate object from dictionary
     */
    init(dictionary: Dictionary<String, Any>) {
 
        if dictionary[APIKey.snippet] == nil || dictionary["id"] == nil {
            return
        }
        let snippet = dictionary[APIKey.snippet] as! Dictionary<String, AnyObject>
        let identityDetails = dictionary[APIKey.idKey] as! Dictionary<String, AnyObject>

        title = snippet[APIKey.title] as? String
        channelTitle = snippet[APIKey.channelTitle] as? String
        videoDescription = snippet[APIKey.description] as? String

        videoId = identityDetails[APIKey.videoId] as? String
        
        guard let thumbnailDetails = snippet[APIKey.thumbnails] as? Dictionary<String, AnyObject> else {
            return
        }
        if thumbnailDetails[APIKey.high] == nil {
            return
        }
        let url = thumbnailDetails[APIKey.high]?[APIKey.url] as? String
        thumbnailUrl = URL(string: url ?? "")
    }


}
