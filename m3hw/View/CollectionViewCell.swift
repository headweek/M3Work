//
//  CollectionViewCell.swift
//  m3hw
//
//  Created by Salman Abdullayev on 10.01.24.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ItemCell"
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.frame = bounds
        return $0
    }(UIImageView())
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        backgroundColor = .black
    }
    
    func setImage (imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        self.imageView.sd_setImage(with: url, placeholderImage: .add)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatalisticheskaya Oshibka!")
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
