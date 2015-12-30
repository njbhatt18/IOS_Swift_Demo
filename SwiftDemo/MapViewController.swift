//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var mapView : MKMapView!
    var annotations : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let userLoc = mapView.userLocation.location as CLLocation?
        //var userCoordinate = userLoc!.coordinate as CLLocationCoordinate2D
        mapView.delegate=self;
        
        
        let theCoordinate1 = CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.419281)  as CLLocationCoordinate2D
        
        let theCoordinate2 = CLLocationCoordinate2D(latitude: 37.810000, longitude: -122.477989)  as CLLocationCoordinate2D

        
        let theCoordinate3 = CLLocationCoordinate2D(latitude: 37.760000, longitude: -122.447989)  as CLLocationCoordinate2D

        
        let theCoordinate4 = CLLocationCoordinate2D(latitude: 37.80000, longitude: -122.407989)  as CLLocationCoordinate2D


        let objAnnotation1 = Annotation(coordinate: theCoordinate1, title: "Rohan", subtitle: "in the city")
        mapView.addAnnotation(objAnnotation1)
        annotations .addObject(objAnnotation1)
        
        let objAnnotation2 = Annotation(coordinate: theCoordinate2, title: "Vaibhav", subtitle: "on the bridge")
        mapView.addAnnotation(objAnnotation2)
        annotations .addObject(objAnnotation2)

        
        let objAnnotation3 = Annotation(coordinate: theCoordinate3, title: "Rituraaj", subtitle: "in the forest")
        mapView.addAnnotation(objAnnotation3)
        annotations .addObject(objAnnotation3)

        
        let objAnnotation4 = Annotation(coordinate: theCoordinate4, title: "Amit", subtitle: "at the hill")
        mapView.addAnnotation(objAnnotation4)
        annotations .addObject(objAnnotation4)

        var flyTo = MKMapRectNull as MKMapRect!
        for annotation in annotations{
            let annot = annotation as! Annotation
            let annotationPoint : MKMapPoint = MKMapPointForCoordinate(annot.coordinate)
            let pointRect : MKMapRect = MKMapRectMake(annotationPoint.x,annotationPoint.y,0,0)
            if(MKMapRectIsNull(flyTo)){
                flyTo = pointRect;
            }else{
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
        }
        mapView.visibleMapRect = flyTo;
    }

    //MapView Delegate Event -
     func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        let identifier = "AnnotationIdentifier" as NSString!
        var pinView : MKPinAnnotationView!
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation : annotation , reuseIdentifier: identifier! as String)
        }
        pinView.animatesDrop=true;
        pinView.canShowCallout=true;
        pinView.pinTintColor=UIColor.blueColor();
        
        var rightButton : UIButton!
        rightButton = UIButton(type: UIButtonType.DetailDisclosure)
        rightButton.addTarget(self, action: "showDetails:", forControlEvents: UIControlEvents.TouchUpInside)
        pinView.rightCalloutAccessoryView=rightButton
        var profileIconView : UIImageView!
        profileIconView = UIImageView(image: UIImage(named: "profile.png"))
        pinView.leftCalloutAccessoryView = profileIconView;
        return pinView

    }
    func showDetails (sender : UIButton)
    {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

