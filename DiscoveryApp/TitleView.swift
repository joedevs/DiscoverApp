//
//  TitleView.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 19/07/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.text = "Discover"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var filterIcon:UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = #imageLiteral(resourceName: "filter")
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        addSubview(title)
        addSubview(filterIcon)
        
        filterIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filterIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        filterIcon.widthAnchor.constraint(equalTo:  self.heightAnchor,multiplier: 0.55).isActive = true
        filterIcon.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.55).isActive = true
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.widthAnchor.constraint(equalTo:  self.widthAnchor,multiplier: 0.65).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.65).isActive = true
    }
}





















