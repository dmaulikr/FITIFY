//
//  Workout.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-29.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import Foundation
import UIKit

class Workout {
    
    var totalNumOfExcercises: Int = 5
    var numOfExcercisesCompleted: Int = 0
    var fractionOfExcercisesCompleted: String!
    var nameOfWorkout: String!
    
    init(name: String, completed: Int) {
        numOfExcercisesCompleted = completed
        fractionOfExcercisesCompleted = "\(numOfExcercisesCompleted) / \(totalNumOfExcercises)"
        nameOfWorkout = name
    }
}
