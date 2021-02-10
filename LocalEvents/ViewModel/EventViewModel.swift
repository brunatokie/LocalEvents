//
//  EventViewModel.swift
//  LocalEvents
//
//  Created by Toki on 05/02/21.
//

import UIKit
import Alamofire

class EventViewModel: UIViewController{
    
    weak var vc: EventTableViewController?
    weak var checkinVC : CheckinViewController?
    var arrayEvents = [Event]()
    
    private let getAllEventsURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
    private let checkinURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin"
    
    func getAllEventsData(){
        AF.request(getAllEventsURL).response { response in
    
                if let _data = response.data{
                    do {
                        let eventResponse = try JSONDecoder().decode([Event].self , from: _data)
                        self.arrayEvents.append(contentsOf: eventResponse)
                       
                        DispatchQueue.main.async {
                            self.vc?.eventsTableView.reloadData()
                            
                        }
                        
                    } catch let err{
                      
                        print(err.localizedDescription)
                    }
                }
            }
                
            }
    
    
    func postCheckIn(){

        let parameters: [String: Any] = [
            "eventId": checkinVC?.checkinEvent?.id,
            "name": checkinVC?.name,
            "email": checkinVC?.email
    ]
        
        AF.request(checkinURL, method:.post, parameters: parameters,encoding: JSONEncoding.default) .responseJSON { (response) in
            if let _data = response.data{

                do {
                    let responseEvent = try? JSONDecoder().decode([Event].self, from: _data)
                    print("post com sucesso")
                    self.checkinVC?.alertSuccess()
                } catch let err{
                    print(err.localizedDescription)
                }

            }}
    }
    
    
    
}
