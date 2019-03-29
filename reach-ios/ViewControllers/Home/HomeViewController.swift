//
//  HomeViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Person {
    let firstName, lastName : String
}

struct NewsFeedItem : Codable {
    let image, title, link : String
    let id : Int
}

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var pointsLabel : UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profilePicture: ProfilePictureProgressView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var sideMenuTableView : UITableView!
    
    // MARK: - Properties
    
    let sideMenu = SideMenu()
    var collectionDataSource = GenericCollectionDataSource<NewsFeedCell,NewsFeedItem>()
    var sideMenuDataSource = GenericTableDataSource<SideMenuCell,SideMenuItem>()
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initializeViews()
        getBanners()
//        sendOneSignalID()
    }
    
    // MARK: - Helpers

    fileprivate func sendOneSignalID() {
        
        let pushObj = PushNotification(id : oneSignalAPIKey, onesignal_id: nil)
        
        let oneSignal = Resource<PushNotification>(url: URL(string: NetworkingConstants.oneSignalID)!, method: HttpMethod<PushNotification>.post(pushObj))
        
        URLSession.shared.load(oneSignal) { (response, status) in
            // response =
            // {
            //    "onesignal_id": "tester"
            // }
        }
    }
    
    fileprivate func initializeViews() {
        
        sideMenuDataSource.data = [SideMenuItem(name: "Home", image: "SideMenuHome"), SideMenuItem(name: "Help", image: "SideMenuHelp"), SideMenuItem(name: "FAQs", image: "SideMenuFAQ"), SideMenuItem(name: "About Us", image: "SideMenuAbout"), SideMenuItem(name: "Contact Us", image: "SideMenuContact"), SideMenuItem(name: "Terms & Conditions", image: "SideMenuTerms"), SideMenuItem(name: "Settings", image: "SideMenuSettings")]
        
        sideMenu.tableView = sideMenuTableView
        sideMenuTableView.dataSource = sideMenuDataSource
        sideMenuTableView.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        collectionView.dataSource = collectionDataSource
        
        let profile = Resource<User>(get: URL(string: NetworkingConstants.profile)!)
        
        URLSession.shared.load(profile) { (response, status) in
            if let user = response {
                self.fullNameLabel.text = user.firstName + " " + user.lastName
                self.profilePicture.profilePicture.urlSetImage(user.image)
                self.profilePicture.totalPoints = user.totalApprovedPoints
                self.profilePicture.maxPoints = user.maxPoints
                self.profilePicture.animateProgress()
                self.pointsLabel.text = "\(user.totalApprovedPoints )"
            }
        }
    }
    
    fileprivate func getBanners() {
        
        let banners = Resource<[NewsFeedItem]>(get: URL(string:NetworkingConstants.banners)!)
        
        URLSession.shared.load(banners) { (bannerItems, status) in
            if let banner = bannerItems, banner.count > 0 {
                self.collectionDataSource.data = banner
                self.collectionView.reloadData()
            }
        }
    }
    
    /// Convenience method to simplify and avoid using Storyboard segues
    func pushFromSideMenu(at index: Int) {
        
        var vcToPush = UIViewController()
        
        switch index {
            
        case 0: return
            
        case 1: // Help
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.Help.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)

        case 2: // FAQ
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.FAQs.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)
            
        case 3: // About
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.About.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)
            
        case 4: // Contact
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.Contact.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UITableViewController.self)
            
        case 5: // T&C
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.TermsAndConditions.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)
            
        case 6: // Settings
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.Settings.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)
            
        default: return
        }
        
        if let navigator = self.navigationController {
            navigator.pushViewController(vcToPush, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        sideMenu.showSideMenu()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        case Segue.Home.toSearch:
            if let searchText = sender, searchText is String, (searchText as! String).count > 0 {
                let vc = segue.destination as! HomeSearchViewController
                vc.searchText = searchText as? String
            }
        default: return
        }
        
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bannerItem = collectionDataSource.data[indexPath.row]

        guard let url = URL(string: bannerItem.link) else { return }
        UIApplication.shared.open(url)
    }
}

// Side Menu delegates
extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sideMenu.dismissMenu {
            self.pushFromSideMenu(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.trimmingCharacters(in: .whitespaces), text.count > 0, !text.isEmpty {
            performSegue(withIdentifier: Segue.Home.toSearch, sender: text)
            searchBar.showsCancelButton = false
            searchBar.resignFirstResponder()
        }
    }
}
