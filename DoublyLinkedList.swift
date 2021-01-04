//
//  DoublyLinkedList.swift
//  TDDDemo
//
//  Created by B0203948 on 29/12/20.
//

import Foundation

final class DoublyLinkedList<T> {
    final class Node<T> {
        var payload: T
        var next: Node<T>?
        var previous: Node<T>?
        init(payload: T) { self.payload = payload }
    }
    var head: Node<T>?
    var tail: Node<T>?
    private(set) var count = 0
    func addHead(payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }
        guard let headValue = head else {
            head = node
            tail = node
            return node
        }
        head?.previous =  node
        node.previous = nil
        node.next = head
        return headValue
    }
    func moveToHead(node: Node<T>) {
        if node === head {
            return
        }
        let previous = node.previous
        let next = node.next
        
        previous?.next = next
        next?.previous = previous
        
        node.next = head
        node.previous = nil
        
        if node === tail {
            tail = previous
        }
        self.head = node
    }
    
    func removeLast() -> Node<T>? {
        guard let tail = self.tail else {
            head = nil
            return nil
        }
        
        let previous = tail.previous
        previous?.next = nil
        self.tail = previous
        
        if count == 1 {
            count = 0
            head = nil
        }
        
        count -= 1
        return tail
    }
}


