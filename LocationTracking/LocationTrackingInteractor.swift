//
//  LocationTrackingInteractor.swift
//  LocationTracker
//
//  Created by Deep on 15/11/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import Foundation
import CoreLocation

protocol Location {
    func startLocationTracking()
    func stopLocationTracking()
}

class LocationTracker: NSObject, Location, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var worker = LocationTrackerWorker()
    var presenter: LocationPresenter?
    func startLocationTracking() {
        locationManager.startUpdatingLocation()
        lookUpAddress()
    }
    
    func stopLocationTracking() {
        locationManager.stopUpdatingLocation()
        lookUpAddress()
    }
    
    func setUpLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        requestLocation()
    }
    
    private func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = manager.location?.coordinate.latitude
        let long = manager.location?.coordinate.longitude
        // Use Lat Long to post on API.
        worker.postLocation(lat: lat!, long: long!)
        lookUpAddress()
    }
    
    func lookUpAddress() {
        if let location = locationManager.location {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if (error == nil) {
                    if let locality = placemarks?[0].subLocality {
                        print(locality)
                        self.presenter?.presentLocation(name: locality)
                    }
                }
            })
        }
    }
    
    
}
