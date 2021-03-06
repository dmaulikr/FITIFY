//
//  SuperGlobals.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-24.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import Foundation
import UIKit

var excercisePlaylist = [
    Excercise(name: "Lunge", desc: "Start with legs together. Stepforward with one foot and bend that knee to 90 degrees. Bounce back up on that knee.", image: UIImage(named: "s1")!),
    Excercise(name: "Squat", desc: "Start with kneed a shoulder width apart. Bend both knees as much as possible then spring back up", image: UIImage(named: "s2")!),
    Excercise(name: "Jumping Jack", desc: "Start with legs together. Jump and spread your arms then return to the initial position", image: UIImage(named: "s3")!),
    Excercise(name: "Ab Crunch", desc: "Start with kneed a shoulder width apart. Bend both knees as much as possible then spring back up", image: UIImage(named: "s2")!),
    Excercise(name: "Super Jacks", desc: "Start with legs together. Jump and spread your arms then return to the initial position", image: UIImage(named: "s3")!),
]

var alternateExcercises = [
    Excercise(name: "Calf Raise", desc: "Push up to your tip toes", image: UIImage(named: "s2")!),
    Excercise(name: "Wall Squat", desc: "Sit against the wall with legs at 90 degrees and hold", image: UIImage(named: "s3")!),
    Excercise(name: "Front Squat", desc: "Place the bar on your shoulderblades and perform a squat", image: UIImage(named: "s2")!),
    Excercise(name: "Leg Curls", desc: "Lay on the bench and curl your legs", image: UIImage(named: "s3")!)
]

var temporaryContainer: [Excercise]!

var workoutArray: [Workout] = [
    Workout(name: "Leg Day", completed: 4),
    Workout(name: "Chest Day", completed: 3),
    Workout(name: "Full Body", completed: 2),
    Workout(name: "Arms Day", completed: 4),
    Workout(name: "Back Day", completed: 5),
    Workout(name: "Leg Day", completed: 2)
]

var CURRENT_EXCERCISE    = 0
var EXCERCISES_SKIPPED   = 0
var EXCERCISES_COMPLETED = 0
let TOTAL_EXCERCISES     = 5
