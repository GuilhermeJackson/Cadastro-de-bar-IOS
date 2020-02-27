//
//  MapsViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController {
    
    @IBOutlet weak var viewMap: MKMapView!
    
    var bares = [Bar]()
    
    // faz o map dar zoom
    let regionRadius: CLLocationDistance = 2000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
            latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        viewMap.setRegion(coordinateRegion, animated: true)
    }
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        viewMap.showsUserLocation = true
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude:-26.879263,longitude:-49.0787757)
         viewMap.delegate = self
        //chamando o func para zoom do map
        centerMapOnLocation(location: locationManager.location ?? initialLocation)

      loadBares()
        
    }
    
    func loadBares() {
        if let savedMeals = NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar] {
            bares += savedMeals
        }
        else {
            // Carrega o metodo loadSampleMeals
            loadSampleMeals()
        }
        
        for bar in bares {
            let geo = CLGeocoder()
            var addres = (bar.estado + " " + bar.cidade + " " + bar.bairro + " " + bar.rua + " " + String(bar.numero))
            geo.geocodeAddressString(addres, completionHandler: {
                (placemarks, error) -> Void in
                
                print(error as Any)
                
                print ("hello " + bar.name)
                if let placemark = placemarks?[0]
                {
                    self.viewMap.addAnnotation(MKPlacemark(placemark: placemark))
                }
            })
            
            viewMap.addAnnotation(bar)
        }
    }
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "mochilas")
        let photo2 = UIImage(named: "cupimBar")
        let photo3 = UIImage(named: "retroBar")
        
        let latLong = CLLocationCoordinate2D(latitude:-26.879263,longitude:-49.0787757)
        let proway = CLLocationCoordinate2D(latitude:-26.9206069,longitude:-49.0766607)
        let shop = CLLocationCoordinate2D(latitude:-26.879263,longitude:-49.0787757)
        
        guard let bar1 = Bar(title: "titulo 1",name: "Moitilas Bar", photo: photo1, rating: 4, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1, coordinate: latLong)  else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let bar2 = Bar(title: "titulo 2",name: "Cupim Bar", photo: photo2, rating: 1, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1, coordinate: proway) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let bar3 = Bar(title: "titulo 3", name: "Retro Bar", photo: photo3, rating: 3, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1, coordinate: shop) else {
            fatalError("Unable to instantiate meal2")
        }
        bares += [bar1, bar2, bar3]
    }
    
    
    
    
    
    
}

//faz retornar viewMap para todas as anotações do map
extension MapsViewController: MKMapViewDelegate {
    // 1 - retorna a visualização para cada Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2 - verifica se a annotation é do tipo Bar, caso contrario retorna nil
        guard let annotation = annotation as? Bar else { return nil }
        // 3 - criando a visualização do tipo MKMarkerAnnotationView
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4 - 	Verifica se existe algum annotation reutilizavel disponivel
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5 - usado para realiza a annotation no mapa usando a title (passa nome do lugar no title)
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
