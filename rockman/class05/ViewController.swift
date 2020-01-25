//
//  ViewController.swift
//  class05
//
//  Created by Max on 2019/7/22.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ballTwo.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var roalColor: [UIView]!
    
    @IBOutlet var balls: [UIView]!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBAction func colorChange(_ sender: Any) {
        for roalColors in roalColor{
            roalColors.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        }
        for ball in balls{
            ball.tintColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        }
    }
    

    @IBOutlet weak var ballPossition: UIView!
    @IBOutlet weak var ball: UIImageView!
    @IBOutlet weak var ballTwo: UIImageView!
    @IBAction func shoot(_ sender: Any) {
       
            self.ball.frame.origin.x = self.ballPossition.frame.origin.x
            self.ball.frame.origin.y = self.ballPossition.frame.origin.y
            self.ballTwo.frame.origin.x = self.ballPossition.frame.origin.x-50
            self.ballTwo.frame.origin.y = self.ballPossition.frame.origin.y
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, animations: {
            self.ball.center.x += 1000
            self.ballTwo.center.x += 1200
        }, completion: nil)
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func weaponChoose(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            ball.isHidden = false
            ballTwo.isHidden = true
        case 1:
            ball.isHidden = false
            ballTwo.isHidden = false
        default:
            break;
        }
    }
}

