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
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.alpha = 0
        eventDiscriptionTV.isEditable = false
        if let event = DataService.shared.event {
        presenter.loadEventInfo(event: event )
        } else { presenter.markerToEvent() }
        
    }

  

    @IBAction func closeWindow() {
        DataService.shared.event = nil
        self.dismiss(animated: true)
    }
    
    
    @IBAction func removeEventButtonTap() {
        guard let event = DataService.shared.event else { return }
        NetworkService.removeEvent(event: event)
        self.dismiss(animated: true)
    }
    
    @IBAction func goButtonTap() {
        NetworkService.followMe()
        displayWarningLabel(withText: "Ваш голос принят !")
    }
    
    func animeOffLabel() {
        UIView.animate(withDuration: 2, delay: 0,
                       animations: { self.infoLabel.alpha = 0 })
    }
    
    func displayWarningLabel(withText text: String) {
        infoLabel.text = text
        infoLabel.textColor = .systemBlue
       
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.infoLabel.alpha = 1
        }) { [weak self] complete in
            self?.animeOffLabel()
            //self?.infoLabel.alpha = 0
        }
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
    
    func removeButtonSetting(hide: Bool) {
        if hide {
            removeButton.isHidden = true
        } else {
            removeButton.isHidden = false
        }
    }
    
}
