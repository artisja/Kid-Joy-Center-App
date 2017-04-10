//
//  ViewController.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/16/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memoryGameButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var playbutton: UIButton!

    
    var difficultyLevel: String = ""
    var difficultyHolder: [Bool] = []
    public var highscores: [HighScore] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundColor = UIColor.init(patternImage: UIImage(named:"back-main.jpg")!).withAlphaComponent(0.5)
        self.view.backgroundColor = backgroundColor
        self.navigationItem.rightBarButtonItem?.title = "High Scores"
        
        mediumButton.backgroundColor = .clear
        mediumButton.layer.cornerRadius = 5
        mediumButton.layer.borderWidth = 1
        mediumButton.layer.borderColor = UIColor.yellow.cgColor
        difficultyHolder.append(false) //Easy
        difficultyHolder.append(true)//Medium
        difficultyHolder.append(false)//Hard
        difficultyLevel = Mode.Medium.rawValue
    }
    //add other highlight functionality for other game buttons and add play funcitonality initialize game
    
    
    @IBAction func highScoreAction(_ sender: Any) {
        
        
    }

    @IBAction func easyClicked(_ sender: Any) {
        if difficultyHolder[1] {
            difficultyHolder[1] = false
            mediumButton.backgroundColor = .clear
            mediumButton.layer.cornerRadius = 0
            mediumButton.layer.borderWidth = 0
            mediumButton.layer.borderColor = UIColor.yellow.cgColor
        }else if difficultyHolder[2] {
            difficultyHolder[2] = false
            hardButton.backgroundColor = .clear
            hardButton.layer.cornerRadius = 0
            hardButton.layer.borderWidth = 0
            hardButton.layer.borderColor = UIColor.yellow.cgColor
        }
        difficultyLevel = Mode.Easy.rawValue
        difficultyHolder[0] = true
        easyButton.backgroundColor = .clear
        easyButton.layer.cornerRadius = 5
        easyButton.layer.borderWidth = 1
        easyButton.layer.borderColor = UIColor.yellow.cgColor
    }
    
    @IBAction func mediumClicked(_ sender: Any) {
        if difficultyHolder[0] {
            difficultyHolder[0] = false
            easyButton.backgroundColor = .clear
            easyButton.layer.cornerRadius = 0
            easyButton.layer.borderWidth = 0
            easyButton.layer.borderColor = UIColor.yellow.cgColor
        }else if difficultyHolder[2] {
            difficultyHolder[2] = false
            hardButton.backgroundColor = .clear
            hardButton.layer.cornerRadius = 0
            hardButton.layer.borderWidth = 0
            hardButton.layer.borderColor = UIColor.yellow.cgColor
        }
        difficultyLevel = Mode.Medium.rawValue
        difficultyHolder[1] = true
        mediumButton.backgroundColor = .clear
        mediumButton.layer.cornerRadius = 5
        mediumButton.layer.borderWidth = 1
        mediumButton.layer.borderColor = UIColor.yellow.cgColor
    }
    
    
    @IBAction func hardClicked(_ sender: Any) {
        if difficultyHolder[0] {
            difficultyHolder[0] = false
            easyButton.backgroundColor = .clear
            easyButton.layer.cornerRadius = 0
            easyButton.layer.borderWidth = 0
            easyButton.layer.borderColor = UIColor.yellow.cgColor
        }else if difficultyHolder[1] {
            difficultyHolder[1] = false
            mediumButton.backgroundColor = .clear
            mediumButton.layer.cornerRadius = 0
            mediumButton.layer.borderWidth = 0
            mediumButton.layer.borderColor = UIColor.yellow.cgColor
        }
        difficultyLevel = Mode.Hard.rawValue
        difficultyHolder[2] = true
        hardButton.backgroundColor = .clear
        hardButton.layer.cornerRadius = 5
        hardButton.layer.borderWidth = 1
        hardButton.layer.borderColor = UIColor.yellow.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToMemory" {
         let memVC = segue.destination as! MemoryGameController
         memVC.gameLevel = difficultyLevel
        }else if segue.identifier == "homeToSorting" {
         let sortVC = segue.destination as! sortingVC
         sortVC.gameLevel = difficultyLevel
        }else if segue.identifier == "homeToBalloon"{
            let ballonVC = segue.destination as! BalloonController
            ballonVC.gameLevel = difficultyLevel
        }
    }
    
    @IBAction func backHome(segue: UIStoryboardSegue){
        print(HighScoreKeeper.memoryHighScore)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

