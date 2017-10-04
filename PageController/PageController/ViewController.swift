//
//  ViewController.swift
//  PageController
//
//  Created by Appinventiv Technologies on 03/10/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //     MARK:- OUTLET'S ......
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    //     MARK:- VARIABLE'S ......
    
    let imageData = ["1","2","3","4","5","6","7"]
    var currentIndex = 0
    var maxLimit = 0
    var minLimit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.numberOfPages = imageData.count
        maxLimit = imageData.count
        
        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        self.imageCollection.register(cellNib,
                                      forCellWithReuseIdentifier: "CustomCellId")
        self.imageCollection.dataSource = self
        self.imageCollection.delegate = self
        
    }
    
    @IBAction func controllerTapped(_ sender: UIPageControl) {
        
        if currentIndex < maxLimit && sender.currentPage > currentIndex {
            currentIndex =  currentIndex + 1
            
            UIView.transition(with: imageCollection,
                              duration: 1,
                              options: .transitionFlipFromRight,
                              animations: {
                                
                                self.imageCollection.scrollToItem(at:IndexPath(item: self.currentIndex,
                                                                               section: 0) ,
                                                                  at: .right,
                                                                  animated: true) })
            // Move to Left
            
        }
        else if currentIndex > minLimit {
            
            currentIndex =  currentIndex - 1
            UIView.transition(with: imageCollection,
                              duration: 1,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.imageCollection.scrollToItem(at:IndexPath(item: self.currentIndex,
                                                                               section: 0) ,
                                                                  at: .left,
                                                                  animated: true) })
        }
    }
    
}

extension ViewController: UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
UIPageViewControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.imageData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellId",
                                                            for: indexPath) as? CustomCell else{
                                                                
                                                                fatalError("Not found:")
        }
        
        cell.scrollImage.image = UIImage(named: imageData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.imageCollection.frame.width
        let height = self.imageCollection.frame.height
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath)
    {
        
        if let cell = collectionView.visibleCells.first {
            
            let index = collectionView.indexPath(for: cell)!
            self.pageController.currentPage = index.row
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        UIView.transition(with: self.imageCollection,
                          duration: 1,
                          options: .transitionFlipFromRight,
                          animations: {
                            
                            self.imageCollection.reloadData()
                            
        })
        
    }
    
}



















