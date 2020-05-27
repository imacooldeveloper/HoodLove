//
//  LocationSearchController.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit
import MapKit



class LocationSearchController: UITableViewController, UISearchResultsUpdating {
    
    var handleMapSearchDelegate:HandleMapSearch? = nil
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    private let  searchAdreesCell = "searchAdreesCell"
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
            guard let mapView = mapView,
                      let searchBarText = searchController.searchBar.text else { return }
                  print(searchBarText)
                  let request = MKLocalSearch.Request()
                  request.naturalLanguageQuery = searchBarText
                  request.region = mapView.region
                  let search = MKLocalSearch(request: request)
                  search.start { response, _ in
                      guard let response = response else {
                          return
                      }
                      self.matchingItems = response.mapItems
                      self.tableView.reloadData()
                  }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
               let search = UISearchController()
               search.searchResultsUpdater = self
               search.obscuresBackgroundDuringPresentation = false
               search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        self.tableView.separatorStyle = .none
        
        tableView.register(LocationSearchCell.self, forCellReuseIdentifier: searchAdreesCell)
       
    }
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        guard let mapView = mapView,
//            let searchBarText = searchController.searchBar.text else { return }
//        print(searchBarText)
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchBarText
//        request.region = mapView.region
//        let search = MKLocalSearch(request: request)
//        search.start { response, _ in
//            guard let response = response else {
//                return
//            }
//            self.matchingItems = response.mapItems
//            self.tableView.reloadData()
//        }
//    }
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedItem = matchingItems[indexPath.row].placemark
    
   
               handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
               
               self.dismiss(animated: true, completion: nil)
               self.dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchAdreesCell, for: indexPath) as! LocationSearchCell
        let selectedItem = matchingItems[indexPath.row].placemark
        
       
        cell.titleCellName.text = selectedItem.name
        
        cell.secondtitleCellName.text =  parseAddress(selectedItem: selectedItem)
//
        
        return cell
    }
}


//extension LocationSearchController {
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let selectedItem = matchingItems[indexPath.row].placemark
//        handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//}
