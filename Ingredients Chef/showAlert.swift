//
//  showAlert.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 13/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(title:String, message:String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
