//
//  ViewController.swift
//  LocalEvents
//
//  Created by Toki on 04/02/21.
//

import UIKit


class ViewController: UIViewController {

    var viewModelEvent = EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModelEvent.getAllEventsData()
    }

    
}

