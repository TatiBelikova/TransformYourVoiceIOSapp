//
//  PlaySoundsViewController.swift
//  transformyourvoice
//
//  Created by Tatiana Belikova on 11/28/15.
//  Copyright © 2015 focuset. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
     
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioPlayer.volume = 5.0
    
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        try! AVAudioSession.sharedInstance().overrideOutputAudioPort(.Speaker)
        
    }
    

    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
    
        audioPlayerNode.play()
       
    }
    
    
    
    @IBAction func playDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.rate = 0.4
        audioPlayer.play()
        
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.rate = 1.6
        audioPlayer.play()
    }
    
   
    
    
}
