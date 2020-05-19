//
//  LoginScreenViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 17.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenViewController: UIViewController {
    
    var presenter: LoginScreenPresenterProtocol!

    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warnLabel.textColor = .red
        warnLabel.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if UserDefaults.standard.bool(forKey: "logined") {
            self.dismiss(animated: false)
        }
    }
    
    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }

    @IBAction func loginButtonTap(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Введите login/password")
            return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Пользователь не зарегистрирован")
                return
            }
            
            if user != nil {
                //self?.navigationController?.popToRootViewController(animated: true)
                //return
                UserDefaults.standard.set(true, forKey: "logined")
                self?.dismiss(animated: true)
            }
            self?.displayWarningLabel(withText: "Пользователь не зарегистрирован")
        }
    }
    
   
    @IBAction func registredButtonTap(_ sender: UIButton) {
        presenter.goAccountScreen()
    }
    
    @IBAction func backButtonTap() {
       // navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
    
}


extension LoginScreenViewController: LoginScreenProtocol {
    


    
}
