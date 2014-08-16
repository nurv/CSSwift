//
//  datastructures.swift
//  CSSwift
//
//  Created by Artur Ventura on 14/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation

// a heap protocol for all heap, operations should be equivalent
protocol Heap{
    typealias Element
    func parent(node:Int) -> Element
    func left(node:Int) -> Element
    func right(node:Int) -> Element
}

class BinaryHeap<T: Comparable> : Heap, Printable{
    var heap = [T]();

    func parent(node:Int) -> Int{
        return Int(node/2)
    }
    
    func right(node:Int) -> Int{
        return 2*node
    }
    
    func left(node:Int) -> Int{
        return 2*node + 1
    }
    
    func heapify(node:Int){
        var l = left(node)
        var r = right(node)
        var largest : Int;
        if l <= heap.count && heap[l] > heap[node] {
            largest = l
        }else{
            largest = node
        }
        
        if r <= heap.count && heap[r] > heap[largest]{
            largest = r
        }
        var array = [1,2,3,4,5]
        if largest != node {
            var tmp = self.heap[node]
            
            // I don't know what the fuck is going on but
            // I can't use swap on a array location
            var array = self.heap;
            swap(&array[largest], &array[node])
            heapify(largest)
        }
    }
    
    var description: String{
        return "\(heap)"
    }
    
    func toString() -> String{
        return "\(heap)"
    }
}