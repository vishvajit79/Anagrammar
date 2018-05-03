//
//  HighScoreTableViewController.swift
//  Anagrammar
//
//  Created by John Smith on 2018-04-20.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class HighScoreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Name: \(items[indexPath.row].name), Score: \(items[indexPath.row].score)"
        return cell
    }
    
    var db: DbManager?
    var items: [(id:Int, name:String, score: Int)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        db = DbManager();
        items = (db?.selectAll())!

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
