//
//  SideMenu.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct SideMenuItem {
    let name : String
    let image : String
}

class SideMenu : NSObject {
    
    let darkBackground = UIView()
    let collectionWidth : CGFloat = 300
    let animationDuration : TimeInterval = 0.3
    
    var tableView : UITableView = {
        return UITableView(frame: .zero, style: .plain)
    }()
    
    override init() {
        super.init()
    
    }
    
    func showSideMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            darkBackground.backgroundColor = UIColor(white: 0, alpha: 0.5)
            darkBackground.frame = window.frame
            darkBackground.alpha = 0
            darkBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenuOnTap) ))
            
            tableView.frame = CGRect(x: -collectionWidth, y: 0, width: collectionWidth, height: window.frame.height)
            
            window.addSubview(darkBackground)
            window.addSubview(tableView)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.darkBackground.alpha = 1
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.collectionWidth, height: self.tableView.frame.height)
            }, completion: nil)
            
        }
    }
    
    func dismissMenu(completion: @escaping () -> ()) {

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.closeMenu()
        }) { (completed) in completion() }
    }
    
    @objc func dismissMenuOnTap() {
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.closeMenu()
        }, completion: nil)
    }
    
    // MARK: - Helpers
    
    func closeMenu() {
        self.darkBackground.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            self.tableView.frame = CGRect(x: -self.collectionWidth, y: 0, width: self.collectionWidth, height: window.frame.height)
        }
    }
    
}

