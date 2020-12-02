//
//  EntryViewController.swift
//  Tasks
//
//  Created by user163814 on 11/30/20.
//  Copyright © 2020 user163814. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var field :UITextField!
    var update :(() ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save", style: .done, target: self, action:
            #selector(saveTask) )
      
        
        // Do any additional setup after loading the view.
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        return true;
    }
    
  @objc  func saveTask(){
        
    guard let  text = field.text ,!text.isEmpty else{
        return
    }
    
    guard let  count  = UserDefaults().value(forKey: "count") as? Int else{
        return
    }
     let newcount = count+1
    UserDefaults().set(newcount,forKey: "count")
    
    UserDefaults().set(text,forKey:"task_\(newcount)" )
    
    update?()
    
    navigationController?.popViewController(animated: true)
    
    
    
 
    }
    

}
