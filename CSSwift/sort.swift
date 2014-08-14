//
//  sort.swift
//  CSSwift
//
//  Created by Artur Ventura on 13/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation


// Insertion Sort

func insertSort<T> (inout array:[T], xMoreThanY:(x: T, y: T) -> Bool){
    for i in 1...array.count-1{
        println(array)
        insertInsert(&array, i, array[i], xMoreThanY);
    }
}

func insertInsert<T> (inout array:[T], pos:Int, value:T, xMoreThanY:(x: T, y: T) -> Bool){
    var i = pos - 1
    
    while i >= 0 && xMoreThanY(x: array[i], y: value) {
        array[i + 1] = array[i]
        i = i - 1
    }
    
    array[i + 1] = value
}

// QuickSort

func quickSort<T> (inout array:[T], cmp:(x: T, y: T) -> Bool){
    qsort2(&array, 0, array.count - 1, cmp)
}

func qsort2<T> (inout array:[T], left:Int, right:Int, cmp:(x: T, y: T) -> Bool){
    if left < right {
        var pi = qpartition(&array, left,right, cmp)
        qsort2(&array, left, pi - 1,cmp)
        qsort2(&array, pi + 1, right,cmp)
    }
}

func qpartition<T> (inout array:[T], left:Int, right:Int, cmp:(x: T, y: T) -> Bool) -> Int{
    println(array)
    // number between left and right
    // using random pivot
    var p = Int(rand()) % ( right - left) + left
    
    // swap values
    swap(&array[right], &array[p])
    var store = left
    for i in left...right - 1 {
        if cmp(x: array[i], y: array[right]){
            swap(&array[i], &array[store])
            store++
        }
    }
    swap(&array[store], &array[right])
    return store
}

