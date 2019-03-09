//
//  SettingsTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapLogout(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: Segue.Settings.toLoginVC, sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.Settings.toLoginVC:
            AuthenticationManager.logout()
        
        default: return
        }
        
    }

}
