//
//  CardView.swift
//  AffirmTakeHome
//
//  Created by Ashish Chatterjee on 8/3/20.
//  Copyright © 2020 Ashish Chatterjee. All rights reserved.
//

import UIKit

class CardView: UIView {

    var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    var imageView: UIImageView?
    var nameLabel: UILabel?
    var ratingLabel: UILabel?
    var business: Business? {
        didSet {
            nameLabel?.text = business!.name
            ratingLabel?.text = "\(business!.rating)"
        }
    }
    var position: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData() {
        nameLabel?.text = business?.name
    }
    
    func initUI() {
        self.clipsToBounds = true
        
        imageView = UIImageView(frame: frame)
        imageView?.layer.masksToBounds = true
        imageView?.contentMode = .scaleAspectFill
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.alpha = 0.8
        self.addSubview(imageView!)
        imageView?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        imageView?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        nameLabel = UILabel()
        nameLabel?.translatesAutoresizingMaskIntoConstraints = false
        nameLabel?.textColor = .white
        nameLabel?.textAlignment = .center
        nameLabel?.font = .boldSystemFont(ofSize: 25)
        self.addSubview(nameLabel!)
        nameLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        nameLabel?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        nameLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        ratingLabel = UILabel()
        ratingLabel?.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel?.backgroundColor = .lightGray
        ratingLabel?.textColor = .white
        ratingLabel?.textAlignment = .center
        ratingLabel?.layer.masksToBounds = true
        ratingLabel?.layer.cornerRadius = 20
        ratingLabel?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.addSubview(ratingLabel!)
        ratingLabel?.adjustsFontSizeToFitWidth = true
        ratingLabel?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        ratingLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        ratingLabel?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        ratingLabel?.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
