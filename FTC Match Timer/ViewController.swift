//
//  ViewController.swift
//  FTC Match Timer
//
//  Created by tbredemeier on 12/8/15.
//  Copyright © 2015 Zephyr Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var counter = 0
    var timer = NSTimer()
    var autonomous = true

    override func viewDidLoad() {
        super.viewDidLoad()
        resetCounter()
    }

    func resetCounter() {
        timer.invalidate()
        counter = 0
        displayCounter()
    }

    func displayCounter() {
        let minutes = counter / 60
        let seconds = counter % 60
        displayLabel.text = String(format: "%1d:%02d", minutes, seconds)
        if counter == 0 {
            displayLabel.textColor = UIColor.whiteColor()
        }
        else if autonomous {
            displayLabel.textColor = UIColor.yellowColor()
        }
        else if counter > 30 {
            displayLabel.textColor = UIColor.greenColor()
        }
        else {
            displayLabel.textColor = UIColor.redColor()
        }
    }

    func updateCounter() {
        displayCounter()
        counter -= 1
        if counter < 0 {
            resetCounter()
        }
    }

    func startTimer() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }

    @IBAction func onAutonomousButtonPressed(sender: UIButton) {
        counter = 30
        autonomous = true
        startTimer()
    }

    @IBAction func onDriverControlledButtonPressed(sender: UIButton) {
        counter = 120
        autonomous = false
        startTimer()
    }

    @IBAction func onResetButtonPressed(sender: UIButton) {
        resetCounter()
    }
}

