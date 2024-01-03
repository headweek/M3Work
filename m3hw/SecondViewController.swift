//
//  SecondViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var btnTwo: UIButton = {
        $0.setTitle("salman", for: .normal)
        $0.backgroundColor = .blue
        $0.tintColor = .white
        $0.frame = CGRect(x: 150, y: 300, width: 100, height: 100)
        return $0
    }(UIButton(primaryAction: action))
    
    lazy var action = UIAction { _ in
        let vc = SecondViewController()
        self.navigationController?.popViewController(animated: true)
        let userInfo = ["Salman": "OK"]
        NotificationCenter.default.post(name: Notification.Name("salman"), object: nil, userInfo: userInfo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnTwo)
        
    }
    

}

