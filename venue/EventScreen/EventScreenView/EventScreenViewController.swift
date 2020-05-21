//
//  EventScreenViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 21.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit

class EventScreenViewController: UIViewController {

    var presenter: EventScreenPresenterProtocol!
    //var marker: GMSMarker!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var eventDataTF: UITextField!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var eventCategoryTF: UITextField!
    @IBOutlet weak var eventDiscriptionTV: UITextView!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nickNameLabel.isEnabled = false
        eventDataTF.isEnabled = false
        eventNameTF.isEnabled = false
        eventCategoryTF.isEnabled = false
        eventDiscriptionTV.isEditable = false
        
        presenter.loadEventInfo()
        
    }

  

    @IBAction func closeWindow() {
        self.dismiss(animated: true)
    }
    
    @IBAction func goButtonTap() {
    }
    
}


extension EventScreenViewController: EventScreenProtocol {
    
    func setTextToView(nickName: String, eventData: String, eventName: String, eventCategory: String, eventDiscription: String) {
        
        nickNameLabel.text = nickName
        eventDataTF.text = eventData
        eventNameTF.text = eventName
        eventCategoryTF.text = eventCategory
        eventDiscriptionTV.text = eventDiscription
    }
    
}
