//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 21..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(location: String) {
        // get location
        let geoCoder = CLGeocoder()
        print(geoCoder)
        
        geoCoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                // get the first placemark
                let placemark = placemarks[0]
                // add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    // display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    // set the zoom level
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        }
    }

}
