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

struct NewsFeedItem {
    let imageName, title, subtitle : String
}

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var pointsLabel : UILabel!
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
        
        collectionDataSource.data = [NewsFeedItem(imageName: "dummy_promotion2", title: "Microsoft", subtitle: "Dynamics CRM"), NewsFeedItem(imageName: "dummy_promotion2", title: "Microsoft", subtitle: "Dynamics CRM"), NewsFeedItem(imageName: "dummy_promotion2", title: "Microsoft", subtitle: "Dynamics CRM") ]
        collectionView.dataSource = collectionDataSource
        
        sideMenuDataSource.data = [SideMenuItem(name: "Home", image: "SideMenuHome"), SideMenuItem(name: "Help", image: "SideMenuHelp"), SideMenuItem(name: "FAQs", image: "SideMenuFAQ"), SideMenuItem(name: "About Us", image: "SideMenuAbout"), SideMenuItem(name: "Contact Us", image: "SideMenuContact"), SideMenuItem(name: "Terms & Conditions", image: "SideMenuTerms"), SideMenuItem(name: "Settings", image: "SideMenuSettings")]
        
        sideMenu.tableView = sideMenuTableView
        sideMenuTableView.dataSource = sideMenuDataSource
        sideMenuTableView.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.animateProgress()
    }

    // MARK: - Helpers
    
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
            vcToPush = self.instantiate(viewControllerID: ViewIdentifier.Contact.rawValue, storyBoard: UIStoryboard.SideMenu!, type: UIViewController.self)
            
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
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        //TODO: SEGUE
//        performSegue(withIdentifier: "zbre", sender: nil)
    }
}
