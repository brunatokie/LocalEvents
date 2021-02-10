//
//  EventLocation.swift
//  LocalEvents
//
//  Created by Toki on 07/02/21.
//

import Foundation
import UIKit

import MapKit

class EventLocation: NSObject, MKAnnotation {
  let title: String?

  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,

    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title

    self.coordinate = coordinate

    super.init()
  }


}
