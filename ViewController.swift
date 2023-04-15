//
//  ViewController.swift
//  ProjectApp
//
//  Created by Emilio Viscal on 3/21/23.
//This App is developed as an educational project. Certain materials are included under the fair use exemption of the U.S. Copyright Law and have been prepared according to the multimedia fair use guidelines and are restricted from further use

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imgLabel: UILabel!
    
    @IBOutlet weak var siteLink: UIButton!
    
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var start: UIButton!
    var OurTimer = Timer()
    var TimerDisplay = 0
    var min = 0
    var hr = 0
    
    @IBOutlet weak var timer: UILabel!
    
    @IBAction func start(_ sender: Any) {
        OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        OurTimer.invalidate()
    }
    
    @IBAction func reset(_ sender: Any) {
        OurTimer.invalidate()
        TimerDisplay = -1
        min = 0
        hr = 0
        timer.text = "00:00:00"
        TimerDisplay = 0
    }
    var selectedValue = 1
    @objc func Action() {
        TimerDisplay += 1
           if (TimerDisplay == 60) {
               TimerDisplay = 0
               min += 1
           }
           if (min == 60){
               min = 0
               hr += 1
           }
            timer.text = String(format: "%02d:%02d:%02d", hr, min, TimerDisplay)
        if(selectedValue == min){
            soundAlert.play()
            OurTimer.invalidate()
        }
    }

    @IBOutlet weak var pickerView: UIPickerView!
    let dataArray : [Int] = [1, 2, 3, 4, 5, 10, 15, 20, 25, 30]
    let dataArray2 : [String] = ["1", "2", "3", "4", "5", "10", "15", "20", "25", "30"]
    
   @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = dataArray[row]
    }
       
     @objc  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return dataArray.count
       }
       
     @objc  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return dataArray2[row]
       }
    
    

    var natureObjectArray = [Sounds1]()
    var beatsObjectArray = [Sounds2]()
    var globalS1 = Sounds1()
    var globalS2 = Sounds2()
    
    var soundAlert:AVAudioPlayer!
    var sound01:AVAudioPlayer!
    var sound02:AVAudioPlayer!
    var sound03:AVAudioPlayer!
    var sound04:AVAudioPlayer!
    var sound05:AVAudioPlayer!
    var sound06:AVAudioPlayer!
    var sound07:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // initialize the Sound variable that was globally declared.
        let  urlObject0 = URL(fileURLWithPath: Bundle.main.path(forResource: "alert", ofType: "wav")!)
        
        soundAlert = try? AVAudioPlayer(contentsOf:urlObject0)
        
        let  urlObject1 = URL(fileURLWithPath: Bundle.main.path(forResource: "waterfall", ofType: "wav")!)
        
        sound01 = try? AVAudioPlayer(contentsOf:urlObject1)
        
        let  urlObject2 = URL(fileURLWithPath: Bundle.main.path(forResource: "rain", ofType: "wav")!)
        
        sound02 = try? AVAudioPlayer(contentsOf:urlObject2)
        
        let  urlObject3 = URL(fileURLWithPath: Bundle.main.path(forResource: "beat01", ofType: "wav")!)
        
        sound03 = try? AVAudioPlayer(contentsOf:urlObject3)
        
        let  urlObject4 = URL(fileURLWithPath: Bundle.main.path(forResource: "beat02", ofType: "wav")!)
        
        sound04 = try? AVAudioPlayer(contentsOf:urlObject4)
        
        let  urlObject5 = URL(fileURLWithPath: Bundle.main.path(forResource: "forest", ofType: "wav")!)
        
        sound05 = try? AVAudioPlayer(contentsOf:urlObject5)
        
        let  urlObject6 = URL(fileURLWithPath: Bundle.main.path(forResource: "shepard tone", ofType: "wav")!)
        
        sound06 = try? AVAudioPlayer(contentsOf:urlObject6)
        
        let  urlObject7 = URL(fileURLWithPath: Bundle.main.path(forResource: "jungle", ofType: "wav")!)
        sound07 = try? AVAudioPlayer(contentsOf:urlObject7)
        // mySoundFile.play() //in the Set Lables function
        initializeData()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isUserInteractionEnabled = true
        
        timer.text = "00:00:00"
        TimerDisplay = 0
        min = 0
        hr = 0
        siteLink.alpha = 0
        setLabels3()
    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        image.alpha = 0
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration: 3, animations: {
            self.image.alpha = 1
            self.sound01.stop()
            self.sound02.stop()
            self.sound03.stop()
            self.sound04.stop()
            self.sound05.stop()
            self.sound06.stop()
            self.sound07.stop()
        })
        setLabels1()
    }
    
    
    @IBAction func openSite(_ sender: Any) {
        
            let browserApp = UIApplication.shared
        if(imgLabel.text == "Shepard Tone"){
            let url = URL(string: globalS2.webAddress)
            browserApp.open(url!)
        }
        if(imgLabel.text == "Jungle"){
            let url = URL(string: globalS1.webAddress)
            browserApp.open(url!)
        }
    }
    
    @IBAction func btnNature(_ sender: Any) {
            sound01.stop()
            sound02.stop()
            sound03.stop()
            sound04.stop()
            sound05.stop()
        sound06.stop()
        sound07.stop()
        setLabels1()
        
    }
    
    @IBAction func btnBeats(_ sender: Any) {
            sound01.stop()
            sound02.stop()
            sound03.stop()
            sound04.stop()
            sound05.stop()
        sound06.stop()
        sound07.stop()
        setLabels2()
    }
    @IBAction func btnPlay(_ sender: Any) {
            if (imgLabel.text=="Waterfall") {sound01.play()
                sound01.numberOfLoops = 1000 //should provide about 1-2 hours of playtime
            }
            else if(imgLabel.text=="Rain"){sound02.play()
                sound02.numberOfLoops = 1000
            }
        else if(imgLabel.text=="Jungle"){sound07.play()
            sound07.numberOfLoops = 1000
        }
            else if(imgLabel.text=="Forest"){sound05.play()
                sound05.numberOfLoops = 1000
            }
            else if(imgLabel.text=="Beat01") {sound03.play()
                sound03.numberOfLoops = 1000
            }
            else if(imgLabel.text=="Beat02"){sound04.play()
                sound04.numberOfLoops = 1000
            }
        else if(imgLabel.text=="Shepard Tone"){sound06.play()
            sound06.numberOfLoops = 1000
        }
        
    }
    
    @IBAction func btnStop(_ sender: Any) {
        if (imgLabel.text=="Waterfall") {sound01.stop()}
        else if(imgLabel.text=="Rain"){sound02.stop()}
        else if(imgLabel.text=="Jungle"){sound07.stop()}
        else if(imgLabel.text=="Beat01") {sound03.stop()}
        else if(imgLabel.text=="Beat02"){sound04.stop()}
        else if(imgLabel.text=="Forest"){sound05.stop()}
        else if(imgLabel.text=="Shepard Tone"){sound06.stop()}
    }
    
    func setLabels1() {
            let randomSound = natureObjectArray.randomElement()
            
            globalS1 = randomSound!
            imgLabel.text = randomSound?.SoundName
        if(imgLabel.text == "Jungle"){
            siteLink.alpha = 1}
        else{ siteLink.alpha = 0}
            image.image = UIImage(named:randomSound!.SoundImage)
            image.layer.cornerRadius = 30
            image.clipsToBounds = true
            image.layer.borderWidth = 5
            image.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setLabels2(){
        let randomSound = beatsObjectArray.randomElement()
        globalS2 = randomSound!
        imgLabel.text = randomSound?.SoundName
        if(imgLabel.text == "Shepard Tone"){
            siteLink.alpha = 1}
        else{ siteLink.alpha = 0}
        image.image = UIImage(named:randomSound!.SoundImage)
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    
    func initializeData() {
        let s1 = Sounds1() // Creating an object of the class sounds
        s1.SoundName = "Waterfall"
        s1.SoundImage = "waterfall.jpg"
        natureObjectArray.append(s1)
        
        let s2 = Sounds1() // Creating an object of the class sounds
        s2.SoundName = "Rain"
        s2.SoundImage = "rain.jpg"
        natureObjectArray.append(s2)
        
        let s5 = Sounds1()
        s5.SoundName = "Forest"
        s5.SoundImage = "forest.jpg"
        natureObjectArray.append(s5)
        
        let s3 = Sounds2() // Creating an object of the class sounds
        s3.SoundName = "Beat01"
        s3.SoundImage = "beats01.jpg"
        beatsObjectArray.append(s3)
        
        let s4 = Sounds2() // Creating an object of the class sounds
        s4.SoundName = "Beat02"
        s4.SoundImage = "beats02.jpg"
        beatsObjectArray.append(s4)
        
        let s6 = Sounds2() // Creating an object of the class sounds
        s6.SoundName = "Shepard Tone"
        s6.SoundImage = "shepard tone.jpg"
        s6.webAddress = "https://en.wikipedia.org/wiki/Shepard_tone"
        beatsObjectArray.append(s6)
        
        
        let s7 = Sounds1() // Creating an object of the class sounds
        s7.SoundName = "Jungle"
        s7.SoundImage = "jungle.jpg"
        s7.webAddress = "https://en.wikipedia.org/wiki/Peninsular_Malaysian_rain_forests"
        natureObjectArray.append(s7)
    }
    
}

