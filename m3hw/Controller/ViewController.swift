//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let network = NetworkManager()
    
    private lazy var viewBuilder: MainView = {
        return MainView(view: self.view, data: self, delegate: self)
    }()
    var items: [Item]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collection = viewBuilder.creatCollection()
        view.addSubview(collection)
        
        network.getImagesFromUnsplash { [weak self] items in
            self?.items = items
            collection.reloadData()
        }
        navigationItem.searchController = UISearchController()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        guard let urlString = items?[indexPath.row].urls.regular else { return UICollectionViewCell() }
        cell.setImage(imageUrl: urlString)
        return cell
    }
    
}
