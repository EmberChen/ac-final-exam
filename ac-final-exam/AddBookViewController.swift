//
//  AddBookViewController.swift
//  ac-final-exam
//
//  Created by Ember on 2017/4/28.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit
import Firebase

class AddBookViewController: UIViewController {

    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var pictureTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var webTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    let ref = FIRDatabase.database().reference()
   
    var key:String?
    var getTime:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func sendButton(_ sender: UIButton) {
        
        let time = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        getTime = "\(dateFormatter.string(from: time as Date))"
        
        
        let data = ["name": nameTF.text!,"picture": pictureTF.text!,"address":  addressTF.text!,"phone": phoneTF.text!,"web": webTF.text!,"description": descriptionTF.text!,"createdAt": getTime!]
        
        ref.child("\(nameTF.text!)").setValue(data)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}
