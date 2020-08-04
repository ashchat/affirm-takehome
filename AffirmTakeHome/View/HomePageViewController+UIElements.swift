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
        self.view.backgroundColor = .darkGray
        
        cards = [cardOne, cardTwo, cardThree, cardFour]
        var pos = 0
        for card in cards {
            initCardUI(card: card, position: Double(pos))
            pos += 1
        }
        
        previousButton.isEnabled = false
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
        card.backgroundColor = .black
        card.layer.cornerRadius = 20
        card.alpha = CGFloat(1.0 - position*0.5)
        let top = 50 + position*10
        card.frame = CGRect(x: 20, y: CGFloat(top), width: carddim, height: carddim)
        self.view.addSubview(card)
        self.view.sendSubviewToBack(card)
    }
    
    @objc func prevButtonTapped(_ sender: UIButton) {
        currIndex -= 1
        
        let carddim = self.view.frame.width-40
        for card in self.cards {
            card.position! += 1
            
            if card.position == 3 && currIndex > 0 {
                card.position = -1
                card.frame = CGRect(x: 20-self.view.frame.width, y: 50, width: carddim, height: carddim)
                card.alpha = 1
                card.business = self.businesses![currIndex-1]
                continue;
            }
            
            UIView.animate(withDuration: 1) {
                if card.position == 0 {
                    self.view.bringSubviewToFront(card)
                    card.frame = CGRect(x: 20, y: 50, width: carddim, height: carddim)
                } else {
                    card.alpha -= 0.5
                    let top = 50 + card.position!*10
                    card.frame = CGRect(x: 20, y: CGFloat(top), width: carddim, height: carddim)
                }
            }
        }
        
        if currIndex == 0 {
            previousButton.isEnabled = false
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        currIndex += 1
        if !previousButton.isEnabled { previousButton.isEnabled = true }
        if currIndex%10 == 4 {
            offset += 10
            fetchBusinesses(offset: offset)
            
        }
        
        let carddim = self.view.frame.width-40
        for card in self.cards {
            card.position! -= 1
            
            UIView.animate(withDuration: 1) {
                if card.position == -1 {
                    card.frame = CGRect(x: 20-self.view.frame.width, y: 50, width: carddim, height: carddim)
                    self.view.sendSubviewToBack(card)
                } else {
                    if self.currIndex > 1 && card.position! < -1 {
                        card.position = 2
                        card.alpha = -0.5
                        card.business = self.businesses![self.currIndex+2]
                    }
                    card.alpha += 0.5
                    let top = 50 + card.position!*10
                    card.frame = CGRect(x: 20, y: CGFloat(top), width: carddim, height: carddim)
                }
            }
        }
        
    }

}
