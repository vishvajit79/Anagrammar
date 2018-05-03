//
//  GameScreenViewController.swift
//  Anagrammar
//
//  Created by John Smith on 2018-02-24.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {

    
    @IBOutlet weak var scoreLbl: UILabel!
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var answerTxt: UITextField!
    
    @IBOutlet weak var resultLbl: UILabel!
    
    @IBOutlet weak var checkNextBtn: UIButton!
    
    @IBOutlet weak var revealAnswerBtn: UIButton!
    
    var anagram: [String: String] = [
        "R I S F T": "FIRST",
        "D E S C O N": "SECOND",
        "H R I T D": "THIRD",
        "R O U F T H": "FOURTH",
        "R R A M M A G": "GRAMMAR"
    ]
    
    var counter: Int = 0
    
    var answer: String = ""
    
    var score: Int = 0
    
    var highScore: Int = UserDefaults.standard.integer(forKey: "highscore")
    
    @IBAction func checkNextBtn(_ sender: UIButton) {
        if resultLbl.text == "Penalty"{
            if answerTxt.text == self.answer{
                resultLbl.text = "Correct"
                resultLbl.textColor = UIColor.green
                sender.setTitle("Next", for: .normal)
                scoreLbl.text = "Score: \(self.score)"
            }
            changeHighScore()
        }
        if sender.titleLabel?.text == "Check Answer"{
            if answerTxt.text == self.answer{
                resultLbl.text = "Correct"
                resultLbl.textColor = UIColor.green
                self.score = self.score + 10
                scoreLbl.text = "Score: \(self.score)"
                changeHighScore()
                if self.counter < self.anagram.count{
                    sender.setTitle("Next", for: .normal)
                }
                else{
                    resultLbl.text = "You're an expert"
                    resultLbl.textColor = UIColor.gray
                    sender.setTitle("Start Over", for: .normal)
                }
                
            }
            else{
                resultLbl.text = "Incorrect"
                resultLbl.textColor = UIColor.red
                self.score = self.score - 5
                scoreLbl.text = "Score: \(self.score)"
                changeHighScore()
            }
        }
        else if sender.titleLabel?.text == "Start Over"{
            self.counter = 0
            sender.setTitle("Check Answer", for: .normal)
            self.nextQuestion()
        }
        else{
            sender.setTitle("Check Answer", for: .normal)
            resultLbl.text = "Result"
            resultLbl.textColor = UIColor.white
            answerTxt.text = ""
            self.nextQuestion()
        }
    }
    
    @IBAction func revealAnswerBtn(_ sender: UIButton) {
        reveal()
    }
    
    func changeHighScore(){
        if self.highScore < self.score{
            self.highScore = self.score
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
        }
    }
    
    func reveal(){
        answerTxt.text = self.answer
        self.score = self.score - 10
        resultLbl.text = "Penalty"
        checkNextBtn.setTitle("Next", for: .normal)
        resultLbl.textColor = UIColor.red
        scoreLbl.text = "Score: \(self.score)"
    }
    
    func nextQuestion(){
        changeHighScore()
        if self.counter < self.anagram.count{
            answerTxt.text = ""
            questionLbl.text = Array(self.anagram.keys)[counter]
            self.answer = Array(self.anagram.values)[counter]
            self.counter = self.counter + 1
            changeHighScore()
        }
        else{
            answerTxt.text = ""
            checkNextBtn.setTitle("Start Over", for: .normal)
            changeHighScore()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextQuestion()
        answerTxt.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "save"{
        var DestViewController: SaveHighScoreViewController = segue.destination as! SaveHighScoreViewController
        DestViewController.userScore = self.score
        }
    }
 

}
