//
//  ViewController.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set Navigation bar attributes for app wide navigation bar style this would be more easily set in AppDelegate
        self.title = "CHAT WITH US"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black.withAlphaComponent(0.1)]
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.black.withAlphaComponent(0.3))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            //register to observe keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraint.constant = keyboardSize.height
            }
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0.0
    }
    
    //MARK: - Actions
    @IBAction func siriMicButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Coming Soon", message: "Feature Coming Soon!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func cameraButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Coming Soon", message: "Feature Coming Soon!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

