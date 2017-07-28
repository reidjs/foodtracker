//
//  Meal.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 7/26/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit
class Meal: NSObject, NSCoding {
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
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
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    //MARK: NSCoding
    //This has to do with data persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    // Because photo is an optional property of Meal, just use conditional cast.
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Meal object.")
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.

        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
   
    
}
