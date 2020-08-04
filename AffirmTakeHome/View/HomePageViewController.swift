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
    
    var cards: [CardView] = []
    let yelp = YelpAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {
        self.view.addSubview(previousButton)
        self.view.addSubview(nextButton)
        
    }
    
    @objc func prevButtonTapped(_ sender: UIButton) {
        print("PREV")
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        print("NEXT")
    }

}
