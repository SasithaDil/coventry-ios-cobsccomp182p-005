//
//  MapViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/25/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        present(searchController, animated: true, completion: nil)
    }
    
    func searchbarBauutonClicked(_ searchBar: UISearchBar){
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        searchBar.resignFirstResponder()
        dismiss(animated:  true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error ) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if response == nil{
                print("error")
            }
            else{
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
                let reigion = MKCoordinateRegion(center: coordinate,span: span)
                self.mapView.setRegion(reigion, animated: true)
            }
        }
    }
   
    @IBAction func Back(_ sender: Any) {
        
        let vc = UploadViewController()
        present(vc, animated: true, completion: nil)
    }
    
    
  
   
    
}
