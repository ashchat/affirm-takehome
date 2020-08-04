//
//  BusinessModel.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

public struct YelpAPIResponse: Codable {
    let businesses: [Business]
}

public struct Business: Codable {
    let id: String
    let name: String
    let rating: Double
    let imageURL: String = "image_url"
}
