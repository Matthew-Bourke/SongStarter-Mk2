//
//  LibrariesViewController.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit
import CoreData

class LibrariesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    ///         Outlets         ///
    
    // TableView outlet from Libraries
    @IBOutlet weak var librariesList: UITableView!
    
    
    
    
    ///          Variables          ///
    
    // Variable 'libraries' of type 'Library' is initialised as an empty array of libraries
    var libraries : [Library] = []
    
    
    
    
    ///      View Did Load       ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        librariesList.reloadData()
        
        // Initialise libraries tableview
        librariesList.delegate = self
        librariesList.dataSource = self
        
        let allTracks = Library()
        allTracks.name = "All"
        allTracks.tracks = []
        
        libraries.append(allTracks)
        
        
    }
    
    
    
    
    ///         Functions           ///
    
    // Number of rows in libraries tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Equal to number of libraries
        return libraries.count
    }
    
    
    // What appears in each cell of tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let library = libraries[indexPath.row]
        
        // Each cell lists the name of each library
        cell.textLabel?.text = library.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let preVC = segue.destination as! ViewController
        preVC.libraries = libraries
        
        
    }
    
    
    
    
    ///         Actions         ///
    
    @IBAction func addTapped(_ sender: Any)  {
        // Add a library
        let addVC = UIAlertController(title: "New Library", message: "Enter the name of the new library", preferredStyle: .alert)
        addVC.addTextField { (nameTF) in
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
                let library = Library()
                library.name = nameTF.text!
                library.tracks = []
                
                self.libraries.append(library)
                self.librariesList.reloadData()
                
            })
            
            addVC.addAction(cancelAction)
            addVC.addAction(addAction)
            
            self.present(addVC, animated: true, completion: nil)
           
        }
        
    }
    
    
    
    /*   @IBAction func addTapped(_ sender: Any) {
     // This is where the CoreData stuff starts
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     let sound = Sound(context: context)
     
     sound.name = nameTF.text
     sound.audio = NSData(contentsOf: audioURL!)
     
     (UIApplication.shared.delegate as! AppDelegate).saveContext()
     // End of core data stuff
     // Seems like its just default code to memorise //
     
     navigationController!.popViewController(animated: true)
     }*/
    
    
    
    
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