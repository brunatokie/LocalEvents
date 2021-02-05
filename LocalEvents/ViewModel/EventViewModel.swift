//
//  EventViewModel.swift
//  LocalEvents
//
//  Created by Toki on 05/02/21.
//

import UIKit

class EventViewModel{
    
    weak var vc: ViewController?
    var arrayEvents = [Event]()
    
    func getAllEventsData(){
        URLSession.shared.dataTask(with: URL(string:"http://5f5a8f24d44d640016169133.mockapi.io/api/events")!) { (data, response, error) in
            if error == nil {
                if let _data = data{
                    do {
                        let eventResponse = try JSONDecoder().decode([Event].self , from: _data)
                        self.arrayEvents.append(contentsOf: eventResponse)
                    } catch let err{
                      
                        print(err.localizedDescription)
                    }
                }
            } else {
               
                print(error?.localizedDescription)
                
                
            }
        }.resume()
    }
}
