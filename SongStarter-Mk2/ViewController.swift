//
//  ViewController.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var libraries : [Library] = []
    
    ///         View Did Load           ///

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

       
        
    }
    
    
    ///         Functions           ///
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! LibrariesViewController
        nextVC.libraries = libraries
    }
    

    ///         Actions         ///

    @IBAction func recordTapped(_ sender: Any) {
        // Begin recording
        
        
        
    }
    
    

    
    
    ///         Memory Warning          ///
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

