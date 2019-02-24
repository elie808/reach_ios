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
        
        sideMenuDataSource.data = [SideMenuItem(name: "Home", image: ""), SideMenuItem(name: "Help", image: ""), SideMenuItem(name: "FAQs", image: ""), SideMenuItem(name: "About Us", image: ""), SideMenuItem(name: "Contact Us", image: ""), SideMenuItem(name: "Terms & Conditions", image: ""), SideMenuItem(name: "Settings", image: "")]
        
        sideMenu.tableView = sideMenuTableView
        sideMenuTableView.dataSource = sideMenuDataSource
        sideMenuTableView.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.animateProgress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationItem.titleView = nil
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

extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sideMenu.dismissMenu {
            
            print(self.sideMenuDataSource.data[indexPath.row].name)
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
