//
//  YoutubeSearchResponse.swift
//  MovieApp-UIKit
//
//  Created by Berkay Disli on 18.03.2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: VideoElementID
}

struct VideoElementID: Codable {
    let kind: String
    let videoId: String
}
