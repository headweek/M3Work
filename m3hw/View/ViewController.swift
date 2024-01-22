//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 19.01.24.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var model = PhotoModelTest()
    var storage = StorageManager()
    var photo = PhotoCollectionViewCell()
    var image = UIImage(named: "img")
    var photos: Results<Photo>!
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.addSubview(buttonOne)
        return collectionView
    }()

    
    lazy var buttonOne: UIButton = {
        $0.setTitle("select", for: .normal)
        $0.backgroundColor = .gray
        $0.frame = CGRect(x: 150, y: 650, width: 100, height: 50)
        $0.addTarget(self, action: #selector(action), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        print(storage.addPath())
        
        if let collect = image?.jpegData(compressionQuality: 1){
            storage.saveImg(imageData: collect)
        }
        
        let _ = RealmManager.shared
        photos = RealmManager.shared.getAllPhotos()
    }
    
    @objc func action () {
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.sourceType = .photoLibrary
        present(imagePick, animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            model.photos.append(image)
//            collectionView.reloadData()
//        }
//        picker.dismiss(animated: true)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                // Сохранение изображения в FileManager
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let uniqueFileName = UUID().uuidString
                    let fileURL = documentsDirectory.appendingPathComponent(uniqueFileName).appendingPathExtension("jpg")

                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        try? imageData.write(to: fileURL)

                        // Сохранение пути и имени изображения в Realm с использованием RealmManager
                        RealmManager.shared.savePhoto(imagePath: fileURL.path, imageName: uniqueFileName)
                        collectionView.reloadData()
                    }
                }
            }

            picker.dismiss(animated: true, completion: nil)
        }
    
}

//MARK: - Extension

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell {
            cell.imageView.image = model.photos[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - TesT Model

class PhotoModelTest {
    var photos: [UIImage] = []
}
