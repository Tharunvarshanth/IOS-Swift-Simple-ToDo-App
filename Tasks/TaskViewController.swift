//
//  TaskViewController.swift
//  Tasks
//
//  Created by user163814 on 11/30/20.
//  Copyright © 2020 user163814. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label:UILabel!
    
    var task:String?
    var location :Int?
    var l:String?
     var update :(() ->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

      l = "\(location!)"
       // l = l!.prefix(1)
        label.text = task! + "\(l)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Delete",style:.done,target:self,action:
            #selector(deleteTask))
        
    }
    
    
    @objc func deleteTask(){
        guard  let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
       let newcount = count-1
        
        UserDefaults().set(newcount,forKey: "count")
       // location = location
        UserDefaults().set(nil, forKey: "task_\(String(describing: location))")
        
       update?()
           
           navigationController?.popViewController(animated: true)
    }
    

   

}
