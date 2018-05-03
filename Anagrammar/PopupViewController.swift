//
//  PopupViewController.swift
//  Anagrammar
//
//  Created by John Smith on 2018-02-24.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
}
