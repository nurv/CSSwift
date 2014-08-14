//
//  main.swift
//  CSSwift
//
//  Created by Artur Ventura on 13/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation

// var test = [15, 9, 8, 1, 4 ,11 , 7, 12, 13, 6, 5, 3, 16, 2, 10, 14]
// insertSort(&test, { $0 > $1 })
// println(test)

var test = [15, 9, 8, 1, 4 ,11 , 7, 12, 13, 6, 5, 3, 16, 2, 10, 14]
quickSort(&test, { $0 <= $1 })
println(test)