//
//  MainView.swift
//  m3hw
//
//  Created by Salman Abdullayev on 10.01.24.
//

import UIKit

class MainView {
    
    var view: UIView
    var dataSource: UICollectionViewDataSource
    var delegate: UICollectionViewDelegate
    
    init(view: UIView, data: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        self.view = view
        self.dataSource = data
        self.delegate = delegate
    }
    
    func creatCollection () -> UICollectionView {
        let collectionView: UICollectionView = {
            let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: view.bounds.width - 40, height: view.bounds.height - 40)
            $0.dataSource = dataSource
            $0.delegate = delegate
            $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
            
            return $0
        }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
        
        return collectionView
    }
}
