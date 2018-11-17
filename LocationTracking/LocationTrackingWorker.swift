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
        let latStr = String(lat)
        let longSrr = String(long)
        print("Long\(longSrr)")
        print("Lat\(latStr)")
    }
}
