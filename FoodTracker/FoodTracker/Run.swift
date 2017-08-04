//
//  Run.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 7/31/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class Run: NSObject, NSCoding{
    //MARK: Properties
    
    var name: String
    var day: String
    var time: String
    var location: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("runs")
    
    //MARK: Initialize
    init?(name: String, day: String, time: String, location: String) {
        guard !name.isEmpty else {
            return nil
        }
        guard !day.isEmpty else {
            return nil
        }
        guard !time.isEmpty else {
            return nil
        }
        guard !location.isEmpty else {
            return nil
        }
        self.name = name
        self.day = day
        self.time = time
        self.location = location 
    }
    struct PropertyKey {
        static let name = "name"
        static let day = "day"
        static let time = "time"
        static let location = "location"
    }
    //MARK: NSCoding
    //This has to do with data persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(day, forKey: PropertyKey.day)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(location, forKey: PropertyKey.location)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Run object.")
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        
        guard let day = aDecoder.decodeObject(forKey: PropertyKey.day) as? String else {
            return nil
        }
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String else {
            return nil
        }
        guard let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String else {
            return nil
        }
        // Must call designated initializer.
        self.init(name: name, day: day, time: time, location: location)
        //self.init(name: "a", day: "b", time: "c", location: "d")

    }
}

