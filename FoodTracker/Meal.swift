//
//  Meal.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 7/26/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit
class Meal {
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int){
        //fail if no name, too high, or neg rating
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        //init stored propties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
