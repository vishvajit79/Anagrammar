//
//  ViewController.swift
//  Anagrammar
//
//  Created by John Smith on 2018-02-24.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var highScoreLbl: UILabel!
    @IBAction func exitBtn(_ sender: UIButton) {
        exit(0)
    }
    
    public func changeHighScore(){
        var highscore = UserDefaults.standard.integer(forKey: "highscore")
        highScoreLbl.text = "High Score: \(highscore)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        changeHighScore()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        var highscore = UserDefaults.standard.integer(forKey: "highscore")
        highScoreLbl.text = "High Score: \(highscore)"
    }

}

