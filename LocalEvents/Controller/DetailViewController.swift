//
//  DetailController.swift
//  LocalEvents
//
//  Created by Toki on 06/02/21.
//

import UIKit

class DetailViewController: UIViewController{
    
    var event: Event?
    let imageEvent = CustomImageView()
    let eventTitle = UILabel()
    let checkInButton = UIButton()
    
    
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        safeArea = view.layoutMarginsGuide
        setupImage()
        setupData()
        setupEventTitle()
        setupCheckinButton()
        backButton()
    }
    
    func backButton(){
        let back = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [back]
    }
    
    @objc func addTapped() {
        self.dismiss(animated: true)
        
    }
    
    func setupEventTitle(){
        view.addSubview(eventTitle)
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        eventTitle.topAnchor.constraint(equalTo: imageEvent.bottomAnchor, constant: 10).isActive = true
        eventTitle.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        eventTitle.textColor = .white
    }
    
    
    
    func setupImage(){
        view.addSubview(imageEvent)
        
        imageEvent.translatesAutoresizingMaskIntoConstraints = false
        imageEvent.contentMode = .scaleAspectFit
        imageEvent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageEvent.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageEvent.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
        imageEvent.heightAnchor.constraint(equalTo: imageEvent.widthAnchor).isActive = true
}
    
    func setupCheckinButton(){
        view.addSubview(checkInButton)
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        checkInButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        checkInButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        checkInButton.setTitle("Fazer CheckIn", for: .normal)
        checkInButton.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
        
    }
    
    
    func setupData(){
        if let event = event, let url = URL(string: event.image ?? ""){
            imageEvent.loadImage(from: url)
            eventTitle.text = event.title
        }
    }
    
    @objc func checkIn(){
        self.dismiss(animated: true)
    }
    
}
