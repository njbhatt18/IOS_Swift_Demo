//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import AVFoundation
class AudioPlayerViewController: UIViewController,AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer!
    @IBOutlet var lblStartTime : UILabel!
    @IBOutlet var lblEndTime : UILabel!
    @IBOutlet var lblCurrTime : UILabel!
    var timer : NSTimer!
   // @IBOutlet var timerControl : UISlider!
    @IBOutlet var timerControl : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Audio"

        let url = NSURL.fileURLWithPath(
            NSBundle.mainBundle().pathForResource("Audio",
                ofType: "mp3")!)
        var error : NSError!
        do{
            audioPlayer = try  AVAudioPlayer(contentsOfURL: url)
            let interval = audioPlayer.duration as Double?
            let maxVal = round(Float(interval!) as Float)
            timerControl.maximumValue=maxVal
            timerControl.minimumValue=0
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.2
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            lblCurrTime.text="0.0s"
            lblStartTime.text="0.0s"
            print(maxVal/60.0)
            print(maxVal%60.0)
            lblEndTime.text=String(Int(maxVal/60.0))+"."+String(Int(maxVal%60.0))+"s"
        }
        catch {
            fatalError ("Error loading \(url): \(error)")
        }
    }
    @IBAction func playAudio(sender: AnyObject) {
        if let player = audioPlayer {
            player.play()
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        }
    }
    func updateTimer ()
    {
        timerControl.value=Float(round(audioPlayer.currentTime))
        lblCurrTime.text=String(Int(round(audioPlayer.currentTime/60.0)))+"."+String(Int(round(audioPlayer.currentTime%60.0)))+"s"

    }
    @IBAction func forwardAudio(sender: AnyObject) {
        var time = audioPlayer.currentTime as Double
        time = time + 5.0
        audioPlayer.currentTime = time
        
    }
    @IBAction func reversAudio(sender: AnyObject) {
        var time = audioPlayer.currentTime as Double
        time = time - 5.0
        audioPlayer.currentTime = time


    }
    @IBAction func stopAudio(sender: AnyObject) {
        if let player = audioPlayer {
            player.stop()
        }
    }
    
    @IBAction func adjustVolume(sender: UISlider) {
        let volumeCntlr = sender as UISlider!
        if audioPlayer != nil {
            audioPlayer?.volume = volumeCntlr.value
        }
    }
//AVAudioPlayerDelegate Event 
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully
        flag: Bool) {
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer,
        error: NSError?) {
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

