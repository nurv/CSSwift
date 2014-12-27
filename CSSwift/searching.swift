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

// Binary Search
// Best: O(1), Avg: O(log n), Worst: O(log n)
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

// Hash-based Search
// Best: O(1), Avg: O(1), Worst: O(n)
func loadTable<T: Comparable>(size:Int, C:[T], hash: (T)->Int) -> Array<LinkedList<T>?>{
    var array = Array<LinkedList<T>?>(count: size, repeatedValue: nil)
    
    for(var i = 0; i<C.count-1; i++){
        var h = hash(C[i])
        
        if array[h] == nil{
            array[h] = LinkedList<T>()
        }
        
        array[h]!.add(array[h]!.length, object: C[i]);
    }
    
    return array
}


func hashSearch<T: Comparable>(C:[T], hash: (T)->Int, object:T) -> Bool{
    var array = loadTable(C.count, C, hash)
    var h = hash(object)
    
    if let list = array[h]{
        return list.find(object)
    }else{
        return false
    }
}

