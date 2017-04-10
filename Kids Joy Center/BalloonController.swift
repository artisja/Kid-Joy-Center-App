//
//  BalloonController.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/27/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit

class BalloonController: UIViewController {

    var startLocation: [CGPoint] = []
    var test: UIView!
    var numbers: [(UIImageView,Int)] = []
    var balloons:  [UIImageView] = []
    var hardRandom: Int = 0
    var mediumRandom: Int = 0
    var easyRandom: Int = 0
    var scoreLabel: UILabel!
    var timeLabel: UILabel!
    var currentScore: Int = 0
    var numberSeconds: Int = 100
    var gameLevel = Mode.Easy.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
        setUpBallons()
        setUpNumbers()
        
        switch gameLevel {
        case "Easy":
            numberSeconds = 120
        //set time
        case "Medium":
            numberSeconds = 106
        //set time
        case "Hard":
            numberSeconds = 91
        //set time
        default:
        numberSeconds = 101
        //set time
        }
        
        print("Start")
        let backgroundImage = UIImageView(image: UIImage(named: "sky-background.jpg"))
        self.view.backgroundColor = UIColor.init(patternImage: backgroundImage.image!)
        startLocation.append(CGPoint(x:15 , y: 1000))
        test = UIView(frame: CGRect(origin: CGPoint(x:100, y:500) , size: CGSize(width: 100, height: 100)))
        test.backgroundColor = UIColor.black
        let t = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(addSV), userInfo: nil, repeats: true)
        scoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:1200, y:75), size: CGSize(width: 170, height:35)))
        scoreLabel?.textAlignment = NSTextAlignment.center
        scoreLabel?.backgroundColor = UIColor.yellow
        scoreLabel.text = "\(currentScore)"
        self.view.addSubview(scoreLabel!)
        
        
        timeLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:75), size: CGSize(width: 170, height:35)))
        timeLabel?.textAlignment = NSTextAlignment.center
        timeLabel?.text = "\(getTime())"
        timeLabel?.backgroundColor = UIColor.orange
        self.view.addSubview(timeLabel!)
        var timeLabelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTime), userInfo: nil , repeats: true)
        
        if numberSeconds == 0
        {
         endOfGame()
        }
    }
    
    
    
    func getTime() -> String {
        numberSeconds = numberSeconds - 1
        var minutes = (numberSeconds % 3600) / 60
        var seconds = (numberSeconds % 3600) % 60
        timeLabel?.text = "Time: \(minutes):\(seconds)"
        if numberSeconds == 0
        {
            endOfGame()
        }

        return "Time: \(minutes):\(seconds)"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBallons() -> Void {
        balloons.append(UIImageView(image: UIImage(named: "color1.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color2.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color3.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color4.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color5.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color6.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color7.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color8.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color9.png")!))
        balloons.append(UIImageView(image: UIImage(named: "color10.png")!))
    }
    
    func setUpNumbers() -> Void {
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-0.png")!),1))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-1.png")!),2))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-2.png")!),3))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-3.png")!),4))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-4.png")!),5))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-5.png")!),6))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-6.png")!),7))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-7.png")!),8))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-8.png")!),9))
        numbers.append((UIImageView(image: UIImage(named: "cartoon-number-9.png")!),10))
        numbers.append(((UIImageView(image: UIImage(named: "skull.png")!),-1)))
        numbers.append(((UIImageView(image: UIImage(named: "star.png")!),20)))


    }
    
    
    func addSV(){
        print("Added")
        let w = 100
        let h = 100
        let x = (arc4random() % 1000)
        let y = self.view.frame.maxY
        let fr = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(w), height: CGFloat(h))
        let a = balloons[Int(arc4random_uniform(UInt32(9)))]
        a.frame = fr
        let width = 50
        let height = 50
        let xCoor = x
        let yCoor = y
        let numberFrame = CGRect(x: CGFloat(w/4), y: CGFloat(h/4), width: CGFloat(width), height: CGFloat(height))
        var randomNumber = Int(arc4random_uniform(UInt32(9)))
        var b = numbers[randomNumber]
        var numberImage: UIImageView
        
        if(randomNumber>9){
        print(b.1)
        numberImage = b.0
        }
        numberImage = b.0
        //else{
        //print(b.1)
        //numberImage = b.0
        //}
        
        numberImage.frame = numberFrame
        numberImage.tag = randomNumber
        a.addSubview(numberImage)
        self.view.addSubview(a)
        animateView(v:a)
        }
    
    
    func animateView(v: UIImageView){
        let speed = v.frame.origin.y/100
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: .allowUserInteraction, animations: {
            v.frame.origin.y = 0
        }, completion: {_ in v.removeFromSuperview() })
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self.view)
        
        for i in 2...self.view.subviews.count {
            if self.view.subviews[i-1].layer.presentation()!.hitTest(touchLocation) != nil {
                print("touched subview \(i)")
                addPoints(index: self.view.subviews[i-1].subviews[0])
                self.view.subviews[i-1].subviews[0].removeFromSuperview()
            }
        }
    }
    
    func addPoints(index: UIView) -> Void {
         currentScore = currentScore + index.tag
         scoreLabel.text = "\(currentScore)"
    }
    
    func endOfGame() -> Void {
        numberSeconds = 0
        let alert = UIAlertController(title: "Game Over", message: "Your Score: \(currentScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home Screen", style: .default) { action in
            self.leave()
        })
        var tempHigh: Int = 0
        if let readBalScore = UserDefaults.standard.object(forKey: "balloonGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        if tempHigh<currentScore {
            let writeHighScore = NSKeyedArchiver.archivedData(withRootObject: currentScore)
            UserDefaults.standard.set(writeHighScore, forKey: "balloonGameScore")
            HighScoreKeeper.balloonHighScore = HighScore(gameScore: currentScore)
        }
        self.present(alert, animated: true, completion:nil)
    }
    
    func leave() -> Void {
        performSegue(withIdentifier: "backFromBalloon", sender: self)
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
