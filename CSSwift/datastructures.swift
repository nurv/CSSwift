//
//  datastructures.swift
//  CSSwift
//
//  Created by Artur Ventura on 14/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation

// Binary Heap
// Insert: O(log n), Delete: O(log n),
class BinaryHeap<T: Comparable> : Printable{
    var heap = [T]();
    
    init(){
    }
    
    init(heap:[T]){
        self.heap = [T](heap)
    }

    func parent(node:Int) -> Int{
        return Int(node/2)
    }
    
    func right(node:Int) -> Int{
        return 2*node
    }
    
    func left(node:Int) -> Int{
        return 2*node + 1
    }
    
    func at(node:Int) -> T{
        return self.heap[node - 1]
    }
    
    func heapify(node:Int){
        var l = 2*node + 1
        var r = 2*node + 2
        var largest : Int;
        
        if l <= heap.count && heap[l] > heap[node] {
            largest = l
        }else{
            largest = node
        }
        
        if r <= heap.count && heap[r] > heap[largest]{
            largest = r
        }
        
        if largest != node {
            // I don't know what the fuck is going on but
            // I can't use swap on a array location
            // swap(&self.heap[largest], &self.heap[node])
            
            var tmp = self.heap[largest]
            self.heap[largest] = self.heap[node ]
            self.heap[node] = tmp
            heapify(largest)
        }
    }
    
    var description: String{
        return "Heap:\(heap)"
    }
    
    func toString() -> String{
        return "Heap:\(heap)"
    }
}

// Linked List
struct LinkedList<T> : Printable{
    var car : T?
    var cdr : LinkedList?
    
    init(){
        self.car = nil
        self.cdr = nil
    }
    
    mutating func add (index: Int, object: T){
        if index == 0 {
            var n = LinkedList()
            n.car = self.car
            n.cdr = self.cdr
            self.car = object
            self.cdr = n
        } else if index == 1 {
            var n = LinkedList()
            n.car = object
            n.cdr = nil
            self.cdr = n
        }else{
            cdr?.add(index-1, object: object)
        }
    }

    subscript(index: Int) -> T? {
        get {
            if index == 0 {
                return car
            }else if index > 0 && cdr == nil{
                assert(false, "Index out of range")
            }else{
                return cdr![index - 1]
            }
        }
        set(newValue) {
            if index == 0 {
                car = newValue
            }else if index > 0 && cdr == nil{
                assert(false, "Index out of range")
            }else{
                cdr![index - 1] = newValue
            }
        }
    }
    
    private func getValues() -> String{
        var result = "\(car)"
        if cdr != nil{
            result += ", " + cdr!.getValues()
        }
        return result
    }
    
    var description: String{
        return "LinkedList:[" + getValues() + "]"
    }
    
    func toString() -> String{
        return "LinkedList:[" + getValues() + "]"
    }
}

