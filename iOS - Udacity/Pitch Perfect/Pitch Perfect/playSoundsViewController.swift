//
//  playSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Krom Caparros on 3/30/15.
//  Copyright (c) 2015 ATT. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    
    // Created a function to combine Stop and Play audioPlayer functions
    func playPauseAudio() -> () {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    // Created a function to Stop the audioEngine function
    func stopPlay() -> (){
    
        audioEngine.stop()
        audioEngine.reset()
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        // Do any additional setup after loading view.
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
       
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        
        // Stop playing the audio

         stopPlay()
         audioPlayer.stop()
        
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        // Plays the recorded audio slowly
        
        stopPlay()
        playPauseAudio()
        audioPlayer.rate = 0.5
        
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        //Plays the recorded audio fast
        
        stopPlay()
        playPauseAudio()
        audioPlayer.rate = 2.0
        
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        // Plays low audio pitch
        
        playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        // Plays high audio pitch
        
        playAudioWithVariablePitch(1000)
    }
    
    
    // Function to play the recorded audio with variable pitch levels
    
    func playAudioWithVariablePitch(pitch: Float){
        
        stopPlay()
        audioPlayer.stop()

        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
     }
 
    
  

}
