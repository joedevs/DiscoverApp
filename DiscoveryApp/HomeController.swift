//
//  ViewController.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 18/07/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let cellId = "cell"
    let xInset:CGFloat = 30
    let cellSpacing:CGFloat = 1
    let animator = Animator()
    
    var destinations = [Destination](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    lazy var searchView:SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.7
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        return view
    }()
    
    lazy var tabbarView:TabBarView = {
        let view = TabBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView:TitleView = {
        let view = TitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var container:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.7
        view.layer.cornerRadius = 10
        return view
    }()
    
    var cellSize:CGSize{
        return CGSize(width: collectionView.frame.width - (xInset * 2),
                      height: collectionView.frame.height)
    }
    
    var cellBeforeSelectedCell:Cell?
    var cellAfterSelectedCell:Cell?
    
    
    //Here lazy var is very important because it allows us to set the
    //delegate and datasource inside the closure
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //This is clear enough about what it does
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = .white
        setup()
        loadDestinations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadDestinations(){
        var localDestinations = [Destination]()
        for i in 1...11{
            let image = UIImage(named: "\(i).jpeg")
            let dest = Destination(image: image!, townName: "New York \(i)", description: "sample description,sample description sample description")
            localDestinations.append(dest)
        }
        
        destinations =  localDestinations
    }
    
    func setup() {
        
        //First add the field to the parent view which is self.
        view.addSubview(searchView)
        view.addSubview(tabbarView)
        view.addSubview(titleView)
        view.addSubview(container)
        view.addSubview(collectionView)
        
        //Second apply constraints
        searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: view.topAnchor,constant: 40).isActive = true
        searchView.widthAnchor.constraint(equalTo:  view.widthAnchor,multiplier: 0.9).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        tabbarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tabbarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabbarView.leadingAnchor.constraint(equalTo:  view.leadingAnchor).isActive = true
        tabbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        titleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleView.topAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 20).isActive = true
        titleView.widthAnchor.constraint(equalTo:  view.widthAnchor,multiplier: 0.9).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        container.topAnchor.constraint(equalTo: titleView.bottomAnchor,constant: 80).isActive = true
        container.bottomAnchor.constraint(equalTo: tabbarView.topAnchor,constant: -20).isActive = true
        container.leadingAnchor.constraint(equalTo:  view.leadingAnchor,constant: 20).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor,constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: tabbarView.topAnchor,constant: -20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo:  view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}


extension HomeController:UICollectionViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Get the cell's width plus spacing
        let cellWidthIncludingSpacing = cellSize.width + cellSpacing
        
        
        //This is the expected offset when the collectionView's scrollView stops scrolling.
        //The new offset after a scroll action has been perfomed
        var offset = targetContentOffset.pointee
        
        //The index is calculated by taking the distance (offset.x) from x = 0 (origin.x) divided by the cellWidthIncludingSpacing.
        //for example if offset.x = 750 and  cellWidthIncludingSpacing = 316 then the index = 737 / 316 = 2.332278...
        //The value here is in CGFloat
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        //Here we round the index to get a whole number
        //for example if we round 2.332278 we'll get 2
        let roundedIndex = round(index)
        
        //Now we calculate the new offset based on the rounded index to make the cell centered
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        //Last we set the new offset.
        targetContentOffset.pointee = offset
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell{
            let dc = DetailsController()
            dc.transitioningDelegate = self
            dc.imageView.image = destinations[indexPath.item].image
            animator.initialFrame = view.convert(cell.destImageView.frame, from: cell)
            animator.finalFrame = dc.imageViewFrame
            present(dc, animated: true, completion: nil)
        }
        
        if indexPath.item - 1 > 0{
            cellBeforeSelectedCell = collectionView.cellForItem(at: IndexPath(item: indexPath.item - 1, section: 0)) as? Cell
        }
        
        if indexPath.item + 1 < destinations.count{
            cellAfterSelectedCell = collectionView.cellForItem(at: IndexPath(item: indexPath.item + 1, section: 0)) as? Cell
        }
    }
}

extension HomeController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? Cell{
            cell.destImageView.image = destinations[indexPath.item].image
            return cell
        }
        
        return UICollectionViewCell()
    }
}


extension HomeController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
    }
}

extension HomeController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = true
        
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = false
        return animator
    }
}



















