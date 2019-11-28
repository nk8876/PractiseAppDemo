//
//  UserDashboard.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 30/07/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import  GoogleMaps
import GooglePlaces
import CoreLocation

class UserDashboard: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var sideMenuBar: UITableView!
    @IBOutlet weak var leadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableLeadingConstrains: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet weak var mapView: UIView!
    var locationManager = CLLocationManager()
    var myMapView = GMSMapView()
    var marker = GMSMarker()
    var menuName : [String] = ["Home","Profile","Pending requests","Accepted requests","Completed rides","Payment","Cancelled rides","History","Favoriets","Setting","About","Help","Share","Logout"]
    var menuIcon  = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "profile"),#imageLiteral(resourceName: "to-do-list"),#imageLiteral(resourceName: "task-complete"),#imageLiteral(resourceName: "done"),#imageLiteral(resourceName: "payment"),#imageLiteral(resourceName: "cancel"),#imageLiteral(resourceName: "history"),#imageLiteral(resourceName: "favorites"),#imageLiteral(resourceName: "setting"),#imageLiteral(resourceName: "about"),#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "logout")]
    var isSideBarOpen:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullName = UserDefaults.standard.object(forKey: "username")
        userName.text! = "\(String(describing: fullName!))"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
            mapView.addGestureRecognizer(tapGesture)
        setUpView()
       
    }

    @objc func tapGestureAction()  {
        self.sideView.isHidden = false
        if isSideBarOpen{
            leadingConstraints.constant = -210
            tableLeadingConstrains.constant = -210
            viewLeading.constant = -210
        }else{
            leadingConstraints.constant = 0
            tableLeadingConstrains.constant = 0
            viewLeading.constant = 0
            
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 10.0)
        myMapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.mapView.frame.width, height: self.mapView.frame.height), camera: camera)
        myMapView.isMyLocationEnabled = true
        self.mapView.addSubview(myMapView)
        
        marker.position = center
        marker.title = "Ashmar Technology & Research Pvt. Ltd."
        marker.map = myMapView
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
        
        locationManager.stopUpdatingLocation()
    }
  
    func setUpView()  {
        userProfileImage.layer.cornerRadius = (userProfileImage.frame.width / 2)
        userProfileImage.layer.masksToBounds = true
        
        // User Location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        sideView.isHidden = true
        sideMenuBar.backgroundColor = UIColor.clear
        isSideBarOpen = false
        sideView.layer.shadowOpacity = 0.5
        sideView.layer.shadowRadius = 5
    
        addCustomizedBackBtn()
        swipView()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true
        )
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            sideView.isHidden = true
        }
    }
    func swipView()  {
        ////SWIP LEFT
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
       
    }
    @objc func didSwipeLeft(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.left :
            self.sideView.isHidden = true
            default:
            break
        }
      
    }
    
    @IBAction func btnOpenCloseMenuAction(_ sender: UIBarButtonItem) {
        
        self.sideView.isHidden = false
        if isSideBarOpen{
            leadingConstraints.constant = -210
            tableLeadingConstrains.constant = -210
            viewLeading.constant = -210
        }else{
            leadingConstraints.constant = 0
            tableLeadingConstrains.constant = 0
            viewLeading.constant = 0
            
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
  
}
extension UserDashboard:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.menuName.text = menuName[indexPath.row]
        cell.menuIcon.image = menuIcon[indexPath.row]
        return cell

    }
  
}

extension UserDashboard:UITableViewDelegate{
    func viewControllerSwitch(identifier:String)  {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewControllerSwitch(identifier: "UserDashboard")
        case 1:
            viewControllerSwitch(identifier: "UserProfileVC")

        case 2:
            viewControllerSwitch(identifier: "PaymentViewController")

        case 3:
            viewControllerSwitch(identifier: "HistoryViewController")

        case 4:
            viewControllerSwitch(identifier: "FavoritesViewController")

        case 5:
            viewControllerSwitch(identifier: "SettingViewController")

        case 6:
            viewControllerSwitch(identifier: "AboutViewController")

        case 7:
            viewControllerSwitch(identifier: "HelpViewController")

        case 8:
            viewControllerSwitch(identifier: "ShareViewController")

        case 9:
            print("9")
            viewControllerSwitch(identifier: "ShareViewController")

        case 10:
            print("10")

            viewControllerSwitch(identifier: "ShareViewController")
        case 11:
            print("11")

            viewControllerSwitch(identifier: "ShareViewController")
        case 12:
            print("12")

            viewControllerSwitch(identifier: "ShareViewController")
        case 13:
            UserDefaults.standard.removeObject(forKey: "mobileNumber")
            let vc = storyboard!.instantiateViewController(withIdentifier:"PhoneNumberCV" )
            let navVC = UINavigationController(rootViewController: vc)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = navVC
            appDelegate?.window?.makeKeyAndVisible()

        default:
        print("can't find view controller")
        }
       
    }
    
}
