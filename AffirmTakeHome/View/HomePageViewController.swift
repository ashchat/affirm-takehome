//
//  HomePageViewController.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

import UIKit
import CoreLocation

class HomePageViewController: UIViewController, CLLocationManagerDelegate {
    
    var previousButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.backgroundColor = .red
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(prevButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.backgroundColor = .green
        button.setImage(UIImage(named: "next"), for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var cardOne = CardView()
    var cardTwo = CardView()
    var cardThree = CardView()
    var cardFour = CardView()
    var cards = [CardView]()
    
    let network = Network()
    var offset = 0
    var businesses: [Business]?
    var currIndex = 0
    
    var location: CLLocation?
    var locationManager: CLLocationManager?
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserLocation()
    }
    
    func fetchBusinesses(offset: Int) {
        network.fetchYelpResults(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude, offset: offset, term: "restaurant") { (response, error) in
            if let response = response {
                if self.businesses != nil {
                    self.businesses?.append(contentsOf: response.businesses)
                } else {
                    self.businesses = response.businesses
                    performUIUpdatesOnMain {
                        self.initUI()
                        for i in 0..<self.cards.count {
                            self.cards[i].business = self.businesses![i]
                        }
                    }
                }
            }
        }
    }
    
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            fetchBusinesses(offset: offset)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    fetchBusinesses(offset: offset)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

// Helper function for UI updates
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
