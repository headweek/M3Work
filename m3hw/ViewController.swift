//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController {
    
    lazy var btnOne: UIButton = {
        $0.setTitle("next", for: .normal)
        $0.backgroundColor = .blue
        $0.tintColor = .white
        $0.frame = CGRect(x: 150, y: 300, width: 100, height: 100)
        return $0
    }(UIButton(primaryAction: action))
    
    lazy var action = UIAction { _ in
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setTitle(sender: )), name: Notification.Name ("salman"), object: nil)
    }
    
    @objc func setTitle (sender: Notification) {
        btnOne.setTitle("newInfo", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnOne)
    }


}

