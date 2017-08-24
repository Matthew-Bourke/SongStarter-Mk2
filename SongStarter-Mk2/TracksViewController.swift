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
    var audioPlayer : AVAudioPlayer? = nil
    
    
    
    ///         View Did Load           ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navBar.title = library.name
        
        
        tracksList.dataSource = self
        tracksList.delegate = self
        
        
        
        
    }
    
    
    
    ///         Functions           ///
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            tracks = try context.fetch(Track.fetchRequest())
            tracksList.reloadData()
        } catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        do {
            audioPlayer = try AVAudioPlayer(data: track.audio! as Data)
            audioPlayer?.play()
        } catch {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
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
    
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
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
