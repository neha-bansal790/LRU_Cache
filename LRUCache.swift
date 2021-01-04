//
//  LRUCache.swift
//  TDDDemo
//
//  Created by B0203948 on 29/12/20.
//

import Foundation

typealias DoublyLinkedListNode<T> = DoublyLinkedList<T>.Node<T>
final class LRUCache<Key: Hashable, Value> {
    private struct CachePayload {
        let key: Key
        let value: Value
    }
    private var capacity: Int = 0
    private let linkedList = DoublyLinkedList<CachePayload>()
    private var cacheMap = [Key : DoublyLinkedListNode<CachePayload>]()
    init(capacity: Int) { self.capacity = max(0, capacity) }
    func setValue(value: Value, for key: Key) {
        let payload = CachePayload(key: key, value: value)
        if let map = cacheMap[key] {
            map.payload = payload
            let _ = linkedList.moveToHead(node: map)
        } else {
            let node = linkedList.addHead(payload: payload)
            cacheMap[key] = node
        }
        removeLastIfCapacityFull()
    }
    func removeLastIfCapacityFull() {
        if linkedList.count > capacity {
            let node = linkedList.removeLast()
            if let key = node?.payload.key {
                cacheMap[key] = nil
            }
        }
    }
    func getValue(for key: Key) -> Value? {
        if let node = cacheMap[key] {
            let _ = linkedList.moveToHead(node: node)
            return node.payload.value
        }
       return nil
    }
}
