//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    var realmManager = RealmManager()
    var storageManager = StorageManager()
    
    lazy var textField: UITextField = {
        $0.text = ""
        $0.textColor = .white
        $0.delegate = self
        $0.frame = CGRect(x: 20, y: 20, width: 40, height: 20)
        return $0
    }(UITextField())
    
    lazy var collectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: view.bounds.width - 20)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        $0.dataSource = self
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.backgroundColor = .white
        $0.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
    
    lazy var plusButton: UIButton = {
        $0.backgroundColor = .black
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.layer.cornerRadius = 25
        
        return $0
    }(UIButton(frame: CGRect(x: view.bounds.width - 100, y: view.bounds.height - 100, width: 50, height: 50), primaryAction: action))
    
    lazy var imagePicker: UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        return $0
    }(UIImagePickerController())
    
    lazy var action = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.present(self.imagePicker, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(plusButton)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".jpg"
            realmManager.writeToRealm(photoName: imageName)
            
            if let pickedImage = info[.originalImage] as? UIImage {
                let vc = SecondViewController()
                vc.receivedImage = pickedImage
                self.navigationController?.pushViewController(vc, animated: true)
            }
    
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            storageManager.saveImage(imageName: imageName, imageData: imageData)
            
        }
        collectionView.reloadData()
        picker.dismiss(animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        realmManager.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
        
        let imageName = realmManager.images[indexPath.item].imageName
        let imageData = storageManager.loadImage(imageName: imageName)
        
        cell.setImage(imageData: imageData)
        
        return cell
    }
    
    
}

