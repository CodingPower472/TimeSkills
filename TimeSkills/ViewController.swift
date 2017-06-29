//
//  ViewController.swift
//  TimeSkills
//
//  Created by Luke Bousfield on 6/29/17.
//  Copyright © 2017 Luke Bousfield. All rights reserved.
//

import UIKit

class Game {
    
    let seconds : Int
    var diffs : [Double] = []
    private var currStartTime : Date
    var numTimesTapped : Int = 0
    
    init(seconds : Int?) {
        
        if let seconds = seconds {
            self.seconds = seconds
        } else {
            self.seconds = 10
        }
        
        currStartTime = Date()
        
    }
    
    func onTap() -> Double {
        let currTime = Date()
        let diff = Swift.abs(currTime.timeIntervalSince(currStartTime) - 1)
        currStartTime = Date()
        numTimesTapped += 1
        diffs.append(diff)
        return diff
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet var differenceLabel: UILabel!
    @IBOutlet var tapToStart: UILabel!
    
    var game : Game?
    
    func average(_ arr : [Double]) -> Double {
        var sum : Double = 0
        for item in arr {
            sum += item
        }
        let count : Double = Double(arr.count)
        return sum / count
    }
    
    func updateText(_ diff : Double?) {
        if let diff = diff {
            differenceLabel.text = "Difference: \(Swift.abs(diff))"
        } else {
            differenceLabel.text = ""
        }
    }
    
    func showEndScreen() {
        tapToStart.text = "Tap to Restart"
        differenceLabel.text = "Average Difference: \(average(game!.diffs))"
        game = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let game = self.game else {
            self.game = Game(seconds: 10)
            updateText(nil)
            tapToStart.text = "Go!"
            return
        }
        updateText(game.onTap())
        if game.numTimesTapped >= game.seconds {
            showEndScreen()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        differenceLabel.text = ""
        
    }
    
    func onStarted() {
        game = Game(seconds: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

