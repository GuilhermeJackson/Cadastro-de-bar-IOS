//
//  Artwork.swift
//  Meu primeiro app
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation { //criando objeto de notação para o map
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
//https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
