//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Krom Caparros on 3/16/15.
//  Copyright (c) 2015 ATT. All rights reserved.
//

import UIKit
import AVFoundation


//Declared Globally
var audioRecorder:AVAudioRecorder!
var recordedAudio:RecordedAudio!

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

  

    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
          }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Hide the stop, pause and play buttons
        
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        recordingInProgress.hidden = false
        recordingInProgress.text = "Tap to record"
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        
       
        // Display a label "Recording in progress...." when button is tapped
        // Disable record button
        // Show the stop and pause buttons
        // Disable the play button
        
        recordingInProgress.text = "Recording in progress...."
        stopButton.hidden = false
        micButton.enabled = false
        pauseButton.hidden = false
        pauseButton.enabled = true
        resumeButton.hidden = true
        resumeButton.enabled = false
        
        println("in RecordAudio")
        
        // Records the User's voice
        
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        //Setup Audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Initialize the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    // Created a function to save the recorded audio and move to the next scene
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
      if (flag){
        
            //Save the recorded audio
        
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)

            // Move to the next scene
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        
      } else{
        
            println("Recording not succesful")
            stopButton.enabled = true
            micButton.enabled = true
        }
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            
            let playSoundsVC:playSoundsViewController = segue.destinationViewController as playSoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        
        }
    }
 
    @IBAction func pauseRecording(sender: UIButton) {
        
            // Pause the recording session
            // Hide the pause button and show the play button to have an option to continue the recording
        
            audioRecorder.pause()
            pauseButton.hidden = true
            stopButton.hidden = false
            pauseButton.enabled = false
            resumeButton.hidden = false
            resumeButton.enabled = true
            micButton.enabled = false
            recordingInProgress.text = "Play to continue recording"
    }
    
    @IBAction func resumeRecording(sender: UIButton) {
        
        // Resume the same recording session
        // Hide the play button and shows the pause button and continue recording the audio
        
        audioRecorder.record()
        resumeButton.enabled = false
        resumeButton.hidden = true
        stopButton.hidden = false
        pauseButton.hidden = false
        pauseButton.enabled = true
        recordingInProgress.text = "Recording in Progress..."
    }
    
    @IBAction func stopAudio(sender: UIButton) {
       
        // Hide the "Recording in progress..." label when button is tapped
       recordingInProgress.hidden = true
       micButton.enabled = true
        
        
        //Stops recording and end session
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
}