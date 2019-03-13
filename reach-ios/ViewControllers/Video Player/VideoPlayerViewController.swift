//
//  VideoPlayerViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class VideoPlayerViewController: UIViewController {

    // MARK: - Properties
    
    var urlString = String()
    var webView : WKWebView?
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .audio
     
        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        self.view.addSubview(webView!)

        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        SVProgressHUD.show()
        
        webView?.load(URLRequest(url: URL(string:"https://www.youtube.com/watch?v=\(urlString)")!))
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            if webView!.estimatedProgress >= 0.6 { //YouTube is practically fully loaded by 0.6, but will take forever to reach 1.0
                SVProgressHUD.dismiss()
            }
        }
    }
}
