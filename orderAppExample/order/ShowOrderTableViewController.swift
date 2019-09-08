//
//  ShowOrderTableViewController.swift
//  order
//
//  Created by Max on 2019/9/1.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ShowOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ShowOrderTableViewController: UITableViewController {
    
    var db: Firestore!

    @IBOutlet var showTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableview.dataSource = self
        showTableview.delegate = self
        // 是否可以點選 cell
        showTableview.allowsSelectionDuringEditing = true
        // 引入Firebase DB
        db = Firestore.firestore()
        // 載入DB資料
        readData()
    }
    
    // 有幾個 Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 每一組有幾個 cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    // 每個 cell 要顯示的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowOrderCell", for: indexPath) as! ShowOrderTableViewCell
        cell.nameLabel.text = nameList[indexPath.row]
        cell.drinkLabel.text = drinkList[indexPath.row]
        cell.sizeLabel.text = sizeList[indexPath.row]
        cell.sugarLabel.text = sugarList[indexPath.row]
        cell.codeLabel.text = codeList[indexPath.row]
        cell.priceLabel.text = priceList[indexPath.row]
        return cell
    }
    
    // 點選 cell 後執行的動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "取消此筆訂單", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "再考慮一下", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "確定取消 ", style: .default, handler: { _ in
            let id = self.documentId[indexPath.row]
            
            // 刪除資料庫內資料
            self.db.collection("orders").document(id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            // 刪除 List 內資料
            self.documentId.remove(at: indexPath.row)
            self.nameList.remove(at: indexPath.row)
            self.drinkList.remove(at: indexPath.row)
            self.sizeList.remove(at: indexPath.row)
            self.sugarList.remove(at: indexPath.row)
            self.codeList.remove(at: indexPath.row)
            self.priceList.remove(at: indexPath.row)
            self.showTableview.deleteRows(at: [indexPath], with: .automatic)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var documentId:[String] = []
    var nameList:[String] = []
    var drinkList:[String] = []
    var sizeList:[String] = []
    var sugarList:[String] = []
    var codeList:[String] = []
    var priceList:[String] = []
    
    func readData(){
        
    db.collection("orders").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    self.documentId.append(document.documentID)
                    self.nameList.append(document.data()["name"] as! String)
                    self.drinkList.append(document.data()["drink"] as! String)
                    self.sizeList.append(document.data()["size"] as! String)
                    self.sugarList.append(document.data()["sugar"] as! String)
                    self.codeList.append(document.data()["code"] as! String)
                    self.priceList.append(document.data()["price"] as! String)
                }
            }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        }
    }
}
