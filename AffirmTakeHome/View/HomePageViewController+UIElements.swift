//
//  HomePageViewController+UIElements.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

import UIKit

extension HomePageViewController {

    func initUI() {
        cards = [cardOne, cardTwo, cardThree, cardFour, cardFive]
        var pos = 0
        for card in cards {
            initCardUI(card: card, position: Double(pos))
            pos += 1
        }
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(previousButton)
        previousButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        previousButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
        nextButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    }
    
    func initCardUI(card: CardView, position: Double) {
        let carddim = self.view.frame.width-40
        card.position = Int(position)
        card.backgroundColor = .gray
        card.layer.cornerRadius = 20
        card.alpha = CGFloat(1.0 - position*0.25)
        let top = 50 + position*10
        card.frame = CGRect(x: 20, y: CGFloat(top), width: carddim, height: carddim)
        self.view.addSubview(card)
    }
    
    @objc func prevButtonTapped(_ sender: UIButton) {
        print("PREV")
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let carddim = self.view.frame.width-40
        performUIUpdatesOnMain {
            for card in self.cards {
                if card.position == 0 {
                    UIView.animate(withDuration: 1) {
                        card.frame = CGRect(x: 20-self.view.frame.width, y: 50, width: carddim, height: carddim)
                    }
                } else {
                    UIView.animate(withDuration: 1) {
                        card.alpha += 0.25
                        card.position! -= 1
                        let top = 50 + card.position!*10
                        card.frame = CGRect(x: 20, y: CGFloat(top), width: carddim, height: carddim)
                    }
                }
            }
        }
    }

}
