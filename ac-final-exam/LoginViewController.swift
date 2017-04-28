//
//  LoginViewController.swift
//  ac-final-exam
//
//  Created by Ember on 2017/4/28.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginButton(_ sender: UIButton) {
        
        //login field check
        if mailTextField.text == "" || passwordTextField.text == "" {
            
            print("Please enter something in the text field")
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) {
                
                (user, error) in
                if error == nil {
                    
                    
                    //Go to the HomeViewController if the login is sucessful
                    self.performSegue(withIdentifier: "gotoList", sender: nil)
                    
                } else {
                    
                    // 提示用戶從 firebase 返回了一個錯誤。
                    print(error!.localizedDescription)
                }
            }
        }
        

        
        
        
        
        
        
        
        
        
        
        
        
        
       
    
    
    }
    
    
      
    
}
