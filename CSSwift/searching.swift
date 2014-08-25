//
//  searching.swift
//  CSSwift
//
//  Created by Artur Ventura on 19/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation


// Sequential Search
// Best: O(1), Avg: O(n), Worst: O(n)
func sequentialSearch<T: Equatable> (array:[T], object:T) -> Bool{
    for i in array{
        if i == object{
            return true
        }
    }
    return false;
}

func binarySearch<T: Comparable> (array:[T], object:T) -> Bool{
    var low = 0
    var high = array.count - 1
    
    while low <= high {
        println(array[low...high])
        var ix = (low + high) / 2
        
        if object == array[ix] {
            return true
        } else if object < array[ix] {
            high = ix - 1
        } else {
            low = ix + 1
        }
    }
    return false
}

