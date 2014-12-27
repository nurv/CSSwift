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

class Cons<T:Any>{
    var car:T? = nil;
    var cdr:Any? = nil;
}

class LinkedListNode<T: Any> : Cons<T>, Printable{
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
    
    func size() -> Int{
        if let x = cdr{
            if let rest = cdr as? LinkedListNode{
                return rest.size() + 1
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }else{
            return 1
        }
    }
    
    func find(object: T, cmp:(T,T) -> Bool) -> Bool{
        if let obj = car{
            if (cmp(obj, object)){
                return true
            }
            
            if let rest = cdr{
                if let rest = cdr as? LinkedListNode{
                    return rest.find(object , cmp)
                }else{
                    assert(false, "LinkedList rest is foreign")
                }
            }else{
                return false;
            }
        }else if let rest = cdr{
            if let rest = cdr as? LinkedListNode{
                return rest.find(object , cmp)
            }else{
                assert(false, "LinkedList rest is foreign")
            }
        }else{
            return false;
        }
    }

    func next() -> Any?{
        return cdr
    }
    
}

struct LinkedList<T:Any> : Printable{
    var list:LinkedListNode<T>? = nil
    
    init(){
        
    }
    
    init(array: [T]){
        for o in array{
            self.push(o)
        }
    }
    
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
    
    mutating func push(newElement: T){
        add(0, object: newElement);
    }
    
    mutating func pop() -> Any{
        var result = get(0)
        remove(0)
        return result
    }
    
    var description: String{
        if let z = list{
            return z.description
        }else{
            return "()"
        }
    }
    
    var count: Int{
        if let x = list{
            return x.size()
        }else{
            return 0
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
    
    func find<K: Equatable>(object: K) -> Bool{
        if let l = list{
            var it = l
            for ; ;{
                if let r = it.car as? K{
                    if r == object{
                        return true;
                    }
                    if let z = it.cdr{
                        it = it.next() as LinkedListNode
                    }else{
                        break;
                    }
                }
            }
            return false;
        }else{
            return false;
        }
    }
    
    var length : Int{
        get {
            if let l = list{
                var result = 1
                var it = l
                for ; ;{
                    if let z = it.cdr{
                        result += 1
                        it = it.next() as LinkedListNode
                    }else{
                        return result;
                    }
                }
            }else{
                return 0;
            }
        }
    }
}

struct HashTable<T:Any>{
    var array = [LinkedList<T>]()
    var hash:(T) -> Int;
    
    init(hashSize:Int, hash: (T) -> Int){
        // this piece of code makes me feel
        // http://littlefun.org/uploads/520be02ac856117033000007_736.jpg
        for(var i=0; i<hashSize; i++){
            array += [LinkedList<T>]()
        }
        self.hash = hash
    }
    
    mutating func add(obj:T){
        array[hash(obj)].add(0, object: obj)
    }
    
    func contains(obj:T){
        
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

struct StackNode<T :Any>{
    var data: T? = nil
    var previous: Any? = nil
}

struct Stack<T: Any>{
    var stack : StackNode<T>? = nil
    var empty: Bool{
        get {
            return stack == nil;
        }
    }
    
    mutating func push(object: T){
        var stack = StackNode<T>()
        
        stack.data = object
        stack.previous = self.stack
        self.stack = stack
    }
    
    mutating func pop() -> T?{
        if var node = stack{
            var data = node.data
            stack = node.previous as? StackNode
            
            return data
        }else{
            return nil
        }
    }
    
    func peek() -> T?{
        if var node = stack{
            return node.data
        }else{
            return nil
        }
    }
}

class QueueNode<T: Any>{
    var data: T? = nil
    var previous: AnyObject? = nil
}

struct Queue<T: Any> {
    var first: QueueNode<T>? = nil
    var last: QueueNode<T>? = nil
    
    var empty:Bool{
        get{
            return first == nil && last == nil;
        }
    }
    
    mutating func enqueue(object:T){
        if(empty){
            first = QueueNode<T>()
            last = first
            first?.data = object
        }else{
            var newNode = QueueNode<T>()
            newNode.data = object
            first?.previous = newNode
            first = newNode
        }
    }
    
    mutating func dequeue() -> T?{
        if (!empty){
            var result = last?.data

            
            if first! === last!{
                first = nil
                last = nil
            }else{
                last = last?.previous as? QueueNode<T>
            }
            
            return result
        }else{
            return nil
        }
    }
    
    func peek() -> T?{
        if (empty){
            return nil
        }else{
            return last?.data
        }
    }
}

struct BinarySearchTree<T: Comparable> {
    var data : T? = nil;
    var left : Any? = nil;
    var right : Any? = nil;
    
    
    func find(object:T) -> BinarySearchTree<T>?{
        var currenNode : BinarySearchTree<T>? = self
        while currenNode != nil{
            if let node = currenNode{
                if node.data == object{
                    return node
                }else if(object < node.data){
                    currenNode = node.left as? BinarySearchTree
                }else{
                    currenNode = node.right as? BinarySearchTree
                }
            }
        }
        return nil
    }
    
    mutating func insert(object: T){
        var currentNode : BinarySearchTree<T>? = self
        while currentNode != nil{
            if var node = currentNode{
                if node.data == object{
                    return
                }
                if(object < node.data){
                    if node.left == nil{
                        var t = BinarySearchTree<T>();
                        t.data = object
                        node.left = t
                        return
                    }else{
                        currentNode = node.left as? BinarySearchTree
                    }
                }else{
                    if node.right == nil{
                        var t = BinarySearchTree<T>();
                        t.data = object
                        node.right = t
                        return
                    }else{
                        currentNode = node.right as? BinarySearchTree
                    }
                }
            }
        }
    }
}




