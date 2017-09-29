//
//  APIConstants.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import Foundation

// Related to API calls

// API Urls
struct APIUrl {
    static let base = ""
    struct suffix {
        static let youtubeSearch = "https://www.googleapis.com/youtube/v3/search?q=<searchString>&maxResults=50&part=snippet&key=AIzaSyBX-b_WR7yAUci1QJhVUFp7wtKyeZE-IIU"
    }
    
}

// Params and Keys
struct APIKey {
    static let high = "high"
    static let snippet = "snippet"
    static let title = "title"
    static let description = "description"
    static let channelTitle = "channelTitle"
    static let videoId = "videoId"
    static let idKey = "id"
    static let thumbnails = "thumbnails"
    static let url = "url"
    static let items = "items"
    static let kind = "kind"

}

// API Error
struct APIError {
    static let generic      = 0
    static let noInternet   = 1
    static let invalidUrl   = 2
    static let invalidData  = 3
}

// Status Codes
struct HTTPStatus {
    static let ok = 200
}
