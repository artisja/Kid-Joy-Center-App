//
//  HighScoresController.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/27/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit

class HighScoresController: UIViewController {

    var memScoreLabel: UILabel!
    var sortScoreLabel: UILabel!
    var balloonScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tempHigh: Int = 0

        //Memory Score Label Stuff
        memScoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:100), size: CGSize(width: 170, height:35)))
        memScoreLabel?.textAlignment = NSTextAlignment.center
        memScoreLabel?.text = "Score: \(HighScoreKeeper.memoryHighScore)"
        if let readBalScore = UserDefaults.standard.object(forKey: "balloonGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        memScoreLabel?.backgroundColor = UIColor.yellow
        self.view.addSubview(memScoreLabel!)
        
        
        //Sort Score Label Stuff
        sortScoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:150), size: CGSize(width: 170, height:35)))
        sortScoreLabel?.textAlignment = NSTextAlignment.center
        if let readBalScore = UserDefaults.standard.object(forKey: "balloonGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        sortScoreLabel?.text = "Score: \(tempHigh)"
        sortScoreLabel?.backgroundColor = UIColor.yellow
        self.view.addSubview(sortScoreLabel!)
        
        
        //Balloon Score Label Stuff
        balloonScoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:200), size: CGSize(width: 170, height:35)))
        balloonScoreLabel?.textAlignment = NSTextAlignment.center
        if let readBalScore = UserDefaults.standard.object(forKey: "balloonGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        balloonScoreLabel?.text = "Score: \(tempHigh)"
        balloonScoreLabel?.backgroundColor = UIColor.yellow
        self.view.addSubview(balloonScoreLabel!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
