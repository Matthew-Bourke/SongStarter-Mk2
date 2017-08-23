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

func createInitialLibrary() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let allLibrary = Library(context: context)
    allLibrary.name = "All"
    
    print("CREATED")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}


func getAllLibraries() -> [Library] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
        let libraries = try context.fetch(Library.fetchRequest()) as! [Library]
        if libraries.count == 0 {
            print("NONE")
            createInitialLibrary()
            return getAllLibraries()
        }
        return libraries
        
    } catch {}
    
    return []
}



