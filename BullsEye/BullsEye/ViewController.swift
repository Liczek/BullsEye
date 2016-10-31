//
//  ViewController.swift
//  BullsEye
//
//  Created by Paweł Liczmański on 29.10.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    // Variables
    
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    var sliderValue: Int = 50
    var points: Int = 0
    var tittle: String = ""

    
    
    // Outlets
    
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    // Actions
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        sliderValue = lroundf(slider.value)
        print(lroundf(slider.value))
    }
    
    
    @IBAction func acceptSlider(_ sender: UIButton) {
        
        pointsGet()
        
        let alert = UIAlertController(title: tittle, message: "Target value was: \(targetValue)" + "\nYou set slider at \(sliderValue)" + "\nYou get \(points) points", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.slider.isEnabled = true
            self.updateLabels()
            self.startNewRound()
            })
        let action2 = UIAlertAction(title: "I want check this", style: .destructive, handler: {
            action in
            self.slider.isEnabled = false
            self.score = self.score - self.points
        })
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        startOver()
        startNewRound()
        updateLabels()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderConfiguration()
        startNewRound()
        updateLabels()
        
    }
    
    // Methods
    
    func updateLabels() {
        targetValueLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        slider.value = Float(sliderValue)
    }
    
    func startOver() {
        score = 0
        round = 0
        sliderValue = 0
        slider.isEnabled = true
    }
    
    func startNewRound() {
        round += 1
        sliderValue = 50
        setTargetValue()
        updateLabels()
        transition()
    }
    
    func setTargetValue() {
        targetValue = 1 + Int(arc4random_uniform(100))
    }
    
    func sliderConfiguration(){
        slider.minimumValue = 1
        slider.maximumValue = 100
        sliderValue = 50
        
        // visual configuration
        let thumbNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbNormal, for: .normal)
        let thumbHighlited = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbHighlited, for: .highlighted)
        
        let insetsNormal = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let insetsHighlighted = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let resizableTrackLeft = trackLeftImage.resizableImage(withCapInsets: insetsNormal)
        let resizableTrackLeftHigh = trackLeftImage.resizableImage(withCapInsets: insetsHighlighted)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let resizableTrackRight = trackRightImage.resizableImage(withCapInsets: insetsNormal)
        let resizableTrackRightHigh = trackRightImage.resizableImage(withCapInsets: insetsHighlighted)
        
        slider.setMinimumTrackImage(resizableTrackLeft, for: .normal)
        slider.setMaximumTrackImage(resizableTrackRight, for: .normal)
        
        slider.setMinimumTrackImage(resizableTrackLeftHigh, for: .highlighted)
        slider.setMaximumTrackImage(resizableTrackRightHigh, for: .highlighted)
        
    }
    
    func pointsGet() {
        
        let difference: Int = abs(targetValue - sliderValue)
            points = 100 - difference
        if difference == 0 {
            points += 100
            tittle = "Perfect!"
        }
        else if difference <= 10 {
            tittle = "You almost have it!"
            if difference == 1 {
                points += 50
                tittle = "So f***ing close!"
            }
        }
        else if difference <= 25 {
            tittle = "Maybe next time!"
        }
        else {
            tittle = "Read manual first!"
        }
        score += points
    }
    
    func transition() {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        view.layer.add(transition, forKey: nil)
        
    }
    

}

