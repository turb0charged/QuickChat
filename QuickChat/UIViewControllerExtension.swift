//
//  UIViewControllerExtension.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

//useful for any vc with a keyboard 

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
