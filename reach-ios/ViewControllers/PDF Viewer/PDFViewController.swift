//
//  PDFViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import PDFKit
import WebKit
import SVProgressHUD

class PDFViewController: UIViewController {
    
    // MARK: - Properties
    
    let webView = WKWebView()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Methods
    
    func loadFromUrl(url: String){
        
        webView.frame = self.view.frame
        self.view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        SVProgressHUD.show()
        
        webView.load(URLRequest(url: URL(string:url)!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress >= 1.0 {
                SVProgressHUD.dismiss()
            }
        }
    }

    func loadFromLocal() {
        
        let pdfView = PDFView(frame: self.view.frame)

        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}
