//
//  Libraries.swift
//  SongStarter-Mk2
//
//  Created by Matthew Bourke on 23/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import Foundation
import CoreData

// Class 'Library' contains the name of library and an array of the tracks (from CoreData) that are in the library
/*
        Thinking whether or not this should also be in CoreData, or if there is a workaround by adding an attribute to 'Track'
        entity in CoreData which describes the library it exists in. Then, if the app is deleted and redownloaded, it can suss out the libraries
        the tracks existed in before it was deleted. Then, have a function that searches each track and finds the library it was in, and checks
        if the library exists. If it doesn't, it can just readd the library to the array of libraries. If it does, then no need to readd it as the track
        should simply be readded to that library.
        Saving space in CoreData or an over-complicated idea?
*/

class Library {
    // Name of the library
    var name = ""
    
    // Tracks that exist in the library
    var tracks : [Track] = []
}
