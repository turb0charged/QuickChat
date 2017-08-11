//
//  ViewController.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController, UITextFieldDelegate, ListAdapterDataSource {
    //MARK: - Properties
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageCollectionView: UICollectionView!
    

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    var counter: Int = 0
    
    var messages : [ChatMessage] = [] /*[ChatMessage.init(primaryKey: 1, messageType: .UserMessage, messageText: [] "Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mattis consectetur purus sit amet fermentum.", messageTimeStamp: Date())]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        messageTextField.delegate = self
        adapter.collectionView = messageCollectionView
        adapter.dataSource = self
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
        //dismiss keyboard observers
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return messages
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ChatMessageSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    //MARK: - Keyboard functions
    func keyboardWillShow(notification: NSNotification) {
        //move view along with keyboard
        //TODO animate and scroll to bottom of collection view when this occurs
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraint.constant = keyboardSize.height
                //TODO fix scrolling to complete bottom
                if(messages.count > 0){
                    let indexPath = IndexPath(item: 0, section: messages.count-1)
                    messageCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //TODO animate and leave collection view as is
        bottomConstraint.constant = 0.0
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        counter+=1
        messages.append(ChatMessage.init(primaryKey: counter, messageType: .UserMessage, messageText: textField.text, messageTimeStamp: Date()))
        counter+=1
        messages.append(ChatMessage.init(primaryKey: counter, messageType: .ResponseMessage, messageText: textField.text, messageTimeStamp: Date()))
        textField.text = ""
        adapter.performUpdates(animated: true)
        
        /*TODO add scrolling to the bottom of the collectionview while you are chatting with keyboard visible*/
        return true
    }
    
    //MARK: - Actions
    @IBAction func messageTextFieldReturnTouched(_ sender: Any, forEvent event: UIEvent) {
        
    }
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



