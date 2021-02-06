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
    private let identifier = "EventCell" //rever o uso do private

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
    func dateToString(_ date: Int) -> String{
        let timeInterval = TimeInterval(date)
        var myNSDate = Date(timeIntervalSince1970: timeInterval)
        print(myNSDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let s = dateFormatter.string(from: myNSDate)
        return s
    }
}
 
extension EventTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventViewModel.arrayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell
        
        let modelEvent = eventViewModel.arrayEvents[indexPath.row]
        cell?.eventTitleLabel.text = modelEvent.title
        
        if let image = modelEvent.image {
        cell?.eventImageView.downloaded(from: image)
        }
        
        if let date = modelEvent.date{
        cell?.dateLabel.text = dateToString(date)
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicou")
    }
    
}

