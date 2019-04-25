//
//  post_setup.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 10/25/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import CoreLocation
import MapKit

class post_setup: UIViewController , CLLocationManagerDelegate {
    //Realm Imports
    let realm = try! Realm()
    var data: Results<Data_Model>!
    var attributes: Results<Attributes>!
    
    var data_a = [Data_Model]()
    var data_b = [Data_Model]()
    
    var attributes_data = [Attributes]()
    
    

    
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var start_over: UIButton!
    
    //current location
    let locationManager = CLLocationManager()
    var latitude:CLLocationDegrees = 0.0
    var longitude:CLLocationDegrees = 0.0
    
    //The user's current location out of the two stored locations
    var spot:String? = "Hello"
    
    //event ex. bus
    var event:String?
    //stored in backe_end
    var stored_address1:String?
    var stored_address2:String?
    
    //cordinates of stored addresses
    var latitude_1:CLLocationDegrees = 0.0
    var longitude_1:CLLocationDegrees = 0.0
    var latitude_2:CLLocationDegrees = 0.0
    var longitude_2:CLLocationDegrees = 0.0
    
    //output outlets that are filled with event + closest address information
    @IBOutlet weak var fill_this_with_event: UILabel!
    @IBOutlet weak var fill_this_with_address: UILabel!
    
    //returns the current time in 24 hour format
    func currentTime()-> String{
        let current_date = Date()
        let format = DateFormatter()
        format.dateFormat = "HHmm"
        let date = format.string(from: current_date)
        return date
    }
    
    //calculate distances from stored cordinates to current cordinates
    //and predict user's closet location i.e the lower difference
    func predict(){
        let cordinate_A = CLLocation(latitude: self.latitude_1  , longitude: self.longitude_1)
        let cordinate_B = CLLocation(latitude: self.latitude_2 , longitude: self.longitude_2)
        let user_cordinate = CLLocation(latitude: self.longitude  , longitude: self.latitude )
        
        let distance_to_A = cordinate_A.distance(from: user_cordinate)
        let distance_to_B = cordinate_B.distance(from: user_cordinate)
        
        print("Longitude 1  " , self.longitude_1)
        print("Longitude 2  " , self.longitude_2)
        print("Longitude" , self.longitude)
        
        if(distance_to_A < distance_to_B){
            //user is at SPOT: A
            spot = "A"
            self.fill_this_with_address.text = stored_address1
            
        }else{
            //user is at Spot: B
            spot = "B"
            self.fill_this_with_address.text = stored_address2
        }
        print("distance to A" , distance_to_A)
        print("distance to B" , distance_to_B)
        
        //spots have been assigned safe to predict time
        predictTime()
    }
    
    //converts address in backend->2D cordinates and calculates the closet path ergo current spot
    func convert(completion: @escaping (_ success: Bool) -> Void){
        
        if let test = self.stored_address1{
        //CONVERTING ADDRESS1->CORDINATES
        var geocoder1 = CLGeocoder()
        geocoder1.geocodeAddressString(self.stored_address1!) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let long = placemark?.location?.coordinate.longitude
            if let test = lat {
            self.latitude_1 = lat!
            self.longitude_1 = long!
            print("got this" , lat!)
            }
            
            
        }
        }
        
        if let test = self.stored_address2 {
        var geocoder2 = CLGeocoder()
        geocoder2.geocodeAddressString(self.stored_address2!) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let long = placemark?.location?.coordinate.longitude
            if let x = lat{
            self.latitude_2 = lat!
            self.longitude_2 = long!
            print("got this" , lat!)
            }
            completion(true)
        }
        
        }
    }
    
    /*
     * stores data from backend into vars
     */
    func currentSpot(){
        for x in attributes_data{
            //only running one time
            print("event is " , x.event)
            self.event = x.event
            self.fill_this_with_event.text = x.event
            self.stored_address1 = x.address1
            self.stored_address2 = x.address2
            break
        }
    }
    
    /*
     * Known: Current closest spot (make sure it syncs)
     * To Find: Next available time in the database of that spot
     */
    func predictTime(){
        print("Predicting")
        if spot != "Hello"{
            //spot has been assigned
            print("Spot has been assigned, finding the next available time: ")
            print(spot)
            var k = currentTime(); //current time
            print(data_a)
              print("Current time into array: " )
            if(spot == "A"){
                print("Predicting next available time for Spot A")
                print("The time schedule for this spot: ")
                print(data_a)
                /*
                 k:   1  3   0   5
                 idx: 0  1   2   3   4   5   6
                 
                 Time:
                 Hour: Int? 13
                 Minute: Int? 05
                 */
                print("the value of current time: " + k)
                if(data_a.isEmpty){
                    print("Data is corrupted")
                }
                for time in data_a{
                    if(time.hour.value == nil){
                        //Corrupted Data!
                        print("Data is corrupted")
                        continue
                    }
                    //converting Time object to comparable string
                    let hour = String(format: "%02d", time.hour.value!)
                    let minute = String(format: "%02d", time.minutes.value!)
                    
                    let comp = String(hour) + String(minute)
                    
                    print(comp + k)
                    if(comp > k){
                        //works!
                        print("Found greater time: " + comp)
                        output.text = comp
                        
                    }
                }
            }
            
            if(spot == "B"){
                print("Predicting next available time for Spot B")
                print("The time schedule for this spot: ")
                print(data_b)
                /*
                 k:   1  3   0   5
                 idx: 0  1   2   3   4   5   6
                 
                 Time:
                 Hour: Int? 13
                 Minute: Int? 05
                 */
                print("the value of current time: " + k)
                if(data_b.isEmpty){
                    print("Data is corrupted")
                }
                for time in data_b{
                    if(time.hour.value == nil){
                        //Corrupted Data!
                        print("Data is corrupted")
                        continue
                    }
                    //converting Time object to comparable string
                    let hour = String(format: "%02d", time.hour.value!)
                    let minute = String(format: "%02d", time.minutes.value!)
                    
                    let comp = String(hour) + String(minute)
                    
                    print(comp + k)
                    if(comp > k){
                        //works!
                        print("Found greater time: " + comp)
                        output.text = comp
                        
                    }
                }
            }
        }
    }
    
    
    //sends back and deletes all the data in back-end
    // deletes the schedule
    func resetData(){
        try! realm.write{
            realm.delete(data)
            //realm.deleteAll()
        }
    }
    
    //completely starts over --> deletes adderess + schedule
    func resetEverything(){
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    
   //reset button event
    @IBAction func reset(_ sender: Any) {
       resetData()
    }
    @IBAction func start_over(_ sender: Any) {
        resetEverything()
    }
    
    
    //log all the data in back-end as soon as navigated
    override func viewDidAppear(_ animated: Bool) {
        
        //load data
        data = realm.objects(Data_Model.self)
        for x in data{
            //safety for corrupted data
           
            if let test = x.hour.value {
                print("READNG FROM CRUD")
                print(x.spot)
                print(x.hour.value )
                print(x.minutes.value)
                print(x.postfix)
                if(x.spot == "A"){
                    data_a.append(x)
                }else{
                    data_b.append(x)
                }
            }
            }
        
        attributes = realm.objects(Attributes.self)
        for y in attributes{
            if(y != nil){
            attributes_data.append(y)
            }
        }
        currentSpot()
        
            currentSpot()
                convert { (success) -> Void in
                    if success {
                        // predict when safe
                        self.predict()
                    }
                }

        
    }
    
    override func viewDidLoad() {
        //location stuff
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
     
        
}
    //current address
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.longitude = locValue.latitude
        self.latitude = locValue.longitude
    }
}
