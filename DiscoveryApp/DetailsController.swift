//
//  DetailsController.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 16/08/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//


import UIKit

class DetailsController: UIViewController {
    
    var imageViewFrame:CGRect {
        return CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.4)
    }
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "1.jpeg")
        return imageView
    }()
    
    lazy var townName:UILabel = {
        let label = UILabel()
        label.text = "New York 1"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var fullDescription:UILabel = {
        let label = UILabel()
        label.text = """
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book
        """
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.numberOfLines = 10
        return label
    }()
    
    lazy var labelsStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [townName,fullDescription])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    
    lazy var cancelButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .lightGray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(){
        
        imageView.frame = imageViewFrame
        labelsStack.frame = CGRect(x: 20, y: imageViewFrame.height + 8, width: imageViewFrame.width - 40, height: view.frame.height * 0.25)
        view.addSubview(imageView)
        view.addSubview(labelsStack)
        view.addSubview(cancelButton)
        
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc fileprivate func goBack(){
        dismiss(animated: true, completion: nil)
    }
}



