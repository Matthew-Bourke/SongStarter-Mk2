//
//  TracksViewController.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class TracksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    ///         Outlets         ///
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tracksList: UITableView!
    
    
    ///         Variables           ///
    
    var library = Library()
    var tracks : [Track] = []
    var realTracks : [Track] = []
    var audioPlayer : AVAudioPlayer? = nil
    
    
    
    ///         View Did Load           ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set heading to library name so its clear where user is
        navBar.title = library.name
        
        tracksList.dataSource = self
        tracksList.delegate = self
    }
    
    
    
    ///         Functions           ///
    
    // Each time VC appears
    override func viewWillAppear(_ animated: Bool) {
        do {
            // Get tracks from CoreData
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            tracks = try context.fetch(Track.fetchRequest())
            
            // For 'All Tracks' library, get all tracks in CoreData
            // For a specific library, only get tracks with track.owner == library.name
            if library.name != "All Tracks"
            {
                for track in tracks {
                    if track.owner == library.name {
                        realTracks.append(track)
                    }
                }
                tracks = realTracks
            }
            
            // Load appropriate tracks
            tracksList.reloadData()
        } catch {   }
    }
    
    
    // Tableview rows = number of tracks in library
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
    // Tableview cell info = name of each track in library
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.name
        return cell
    }
    
    
    // When a track is selected, play track.
    // In future, move to a SingleTrackViewController for editing/playing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        do {
            audioPlayer = try AVAudioPlayer(data: track.audio! as Data)
            audioPlayer?.play()
        } catch {   }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // Function which allows Swipe to Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let track = tracks[indexPath.row]
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(track)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            tracks = getAllTracks()
            tracksList.reloadData()
        }
    }
    
    
    
    ///         Actions         ///
    
    // Add from track VC moves back to main hub VC
    @IBAction func addTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    ///         Memory Warning          ///
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
