//
//  LocationTrackerViewController.swift
//  LocationTracker
//
//  Created by Deep on 15/11/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

protocol ShowLocation {
    func viewLocation(name: String)
}

class LocationTrackerViewController: UIViewController, ShowLocation {
   
    var interactor: LocationTracker?
    var presenter: LocationPresenter?
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        interactor?.setUpLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickingStartTrack(_ sender: Any) {
        interactor?.startLocationTracking()
    }
    
    @IBAction func onClickingStopTrack(_ sender: Any) {
        interactor?.stopLocationTracking()
    }
    
    private func setUp() {
        interactor = LocationTracker()
        presenter = LocationPresenter()
        interactor?.presenter = presenter
        presenter?.vc = self
    }
    
    func viewLocation(name: String) {
        addressLabel.text = name
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
