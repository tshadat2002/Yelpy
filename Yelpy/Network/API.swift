//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "Y-S8d5cGwVKfBt6kZpV6xu3R33l6zFprmqgo3vNGrv2Jf6Yp45p26X43_wQgq2lf6uDBQpLwOPuap7m5hjccvK7Rj2hwsWCHiCNBBw1Q5rhQtDN9EKPdlVMxjNb8YHYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                print(data)
                //1. convert JSon response to dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //2. grab the business data and convert it to an array of dictionaries
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                // ––––– TODO: Get data from API and return it using completion
                
                
                //3. completion is an escaping method which allows the data to be used outside of the closure
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
