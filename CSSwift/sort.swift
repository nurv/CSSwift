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
    if (array.count == 0){
        return
    }
    
    for i in 1..<array.count{
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


// Heap Sort
// Best: O(n log n), Avg: O(n log n), Worst: O(n log n)
func heapsort<T: Comparable> (inout array:[T]){
    buildHeap(&array)
    for var i = array.count - 1; i >= 1; i-- {
        swap(&array[0], &array[i])
        heapify(&array, 0, i)
    }
    
}

func buildHeap<T: Comparable>(inout array:[T]){
    for var i = Int(floor(Double(array.count) / 2.0)) - 1; i >= 0; i-- {
        heapify(&array, i, array.count)
    }
}

func heapify<T: Comparable>(inout array:[T],idx:Int, max:Int){
    println(array)
    var left = 2*idx + 1
    var right = 2*idx + 2
    var largest: Int
    if left < max && array[left] > array[idx] {
        largest = left
    }else{
        largest = idx
    }
    
    if right < max && array[right] > array[largest] {
        largest = right
    }
    
    if largest != idx{
        swap(&array[idx], &array[largest])
        heapify(&array, largest, max)
    }
}

// Counting Sort
// Best: O(n), Avg: O(n), Worst O(n)
func countingSort (inout array:[Int], max:Int){
    var buckets = [Int](count:max, repeatedValue:0)

    for var i = 0; i<array.count; i++ {
        buckets[array[i]]++
    }
    
    var idx=0
    for var i = 0; i<max; i++ {
        while buckets[i] > 0{
            array[idx++] = i
            buckets[i]--
        }
    }
}

// Bucket Sort
// Best: O(n), Avg: O(n), Worst: O(n)
func bucketSort<T: Comparable> (inout array:[T], hashfunc:(T) -> Int){
    var buckets = [[T]](count:array.count, repeatedValue:[])
    
    for i in 0..<array.count{
        buckets[i] = [T]()
    }
    
    for i in 0..<array.count{
        var k = hashfunc(array[i])
        
        buckets[k].append(array[i])
    }
    
    extract(buckets, &array)
}

func extract<T: Comparable> (buckets: [[T]], inout array:[T]){
    var idx = 0
    for i in 0..<buckets.count {
        var b : [T] = buckets[i]
        insertSort(&b)
        for k in b{
            array[idx] = k
            idx++
        }
    }
}