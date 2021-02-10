//
//  CheckinViewController.swift
//  LocalEvents
//
//  Created by Toki on 09/02/21.
//
import UIKit
import Foundation
import MapKit

class CheckinViewController: UIViewController{
    
    var eventViewModel = EventViewModel()
    var checkinEvent: Event?
    var name:String?
    var email:String?
    let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    var safeArea: UILayoutGuide!
    let checkInButton = UIButton()
    
    
    var nameTextField : UITextField!
    var emailTextField : UITextField!
    var namelabel : UILabel!
    var emailabel : UILabel!
    let nameStr : String = "Nome: "
    let emailSrt: String = "E-mail: "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        mapEvent()
        inicialLocation()
        locationManager.requestWhenInUseAuthorization()
        addAnnotation()
        setName()
        setEmail()
        setupCheckinButton()
    }
    
    // MARK: - VIEW
    
    func mapEvent(){
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 50
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        view.addSubview(mapView)
    }
    
    func addAnnotation(){
        let localEvent = EventLocation(
            title: checkinEvent?.title,
            coordinate: CLLocationCoordinate2D(latitude: checkinEvent?.latitude ?? 0, longitude: checkinEvent?.longitude ?? 0 ))
        mapView.addAnnotation(localEvent)
    }
    
    func setName(){
        
        let placeholder = NSAttributedString(string: "Nome", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        nameTextField = UITextField(frame: CGRect(x: 50, y: 420, width: 200, height: 25))
        
        nameTextField.attributedPlaceholder = placeholder
        nameTextField.textColor = UIColor.black
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.clearsOnBeginEditing = true
        view.addSubview(nameTextField)
        
        namelabel = UILabel(frame: CGRect(x: 50, y: 400, width: 300, height: 20))
        namelabel.text = nameStr
        view.addSubview(namelabel)
        
    }
    func setEmail(){
        
        let placeholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        emailTextField = UITextField(frame: CGRect(x: 50, y: 500, width: 200, height: 25))
        
        emailTextField.attributedPlaceholder = placeholder
        emailTextField.textColor = UIColor.black
        emailTextField.delegate = self
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.clearsOnBeginEditing = true
        view.addSubview(emailTextField)
        
        emailabel = UILabel(frame: CGRect(x: 50, y: 480, width: 300, height: 20))
        emailabel.text = emailSrt
        view.addSubview(emailabel)
        
    }
    
    func setupCheckinButton(){
        view.addSubview(checkInButton)
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        checkInButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        checkInButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        checkInButton.setTitle("Fazer CheckIn", for: .normal)
        checkInButton.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
        checkInButton.backgroundColor = .lightGray
        checkInButton.layer.cornerRadius = 10
    }
    @objc func checkIn(){
        alert()
       
    }
    
    func requestCheckin(){
       
        self.email = emailTextField.text
        self.name = nameTextField.text
        eventViewModel.postCheckIn()
        }
     
    func validateFields() -> Bool {
        if emailTextField.text?.isEmpty ?? true && nameTextField.text?.isEmpty ?? true {
            return false
        }
        return true
    }
        
    // MARK: - ALERTS
    
    func alert(){
        
        if self.validateFields(){
        var dialogMessage = UIAlertController(title: "CheckIn", message: "Deseja fazer o checkin?", preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.requestCheckin()
            self.alertSuccess()
        })
      
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
            
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
       
        self.present(dialogMessage, animated: true, completion: nil)
        }
        else{
            var dialogMessage = UIAlertController(title: "Aviso", message: "Preencha todos os campos", preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler:nil)
          
            
            dialogMessage.addAction(ok)
           
           
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func alertSuccess(){
        var dialogMessage = UIAlertController(title: "Sucesso", message: "CheckIn com sucesso!", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler:{ (action) -> Void in
            guard let vc = self.presentingViewController else { return }

                while (vc.presentingViewController != nil) {
                    vc.dismiss(animated: true, completion: nil)
                }
        })
                            
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    
    }
}

// MARK: - TextFieldDelegate

extension CheckinViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        view.backgroundColor = UIColor.white
    }
    
    func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        nameTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.backgroundColor = UIColor.orange
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        //Hide the keyboard
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - MKMapViewDelegate

extension CheckinViewController: MKMapViewDelegate{
    
    func inicialLocation() {
        let initialLocation = CLLocation(latitude: -30.0358389517062, longitude: -51.2161226)
        self.centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? EventLocation else {
            return nil
        }
        
        let identifier = "eventlocation"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
