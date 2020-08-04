//
//  HomePageViewController.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
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
    var cardFive = CardView()
    var cards = [CardView]()
    
    let network = Network()
    var offset = 0
    var businesses: [Business]?
    
    override func viewWillAppear(_ animated: Bool) {
        fetchBusinesses(offset: offset)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func fetchBusinesses(offset: Int) {
        network.fetchYelpResults(latitude: 40, longitude: -70, offset: offset, term: "restaurant") { (response, error) in
            if let response = response {
                self.businesses = response.businesses
            }
        }
    }

}

// Helper function for UI updates
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
