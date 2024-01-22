//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.


import UIKit

class AViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var collectionView: UICollectionView!
    var model = PhotoModel()
    var storage = StorageManager()
    var ppp = PhotoCollectionViewCell()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(storage.addPath())
        
        if let collect = ppp.imageView.image?.jpegData(compressionQuality: 0.4){
            storage.saveImg(imageData: collect)
        }
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("Выбрать фото", for: .normal)
        addButton.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
    @objc func addPhotoButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            model.photos.append(image)
            collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell {
            cell.imageView.image = model.photos[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
}
