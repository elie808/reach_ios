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
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    // MARK: - Methods
    
    func loadFromUrl(url: String){
        
        let webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        webView.load(URLRequest(url: URL(string:url)!))
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
