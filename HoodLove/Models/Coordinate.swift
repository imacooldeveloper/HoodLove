//
//  Coordinate.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import Foundation
import MapKit
import Contacts
import UIKit

struct Coordinate {
   
    
    let lat: Double
    let long: Double
    let pinType: String
 
    init( dictornary:[String:Any]) {
        
        lat = dictornary["lat"] as? Double ?? 0
        long = dictornary["long"] as? Double ?? 0
        pinType = dictornary["pinType"] as? String ?? ""
      
    }
}



class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D
  
  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D)
    {
      self.title = title
      self.locationName = locationName
      self.discipline = discipline
      self.coordinate = coordinate
      
      super.init()
    }
}


class ImageAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageUrl: UIImage?

    override init() {
        self.coordinate = CLLocationCoordinate2D()
        self.title = nil
        self.subtitle = nil
        self.imageUrl = nil
    }
}
