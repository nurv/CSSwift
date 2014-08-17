//
//  sort.swift
//  CSSwift
//
//  Created by Artur Ventura on 13/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation


// Insertion Sort
// Best: O(n), Avg: O(n^2), Worst: O(n^2)
func insertSort<T: Comparable> (inout array:[T]){
    for i in 1...array.count-1{
        println(array)
        insertInsert(&array, i, array[i]);
    }
}

func insertInsert<T: Comparable> (inout array:[T], pos:Int, value:T){
    var i = pos - 1
    
    while i >= 0 && array[i] > value {
        array[i + 1] = array[i]
        i = i - 1
    }
    
    array[i + 1] = value
}

// QuickSort
// Best: O(n log n), Avg: O(n log n), Worst: O(n^2)
func quickSort<T: Comparable> (inout array:[T]){
    qsort2(&array, 0, array.count - 1)
}

func qsort2<T: Comparable> (inout array:[T], left:Int, right:Int){
    if left < right {
        var pi = qpartition(&array, left,right)
        qsort2(&array, left, pi - 1)
        qsort2(&array, pi + 1, right)
    }
}

func qpartition<T: Comparable> (inout array:[T], left:Int, right:Int) -> Int{
    println(array)
    // number between left and right
    // using random pivot
    var p = Int(rand()) % ( right - left) + left
    
    // swap values
    swap(&array[right], &array[p])
    var store = left
    for i in left...right - 1 {
        if array[i] <= array[right]{
            swap(&array[i], &array[store])
            store++
        }
    }
    swap(&array[store], &array[right])
    return store
}

