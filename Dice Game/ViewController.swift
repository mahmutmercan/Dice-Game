//
//  ViewController.swift
//  Dice Game
//
//  Created by Sirius on 28.06.2020.
//  Copyright © 2020 Jaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelPlayer1Score: UILabel!
    @IBOutlet weak var labelPlayer2Score: UILabel!
    @IBOutlet weak var labelPlayer1Point: UILabel!
    @IBOutlet weak var labelPlayer2Point: UILabel!
    @IBOutlet weak var imagePlayer1Status: UIImageView!
    @IBOutlet weak var imagesPlayer2Status: UIImageView!
    @IBOutlet weak var imageDice1: UIImageView!
    @IBOutlet weak var imagesDice2: UIImageView!
    @IBOutlet weak var labelSetResult: UILabel!
    
    
    
    var playerPoint = (firstPlayerPoint : 0 , secondPlayerPoint : 0)
    var playerScore = (firstPlayerScore : 0 , secondPlayerScore : 0)
    var playerQueue : Int = 1
    
    var maxSetNumber : Int = 5
    var currentSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let arkaPlan = UIImage(named: "arkaPlan") {
            self.view.backgroundColor = UIColor(patternImage: arkaPlan)
            
        }

    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if currentSet > maxSetNumber {
            return
        }

        
        zarDegerleriniUret()
    }
    func setResult(dice1 : Int, dice2 : Int) {
        
        if playerQueue == 1 {
//            New Set
            playerPoint.firstPlayerPoint = dice1 + dice2
            labelPlayer1Point.text = String(playerPoint.firstPlayerPoint)
            imagePlayer1Status.image = UIImage(named: "bekle")
            imagesPlayer2Status.image = UIImage(named: "onay")
            labelSetResult.text = "2nd Player"
            playerQueue = 2
            labelPlayer2Point.text = "0"
        } else {
            playerPoint.secondPlayerPoint = dice1 + dice2
            labelPlayer2Point.text = String(playerPoint.secondPlayerPoint)
            imagePlayer1Status.image = UIImage(named: "onay")
            imagesPlayer2Status.image = UIImage(named: "bekle")
            playerQueue = 1
            
//            Set Result
            if playerPoint.firstPlayerPoint > playerPoint.secondPlayerPoint {
//                1. player win
                playerScore.firstPlayerScore += 1
                labelSetResult.text = "\(currentSet). Set Player 1 Win"
                
                currentSet += 1
                labelPlayer1Score.text = String(playerScore.firstPlayerScore)
            } else if playerPoint.secondPlayerPoint > playerPoint.firstPlayerPoint {
                playerScore.secondPlayerScore += 1
                labelSetResult.text = "\(currentSet). Set Player 2 Win"
                currentSet += 1
                labelPlayer2Score.text = String(playerScore.secondPlayerScore)
            } else {
//                Draw set sayısıf değişmicek
                labelSetResult.text = "\(currentSet). Set Draw Ended"
            }
            
            playerPoint.firstPlayerPoint = 0
            playerPoint.secondPlayerPoint = 0


            
        }
        
    }
    func zarDegerleriniUret() {
        print("Kod1")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            
            self.imageDice1.image = UIImage(named: String(dice1))
            self.imagesDice2.image = UIImage(named: String(dice2))
            
            self.setResult(dice1: Int(dice1), dice2: Int(dice2))
            
            if self.currentSet > self.maxSetNumber {
                if self.playerScore.firstPlayerScore > self.playerScore.secondPlayerScore {
                    self.labelSetResult.text = "Player 1 Win"
                } else {
                    self.labelSetResult.text = "Player 2 Win"
                }
            }


        }
        print("Kod2")
        labelSetResult.text = "Awaiting dice results for Player \(playerQueue). "
        imageDice1.image = UIImage(named: "bilinmeyenZar")
        imagesDice2.image = UIImage(named: "bilinmeyenZar")
        

    }

}

