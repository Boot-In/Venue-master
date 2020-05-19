//
//  AccountScreenViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 11.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountScreenViewController: UIViewController {
    
    var presenter: AccountScreenPresenterProtocol!
    
    let picker = UIDatePicker()
    // let calendar = Calendar.current
    
    @IBOutlet weak var nameUserTF: UITextField!
    @IBOutlet weak var secondNameUserTF: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nickNameUserTF: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.textColor = .red
        checkUserData()
    }
    
    
    func checkUserData() {
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: "logined") {
            logOutButton.isHidden = false
            nameUserTF.text = userDefault.string(forKey: "nameUser")
            secondNameUserTF.text = userDefault.string(forKey: "secondNameUser")
            nickNameUserTF.text = userDefault.string(forKey: "niсkNameUser")
            emailTextField.text = userDefault.string(forKey: "email")
            passwordTextField.text = userDefault.string(forKey: "password")
            rePasswordTextField.text = userDefault.string(forKey: "password")
            infoLabel.text = "Данные сохранены !"
        } else {
            logOutButton.isHidden = true
            infoLabel.text = "Заполните все поля"
        }
    }
    
//    func createDatePicker() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(donePressed))
//        toolbar.setItems([done], animated: true)
//
//        dobUserTF.inputAccessoryView = toolbar // вызов тулбара
//        dobUserTF.inputView = picker
//        picker.datePickerMode = .date
//        picker.locale = .init(identifier: "Russian")
//    }

//    @objc func donePressed() {
//        let formatter = DateFormatter()
//        formatter.locale = .init(identifier: "Russian")
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//
//       // myDate = calendar.component(.day, from: picker.date)
//       // myMonth = calendar.component(.month, from: picker.date)
//      //  myYear = calendar.component(.year, from: picker.date)
//      //  print(myDate, myMonth, myYear)
//        UserData.shared.dateOB = picker.date
//        let dateString = formatter.string(from: picker.date)
//        UserData.shared.dateOBString = dateString
//        dobUserTF.text = "\(dateString)"
//
//        self.view.endEditing(true)
//    }
    
    @IBAction func closeWindow() {
        //   guard let navigationController = self.navigationController else { return }
        //   var navigationArray = navigationController.viewControllers
        //   navigationArray.remove(at: 1)
        //   self.navigationController?.viewControllers = navigationArray
        //   navigationController.popViewController(animated: true)
        //navigationController?.popToRootViewController(animated: true)
        dismiss(animated: false)
    }
    
    @IBAction func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        UserDefaults.standard.set(false, forKey: "logined")
        self.dismiss(animated: true)
        //navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveButtonTap() {
        
        guard let firstUN = nameUserTF.text, nameUserTF.text != "" else {
            infoLabel.text = "Не заполнено поле Имя" ; return }
        guard let secondUN = secondNameUserTF.text, secondNameUserTF.text != "" else {
        infoLabel.text = "Не заполнено поле Фамилия" ; return }
        guard let nickUN = nickNameUserTF.text, nickNameUserTF.text != "" else {
               infoLabel.text = "Не заполнено поле Ник" ; return }
        guard let email = emailTextField.text, emailTextField.text != "" else {
            infoLabel.text = "Не заполнено поле E-mail" ; return
        }
        
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            infoLabel.text = "Не заполнено поле Password" ; return
        }
       
        if password.count < 6 {
            infoLabel.text = "Пароли менее 6-ти символов !"; return
        }
        
        if passwordTextField.text != rePasswordTextField.text {
            infoLabel.text = "Пароли не совпадают" ; return
        }
        infoLabel.textColor = .systemBlue
        infoLabel.text = "Подождите....."
        
        presenter.createUser(email: email, password: password, fName: firstUN, sName: secondUN, nik: nickUN)
    }
    
    
    
}


extension AccountScreenViewController: AccountScreenProtocol {
    
    func sendMessage(text: String) {
        infoLabel.text = text
        checkUserData()
    }

    
}

extension AccountScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true) // Скрывает клавиатуру по Enter
    }
}
