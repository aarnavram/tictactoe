//
//  ViewController.swift
//  tictactoe
//
//  Created by Aarnav Ram on 14/08/16.
//  Copyright © 2016 Aarnav Ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var state:Int = 0
    var mainArr:[String] = ["*","*","*","*","*","*","*","*","*"]
    var currentChar = "*"
    var roundOver:Bool = false
    var timer:NSTimer!
    var moves:Int = 0
    let blue = UIColor(red: 106/255, green: 123/255, blue: 255/255, alpha: 1)
    var player1score = 0
    var player2score = 0
    
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonPressed(sender: UIButton) {
        if state == 0 && !roundOver {
            sender.setTitle("X", forState: .Normal)
            sender.setTitleColor(blue, forState: .Normal) //clear color to blue to get the fade animation
            mainArr[sender.tag] = "x"
            sender.userInteractionEnabled = false
            currentChar = "x"
            moves = moves + 1
            state = 1
            roundOver = checkForWin(sender.tag)
            if roundOver {
                if timer != nil {
                    timer.invalidate()
                }
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
                moves = 0
                player1score = player1score + 1
                player1Label.text = "Player 1 : \(player1score)"
            }
            checkNoWin()
        } else if state == 1 && !roundOver {
            sender.setTitle("O", forState: .Normal)
            sender.setTitleColor(UIColor.grayColor(), forState: .Normal) // clear to gray to get fade animation
            mainArr[sender.tag] = "o"
            sender.userInteractionEnabled = false
            currentChar = "o"
            moves = moves + 1
            state = 0
            roundOver = checkForWin(sender.tag)
            if roundOver {
                if timer != nil {
                    timer.invalidate()
                }
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
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
        case 0: if straightFirstRow(tag) || HFirstCol(tag) || zeroDia(tag) {
            print("\(currentChar) won")
            return true
            }
        case 1: if HFirstCol(tag) || straightFirstRow(tag) {
            print("\(currentChar) won")
            return true
            }
        case 2: if HLastCol(tag) || straightFirstRow(tag) || twoDia(tag) {
            print("\(currentChar) won")
            return true
            }
        case 3: if HFirstCol(tag) || straightMidRow(tag) {
            print("\(currentChar) won")
            return true
            }
        case 4: if HMidCol(tag) || midLeft(tag) || midRight(tag) || straightMidRow(tag) {
            print("\(currentChar) won")
            return true
            }
        case 5: if straightMidRow(tag) || HLastCol(tag) {
            print("\(currentChar) won")
            return true
            }
        case 6: if sixDia(tag) || straightLastRow(tag) || HFirstCol(tag) {
            print("\(currentChar) won")
            return true
            }
        case 7: if straightLastRow(tag) || HMidCol(tag) {
            print("\(currentChar) won")
            return true
            }
        case 8: if eightDia(tag) || HLastCol(tag) || straightLastRow(tag) {
            print("\(currentChar) won")
            return true
            }
            
        default: return false
        }
        return false
    }
    
    func newRound() {
        roundOver = false
        mainArr = ["*","*","*","*","*","*","*","*","*"]
        currentChar = "*"
        clearBtnColors()
        enableInteraction()
    }
    
    func enableInteraction() {
        btn0.userInteractionEnabled = true
        btn1.userInteractionEnabled = true
        btn2.userInteractionEnabled = true
        btn3.userInteractionEnabled = true
        btn4.userInteractionEnabled = true
        btn5.userInteractionEnabled = true
        btn6.userInteractionEnabled = true
        btn7.userInteractionEnabled = true
        btn8.userInteractionEnabled = true
    }
    
    func clearBtnColors() {
        btn0.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn1.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn2.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn3.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn4.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn5.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn6.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn7.setTitleColor(UIColor.clearColor(), forState: .Normal)
        btn8.setTitleColor(UIColor.clearColor(), forState: .Normal)
    }
    
    func checkNoWin() {
        if moves == 9 && roundOver == false {
            if timer != nil {
                timer.invalidate()
            }
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.newRound), userInfo: nil, repeats: false)
        }
    }
    
}

