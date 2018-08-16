//
//  Cell.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 20/07/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    lazy var destImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var townName:UILabel = {
        let label = UILabel()
        label.text = "New York 1"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shortDescription:UILabel = {
        let label = UILabel()
        label.text = "Sample text sample samsplemmmmsadknknknda"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    lazy var labelsStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [townName,shortDescription])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        addSubview(destImageView)
        addSubview(labelsStack)
        
        destImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        destImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        destImageView.widthAnchor.constraint(equalTo:  self.widthAnchor,multiplier:0.95).isActive = true
        destImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier:0.95).isActive = true
        
        labelsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelsStack.topAnchor.constraint(equalTo: self.destImageView.bottomAnchor).isActive = true
        labelsStack.widthAnchor.constraint(equalTo:  self.widthAnchor,multiplier: 0.95).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20).isActive = true
    }
}






































