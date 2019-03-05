//
//  PDFViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadFromUrl(url: String){
        
        let webView = UIWebView(frame: self.view.frame)
        
        webView.loadRequest(URLRequest(url: URL(string:url)!))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
