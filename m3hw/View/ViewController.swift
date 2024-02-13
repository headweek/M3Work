//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let firebase = FireBase()
    
    lazy var offsetYPassword = datePicker.frame.origin.y + 100
    
    lazy var loginFiewld = createTextFidel(placeholder: "login", offsetY: -35)
    lazy var passwordField = createTextFidel(placeholder: "password", offsetY: 35, isPassword: true)
    
    lazy var regBtn = createButton(title: "Регистрация", action: regAction, originY: offsetYPassword)
    lazy var signIngBtn = createButton(title: "Войти", action: signInAction, originY: offsetYPassword + 40)
    
    lazy var datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.maximumDate = Date()
        return $0
    }(UIDatePicker(frame: CGRect(x: 20, y: view.center.y + 30, width: view.frame.size.width - 40, height: 50)))
    
    var regAction: UIAction?
    var signInAction: UIAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        regAction = UIAction(handler: { [weak self] _ in
            self?.firebase.createNewUser(email: self?.loginFiewld.text ?? "", pass: self?.passwordField.text ?? "") { isReg in
                if isReg {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": true])
                }
            }
        })
        
        signInAction = UIAction(handler: { [weak self] _ in
            self?.firebase.signIn(email: self?.loginFiewld.text ?? "", password: self?.passwordField.text ?? "", completion: { isSignIn in
                if isSignIn {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": true])
                }
            })
        })
        
        view.addSubview(loginFiewld)
        view.addSubview(passwordField)
        view.addSubview(regBtn)
        view.addSubview(signIngBtn)
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    private func createTextFidel(placeholder: String, offsetY: Double, isPassword: Bool = false) -> UITextField{
        let textField = UITextField()
        let topOffset = view.center.y - 200
        textField.frame.size = CGSize(width: view.frame.size.width - 40, height: 50)
        textField.frame.origin = CGPoint(x: 20, y: topOffset + offsetY)
        textField.backgroundColor = .lightGray
        textField.isSecureTextEntry = isPassword
        textField.placeholder = placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: .zero))
        textField.leftViewMode = .always
        return textField
    }
    
    private func createButton(title: String, action: UIAction?, originY: Double) -> UIButton{
        let btn = UIButton(primaryAction: action)
        btn.frame.size = CGSize(width: view.frame.size.width - 40, height: 40)
        btn.frame.origin = CGPoint(x: 20, y: originY)
        btn.setTitle(title, for: .normal)
        return btn
    }
}
