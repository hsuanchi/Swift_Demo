//
//  TodayViewController.swift
//  Today
//
//  Created by 宣齊 on 2019/6/2.
//  Copyright © 2019年 maxlist. All rights reserved.
//

import UIKit
import NotificationCenter
import AVFoundation


class TodayViewController: UIViewController, NCWidgetProviding {
    
    var players:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        playerListTableView.dataSource = self
        playerListTableView.delegate = self
        playerListTableView.isEditing = true
        playerListTableView.allowsSelectionDuringEditing = true
        
        loadData()
        print(players)
    self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        // Do any additional setup after loading the view from its nib.
    }
    @IBOutlet weak var playerListTableView: UITableView!
    
    func loadData() {
        let userDefaults = UserDefaults(suiteName: "group.xyz.maxlist.New1208")
        players = userDefaults?.stringArray(forKey: "players") ?? []
        }
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 237)
        }else {
            self.preferredContentSize = maxSize
        }
    }
    
}

extension TodayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(named: "sodada")
        cell.imageView?.sizeToFit()
        cell.imageView?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.text = players[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    // 設定 EditingStyle 為None
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    // 調整table的欄位行數
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 8
    }
}
