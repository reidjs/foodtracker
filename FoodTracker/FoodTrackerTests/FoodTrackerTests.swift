//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Reid Sherman MAT on 7/21/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
   //MARK: Meal Class Tests
    //confirm meal init returns a meal object when passed valid params
    func testMealInitializationSucceeds(){
        //lowest rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        //highest rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
    }
    func testMealInitializationFails() {
        //negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        //empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        //rating exceeds max
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
}
