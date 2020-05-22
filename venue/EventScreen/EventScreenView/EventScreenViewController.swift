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
    @IBOutlet weak var eventDataLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventCategoryLabel: UILabel!
    @IBOutlet weak var eventDiscriptionTV: UITextView!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventDiscriptionTV.isEditable = false
        presenter.loadEventInfo()
    }

  

    @IBAction func closeWindow() {
        self.dismiss(animated: true)
    }
    
    @IBAction func goButtonTap() {
        presenter.followMe()
    }
    
}


extension EventScreenViewController: EventScreenProtocol {
    
    func setTextToView(nickName: String, eventData: String, eventName: String, eventCategory: String, eventDiscription: String) {
        
        nickNameLabel.text = nickName
        eventDataLabel.text = "Дата проведения: \(eventData)"
        eventNameLabel.text = "Название: \(eventName)"
        eventCategoryLabel.text = "Категория: \(eventCategory)"
        eventDiscriptionTV.text = eventDiscription
    }
    
}
