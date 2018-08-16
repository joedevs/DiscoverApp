//
//  SearchView.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 18/07/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    //Declaring the search field
    lazy var searchfield:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search hundreds of destinations"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //Declaring the icon imageView
    lazy var iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "search")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //In the setup function,I will apply constraints to the fields I have just declared up above
    fileprivate func setup(){
        
        //First add the field to the parent view which is self.
        self.addSubview(searchfield)
        self.addSubview(iconImageView)
        
        
        //Second apply constraints
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
        iconImageView.widthAnchor.constraint(equalTo:  self.heightAnchor,multiplier: 0.3).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.3).isActive = true
        
        searchfield.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        searchfield.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchfield.leadingAnchor.constraint(equalTo:  iconImageView.trailingAnchor,constant: 5).isActive = true
        searchfield.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.7).isActive = true
        
        
    }

}












