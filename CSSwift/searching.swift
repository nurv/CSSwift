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


func loadTable<T: Comparable>(size:Int, C:[T], hash: (T)->Int) -> [LinkedList<T>]{
    var array = [LinkedList<T>]()
    
    
    for(var i=0; i<size; i++){
        array += [LinkedList<T>]()
    }
    
    for(var i = 0; i<C.count-1; i++){
        var h = hash(C[i])

        array[h].add(array[h].count, object: C[i])
    }
    
    return array
}

func hashBasedSearch<T: Comparable>(A:[LinkedList<T>], t:T, hash: (T)->Int)->Bool{
    var h = hash(t)
    var list = A[h]

    if (list.count == 0){
        return false;
    }else if(list.find(){
        
    }
}
