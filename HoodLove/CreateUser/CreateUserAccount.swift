//
//  CreateUserAccount.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit
import Firebase


class CreateUserAccount: UIViewController {
    
    
    var userNameLab = UILabel(text: "Email", font: UIFont.systemFont(ofSize: 20, weight: .light))
    var userNamePlace = UserPlaceHolder()
    var passwordLab = UILabel(text: "Password", font: UIFont.systemFont(ofSize: 20, weight: .light))
    var passwordPlace = PasswordPlaceHolder()
    var alreadyHaveAccountLab = UILabel(text: "I have an account", font: UIFont.systemFont(ofSize: 20, weight: .light))
    lazy var signUpBTN: ConfirmBTN = {
        var btn = ConfirmBTN(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.addTarget(self, action: #selector(handleSignUpBtn), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func handleSignUpBtn (){
        signUpBtn()
    }
    
    lazy var alreadyHaveAccountBTN: UIButton = {
           var btn = UIButton(type: .system)
           btn.setTitle("Sign In", for: .normal)
        
        btn.setTitleColor(#colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1), for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
           btn.addTarget(self, action: #selector(AlreadyHaveAnAccountBTN), for: .touchUpInside)
           return btn
       }()
    
    @objc func AlreadyHaveAnAccountBTN() {
        let alreadyAUser = LoginController()
        let nav = UINavigationController(rootViewController: alreadyAUser)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
    
    
//    @objc func handleInputChange() {
//         let allInputValid =  userEmailFIELD.text?.count ?? 0 > 0 && userNameFIELD.text?.count ?? 0 > 0 &&    PasswordFIELD.text?.count ?? 0 > 0 && userFloor.text?.count ?? 0 > 0 && userAccountType.text?.count ?? 0 > 0
//
//         if allInputValid {
//             userLoginBtn.isEnabled = true
//             userLoginBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//         } else {
//             userLoginBtn.isEnabled = false
//             userLoginBtn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//         }
//     }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        createUserHUD()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func signUpBtn() {
        guard let userEmail = userNamePlace.text, userEmail.count > 0 else {return }
        
        guard let password = passwordPlace.text, password.count > 0 else {return }
        
        Auth.auth().createUser(withEmail: userEmail, password: password) { (user, er) in
            if let er = er {
                print(er)
                Alert.showInvalidEmailAlert(on: self)
                return
            }
              guard let uid = user?.user.uid else { return }
            
            let dictornayValues = ["userEmail":userEmail]
            let values = [uid:dictornayValues]
            Database.database().reference().child("user").updateChildValues(values) { (er, ref) in
                if let er = er {
                    print(er)
                    return
                }
                
             
               
                
                let mapview = MapView()
                mapview.modalPresentationStyle = .fullScreen
                
//                let nav = UINavigationController(rootViewController: mapview)
//                nav.modalPresentationStyle = .fullScreen
                
                self.present(mapview, animated: true, completion: nil)
                
                print(ref)
            }
            
            
        }
               
    }
    
    fileprivate func createUserHUD() {
          view.backgroundColor = .white
        
        let usernameStack = UIStackView(arrangedSubviews: [userNameLab,userNamePlace])
        usernameStack.spacing = 3
        usernameStack.distribution = .fillEqually
        usernameStack.axis = .vertical
//        userNamePlace.constrainHeight(constant: 50)
        view.addSubview(usernameStack)
        usernameStack.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 200, left: 30, bottom: 0, right: 30),size: .init(width: 0, height: 120))
        usernameStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //password
         let passwordStack = UIStackView(arrangedSubviews: [passwordLab,passwordPlace])
                passwordStack.spacing = 3
                passwordStack.distribution = .fillEqually
                passwordStack.axis = .vertical
        //        userNamePlace.constrainHeight(constant: 50)
                view.addSubview(passwordStack)
                passwordStack.anchor(top: usernameStack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 30, bottom: 0, right: 30),size: .init(width: 0, height: 120))
                passwordStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(signUpBTN)
        signUpBTN.anchor(top: passwordStack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 30, bottom: 0, right: 30),size: .init(width: 0, height: 50))
        
           signUpBTN.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let alreadyHaveAnAccountStack = UIStackView(arrangedSubviews: [alreadyHaveAccountLab,alreadyHaveAccountBTN])
        
        alreadyHaveAnAccountStack.spacing = 0
        alreadyHaveAnAccountStack.distribution = .fillEqually
        alreadyHaveAnAccountStack.axis = .horizontal
        view.addSubview(alreadyHaveAnAccountStack)
        alreadyHaveAccountLab.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        alreadyHaveAnAccountStack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 100, right: 50), size: .init(width: 0, height: 20))
    }
}

