//
//  BookListViewController.swift
//  ac-final-exam
//
//  Created by Ember on 2017/4/28.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit
import Firebase

class Book{
    var key: String = ""
    var name: String = ""
    var picture: String = ""
    var address: String = ""
    var phone: String = ""
    var web: String = ""
    var description: String = ""
    var createdAt: String = ""
    
    init(key: String, name: String, picture: String, address: String, phone: String, web:String, description: String, createdAt: String){
        
        self.key = key
        self.name = name
        self.picture = picture
        self.address = address
        self.phone = phone
        self.web = web
        self.description = description
        self.createdAt = createdAt
    }
}

class BookListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let ref = FIRDatabase.database().reference()
    var data:[Book] = []
    var refresh:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.queryOrdered(byChild: "createdAt")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            self.data = []
            
            //read multi data
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    let tempData = snap.value as? Dictionary<String, String>
                    let key = snap.key
                    
                    let book = Book(key: key, name: tempData!["name"]!, picture: tempData!["picture"]!, address: tempData!["address"]!, phone: tempData!["phone"]!, web: tempData!["web"]!, description: tempData!["description"]!, createdAt: tempData!["createdAt"]!)
                    
                    self.data.append(book)
                }
                self.tableView.reloadData()
            }
        })
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(pop), for: .valueChanged)
        tableView.addSubview(refresh)
    
    }

    func pop(){
        //ordering by createdAt
        ref.queryOrdered(byChild: "createdAt")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            self.data = []
            
            //read multi data
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    let tempData = snap.value as? Dictionary<String, String>
                    let key = snap.key
                    
                    let book = Book(key: key, name: tempData!["name"]!, picture: tempData!["picture"]!, address: tempData!["address"]!, phone: tempData!["phone"]!, web: tempData!["web"]!, description: tempData!["description"]!, createdAt: tempData!["createdAt"]!)
                    
                    self.data.append(book)
                }
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].name
        
        return cell
    }
    
    //刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let key = data[indexPath.row].key
        
        //刪除firebase資料
        ref.child(key).removeValue()
        //remove data 畫面更新
        self.data.remove(at: indexPath.row)
        tableView.deleteRows(at:[indexPath], with: .fade)
        
    }
    

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "gotoAdd", sender: nil)
    }

     
}
