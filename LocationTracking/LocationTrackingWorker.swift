//
//  LocationTrackingWorker.swift
//  LocationTracker
//
//  Created by Deep on 15/11/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import Foundation

protocol PostLocationTracker {
    func postLocation(lat: Double, long: Double)
}

class LocationTrackerWorker: NSObject, PostLocationTracker {
    
    func postLocation(lat: Double, long: Double) {
        // Use API to post data.
        
        let urlStr = "https://api.locus.sh/v1//client/test/user/candidate/location"
        let userName = "test/candidate"
        let password = "c00e-4764"
        
        let latStr = String(lat)
        let longSrr = String(long)
        print("Long\(longSrr)")
        print("Lat\(latStr)")
        let param : [String: Any] = [
            "location": [
                "lat": latStr,
                "lng": longSrr
            ]
        ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let credentialData = "\(userName):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Content-Type": "application/json",
                       "Authorization": "Basic \(base64Credentials)"]
        request.allHTTPHeaderFields = headers
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let result = response as? HTTPURLResponse {
                print(result.statusCode)
                if (result.statusCode == 200) {
                    print("Success")
                } else {
                    print("Failure")
                }
            }
        }
        task.resume()
    }
}
