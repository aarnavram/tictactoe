//
//  ViewController.swift
//  tictactoe
//
//  Created by Aarnav Ram on 14/08/16.
//  Copyright © 2016 Aarnav Ram. All rights reserved.
//

import UIKit
import SAConfettiView
import Spring

class ViewController: UIViewController {
    
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var state:Int = 0
    var mainArr:[String] = ["*","*","*","*","*","*","*","*","*"]
    var currentChar = "*"
    var roundOver:Bool = false
    var timer:Timer!
    var moves:Int = 0
    let blue = UIColor(red: 106/255, green: 123/255, blue: 255/255, alpha: 1)
    var player1score = 0
    var player2score = 0
    var confettiView = SAConfettiView(frame: UIScreen.main.bounds)

    
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        self.view.sendSubview(toBack: confettiView)
        confettiView.type! = .diamond
        confettiView.intensity = 1
        leftView.layer.cornerRadius = 10
        rightView.layer.cornerRadius = 10
        topView.layer.cornerRadius = 10
        bottomView.layer.cornerRadius = 10
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onResetPressed(_ sender: AnyObject) {
        
        newRound()
        player1score = 0
        player2score = 0
        player1Label.text = "Player 1 : \(player1score)"
        player2Label.text = "Player 2 : \(player2score)"
        
    }
    
    @IBAction func onButtonPressed(sender: UIButton) {
        if state == 0 && !roundOver {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal) //clear color to white to get the fade animation
            
            mainArr[sender.tag] = "x"
            sender.isUserInteractionEnabled = false
            currentChar = "x"
            moves = moves + 1
            state = 1
            roundOver = checkForWin(tag: sender.tag)
            if roundOver {
                if timer != nil {
                    timer.invalidate()
                }
                confettiView.startConfetti()
                timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
                moves = 0
                player1score = player1score + 1
                player1Label.text = "Player 1 : \(player1score)"
            }
            checkNoWin()
        } else if state == 1 && !roundOver {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal) // clear to white to get fade animation
            mainArr[sender.tag] = "o"
            sender.isUserInteractionEnabled = false
            currentChar = "o"
            moves = moves + 1
            state = 0
            roundOver = checkForWin(tag: sender.tag)
            if roundOver {
                if timer != nil {
                    timer.invalidate()
                }
                confettiView.startConfetti()
                timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
                moves = 0
                player2score = player2score + 1
                player2Label.text = "Player 2 : \(player2score)"
            }
            checkNoWin()
        }
    }
    
    func straightFirstRow(tag:Int) -> Bool {
        if currentChar == mainArr[tag + 3] && currentChar == mainArr[tag + 6] {
            return true
        } else {
            return false
        }
    }
    
    func straightMidRow(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 3] && currentChar == mainArr[tag + 3] {
            return true
        } else {
            return false
        }
    }
    
    func straightLastRow(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 3] && currentChar == mainArr[tag - 6] {
            return true
        } else {
            return false
        }
    }
    
    func HFirstCol(tag:Int) -> Bool {
        if currentChar == mainArr[tag + 1] && currentChar == mainArr[tag + 2] {
            return true
        } else {
            return false
        }
    }
    
    func HMidCol(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 1] && currentChar == mainArr[tag + 1] {
            return true
        } else {
            return false
        }
    }
    
    func HLastCol(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 1] && currentChar == mainArr[tag - 2] {
            return true
        } else {
            return false
        }
    }
    
    func midLeft(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 4] && currentChar == mainArr[tag + 4] {
            return true
        } else {
            return false
        }
    }

    func midRight(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 2] && currentChar == mainArr[tag + 2] {
            return true
        } else {
            return false
        }
    }
    
    func zeroDia(tag:Int) -> Bool {
        if currentChar == mainArr[tag + 4] && currentChar == mainArr[tag + 8] {
            return true
        } else {
            return false
        }
    }
    
    func twoDia(tag:Int) -> Bool {
        if currentChar == mainArr[tag + 2] && currentChar == mainArr[tag + 4] {
            return true
        } else {
            return false
        }
    }
    
    func eightDia(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 4] && currentChar == mainArr[tag - 8] {
            return true
        } else {
            return false
        }
    }
    
    func sixDia(tag:Int) -> Bool {
        if currentChar == mainArr[tag - 2] && currentChar == mainArr[tag - 4] {
            return true
        } else {
            return false
        }
    }
    
    func checkForWin(tag:Int) -> Bool {
        switch tag {
        case 0: if straightFirstRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn3, btnThree: btn6)
            return true
        } else if HFirstCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn1, btnThree: btn2)
            return true
        } else if zeroDia(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn4, btnThree: btn8)
            return true
        }
            
        case 1: if HMidCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn1, btnThree: btn2)
            return true
        } else if straightFirstRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn1, btnTwo: btn4, btnThree: btn7)
            return true
        }
            
        case 2: if HLastCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn1, btnThree: btn2)
            return true
        } else if straightFirstRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn2, btnTwo: btn5, btnThree: btn8)
            return true
        } else if twoDia(tag: tag) {
            animateButtonsOnWin(btnOne: btn2, btnTwo: btn4, btnThree: btn6)
            return true
            }
            
        case 3: if HFirstCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn3, btnTwo: btn4, btnThree: btn5)
            return true
        } else if straightMidRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn3, btnThree: btn6)
            return true
            }
            
        case 4: if HMidCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn3, btnTwo: btn4, btnThree: btn5)
            return true
        } else if midLeft(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn4, btnThree: btn8)
            return true
        } else if midRight(tag: tag) {
            animateButtonsOnWin(btnOne: btn4, btnTwo: btn2, btnThree: btn6)
            return true
        } else if straightMidRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn1, btnTwo: btn4, btnThree: btn7)
            return true
            }
        case 5: if straightMidRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn5, btnTwo: btn2, btnThree: btn8)
            return true
        } else if HLastCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn3, btnTwo: btn4, btnThree: btn5)
            return true
            }
        case 6: if sixDia(tag: tag) {
            animateButtonsOnWin(btnOne: btn6, btnTwo: btn4, btnThree: btn2)
            return true
        } else if straightLastRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn6, btnTwo: btn3, btnThree: btn0)
            return true
        } else if  HFirstCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn6, btnTwo: btn8, btnThree: btn7)
            return true
            }
        case 7: if straightLastRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn1, btnTwo: btn4, btnThree: btn7)
            return true
        } else if HMidCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn6, btnTwo: btn7, btnThree: btn8)
            return true
            }
        case 8: if eightDia(tag: tag) {
            animateButtonsOnWin(btnOne: btn0, btnTwo: btn4, btnThree: btn8)
            return true
        } else if HLastCol(tag: tag) {
            animateButtonsOnWin(btnOne: btn6, btnTwo: btn7, btnThree: btn8)
            return true
        } else if straightLastRow(tag: tag) {
            animateButtonsOnWin(btnOne: btn2, btnTwo: btn5, btnThree: btn8)
            return true
            }
            
        default: return false
        }
        return false
    }
    
    func newRound() {
        confettiView.stopConfetti()
        roundOver = false
        mainArr = ["*","*","*","*","*","*","*","*","*"]
        currentChar = "*"
        clearBtnColors()
        enableInteraction()
        moves = 0
    }
    
    func enableInteraction() {
        btn0.isUserInteractionEnabled = true
        btn1.isUserInteractionEnabled = true
        btn2.isUserInteractionEnabled = true
        btn3.isUserInteractionEnabled = true
        btn4.isUserInteractionEnabled = true
        btn5.isUserInteractionEnabled = true
        btn6.isUserInteractionEnabled = true
        btn7.isUserInteractionEnabled = true
        btn8.isUserInteractionEnabled = true
    }
    
    func clearBtnColors() {
        btn0.setTitleColor(UIColor.clear, for: .normal)
        btn1.setTitleColor(UIColor.clear, for: .normal)
        btn2.setTitleColor(UIColor.clear, for: .normal)
        btn3.setTitleColor(UIColor.clear, for: .normal)
        btn4.setTitleColor(UIColor.clear, for: .normal)
        btn5.setTitleColor(UIColor.clear, for: .normal)
        btn6.setTitleColor(UIColor.clear, for: .normal)
        btn7.setTitleColor(UIColor.clear, for: .normal)
        btn8.setTitleColor(UIColor.clear, for: .normal)
    }
    
    func checkNoWin() {
        if moves == 9 && roundOver == false {
            if timer != nil {
                timer.invalidate()
            }
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
        }
    }
    
    func changeHorizontalViewColors(color: UIColor) {
        leftView.backgroundColor = color
        rightView.backgroundColor = color
    }
    
    func changeVerticalViewColors(color: UIColor) {
        topView.backgroundColor = color
        bottomView.backgroundColor = color
    }
    
    func animateButtonsOnWin(btnOne: UIButton, btnTwo: UIButton, btnThree: UIButton) {
        UIView.animate(withDuration: 0.3 , animations: {
            btnOne.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            btnTwo.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            btnThree.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            
        }, completion: { finish in
            UIView.animate(withDuration: 1){
            btnOne.transform = CGAffineTransform.identity
            btnTwo.transform = CGAffineTransform.identity
            btnThree.transform = CGAffineTransform.identity
        }
            
        })
    }
    
}

