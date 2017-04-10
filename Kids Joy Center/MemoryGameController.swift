//
//  MemoryGameController.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/21/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit
import AVFoundation

class MemoryGameController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    var collectionViewGrid: UICollectionView!
    var gridDataSource: UICollectionViewDataSource!
    var gridDelegate: UICollectionViewDelegate!
    var scoreLabel: UILabel?
    var timeLabel: UILabel?
    let cardSet = [
        UIColor.orange,
        UIColor.red,
        UIColor.blue,
        UIColor.brown,
        UIColor.gray,
        UIColor.purple,
        UIColor.green,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.yellow] as [UIColor]
    var rowNumber:Int = 3
    var columnNumber:Int = 4
    var underCardsSet: [Bool] = []
    var numberOfCards:Int = 0
    var currentCardSet: [Int] = []
    var firstCount:Int = 0
    var secondCount:Int = 0
    var currentCell: MemoryCell? = nil
    var firstSelectedCell:MemoryCell? = nil
    var firstChoiceSelected:Bool = false
    var cheerPlayer = AVAudioPlayer()
    var score:Int = 0
    var timeLastPairFound:Int = 0
    var time: Int = 0
    var gameLevel = Mode.Easy.rawValue
    var numberSeconds: Int = 100
    var background = UIImage(named: "background.jpg")
    var backgroundImage = UIImageView(image: UIImage(named: "question.jpg"))
    var numberOfMatches: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch gameLevel {
        case "Easy":
            rowNumber = 4
            columnNumber = 3
            numberSeconds = 120
            //set time
        case "Medium":
            rowNumber = 4
            columnNumber = 4
            numberSeconds = 105
            //set time
        case "Hard":
            rowNumber = 4
            columnNumber = 5
            numberSeconds = 90
            //set time
        default:
            rowNumber = 4
            columnNumber = 4
            //set time
        }
        numberOfCards = (rowNumber * columnNumber)/2
        underCardsSet = [Bool](repeating: false, count: numberOfCards)
        var backgroundColor = UIColor.init(patternImage: background!).withAlphaComponent(0.7)
        self.view.backgroundColor = backgroundColor
            //Collection View stuff
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 120)
        let gridFrame = CGRect(origin: CGPoint(x:400, y:150), size: CGSize(width: 800, height: 800))
        collectionViewGrid = UICollectionView(frame:gridFrame, collectionViewLayout: layout)
        collectionViewGrid.dataSource = self
        collectionViewGrid.delegate = self
        collectionViewGrid.register(MemoryCell.self, forCellWithReuseIdentifier: "Memory Cell")
        collectionViewGrid.backgroundColor = UIColor.clear
        self.view.addSubview(collectionViewGrid)
        
        //Score Label Stuff
        scoreLabel = UILabel(frame: CGRect(origin: CGPoint(x:1200, y:75), size: CGSize(width: 170, height:35)))
        scoreLabel?.textAlignment = NSTextAlignment.center
        scoreLabel?.text = "Score: \(score)"
        scoreLabel?.backgroundColor = UIColor.yellow
        self.view.addSubview(scoreLabel!)
        
        //Time Label Stuff
        timeLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y:75), size: CGSize(width: 170, height:35)))
        timeLabel?.textAlignment = NSTextAlignment.center
        timeLabel?.text = "\(getTime())"
        timeLabel?.backgroundColor = UIColor.orange
        self.view.addSubview(timeLabel!)
        var timeLabelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTime), userInfo: nil , repeats: true)
        let audioPath = Bundle.main.path(forResource: "Sorry", ofType: "mp3")
        do{
            cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            cheerPlayer.play()

        }
        catch{
            print("Awesome")
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpCardCollection()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        cheerPlayer.stop()

    }
    
    
    func getTime() -> String {
        numberSeconds = numberSeconds - 1
        var minutes = (numberSeconds % 3600) / 60
        var seconds = (numberSeconds % 3600) % 60
        timeLabel?.text = "Time: \(minutes):\(seconds)"
        return "Time: \(minutes):\(seconds)"
    }
    
    func setUpCardCollection() -> Void{
        var funcCount = 0
        while funcCount != numberOfCards{
            var cardNumber = Int(arc4random_uniform(UInt32(numberOfCards)))
            if !currentCardSet.contains(cardNumber)
            {
                currentCardSet.append(cardNumber)
                funcCount = funcCount + 1
            }
        }
        secondCount = numberOfCards - 1
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rowNumber
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnNumber
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Memory Cell" , for: indexPath) as! MemoryCell
        cell.backgroundView = UIImageView(image: UIImage(named: "question.png"))
    
        if firstCount < numberOfCards {
            cell.tag = currentCardSet[firstCount]
            underCardsSet[firstCount] = true
            var cellColor = cardSet[firstCount]
            cell.imageBack = cellColor
            firstCount = firstCount + 1
            print("First Round: \(cell.tag)")
            
        }else{
            
            if firstCount == 8 {
                currentCardSet.removeAll()
                setUpCardCollection()
                firstCount=firstCount+1
            }
            
            if secondCount >= 0{
            cell.tag = currentCardSet[secondCount]
            underCardsSet[secondCount] = true
            var cellColor = cardSet[secondCount]
            cell.imageBack = cellColor
            secondCount = secondCount - 1
            print("Second Round: \(cell.tag)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! MemoryCell
        currentCell = cell
     //put if statement for if last tag matches this current tag
        if firstChoiceSelected {
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(changeUnderCard), userInfo: nil, repeats: false)
            print("\(firstSelectedCell?.tag)  \(currentCell?.tag)")
            if ((firstSelectedCell?.tag == (currentCell?.tag)!)) {
                Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(match), userInfo: nil, repeats: false)
                print("Match")
            }else{
                Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(noMatch), userInfo: nil, repeats: false)
            }
        }else{
            print("firstChoice")
            firstChoiceSelected = true
            firstSelectedCell = currentCell
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(changeFirstUnderCard), userInfo: nil, repeats: false)
        }
    }
    
    @objc func changeFirstUnderCard() -> Void {
        currentCell?.backgroundView = nil
        currentCell?.backgroundColor = currentCell?.imageBack
        print("flip first card")
    }

    @objc func changeUnderCard() -> Void {
        currentCell?.backgroundView = nil
        currentCell?.backgroundColor = currentCell?.imageBack

    }
    
    @objc func match() -> Void {
        firstSelectedCell?.backgroundColor = firstSelectedCell?.imageBack
        currentCell?.backgroundColor = currentCell?.imageBack
        firstChoiceSelected = false
        firstSelectedCell = nil
        let audioPath = Bundle.main.path(forResource: "cheering", ofType: "mp3")
        do{
            cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            cheerPlayer.play()
        }
        catch{
            print("Awesome")
        }
        numberOfMatches = numberOfMatches + 1
        if numberOfMatches==numberOfCards {
            endOfGame()
        }
    }
    
    @objc func noMatch() -> Void {
        firstSelectedCell?.backgroundColor = UIColor.init(patternImage: UIImage(named: "question.png")!)
        currentCell?.backgroundColor = UIColor.init(patternImage: UIImage(named: "question.png")!)
        
        firstChoiceSelected = false
        firstSelectedCell = nil
    }
    
    func endOfGame() -> Void {
        numberSeconds = 0
        let alert = UIAlertController(title: "Game Over", message: "Your Score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home Screen", style: .default) { action in
            self.leave()
        })
        var tempHigh: Int = 0
        if let readBalScore = UserDefaults.standard.object(forKey: "balloonGameScore") as? Data {
            tempHigh = NSKeyedUnarchiver.unarchiveObject(with: readBalScore) as! Int
        }
        if tempHigh<score {
            let writeHighScore = NSKeyedArchiver.archivedData(withRootObject: score)
            UserDefaults.standard.set(writeHighScore, forKey: "balloonGameScore")
            HighScoreKeeper.balloonHighScore = HighScore(gameScore: score)
        }
        self.present(alert, animated: true, completion:nil)
    }
    
    func leave() -> Void {
        performSegue(withIdentifier: "backFromMemory", sender: self)
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
        
    }
}
