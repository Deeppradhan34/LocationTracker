//
//  LocationTrackerPresenter.swift
//  LocationTracker
//
//  Created by Deep on 15/11/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import Foundation

protocol PresentLocation {
    func presentLocation(name: String)
}

class LocationPresenter: NSObject, PresentLocation {
    var vc: LocationTrackerViewController?
    func presentLocation(name: String) {
        vc?.viewLocation(name: name)
    }
}
