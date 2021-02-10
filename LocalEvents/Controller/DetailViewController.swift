//
//  DetailController.swift
//  LocalEvents
//
//  Created by Toki on 06/02/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController{
    
    var selectedEvent: Event?
    var eventViewModel = EventViewModel()
    let imageEvent = CustomImageView()
    let eventTitle = UILabel()
    let eventDescription = UILabel()
    let checkInButton = UIButton()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupImage()
        setupData()
        setupEventTitle()
        setupDescription()
        setupCheckinButton()
        backButton()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar" , style: .plain, target: self, action: #selector(backButton))
          navigationItem.title = NSLocalizedString("ADD_NAVTITLE", comment: "")
        
    }
    
    // MARK: - BUTTON
    
    func leftBarButton(){
        
       let barButtonItem = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar" , style: .plain, target: self, action: #selector(backButton))
 
        barButtonItem.self
    }
    
    @objc func backButton() {
        self.dismiss(animated: true)
        
    }
    
    
    // MARK: - VIEW
    
    func setupEventTitle(){
        view.addSubview(eventTitle)
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        eventTitle.topAnchor.constraint(equalTo: imageEvent.bottomAnchor, constant: 10).isActive = true
        eventTitle.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        eventTitle.textColor = .black
        eventTitle.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    func setupImage(){
        view.addSubview(imageEvent)
        
        imageEvent.translatesAutoresizingMaskIntoConstraints = false
        imageEvent.contentMode = .scaleAspectFit
        imageEvent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageEvent.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true
        imageEvent.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageEvent.heightAnchor.constraint(equalTo: imageEvent.widthAnchor).isActive = true
    }
    
    func setupDescription(){
        view.addSubview(eventDescription)
        eventDescription.translatesAutoresizingMaskIntoConstraints = false
        eventDescription.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant:10).isActive = true
        eventDescription.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: 20).isActive = true
  
        eventDescription.textColor = .black
        eventDescription.font = UIFont.boldSystemFont(ofSize: 12)
        eventDescription.numberOfLines = 0
        eventDescription.lineBreakMode = .byWordWrapping
    
        
    }
    
    func setupCheckinButton(){
        view.addSubview(checkInButton)
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        checkInButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        checkInButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        checkInButton.setTitle("Avançar", for: .normal)
        checkInButton.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
        checkInButton.backgroundColor = .lightGray
        checkInButton.layer.cornerRadius = 10
        
    }
    
    
    // MARK: - DATA
    
    func setupData(){
        if let event = selectedEvent, let url = URL(string: event.image ?? ""){
            imageEvent.loadImage(from: url)
            eventTitle.text = event.title
            eventDescription.text = event.description
        }
    }
    
    @objc func checkIn(){

        let checkinVC = CheckinViewController()
        checkinVC.checkinEvent = selectedEvent
        self.present(checkinVC, animated: true, completion: nil)
    }
    
}




