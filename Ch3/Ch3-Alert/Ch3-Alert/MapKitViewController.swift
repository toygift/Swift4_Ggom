//
//  MapKitViewController.swift
//  Ch3-Alert
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView
        self.preferredContentSize.height = 200
        
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: pos, span: span)
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
    }

}
