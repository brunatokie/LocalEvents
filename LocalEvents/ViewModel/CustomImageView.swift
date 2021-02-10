//
//  CustomImageView.swift
//  LocalEvents
//
//  Created by Toki on 06/02/21.
//

import UIKit


class CustomImageView: UIImageView{
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL){
      
        
        addSpinner()
        let task = URLSession.shared.dataTask(with: url){(data, response, error)
            in
            guard
                let data = data,
                let newImage = UIImage(data: data) else {
                print("could't load image url \(url)")
                
                DispatchQueue.main.async {
                self.image = UIImage(named: "noImage")
                    self.removeSpinner()
                }

                return
            }
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
            
        }
        
        task.resume()
    }
    
    
    
    func addSpinner(){
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner(){
        spinner.removeFromSuperview()
    }
}

func dateToString(_ date: Int) -> String{
    let timeInterval = TimeInterval(date)
    var myNSDate = Date(timeIntervalSince1970: timeInterval)
    print(myNSDate)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let s = dateFormatter.string(from: myNSDate)
    return s
}
