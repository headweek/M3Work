//
//  SecondViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 28.01.24.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    var camera = ViewController()
    var receivedImage: UIImage?
    
    let titleTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Заголовок"
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        let descriptionTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Описание"
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .systemBlue
            button.setTitle("Сохранить", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(SecondViewController.self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
        }()
    
    lazy var image: UIImageView = {
        $0.image = camera.collectionView.largeContentImage
        $0.frame = view.bounds
        return $0
    }(UIImageView())
    
    lazy var saveBtn: UIButton = {
        $0.setTitle("Save", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .purple
        $0.frame = CGRect(x: 600, y: 200, width: 100, height: 50)
        return $0
    }(UIButton())
    
    @objc func saveButtonTapped() {
        if let title = titleTextField.text, let description = descriptionTextField.text {
            print("Title: \(title)")
            print("Description: \(description)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(saveBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        
        if let image = receivedImage {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 20, y: 100, width: 355, height: 355)
            imageView.layer.cornerRadius = 10
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            view.addSubview(imageView)
        }
        
        titleTextField.frame = CGRect(x: 100, y: 520, width: 200, height: 30)
        descriptionTextField.frame = CGRect(x: 100, y: 560, width: 200, height: 30)
        saveButton.frame = CGRect(x: 100, y: 600, width: 200, height: 40)
        
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(saveButton)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
