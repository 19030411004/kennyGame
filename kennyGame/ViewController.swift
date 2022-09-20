//
//  ViewController.swift
//  kennyGame
//
//  Created by Fatmagül Demirbaş on 17.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var count = 0
    var timer = Timer()
    var HideTimer = Timer()
    var kennyArray = [UIImageView]()
    var highestscore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighestScore: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //highscore check-- yeni yüksek skoru tutacak ve her oyunu açtığımızda gösterecek
        let storedHighScore = UserDefaults.standard.object(forKey: "highestScore")
        
        if storedHighScore == nil {
            highestscore = 0
            HighestScore.text = " Highest Score : \(highestscore)"
        }
        if let newScore = storedHighScore as? Int {
            highestscore = newScore
            HighestScore.text = "Highest Score : \(highestscore)"
        }
        
        
        //time
        count = 10
        timeLabel.text = "Time : \(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TımeInterval), userInfo: nil, repeats: true)
        //hareket eden imagelerin kaç saniyede yok olacaklarını belirledik
        HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(HideKenny), userInfo: nil, repeats: true)
        
        //score
        ScoreLabel.text = "Score: \(score)"
        
        // Resimleri user etkileşimine açık hale getirdik
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4 , kenny5 ,kenny6, kenny7 , kenny8 , kenny9]
        
        //resmin üstünü tıklamak için;
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(kennyTap))
        
        //her bir image i tanımladık
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        
        HideKenny()
        
    }
    
    @objc func HideKenny(){
        for kenny in kennyArray {
            kenny.isHidden = true //tüm kenny'leri görünmez hale getirdi.
        }
        
        //kenny'leri ekranda RASTGELE görünmez hale getirdi.
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1))) // Arraylerde index 0  dan basladıgı icin -1 dedik
        kennyArray[random].isHidden = false
    }
    
    
    @objc func kennyTap(){
        //üstüne her tıklandığında score 1 artırıyor
        score += 1
        ScoreLabel.text = "Score: \(score)"
      
        }
        
        
    @objc func TımeInterval(){
        //süre geriye akıyor ve bitince uyarı veriyor.
        count -= 1
        timeLabel.text = "Time: \(count)"
        if count == 0 {
            timer.invalidate() //süreyi 0 a gelince kapatıyor.
            
            HideTimer.invalidate()
            for kenny in kennyArray {
                kenny.isHidden = true
                
                //highest score'u bulmak için
                if self.score > self.highestscore {
                    self.highestscore = self.score
                    HighestScore.text = "Highest Score: \(self.highestscore)"
                    UserDefaults.standard.set(self.highestscore, forKey: "highestScore") // veriyi saklamak için
                }
            }
                //uyarı mesajı oluşturduk.
                let alert = UIAlertController.init(title:"TIME'S UP", message: "Do you want to play again ?", preferredStyle: UIAlertController.Style.alert)
                let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                let replayButton = UIAlertAction(title: "Replay", style:  UIAlertAction.Style.default) {
                    (UIAlertAction) in
                    
                //replay tuşuna bastıktan sonra oyunu tekrar başlatmak için;
                    self.score = 0
                    self.ScoreLabel.text = "Score : \(self.score)"
                    self.count = 10
                    self.timeLabel.text = String(self.count)
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.TımeInterval), userInfo: nil, repeats: true)
                    self.HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.HideKenny), userInfo: nil, repeats: true)
                    }
                alert.addAction(button)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion:nil)}
            
            
        }
    }

