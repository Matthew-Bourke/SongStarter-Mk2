//
//  CoreDataHelp.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import Foundation
import CoreData
import UIKit



///         CoreData Functions          ///

// For first time use, create 'All Tracks' library to CoreData
func createInitialLibrary() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let allLibrary = Library(context: context)
    allLibrary.name = "All Tracks"
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


// Load all libraries from CoreData
func getAllLibraries() -> [Library] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        // Load libraries
        let libraries = try context.fetch(Library.fetchRequest()) as! [Library]
        // If no libraries exist, call create initial library function
        if libraries.count == 0 {
            createInitialLibrary()
            return getAllLibraries()
        }
        return libraries
    } catch {   }
    return []
}


// Load all tracks from CoreData
func getAllTracks() -> [Track] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let tracks = try context.fetch(Track.fetchRequest()) as! [Track]
        return tracks
    } catch {   }
    return []
}



