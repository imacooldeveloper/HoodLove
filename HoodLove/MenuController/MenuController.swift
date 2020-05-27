//
//  MenuController.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit
import Firebase

class MenuControllers: UIViewController {
    
    let SIgnOutLAB = UILabel(text: "We Appreciate You ", font: .systemFont(ofSize: 20, weight: .medium))
    
    lazy var cancelBTN: UIButton = {
        let BTN = UIButton(type: .system)
        
     BTN.setTitle("Cancel", for: .normal)
        BTN.layer.cornerRadius = 4
     BTN.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        BTN.backgroundColor = #colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1)
        BTN.layer.masksToBounds = true
        BTN.layer.borderWidth = 0.5
        BTN.addTarget(self, action: #selector(HandleCancel), for: .touchUpInside)
        
        return BTN
    }()
    @objc func HandleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var signOutBTN: UIButton = {
        let BTN = UIButton(type: .system)
        
     BTN.setTitle("Sign Out", for: .normal)
        BTN.setTitleColor(#colorLiteral(red: 0.6937795877, green: 0.2300651073, blue: 0.2337480783, alpha: 1), for: .normal)
        
        BTN.addTarget(self, action: #selector(Handlesignout), for: .touchUpInside)
        
        return BTN
    }()
    
    @objc func Handlesignout() {
        do {
                   
                               try Auth.auth().signOut()
            
            let loginCon = LoginController()
            let nav = UINavigationController(rootViewController: loginCon)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
//                   self.navigationController?.dismiss(animated: true, completion: nil)
               
               
                           } catch let signOutErr {
                               print("Failed to sign out:", signOutErr)
                           }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuHUD()
    }
    
    func menuHUD() {
        view.backgroundColor = .white
        
        view.addSubview(SIgnOutLAB)
        SIgnOutLAB.numberOfLines = 5
        SIgnOutLAB.textAlignment = .center
        SIgnOutLAB.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 200, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 200))
        
        SIgnOutLAB.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(cancelBTN)
        cancelBTN.anchor(top: SIgnOutLAB.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        cancelBTN.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        SIgnOutLAB.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        view.addSubview(signOutBTN)
       
        signOutBTN.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 30, right: 0),size: .init(width: 100, height: 50))
         signOutBTN.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
