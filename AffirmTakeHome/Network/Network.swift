//
//  YelpAPI.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class Network {
    
    let token = "itoMaM6DJBtqD54BHSZQY9WdWR5xI_CnpZdxa3SG5i7N0M37VK1HklDDF4ifYh8SI-P2kI_mRj5KRSF4_FhTUAkEw322L8L8RY6bF1UB8jFx3TOR0-wW6Tk0KftNXXYx"

    func fetchYelpResults(latitude: Double, longitude: Double, offset: Int, term: String, completion: @escaping (YelpAPIResponse?, Error?) -> Void) {
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?location=NYC&offset=\(offset)&limit=10&radius=1000&term=\(term)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(YelpAPIResponse.self, from: data)
                completion(responseObject, nil)
            } catch {
                return
            }
        }
        task.resume()
    }
    
    // Image load and cacheing
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(imageURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let url = URL(string: imageURL)
        
        // if the image is in the cache, load it. otherwise, continue to the api call
        if let imageFromCache = imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            completion(imageFromCache, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                // cache images to enhance speed
                let imageToCache = UIImage(data: data)!
                self.imageCache.setObject(imageToCache, forKey: imageURL as AnyObject)
                completion(imageToCache, nil)
            }
        }.resume()
        
    }
    
}
