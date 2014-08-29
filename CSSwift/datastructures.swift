//
//  datastructures.swift
//  CSSwift
//
//  Created by Artur Ventura on 14/08/14.
//  Copyright (c) 2014 Artur Ventura. All rights reserved.
//

import Foundation
// LinkedList
// Delete/Insert: Best: O(1)
//                Worst: O(n)


// SwiftC has a problem that goes SegFault on Recursive data structures.
// I'm gonna use a lisp approach to implment a LinkedList

class Cons{
    var car:Any? = nil;
    var cdr:Any? = nil;
}

class LinkedListNode<T: Any> : Cons, Printable{
    func add (index: Int, object: T){
        if index == 1 {
            var n = LinkedListNode()
            n.car = object
            n.cdr = self.cdr
            self.cdr = n
        }else{
            if cdr is LinkedListNode{
                if let rest = cdr as? LinkedListNode{
                    rest.add(index-1, object: object)
                }
            }else if cdr == nil{
                assert(false, "Access out of bound")
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }
    }
    
    func remove (index: Int){
        if index == 1 {
            if let z = cdr{
                if let rest = z as? LinkedListNode{
                    self.cdr = rest.cdr
                }
            }
        }else{
            if cdr is LinkedListNode{
                if let rest = cdr as? LinkedListNode{
                    rest.remove(index-1)
                }
            }else if cdr == nil{
                assert(false, "Access out of bound")
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }
    }
    
    func get(index: Int) -> Any? {
        if index == 0 {
            return car
        }else if index > 0 && cdr == nil{
            assert(false, "Index out of range")
        }else{
            if cdr is LinkedListNode{
                if let rest = cdr as? LinkedListNode{
                    return rest.get(index-1)
                }
            }else if cdr == nil{
                assert(false, "Access out of bound")
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }
        return nil
    }
    
    func set(index: Int, object:T) {
        if index == 0 {
            car = object
        }else if index > 0 && cdr == nil{
            assert(false, "Index out of range")
        }else{
            if cdr is LinkedListNode{
                if let rest = cdr as? LinkedListNode{
                    rest.set(index-1, object: object)
                }
            }else if cdr == nil{
                assert(false, "Access out of bound")
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }
        
    }
    
    private func getValues() -> String{
        
        if car == nil {
            if cdr == nil {
                return ""
            }else{
                return "nil . \(cdr!)"
            }
        }else{
            var result = "\(car!)"
            if let x = cdr{
                if let rest = x as? LinkedListNode {
                    result += " " + rest.getValues()
                }else{
                    result += " . \(cdr!)"
                }
            }
            return result
        }
    }
    
    var description: String{
        return "(" + getValues() + ")"
    }
    
    func toString() -> String{
        return "(" + getValues() + ")"
    }
}

struct LinkedList<T:Any> : Printable{
    var list:LinkedListNode<T>? = nil
    
    mutating func add(index: Int, object: T){
        if index == 0{
            var l = LinkedListNode<T>()
            l.car = object
            l.cdr = self.list
            self.list = l
        }else{
            self.list?.add(index, object: object)
        }
    }
    
    mutating func remove(index: Int){
        if index == 0{
            if let z = self.list{
                if let obj = z.cdr{
                    if let obj = z.cdr as? LinkedListNode<T>{
                        self.list = obj
                    }
                }else{
                    self.list = nil
                }
            }
        }else{
            if let z = list{
                z.remove(index)
            }
        }
    }
    
    
    var description: String{
        if let z = list{
            return z.description
        }else{
            return "()"
            }
    }
    
    func toString() -> String{
        if let z = list{
            return z.description
        }else{
            return "()"
        }
        
    }
    
    func get(index: Int) -> Any?{
        if let l = self.list{
            return l.get(index)
        }else{
            return nil
        }
    }
    
    func set(index: Int, object: T){
        if let l = self.list{
            l.set(index, object:object)
        }
    }
}

struct HashTable<T:Any>{
    var array:Array<LinkedList<T>?>?
    var hash:(T) -> Int;
    
    init(hashSize:Int, hash: (T) -> Int){
        array = Array<LinkedList<T>?>(count: hashSize, repeatedValue: nil)
        self.hash = hash
    }
}


//// Binary Heap
//// Insert: O(log n), Delete: O(log n),
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


