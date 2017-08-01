//
//  Run.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 7/31/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class Run {
    //MARK: Properties
    
    var name: String
    var day: String
    var time: String
    var location: String
    
    //MARK: Initialize
    init?(name: String, day: String, time: String, location: String) {
        if name.isEmpty || day.isEmpty || time.isEmpty || location.isEmpty  {
            print("failed to initialize a Run")
            return nil
        }
        self.name = name
        self.day = day
        self.time = time
        self.location = location
    }
}

