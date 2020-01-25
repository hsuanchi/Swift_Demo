//
//  ViewController.swift
//  蕃茄鐘
//
//  Created by 宣齊 on 2019/5/31.
//  Copyright © 2019年 maxlist. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import PopMenu

class TimeViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var counter = 1500
    var total_time = 0
    var timer: Timer?
    var total_timer: Timer?
    var isPlaying = false
    var workhard = false
    var setMusic = false
   
    
    @IBOutlet weak var MusicChoose: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timeLabel.text = timeString(time: TimeInterval(counter))
        pauseButton.isEnabled = false
        
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if total_timer != nil{
            total_timer?.invalidate()
            saveData()
        }
        if timer != nil{
            timer?.invalidate()
        }
    }
    
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
  
    
    @IBAction func startTimer(_ sender: Any) {
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        total_timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountTimer), userInfo: nil, repeats: true)
        
        isPlaying = true
        
        Analytics.logEvent("Click_start", parameters: [
            AnalyticsParameterItemID: counter,
            AnalyticsParameterItemName: counter,
            AnalyticsParameterContentType: "cont"
            ])
    }
    
    
    @IBAction func pauseTimer(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        total_timer?.invalidate()
        timer?.invalidate()
        isPlaying = false
        
        Analytics.logEvent("Click_pause", parameters: [
            AnalyticsParameterItemID: counter,
            AnalyticsParameterItemName: counter,
            AnalyticsParameterContentType: "cont"
            ])
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        if(workhard) {
            
            Analytics.logEvent("Click_reset", parameters: [
                AnalyticsParameterItemID: counter,
                AnalyticsParameterItemName: counter,
                AnalyticsParameterContentType: "cont"
                ])
            
            total_timer?.invalidate()
            timer?.invalidate()
            isPlaying = false
            counter = 300
            timeLabel.text = timeString(time: TimeInterval(counter))
        }else{
            
            Analytics.logEvent("Click_reset", parameters: [
                AnalyticsParameterItemID: counter,
                AnalyticsParameterItemName: counter,
                AnalyticsParameterContentType: "cont"
                ])

            total_timer?.invalidate()
            timer?.invalidate()
            isPlaying = false
            counter = 1500
            timeLabel.text = timeString(time: TimeInterval(counter))
        }
    }
    
    
    @objc func UpdateTimer() {
        if counter < 1 {
            if(workhard) {
                workhard = false
                timer?.invalidate()
                counter = 1500
                timeLabel.text = timeString(time: TimeInterval(counter))
                
                startButton.isEnabled = true
                pauseButton.isEnabled = false
                isPlaying = false
            } else{
                workhard = true
                timer?.invalidate()
                counter = 300
                timeLabel.text = timeString(time: TimeInterval(counter))
                
                startButton.isEnabled = true
                pauseButton.isEnabled = false
                isPlaying = false
            }
        } else {
            counter = counter - 1
            timeLabel.text = timeString(time: TimeInterval(counter))
            print(counter)
        }
    }
    @objc func CountTimer() {
        total_time = total_time + 1
        print(total_time)
    }
    
    
    func timeString(time:TimeInterval) -> String {
        //        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    @IBAction func setRedColor(_ sender: Any) {
        self.view.backgroundColor = UIColor(hexFromString: "#FF7E79")
    }
    
    @IBAction func setYellowColor(_ sender: Any) {
        self.view.backgroundColor = UIColor(hexFromString: "#FFD479")
    }
    
    @IBAction func setBlueColor(_ sender: Any) {
        self.view.backgroundColor = UIColor(hexFromString: "#4BABB3")
    }
    
    @IBAction func setGrayColor(_ sender: Any) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ripple.jpeg")!)
    }
    @IBAction func setColorful(_ sender: Any) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "colorful_door.jpeg")!)
    }
    
    func setMusic(music: String){
        let url = Bundle.main.url(forResource: music, withExtension: "mp3")
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url!)
            self.audioPlayer.numberOfLoops = -1
            self.audioPlayer.prepareToPlay()
            setMusic = true
        } catch {
            print("Error:", error.localizedDescription)
        }
    }
    
    @IBAction func MusicChoose(_ sender: Any) {
        let manager = PopMenuManager.default
        let action1 = PopMenuDefaultAction(title: "Mute", image: UIImage(named: "mute"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1), didSelect: { action in
            if(self.setMusic){
                self.audioPlayer.pause()
            }
        })
        let action2 = PopMenuDefaultAction(title: "CoffeeShop", image: UIImage(named: "java"), color: .white, didSelect: { action in
            self.setMusic(music:"CoffeeShop")
            self.audioPlayer.play()
            
        })
        let action3 = PopMenuDefaultAction(title: "Campfire", image: UIImage(named: "fire"), color: .white, didSelect: { action in
            self.setMusic(music:"campfire")
            self.audioPlayer.play()
        })
        let action4 = PopMenuDefaultAction(title: "Rain", image: UIImage(named: "rain"), color: .white, didSelect: { action in
            self.setMusic(music:"rain")
            self.audioPlayer.play()
        })
        let action5 = PopMenuDefaultAction(title: "River", image: UIImage(named: "waves"), color: .white, didSelect: { action in
            self.setMusic(music:"river")
            self.audioPlayer.play()
        })
        let action6 = PopMenuDefaultAction(title: "Beach", image: UIImage(named: "sun"), color: .white, didSelect: { action in
            self.setMusic(music:"beach")
            self.audioPlayer.play()
        })
        let action7 = PopMenuDefaultAction(title: "Ocean", image: UIImage(named: "docker"), color: .white, didSelect: { action in
            self.setMusic(music:"ocean")
            self.audioPlayer.play()
        })

        
        manager.addAction(action1)
        manager.addAction(action2)
        manager.addAction(action3)
        manager.addAction(action4)
        manager.addAction(action5)
        manager.addAction(action6)
        manager.addAction(action7)
        manager.present(sourceView: sender as AnyObject)

    }

    // MARK: Save data & load data
    func saveData() {
        let userDefaults = UserDefaults(suiteName: "group.xyz.maxlist.New1208")
        userDefaults?.set(total_time, forKey: "total_time")
    }
    
    func loadData() {
        let userDefaults = UserDefaults(suiteName: "group.xyz.maxlist.New1208")
        total_time = userDefaults?.integer(forKey: "total_time") ?? 0
    }
    
}
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


