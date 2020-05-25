//
//  AddMarkerScreenViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 11.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit

class AddMarkerScreenViewController: UIViewController {
    @IBOutlet weak var userNickLabel: UILabel!
    @IBOutlet weak var dateEventTF: UITextField!
    @IBOutlet weak var nameEventTF: UITextField!
    @IBOutlet weak var categoryEventTF: UITextField! // задействовать с таблицей категорий
    @IBOutlet weak var discriptionEventTV: UITextView!
    @IBOutlet weak var iconEventIV: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var presenter: AddMarkerScreenPresenterProtocol!
    let picker = UIDatePicker()
    let iconArray = ["marker-icon", "red-marker", "green-marker", "blue-marker"]
    var i = 0
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isHidden = false
        
        formatter.locale = .init(identifier: "Russian")
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        infoLabel.text = "Заполните поля"
        infoLabel.textColor = .red
        createDatePicker()
        loadDataForTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // при включённом наблюдателе не работает
    }
    
    func observeToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey ] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
          (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
       }
    
    func loadTextFieldFromEvent() {
       // presenter.
    }
    
    func loadDataForTextField() {
        let userDefault = UserDefaults.standard
        userNickLabel.text = "Организатор: \(userDefault.string(forKey: "nickNameUser") ?? "без названия")"
        let stringDate = formatter.string(from: Date())
        nameEventTF.text = DataService.shared.placeEvent
        iconEventIV.image = UIImage(named: iconArray[i])
        dateEventTF.text = stringDate
        DataService.shared.dateEvent = Date()
        DataService.shared.dataEventString = stringDate
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(donePressed))
        //done.title = "Готово"
        toolbar.setItems([done], animated: true)
        
        dateEventTF.inputAccessoryView = toolbar // вызов тулбара
        dateEventTF.inputView = picker
        picker.datePickerMode = .date
        picker.locale = .init(identifier: "Russian")
    }
    
    @objc func donePressed() {       
        let dateString = formatter.string(from: picker.date)
        DataService.shared.dateEvent = picker.date
        DataService.shared.dataEventString = dateString
        dateEventTF.text = "\(dateString)"
        
        self.view.endEditing(true)
    }
    
    @IBAction func closeButtonTap() {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeIconButtonTap() {
        i += 1
        if i == iconArray.count {i = 0}
        iconEventIV.image = UIImage(named: iconArray[i])
    }
    
    
    @IBAction func saveButtonTap() {
        guard let _ = dateEventTF.text, dateEventTF.text != "" else {
            infoLabel.text = "Не заполнено поле Дата" ; return }
        guard let name = nameEventTF.text, nameEventTF.text != "" else {
            infoLabel.text = "Не заполнено поле Название" ; return }
        guard let discr = discriptionEventTV.text else { return }
        //guard let category = categoryEventTF.text else { return }
        DataService.shared.categoryEvent = categoryEventTF.text ?? ""
        infoLabel.textColor = .systemBlue
        infoLabel.text = "Сохраняем ...."
        presenter.saveEvent(nameEvent: name, iconEvent: iconArray[i], discrEvent: discr)
        infoLabel.text = "Данные успешно сохранены"
        saveButton.isHidden = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        // Скрывает клавиатуру, вызванную для любого объекта
    }
    
}


extension AddMarkerScreenViewController: AddMarkerScreenProtocol {
    
    func fieldInfo(nik: String, name: String, caregiry: String, icon: String, discription: String) {
        
        userNickLabel.text = "Организатор: \(nik)"
        nameEventTF.text = name
        dateEventTF.text = formatter.string(from: Date())
        categoryEventTF.text = caregiry
        iconEventIV.image = UIImage(named: icon)
        discriptionEventTV.text = discription
        infoLabel.text = "Внесите изменения, проверьте дату"
        DataService.shared.dateEvent = Date()
        DataService.shared.dataEventString = formatter.string(from: Date())
    }
    
}

extension AddMarkerScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.view.endEditing(true) // Скрывает клавиатуру по Enter
    }
    
}
