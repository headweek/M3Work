//
//  ImageCell.swift
//  m3hw
//
//  Created by Salman Abdullayev on 31.01.24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let reuseId = "ImageCell"
    
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView(frame: bounds))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    func setImage(imageData: Data){
        let image = UIImage(data: imageData)
        imageView.image = image
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
