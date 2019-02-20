//
//  UIStoryboards+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

public enum StoryboardIdentifier: String {
    case Main = "Main"
}

//public enum ViewControllerStoryboardIdentifier: String {
//    case ReportSale = "ReportSaleViewController"
//}

extension UIStoryboard {
    
    class var Main: UIStoryboard {
        struct Static {
            static let instance: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main.rawValue, bundle: nil)
        }
        return Static.instance
    }
}

struct Segue {
    
    struct ReportSale {
        static let toQRScannerVC = "ReportSaleToQRScannerVC"
    }
    
    struct QRScanner {
        static let toReportSale = "QRScannerToReportSaleVC"
    }

}
