//
//  ViewController.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    
    var audioRecorder : AVAudioRecorder? = nil
    var audioPlayer : AVAudioPlayer? = nil
    var audioURL : URL?
    
    
    
    ///         View Did Load           ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupRecorder()
        
    }
    
    
    ///         Functions           ///
    
    func setupRecorder() {
        do {
            //Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            
            
            // Create settings for audio recorder
            var settings : [String : Any] = [:]
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create AudioRecorder object
            try audioRecorder = AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    ///         Actions         ///
    
    @IBAction func recordTapped(_ sender: Any) {
        // Begin recording
        
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder!.stop()
            
            // Change button title to 'record'
            recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
            
            
            
            // Present alert asking if save or not
            let addVC = UIAlertController(title: "New Track", message: "Choose a name for your recording", preferredStyle: .alert)
            addVC.addTextField(configurationHandler: { (nameTF) in
                let discardAction = UIAlertAction(title: "Discard", style: .default, handler: nil)
                let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let track = Track(context: context)
                    track.name = nameTF.text!
                    
                    
                    track.audio = NSData(contentsOf: self.audioURL!)
                    
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()

                })
                
                addVC.addAction(discardAction)
                addVC.addAction(addAction)
                
                self.present(addVC, animated: true)
                
            })
            
            
        } else {
            // Start the recording
            audioRecorder!.record()
            
            // Change button title to 'stop'
            recordButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    ///         Memory Warning          ///
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

