//
//  sortingVC.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/25/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit
import AVFoundation

class sortingVC: UIViewController,UIGestureRecognizerDelegate{
    
    //declare vehicles
    //Air Vehicles
    let airplane = Vehicle(image: UIImageView(image: UIImage(named:"1-1.png")), vType: vehicleType.air)
    let ballon = Vehicle(image: UIImageView(image: UIImage(named:"1-2.png")), vType: vehicleType.air)
    let drone = Vehicle(image: UIImageView(image: UIImage(named:"1-3.png")), vType: vehicleType.air)
    let helicopter = Vehicle(image: UIImageView(image: UIImage(named:"1-4.png")), vType: vehicleType.air)
    let rocket = Vehicle(image: UIImageView(image: UIImage(named:"1-5.png")), vType: vehicleType.air)
    
    //Water Vehicles
    let boat = Vehicle(image: UIImageView(image: UIImage(named:"2-1.png")), vType: vehicleType.water)
    let cargoShip =  Vehicle(image:UIImageView(image: UIImage(named:"2-2.png")), vType: vehicleType.water)
    let jetSki =  Vehicle(image: UIImageView(image: UIImage(named:"2-3.png")), vType: vehicleType.water)
    let woodBoat =  Vehicle(image: UIImageView(image: UIImage(named:"2-4.png")), vType: vehicleType.water)
    let submarine =  Vehicle(image: UIImageView(image: UIImage(named:"2-5.png")), vType: vehicleType.water)
    
    //Land Vehicles
    let truck =  Vehicle(image: UIImageView(image: UIImage(named:"3-1.png")), vType: vehicleType.land)
    let bike =  Vehicle(image: UIImageView(image: UIImage(named:"3-2.png")), vType: vehicleType.land)
    let van =  Vehicle(image: UIImageView(image: UIImage(named:"3-3.png")), vType: vehicleType.land)
    let car =  Vehicle(image:UIImageView(image: UIImage(named:"3-4.png")), vType: vehicleType.land)
    let motorcycle = Vehicle(image: UIImageView(image: UIImage(named:"3-5.png")), vType: vehicleType.land)
    
    //Other Variables
    var gameLevel = Mode.Easy.rawValue
    var pracImage: UIView!
    var prac2Image: UIView!
    var pracGesture: UIPanGestureRecognizer!
    var landBounds: (Int,Int) = (149,800)
    var waterBounds: (Int,Int) = (950,801)
    var airBounds: (Int,Int) = (0,800)
    var startPoint:(Int,Int) = (300,100)
    var currentNation:vehicleType = vehicleType.land
    var vehicleCollection: [Vehicle] = []
    var waterImage: UIView!
    var scoreLabel: UILabel!
    var air: UIView!
    var cheerPlayer = AVAudioPlayer()
    var gameSong = AVAudioPlayer()
    var timerLabel: UILabel!
    var numberSeconds: Int = 0
    var vehiclesInPlay: [Vehicle] = []
    var currentScore: Int = 0
    var numberImages: Int = 0
    var gameImages: [Vehicle] = []
    var firstX = 100
    var NumberOfViews: [Int] = []
    var tagNumbers: [Int] = []
    var placedCorrectly: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        setUpCollection()
        switch gameLevel {
        case "Easy":
            numberImages = 8
            numberSeconds = 120
        //set time
        case "Medium":
            numberImages = 10
            numberSeconds = 105
        //set time
        case "Hard":
            numberImages = 12
            numberSeconds = 90
        //set time
        default: break
            //set time
        }

        let background = UIImage(named: "air-land-water.jpg")
        let backgroundImageView = UIImageView(image: background)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = self.view.frame
        self.view.addSubview(backgroundImageView)
        let backgroundColor = UIColor.init(patternImage: background!).withAlphaComponent(0.7)
        self.view.backgroundColor = backgroundColor
        let upperBar = CGRect(origin: CGPoint(x:0,y:65)  , size: CGSize(width: self.view.frame.maxX, height: 150))
        let upperView = UIView(frame: upperBar)
        upperView.backgroundColor = UIColor.black
        self.view.addSubview(upperView)
        
//        //first test image
//        pracImage = UIImageView(image: truck.getImage())
//        pracImage.isUserInteractionEnabled = true
//        pracImage.frame = CGRect(origin: CGPoint(x: 300, y: 100),size: CGSize(width: 100, height: 100))
//      Time Label
        timerLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:self.view.frame.maxY-35), size: CGSize(width: 170, height:35)))
        timerLabel?.textAlignment = NSTextAlignment.center
        timerLabel?.text = "\(getTime())"
        timerLabel?.backgroundColor = UIColor.orange
        self.view.addSubview(timerLabel!)
        
        //Score Label Stuff
        scoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:1200, y:self.view.frame.maxY-35), size: CGSize(width: 170, height:35)))
        scoreLabel?.textAlignment = NSTextAlignment.center
        scoreLabel?.text = "Score: \(currentScore)"
        scoreLabel?.backgroundColor = UIColor.yellow
        self.view.addSubview(scoreLabel!)

        var timeLabelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTime), userInfo: nil , repeats: true)
        getImages()
//        pracGesture = UIPanGestureRecognizer(target: self, action: #selector(move))
//        pracImage.addGestureRecognizer(pracGesture)
//        self.view.addSubview(pracImage)
//        let audioPath = Bundle.main.path(forResource: "Sorry", ofType: "mp3")
//        do{
//            gameSong = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
//            gameSong.play()
//            
//        }
//        catch{
//            print("Awesome")
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //gameSong.stop()
    }
    
    func getImages() -> Void {
       makeRandomSelections()
        var count = 0
        for vehicle in gameImages {
            var currImage = vehicle.getImage()
            currImage.frame = CGRect(origin: CGPoint(x: firstX, y: 75),size: CGSize(width: 100, height: 100))
            currImage.isUserInteractionEnabled = true
            currImage.tag = tagNumbers[count]
            pracGesture = UIPanGestureRecognizer(target: self, action: #selector(move))
            currImage.addGestureRecognizer(pracGesture)
            self.view.addSubview(currImage)
            firstX = firstX + 150
            count = count+1
        }
        
    }
    
    func makeRandomSelections() -> Void{
        var funcCount = 0
        while funcCount < numberImages{
            var cardNumber = Int(arc4random_uniform(UInt32(vehicleCollection.count)))
            if !NumberOfViews.contains(cardNumber)
            {
                NumberOfViews.append(cardNumber)
                tagNumbers.append(cardNumber)
                gameImages.append(vehicleCollection[cardNumber])
                funcCount = funcCount + 1
            }
        }
    }

    
    func setUpCollection() -> Void {
        vehicleCollection.append(airplane)
        vehicleCollection.append(ballon)
        vehicleCollection.append(drone)
        vehicleCollection.append(helicopter)
        vehicleCollection.append(rocket)
        vehicleCollection.append(boat)
        vehicleCollection.append(cargoShip)
        vehicleCollection.append(jetSki)
        vehicleCollection.append(woodBoat)
        vehicleCollection.append(submarine)
        vehicleCollection.append(truck)
        vehicleCollection.append(bike)
        vehicleCollection.append(van)
        vehicleCollection.append(car)
        vehicleCollection.append(motorcycle)
    }
    
    func move(_sender: UIPanGestureRecognizer){
        let point = _sender.location(in: view)
        let selectedVehicle = _sender.view
        
        if _sender.state == UIGestureRecognizerState.ended {
            var currentPoint = point
            //add other if else statements for other nations
            if (point.x<750 && point.y>700) || (point.x<975 && (point.y>600 && point.y<790)){//On Water
                currentNation = vehicleType.water
                 if(currentNation.rawValue == vehicleCollection[(_sender.view?.tag)!].getType().rawValue){
                    print("Bout to Play")
                    let audioPath = Bundle.main.path(forResource: "cheering", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                    adjustDataAccordingly()
                    print("Right")
                 }else{
                    let audioPath = Bundle.main.path(forResource: "booing", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                    backToBegin(currPoint: point,senderImage: selectedVehicle as! UIImageView)
                }
                print("Water Nation")
            }else if point.y<625 {//On Air
                currentNation = vehicleType.air
                if(currentNation.rawValue == vehicleCollection[(_sender.view?.tag)!].getType().rawValue){//if its a right nation
                    let audioPath = Bundle.main.path(forResource: "cheering", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                    adjustDataAccordingly()
                    print("right")
                }else{
                    let audioPath = Bundle.main.path(forResource: "booing", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                    
                    backToBegin(currPoint: point,senderImage: selectedVehicle as! UIImageView)
                }
                print("Air Nation")
            }else{//On Land
                currentNation = vehicleType.land
                if(currentNation.rawValue == vehicleCollection[(_sender.view?.tag)!].getType().rawValue){//if its a right nation
                    let audioPath = Bundle.main.path(forResource: "cheering", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                   adjustDataAccordingly()
                   print("right")

                }else{
                    let audioPath = Bundle.main.path(forResource: "booing", ofType: "mp3")
                    do{
                        cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                        cheerPlayer.play()
                    }
                    catch{
                        print("Awesome")
                    }
                    backToBegin(currPoint: point, senderImage: selectedVehicle as! UIImageView)
                }
            print("Earth Nation")
            }
            print("Over")
        }else{
            
        }
        selectedVehicle?.center = point
        print(point)
        if placedCorrectly == numberImages{
            endOfGame()
        }
    }
    
    
    func adjustDataAccordingly() -> Void {
        placedCorrectly = placedCorrectly + 1
        currentScore = currentScore + 5
        scoreLabel.text = "\(currentScore)"
    }
    
    func backToBegin(currPoint: CGPoint,senderImage: UIImageView){
        //find out distance back formula
        print((gameImages.index(after: senderImage.tag)-1))
        print()
        print()
        var distanceX = ((gameImages.index(after: senderImage.tag)-1)*85-Int(currPoint.x))
        var distanceY = (25-Int(currPoint.y) + 100)
        print(distanceX)
        print(distanceY)
        let translation = CGAffineTransform(translationX: CGFloat(distanceX), y: (CGFloat)(distanceY))
        print("Translate X: \(CGFloat(distanceX))")
        print("Translate Y: \(CGFloat(distanceY))")
        print(translation)
        UIView.animate(withDuration: 3.0, delay: 3, options: [], animations:{
        senderImage.transform = translation
        }, completion: nil)

    }
    
    func getTime() -> String {
        numberSeconds = numberSeconds - 1
        var minutes = (numberSeconds % 3600) / 60
        var seconds = (numberSeconds % 3600) % 60
        timerLabel?.text = "Time: \(minutes):\(seconds)"
        if numberSeconds == 0
        {
            endOfGame()
        }
        return "Time: \(minutes):\(seconds)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endOfGame() -> Void {
        numberSeconds = 0
        let alert = UIAlertController(title: "Game Over", message: "Your Score: \(currentScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home Screen", style: .default) { action in
            // perhaps use action.title here
        })
        var tempHigh: Int = 0
        if let readBalScore = UserDefaults.standard.object(forKey: "sortGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        if tempHigh<currentScore {
            let writeHighScore = NSKeyedArchiver.archivedData(withRootObject: currentScore)
            UserDefaults.standard.set(writeHighScore, forKey: "sortGameScore")
            HighScoreKeeper.sortHighScore = HighScore(gameScore: currentScore)
        }

        self.present(alert, animated: true, completion:nil)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        unwindSegue.perform()
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
