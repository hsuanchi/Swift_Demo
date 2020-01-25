//
//  PlayerListViewController.swift
//  New1208
//
//  Created by 宣齊 on 2019/5/27.
//  Copyright © 2019年 maxlist. All rights reserved.
//


import UIKit
import Firebase

class PlayerListViewController: UIViewController {
    
    var players:[String] = []
        {
        didSet {
            if players.count >= 8 {
                numberOfPlayers.textColor = #colorLiteral(red: 1, green: 0.1803921569, blue: 0.3882352941, alpha: 1)
            } else {
                numberOfPlayers.textColor = .black
            }
            numberOfPlayers.text = "Number Of Tasks: \(players.count)/8"
        }
    }
    
    @IBOutlet weak var playerListTableView: UITableView!
    @IBOutlet weak var numberOfPlayers: UILabel!
    @IBOutlet weak var actionBarButtonItem: UIBarButtonItem!
    @IBAction func startGame(_ sender: Any) {
        
        if players.count < 1 {
            let alertController = UIAlertController(title: "Error", message: "Must have more than one task to focus", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else if players.count > 8 {
            checkGame()
        } else {
            self.performSegue(withIdentifier: "goToFocus", sender: nil)
        }
        
    }
    // 跳出新增玩家視窗
    @IBAction func addNewPlayer(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Task(\(players.count + 1))", message: "Please enter task name", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Task\(self.players.count + 1)"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            if let textField = alertController.textFields?.first {
                if textField.text != "" {
                    self.players.append(textField.text!)
                    self.saveData()
                    
                    Analytics.logEvent("AddTOList", parameters: [
                        AnalyticsParameterItemID: textField.text,
                        AnalyticsParameterItemName:
                            textField.text,
                        AnalyticsParameterContentType: "cont"
                    ])
                    
                    
                    Analytics.logEvent(AnalyticsEventEcommercePurchase, parameters: [
                        AnalyticsParameterCurrency: "TWD",
                        AnalyticsParameterQuantity: 1,
                        AnalyticsParameterValue: 5000
                    ])
                    
                    print(self.players)
                } else {
                    self.players.append("Task\(self.players.count + 1)")
                    self.saveData()
                }
                self.playerListTableView.insertRows(at: [[0,self.players.count - 1]], with: .top)
                self.playerListTableView.scrollToRow(at: [0,self.players.count - 1], at: .bottom, animated: true)
            }
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerListTableView.dataSource = self
        playerListTableView.delegate = self
        playerListTableView.isEditing = true
        playerListTableView.allowsSelectionDuringEditing = true
        loadData()
        if players.count < 1 {
            players = ["Click to Change Name"]
            }
        
        let names = ["Max", "Dennis", "Issac", "Joey", "Fergus", "Jerry", "Sunny", "Marvin"]
        
        let randomName = names.randomElement()
        
        Analytics.setUserProperty("Property_"+randomName!, forName: "Property_User")

        Analytics.setUserID("UserID_"+randomName!)
        
        Analytics.setScreenName("ToDoListPage", screenClass: "ToDoListPage")

    }
    
    // MARK: Save data & load data
    func saveData() {

        let userDefaults = UserDefaults(suiteName: "group.xyz.maxlist.New1208")
        userDefaults?.set(players, forKey: "players")
        
//        UserDefaults.standard.set(players, forKey: "players")
    }
    
    func loadData() {

        let userDefaults = UserDefaults(suiteName: "group.xyz.maxlist.New1208")
        players = userDefaults?.stringArray(forKey: "players") ?? []
        
//        players = UserDefaults.standard.stringArray(forKey: "players") ?? []
    }
    
    
    func checkGame() {
        let alertController = UIAlertController(title: "Start Focus", message: "When the task has less than eight,\n you can have a better experience.", preferredStyle: .alert)
        let startAction = UIAlertAction(title: "Start", style: .default) { (action) in
            self.performSegue(withIdentifier: "goToFocus", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(startAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension PlayerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(named: "sodada")
        cell.imageView?.sizeToFit()
        cell.imageView?.tintColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        cell.textLabel?.text = players[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        return cell
    }
    
    
    
    // 雙擊後可新增或刪除
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: "Select \(players[indexPath.row])", message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let editAction = UIAlertAction(title: "Change Task Name", style: .default) { (_) in
            let alertController = UIAlertController(title: "Change task name", message: "Please enter a new task name", preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "New task name"
            }
            let changeAction = UIAlertAction(title: "Change", style: .default, handler: { (_) in
                if let textField = alertController.textFields?.first {
                    if textField.text != "" {
                        self.players[indexPath.row] = textField.text!
                        self.playerListTableView.reloadRows(at: [indexPath], with: .automatic)
                        self.saveData()
                    }
                }
            })
            
            alertController.addAction(changeAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        let removeAction = UIAlertAction(title: "Delete Task", style: .default) { (_) in
            self.players.remove(at: indexPath.row)
            self.playerListTableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveData()
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(editAction)
        actionSheet.addAction(removeAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // 設定 EditingStyle 為None
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 開啟可以移動清單
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 寫入移動後的順序
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movePlayer = players.remove(at: sourceIndexPath.row)
        players.insert(movePlayer, at: destinationIndexPath.row)
        saveData()
    }
    
    // 調整table的欄位行數
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 8
    }
}



//
//cell.productLabel?.text = product[indexPath.row]
//cell.priceLabel?.text = price[indexPath.row]
