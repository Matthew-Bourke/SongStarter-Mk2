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
    
    
    
    ///         Outlets         ///
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    
    
    ///         Variables           ///
    // Variables initialised for recording
    var audioRecorder : AVAudioRecorder? = nil
    var audioPlayer : AVAudioPlayer? = nil
    var audioURL : URL?
    // Array of tracks of type 'Track'
    var tracks : [Track] = []
    
    
    
    
    ///         View Did Load           ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup recorder for recording
        setupRecorder()
        
    }
    
    
    ///         Functions           ///
    
    // Function is just typical setup procedure
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
            
            // Get all tracks from CoreData for count to autofill track name
            tracks = getAllTracks()
            
            // Present alert asking if save or not
            let addVC = UIAlertController(title: "New Track", message: "Choose a name for your recording", preferredStyle: .alert)
            //Add text field to alert controller
            addVC.addTextField(configurationHandler: { (nameTF) in
                // Set default text in text field
                nameTF.text = "My Idea \(self.tracks.count + 1)"
                // Create actions 'Add' and 'Discard'
                let discardAction = UIAlertAction(title: "Discard", style: .default, handler: nil)
                let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
                    
                    // Collect tracks from CoreData
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let track = Track(context: context)
                    
                    // Set track audio to recorded audio
                    track.audio = NSData(contentsOf: self.audioURL!)
                    
                    // If text field is empty, automatically create track with default name
                    if nameTF.text == "" {
                        track.name = "My Idea \(self.tracks.count + 1)"
                    } else {
                        track.name = nameTF.text!
                    }
                    
                    // Trying so save into specific library
                    

                    
                    
                    //
                    
                    // Save new track in CoreData
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                      })
                
                // Add actions to alert controller
                addVC.addAction(discardAction)
                addVC.addAction(addAction)
                
                // Present alert controller
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

