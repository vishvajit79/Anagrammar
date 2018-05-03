//
//  SaveHighScoreViewController.swift
//  Anagrammar
//
//  Created by John Smith on 2018-03-25.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class SaveHighScoreViewController: UIViewController {
    var userScore = Int()
    var score: Int = 0
    var db: DbManager?
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBAction func closePopup(_ sender: Any) {
        db?.insertItem(name: userNameTxt.text!, score: score)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        score = userScore
        db = DbManager();
        // Do any additional setup after loading the view.
    }
}
