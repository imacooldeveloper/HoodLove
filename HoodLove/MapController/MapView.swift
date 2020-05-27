//
//  MapView.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MapView: UIViewController, MKMapViewDelegate, UISearchResultsUpdating {
    var uid: String?
    var selectedPin:MKPlacemark?
    
    var resultSearchController:UISearchController? = nil
    
    func updateSearchResults(for searchController: UISearchController) {
         guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    
    func authenticateUserNadConfigureView()
    {
      
    }
    
    var user: User?
    
    var fecthLoveCoordinate: String?
    var fecthCoughCoordinate: String?
    var loveCoordinate = [Coordinate]()
     var coughCoordinate = [Coordinate]()
    var candleCoordinate = [Coordinate]()
     var mapView = MKMapView()
    var WhatWrong: String?
    var lovefecth: String?
    var lastLocationSelected: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100
    
    var doubleTapView = DoubleTapView()
     var searchLocationView = DoubleTapView()
    
    
    
    lazy var menuBTN: UIButton = {
              let BTN = UIButton(type: .system)
              
        BTN.setImage(#imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), for: .normal)
//              BTN.layer.cornerRadius = 4
//           BTN.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//              BTN.backgroundColor = #colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1)
//              BTN.layer.masksToBounds = true
//              BTN.layer.borderWidth = 0.5
              BTN.addTarget(self, action: #selector(HandleMenu), for: .touchUpInside)
              
              return BTN
          }()
    
    @objc func HandleMenu() {
        let menuCon = MenuControllers()
        let nav = UINavigationController(rootViewController: menuCon)
        //nav.modalPresentationStyle = .fullScreen
        //menuCon.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    var refreshBTN: UIButton = {
           let BTN = UIButton(type: .system)
           
        BTN.setTitle("Refresh", for: .normal)
           BTN.layer.cornerRadius = 4
        BTN.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           BTN.backgroundColor = #colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1)
           BTN.layer.masksToBounds = true
           BTN.layer.borderWidth = 0.5
           BTN.addTarget(self, action: #selector(HandleRefrsh), for: .touchUpInside)
           
           return BTN
       }()
    
    @objc func HandleRefrsh() {
        
        refreshBTN.isSelected = true
        if refreshBTN.isSelected{
            self.fecthDropPoint()
            refreshBTN.isSelected = false
        }
        
    }
    
    lazy var shareButtonClicked: UIButton = {
        
        var BTN = UIButton(type: .system)
        
        BTN.setImage(#imageLiteral(resourceName: "AppLogo2").withRenderingMode(.alwaysOriginal), for: .normal)
//      BTN.contentMode = .center
//        BTN.imageView?.contentMode = .scaleAspectFit
        BTN.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
             
        BTN.layer.cornerRadius = 10
             BTN.layer.shadowColor = UIColor.black.cgColor
                BTN.layer.shadowOffset = CGSize(width: 2, height: 2)
                BTN.layer.shadowRadius = 5
                BTN.layer.shadowOpacity = 1.0
        BTN.addTarget(self, action: #selector(HandleShareButtonCLicked), for: .touchUpInside)
        
        
        return BTN
    }()
    
    @objc func HandleShareButtonCLicked() {
        
        let textToShare = "Hood Check tells you how your nebirhood is doing"
           
              if let myWebsite = NSURL(string: "https://apps.apple.com/us/developer/martin-gallardo/id1153163251") {
                  let objectsToShare = [textToShare, myWebsite] as [Any]
                  let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
           
                  //New Excluded Activities Code
                  activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                  //
           
                self.present(activityVC, animated: true, completion: nil)
 
                
        }
    }

    
    var coughView: UIButton = {
        let BTN = UIButton(type: .system)
        
        BTN.setImage(#imageLiteral(resourceName: "MaskCough").withRenderingMode(.alwaysOriginal), for: .normal)
        BTN.layer.borderWidth = 0.5
        BTN.backgroundColor = .white
        BTN.layer.cornerRadius = 4
        BTN.layer.masksToBounds = true
        
        BTN.addTarget(self, action: #selector(HandleCoughingPeople), for: .touchUpInside)
        
        return BTN
    }()
    var coughImage = UIImageView()
    var candleView: UIButton = {
        let BTN = UIButton(type: .system)
        
        BTN.setImage(#imageLiteral(resourceName: "Candle").withRenderingMode(.alwaysOriginal), for: .normal)
        BTN.layer.cornerRadius = 4
        BTN.backgroundColor = .white
        BTN.layer.masksToBounds = true
        BTN.layer.borderWidth = 0.5
        BTN.addTarget(self, action: #selector(HandleCandle), for: .touchUpInside)
        
        return BTN
    }()
    @objc func HandleCoughingPeople() {
        self.confirmBTN.isEnabled = true
        self.savingLivesLAB.isHidden = false
        if self.confirmBTN.isEnabled {
            confirmBTN.isHidden = false
           
//            confirmBTN.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            confirmBTN.layer.borderWidth = 2
//            confirmBTN.layer.cornerRadius = 10
            WhatWrong = "cough"
        }
        
    }
    @objc func HandleCandle() {
           self.confirmBTN.isEnabled = true
        self.savingLivesLAB.isHidden = false
            confirmBTN.isHidden = false
           if self.confirmBTN.isEnabled {
               WhatWrong = "Candle"
           }
           
       }
    
    var GoodView: UIButton = {
        let BTN = UIButton(type: .system)
        
        BTN.setImage(#imageLiteral(resourceName: "LoveIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        BTN.backgroundColor = .white
        BTN.layer.cornerRadius = 4
        BTN.layer.masksToBounds = true
        BTN.layer.borderWidth = 0.5
         BTN.addTarget(self, action: #selector(HandleGoodView), for: .touchUpInside)
        
        return BTN
    }()
    @objc func HandleGoodView() {
              self.confirmBTN.isEnabled = true
        self.savingLivesLAB.isHidden = false
        confirmBTN.isHidden = false
        
              if self.confirmBTN.isEnabled {
                  WhatWrong = "Love"
              }
              
          }
       
    
    
    
    let whatHappeningLAB = UILabel(text: "What's happening?", font: .systemFont(ofSize: 20))
     let savingLivesLAB = UILabel(text: "Tapp Confirm makes and help others", font: .systemFont(ofSize: 20))
   
    
    lazy var confirmBTN: UIButton = {
        let btn = UIButton(type: .system)
        btn.isEnabled = false
        
        btn.backgroundColor = #colorLiteral(red: 0.5176470588, green: 0.8196078431, blue: 0.6682328582, alpha: 1)
//        btn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = UIColor.black.cgColor
           btn.layer.shadowOffset = CGSize(width: 2, height: 2)
           btn.layer.shadowRadius = 5
           btn.layer.shadowOpacity = 1.0
        btn.setTitle("Confirm", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.addTarget(self, action: #selector(HandleConfirm), for: .touchUpInside)
        return btn
    }()
    
    @objc func HandleConfirm() {
        print("you saved a life")
        
//        self.confirmBTN.isSelected = true
        
        if self.confirmBTN.isEnabled {
            
            self.addAnnotation(location: self.lastLocationSelected ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0))
            
            guard let locations = self.lastLocationSelected else { return }
                       let region = MKCoordinateRegion.init(center: locations, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                       mapView.setRegion(region, animated: true)
            
                        guard let pinType = self.WhatWrong else { return }
            
            let values = [ "lat": locations.latitude,
                           "long": locations.longitude,"pinType":pinType] as [String : Any]
                      
            let reff =   Database.database().reference().child("SocialDropPoint")
                        
            reff.childByAutoId().updateChildValues(values) { (er, ref) in
                          if let er = er {
                              print(er)
                              return
                          }
                
                if self.WhatWrong == "Love" {
                    let convert =  self.lastLocationSelected ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
                                                
                                                let annotation = ImageAnnotation()
                                                annotation.coordinate = convert
                                                annotation.title = "love"
                                                
                                                annotation.imageUrl = UIImage(named: "love")
                    
                    
                    
                                 self.refreshBTN.isSelected = false
                            self.mapView.addAnnotation(annotation)
                    
                    
                    
                } else if self.WhatWrong == "cough"{
                    let convert =  self.lastLocationSelected ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
                                                
                                                let annotation = ImageAnnotation()
                                                annotation.coordinate = convert
                                                annotation.title = "love"
                                                
                                                annotation.imageUrl = UIImage(named: "mask")
                    self.refreshBTN.isSelected = false
                                               
                                                self.mapView.addAnnotation(annotation)
                } else if self.WhatWrong == "Candle"{
                    let convert =  self.lastLocationSelected ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
                                                
                                                let annotation = ImageAnnotation()
                                                annotation.coordinate = convert
                                                annotation.title = "love"
                                                
                                                annotation.imageUrl = UIImage(named: "Candle")
                    
                    self.refreshBTN.isSelected = false
                                               
                                                self.mapView.addAnnotation(annotation)
                }
                          
                
                    
                          print(ref)
                      }
                   
            
            self.doubleTapView.isHidden = true
            
        }
      
    }
    
    lazy var SetLocationToUser: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Map").withRenderingMode(.alwaysOriginal), for: .normal)
        
       btn.layer.cornerRadius = 10
        btn.layer.shadowColor = UIColor.black.cgColor
           btn.layer.shadowOffset = CGSize(width: 2, height: 2)
           btn.layer.shadowRadius = 5
           btn.layer.shadowOpacity = 1.0
        btn.addTarget(self, action: #selector(HandleCough), for: .touchUpInside)
        return btn
    }()
    lazy var searchLocation: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Search1").withRenderingMode(.alwaysOriginal), for: .normal)
        
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
             btn.layer.shadowColor = UIColor.black.cgColor
                btn.layer.shadowOffset = CGSize(width: 2, height: 2)
                btn.layer.shadowRadius = 5
                btn.layer.shadowOpacity = 1.0
        btn.addTarget(self, action: #selector(HandlsearchLocation), for: .touchUpInside)
        return btn
    }()
    
    
    func AddAnnotationInMap() {
        
    }
    
    @objc func HandleCough() {
        self.centerViewOnUserLocation()
    }
    let seacrhController = UISearchBar()
    @objc func HandlsearchLocation() {
        
        
//        mapView.addSubview(searchLocationView)
//
//         searchLocationView.anchor(top: nil, leading: mapView.leadingAnchor, bottom: mapView.bottomAnchor, trailing: mapView.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20),size: .init(width: 0, height: 500))
        
        calltableView()
        
        
      
        
//
//        navigationItem.searchController = search
        
        
        
        // Request for supermarkets
//           request.naturalLanguageQuery = "Supermarket"
//                   request.region = mapView.region
//                   let search = MKLocalSearch(request: request)
//                       search.start(completionHandler: {(response, error) in
//                           if error != nil {
//           //                    print("Error occured in search:
//           //                    \(error!.localizedDescription)")
//                           } else if response!.mapItems.count == 0 {
//                               print("No matches found")
//                           } else {
//                               print("Matches found")
//
//                               for item in response!.mapItems {
//                                   print("Name = \(item.name)")
//                                   print("Phone = \(item.phoneNumber)")
//                           }
//                       }
//                   })
       }
    
    let request = MKLocalSearch.Request()
    
//    override func viewDidAppear(_ animated: Bool) {
//        fecthDropPoint()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
                  DispatchQueue.main.async {
                      let loginController = LoginController()
                      
                      self.navigationController?.popViewController(animated: true)
                  }
              }  else {
           authenticateUserNadConfigureView()
            self.fecthDropPoint()
                                     mapView.delegate = self
                                     checkLocationServices()
                                     centerViewOnUserLocation()
            
            
//                                     navigationItem.rightBarButtonItem = UIBarButtonItem(title: "r", style: .plain, target: self, action: #selector(HandleRefresh))
                                     MapHUD()
                                     
                                     let tapMapViewDissMiss = UITapGestureRecognizer(target: self, action: #selector(handleDissMissView))
                                     
                                     mapView.addGestureRecognizer(tapMapViewDissMiss)
                             //
                                     let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
                                        mapView.addGestureRecognizer(longTapGesture)
                                     
                                      
                         }
        
    
//      fecthDropPoint()
        
    }
    
    
    func calltableView() {
//        let navSearchController = UISearchController()
//        let serachBar = navSearchController.searchBar
//        serachBar.placeholder = "Your placeholder"
//
//
//        var leftNavBarButton = UIBarButtonItem(customView:serachBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
//        let navBar = navigationController?.navigationBar
        
        
            
        
        let locationSearchTable = LocationSearchController()
        
        locationSearchTable.handleMapSearchDelegate = self
        locationSearchTable.mapView = self.mapView
        
        
//        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        
//        resultSearchController?.searchResultsUpdater
        
       let nav = UINavigationController(rootViewController: locationSearchTable)
//        nav.modalPresentationStyle = .custom
        
      
       
        
        self.present(nav, animated: true, completion: nil)
    }
    
//    @objc func HandleRefresh() {
//        self.fecthDropPoint()
//    }
    
    //MARK: -fecth DropPoints
    
    func fecthDropPoint() {
     
        
        
        if Auth.auth().currentUser?.uid == self.uid {
            print(Auth.auth().currentUser?.uid)
            print(self.uid )
        
           
            Database.database().reference().child("SocialDropPoint").observeSingleEvent(of: .value, with: { (snap) in
            guard let dic = snap.value as? [String:Any] else { return}
            
           
            
            dic.forEach { (key,value) in
                guard let dic2 = value as? [String:Any] else { return }
                
                
                let coordinates = Coordinate( dictornary: dic2)
                        
                
                if coordinates.pinType == "Love"{
                    self.loveCoordinate.append(coordinates)
                                      
                                      
                                      
                                      let convert =  CLLocationCoordinate2DMake(coordinates.lat,coordinates.long)
                    
                    let annotation = ImageAnnotation()
                    annotation.coordinate = convert
                    annotation.title = "love"
                    
                    annotation.imageUrl = UIImage(named: "love")
                    print(annotation.imageUrl)
                    self.mapView.addAnnotation(annotation)
                    
                    
                    
                  
                    
                    self.fecthLoveCoordinate = "Love"
                    
//                   self.addAnnotation(location: convert)
                   
//                    self.addAnnotation(location: )
                    
                }
                
                else  if coordinates.pinType == "cough"{
                                    self.coughCoordinate.append(coordinates)
                                    
                                    
                                    
                                    let converts =  CLLocationCoordinate2DMake(coordinates.lat,coordinates.long)
                    
                    
                                    
                    let annotation = ImageAnnotation()
                                      annotation.coordinate = converts
                                      annotation.title = "cough"
//                                      annotation.subtitle = "subtitle"
                                      annotation.imageUrl = UIImage(named: "mask")
                    self.mapView.addAnnotation(annotation)
                    
//                    self.addCoughAnnotation(location: converts)
                    
//                    self.addCoughAnnotation(location: annotation.coordinate)
//                                      self.mapView.addCoughAnnotation(annotation)
                                    
                    
//                    self.addCoughAnnotation(location: convert)
                                    //self.addAnnotation
                                   
                
                                    
                                } else if coordinates.pinType == "Candle"{
                                                    self.candleCoordinate.append(coordinates)
                                                                      
                                                                      
                                                                      
                                                                      let convert =  CLLocationCoordinate2DMake(coordinates.lat,coordinates.long)
                                                    
                                                    let annotation = ImageAnnotation()
                                                    annotation.coordinate = convert
                                                    annotation.title = "Candle"
                                                    
                                                    annotation.imageUrl = UIImage(named: "Candle")
                                                  
                                                    self.mapView.addAnnotation(annotation)
                                                    
                                                    
                                                    
                                                  
                                                    
                                                 
                                //                   self.addAnnotation(location: convert)
                                                   
                                //                    self.addAnnotation(location: )
                                                    
                                                }
                
            }
          
            
        }) { (er) in
            print(er)
        }
        }
        
    }
    
    @objc func handleDissMissView() {
        self.doubleTapView.isHidden = true
    }
    
    
    
  
    //MARK: - Views
    func AddViewUnderAnnotation() {
         self.doubleTapView.isHidden = false
                self.mapView.addSubview(doubleTapView)
        
        
        
                doubleTapView.anchor(top: nil, leading: mapView.leadingAnchor, bottom: mapView.bottomAnchor, trailing: mapView.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20),size: .init(width: 0, height: 500))
        
        doubleTapView.addSubview(whatHappeningLAB)
                      whatHappeningLAB.numberOfLines = 0
                      whatHappeningLAB.textAlignment = .center
                      whatHappeningLAB.anchor(top: doubleTapView.topAnchor, leading: doubleTapView.leadingAnchor
                          , bottom: nil, trailing: doubleTapView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
                      
                
                let actionViewStack = UIStackView(arrangedSubviews: [GoodView])
                 
//                coughView.backgroundColor = .red
//                PeopleView.backgroundColor = .purple
//                GoodView.backgroundColor = .yellow
                actionViewStack.distribution = .fillEqually
                actionViewStack.spacing = 10
                actionViewStack.axis = .horizontal
        //        actionViewStack.alignment = .center
        //        coughView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                doubleTapView.addSubview(actionViewStack)
               
                actionViewStack.anchor(top: whatHappeningLAB.bottomAnchor, leading: doubleTapView.leadingAnchor, bottom: nil, trailing: doubleTapView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 0, right: 15),size: .init(width: 0, height: 80))

                
                
              
               doubleTapView.addSubview(confirmBTN)

        confirmBTN.isHidden = true
        confirmBTN.anchor(top: actionViewStack.bottomAnchor, leading: doubleTapView.leadingAnchor
                    , bottom: nil, trailing: doubleTapView.trailingAnchor,padding: .init(top: 40, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 60))
        
        
        doubleTapView.addSubview(savingLivesLAB)
                             savingLivesLAB.numberOfLines = 0
                             savingLivesLAB.textAlignment = .center
        
        savingLivesLAB.isHidden = true
        savingLivesLAB.anchor(top: confirmBTN.bottomAnchor, leading: doubleTapView.leadingAnchor
            , bottom: nil, trailing: doubleTapView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
                
    }
    @objc func longTap(sender: UIGestureRecognizer){
        
        if sender.state == .began {
            
            self.AddViewUnderAnnotation()
            let generator = UIImpactFeedbackGenerator(style: .heavy)
                  generator.impactOccurred()
         
            
            print("long tap")
            
            
            
            let locationInView = sender.location(in: mapView)
            
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
             
                let regions = MKCoordinateRegion.init(center: locationOnMap, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            
            print(regionInMeters)
            
            
//
//            if let location = locationManager.location?.coordinate {
//                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//                print(regionInMeters)
//
//
//                if regionInMeters == regionInMeters {
//
//                }
//                mapView.setRegion(region, animated: true)
//            }
            
            print(locationOnMap)
            self.lastLocationSelected = locationOnMap
            
            // add anotation only if select confirm on btn
//            if self.HelpOthersBTN.isSelected {
//                   addAnnotation(location: locationOnMap)
//            }
         
            
            print(locationOnMap)
//            self.lastLocationSelected = locationOnMap
           

            
          
            
            sender.state = .ended
           
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ImageAnnotation else {
            return nil
        }

        let reuseId = "Pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
//
            pinView?.image = annotation.imageUrl
                
//
            
        }
        else {
            pinView?.canShowCallout = true
            pinView?.image = annotation.imageUrl
            pinView?.annotation = annotation
            
            
        }

        return pinView
    }
    
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? ImageAnnotation else {
//            return nil
//        }
//
//        if self.fecthLoveCoordinate == "Love"{
//
//
//
//        let reuseId = "Pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//        if pinView == nil {
//            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView?.canShowCallout = true
////            let data = NSData(contentsOf: URL(string: annotation.imageUrl!)!)
//            pinView?.image = UIImage(named: "LoveIcon")        }
//        else {
//            pinView?.annotation = annotation
//        }
//
//            return pinView
// } else
//         if self.fecthLoveCoordinate == "cough"{
//
//
//
//                let reuseId = "Pin"
//                var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//                if pinView == nil {
//                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//                    pinView?.canShowCallout = true
//        //            let data = NSData(contentsOf: URL(string: annotation.imageUrl!)!)
//                    pinView?.image = UIImage(named: "Flag")        }
//                else {
//                    pinView?.annotation = annotation
//                }
//
//                    return pinView
//         }
//
//
//        return MKAnnotationView()
//    }
//
    
    
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let userLocation = MKAnnotation.Protocol.self
//
//        if (annotation is MKUserLocation)
//        {
//
//            return nil;
//        }
//
//
//        else {
//            let pinIdent = "Pin";
//            var pinView: MKAnnotationView?
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent)
//            {
//                dequeuedView.annotation = annotation
//                pinView = dequeuedView;
//            }
//            else
//            {
//
//
//
//                if self.WhatWrong == "cough" {
//                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
//                    pinView?.image = UIImage(named: "Flag")
//
////                    if self.fecthLoveCoordinate == "cough" {
////                                       pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                                                                  pinView?.image = UIImage(named: "Flag")
////                                    }
//
//
//                } else  if self.WhatWrong == "Crowded" {
//                                   pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
//                                   pinView?.image = UIImage(named: "Crowded")
//                               }
//
//                else  if self.WhatWrong == "Love" {
//                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
//                    pinView?.image = UIImage(named: "LoveIcon")
//
//
////                    if self.fecthLoveCoordinate == "Love" {
////                                       //print(love)
////                                          pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                                               pinView?.image = UIImage(named: "LoveIcon")
////                                    }
//                }
////                 else if self.fecthLoveCoordinate == "Love" {
////                for love in self.loveCoordinate {
////                    print(love)
////                       pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                            pinView?.image = UIImage(named: "LoveIcon")
////                 }
////                }
////                 else  if self.fecthLoveCoordinate == "cough" {
////                for cough in self.coughCoordinate {
////                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                                               pinView?.image = UIImage(named: "Flag")
////                 }
////                }
//
////                else  if self.fecthLoveCoordinate == "Love" {
////                    print(self.fecthLoveCoordinate)
////                     pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                        pinView?.image = UIImage(named: "LoveIcon")
////                }
////                else if self.fecthLoveCoordinate == "cough"{
////
////                    print(self.fecthLoveCoordinate)
////                     pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////
////                                       pinView?.image = UIImage(named: "Flag")
////                }
////                else {
////                for loveIcon in self.loveCoordinate {
////                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                        pinView?.image = UIImage(named: "LoveIcon")
////                    }
////                }
////            for coughIcon in self.coughCoordinate {
////                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                    pinView?.image = UIImage(named: "Flag")
////                }
////            }
////                else {
////                    self.loveCoordinate.forEach { (loveCoordinate) in
////
////                                      pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                      pinView?.image = UIImage(named: "LoveIcon")
////                                  }
////
////
////                        self.coughCoordinate.forEach { (loveCoordinate) in
////
////                                                                                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
////                                                                                    pinView?.image = UIImage(named: "Flag")
//                                                                                }
////
////
//
//
//            return pinView;
//        }
//    }
    
//
    func addAnnotation(location: CLLocationCoordinate2D){


            let annotation = MKPointAnnotation()
            annotation.coordinate = location
//        print(location)


            annotation.title = "Some Title"
            annotation.subtitle = "Some Subtitle"
        

            //self.mapView.addAnnotation(annotation)
       
//
    }
    
    func addCoughAnnotation(location: CLLocationCoordinate2D){


                let annotation = MKPointAnnotation()
                annotation.coordinate = location
    //        print(location)


                annotation.title = "Some Title"
                annotation.subtitle = "Some Subtitle"
            

                //self.mapView.addAnnotation(annotation)
           
    //
        }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            print(regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
//centerViewOnUserLocation()
     locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    
    
      fileprivate func MapHUD() {
        mapView.showsBuildings = true
        mapView.mapType = .hybridFlyover
        
       
            view.addSubview(mapView)
            mapView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        mapView.addSubview(menuBTN)
        menuBTN.anchor(top: mapView.safeAreaLayoutGuide.topAnchor, leading: mapView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0), size: .init(width: 30, height: 30))
            
        mapView.addSubview(refreshBTN)
       
        refreshBTN.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 150, height: 50))
     
        refreshBTN.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
            
        
        mapView.addSubview(shareButtonClicked)
              
               
               shareButtonClicked.anchor(top: nil, leading: nil, bottom: mapView.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 240, right: 40),size: .init(width: 60, height: 60))
        
        
        
        
       
        
            mapView.addSubview(SetLocationToUser)
            SetLocationToUser.backgroundColor = #colorLiteral(red: 0.7346658707, green: 0.7347907424, blue: 0.7346494794, alpha: 1)
            SetLocationToUser.anchor(top: shareButtonClicked.bottomAnchor, leading: shareButtonClicked.leadingAnchor, bottom: nil, trailing: shareButtonClicked.trailingAnchor,padding: .init(top: 70, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 60))
        
       
        
        
        
        
        mapView.addSubview(searchLocation)
                   searchLocation.backgroundColor = #colorLiteral(red: 0.7346658707, green: 0.7347907424, blue: 0.7346494794, alpha: 1)
        searchLocation.anchor(top: shareButtonClicked.topAnchor, leading: view.leadingAnchor, bottom: mapView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 240, right: 0),size: .init(width: 60, height: 60))
        
        
        
    //
    //        mapView.addSubview(oughBTN)
    //        oughBTN.anchor(top: SetLocationToUser.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 40, left: 0, bottom: 0, right: 40),size: .init(width: 40, height: 40))
            
    //
    //        mapView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
    //        mapView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        }
    
    
}


extension MapView: CLLocationManagerDelegate {
    
    
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//
//
//        guard let location = locations.last else { return }
//        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
//    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
//extension ViewController: MKMapViewDelegate{
//
//func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
//
//    let reuseId = "pin"
//    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//
//    if pinView == nil {
//        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        pinView!.canShowCallout = true
//        pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
//        pinView!.pinTintColor = UIColor.black
//    }
//    else {
//        pinView!.annotation = annotation
//    }
//    return pinView
//}
//
//func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    print("tapped on pin ")
//}
//
//func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    if control == view.rightCalloutAccessoryView {
//        if let doSomething = view.annotation?.title! {
//           print("do something")
//        }
//    }
//  }
//}

// Adding the Zoom From Serach

extension MapView: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
       
        print( placemark.coordinate)
       
        // cache the pin
        selectedPin = placemark
        // clear existing pins
//        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        print(annotation.coordinate)
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta:0.002, longitudeDelta:0.002 )
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)

    }
}
