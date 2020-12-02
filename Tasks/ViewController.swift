//
//  ViewController.swift
//  Tasks
//
//  Created by user163814 on 11/29/20.
//  Copyright © 2020 user163814. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        
    @IBOutlet var tableView:UITableView?;
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tasks"
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true,forKey:"setup")
            UserDefaults().set( 0 ,forKey:"count")
        }
        
        //Get All Saved Tasks
        updateTasks()
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        guard let  count = UserDefaults().value(forKey: "count") as! Int? else {
            return
        }
        
        for x in 0..<count{
            if  let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            else{
                
            }
        }
        tableView?.reloadData()
        
        
    }
    
    @IBAction  func  didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title  = "New Task"
        vc.update = {
            DispatchQueue.main.async{
                self.updateTasks()
            }
       
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

extension ViewController:UITableViewDelegate{
    
    func  tableView(_ tableView:UITableView,didSelectRowAt indexPath:IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
         let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
               vc.title  = " Task"
               vc.task = tasks[indexPath.row]
               vc.location = indexPath.row+1
         vc.update = {
                   DispatchQueue.main.async{
                       self.updateTasks()
                   }
                }
        
               
               navigationController?.pushViewController(vc, animated: true)
    }
        func updateTasks1(){
        
        tasks.removeAll()
        guard let  count = UserDefaults().value(forKey: "count") as! Int? else {
            return
        }
        
        for x in 0..<count{
            if  let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            else{
                
            }
        }
        tableView?.reloadData()
        
        
    }
}

extension ViewController:UITableViewDataSource{
    
    func  tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
    return tasks.count
        
    }
    
    func  tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell;
    }
    
    
}
