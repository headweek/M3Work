//
//  SecondViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 13.02.24.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let firebase = FireBase()
    
    lazy var regBtn = createButton(title: "Out", action: regAction, originY: 300)
    
    lazy var regAction = UIAction(handler: { [weak self] _ in
        self?.firebase.signInOut()
        NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": false])
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(regBtn)
    }

    private func createButton(title: String, action: UIAction?, originY: Double) -> UIButton{
        let btn = UIButton(primaryAction: action)
        btn.frame.size = CGSize(width: view.frame.size.width - 40, height: 40)
        btn.frame.origin = CGPoint(x: 20, y: originY)
        btn.setTitle(title, for: .normal)
        return btn
    }

}
