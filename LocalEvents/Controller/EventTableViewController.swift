//
//  EventTableView.swift
//  LocalEvents
//
//  Created by Toki on 05/02/21.
//

import UIKit

class EventTableViewController: UIViewController {
    
    var eventViewModel = EventViewModel()
    let eventsTableView = UITableView()
    private let identifier = "EventCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        eventViewModel.getAllEventsData()
        eventViewModel.vc = self
    }
    
    func setTableView(){

        view.backgroundColor = .white
        self.view.addSubview(eventsTableView)
        
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        eventsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        eventsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        eventsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        eventsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        
        eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: identifier)

    }
    
    
}
 
extension EventTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventViewModel.arrayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        let modelEvent = eventViewModel.arrayEvents[indexPath.row]
        
        guard let eventCell = cell as? EventTableViewCell else {return cell}
        
        
        eventCell.eventTitleLabel.text = modelEvent.title
        
        
        if let url = URL(string: modelEvent.image ?? "noImage"){
            eventCell.eventImageView.loadImage(from: url)
        }
        
        if let date = modelEvent.date{
            eventCell.dateLabel.text = dateToString(date)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let event = self.eventViewModel.arrayEvents[indexPath.row]
        let eventDetailVC = DetailViewController()
        eventDetailVC.selectedEvent = event

        self.present(eventDetailVC, animated: true, completion: nil)
    }
    
    
}


