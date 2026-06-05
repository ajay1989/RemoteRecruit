//
//  LRUCache.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

// Generic LRU cache, evicts least recently used entry when capacity is reached
actor LRUCache<Key: Hashable, Value> {
    
    private let capacity: Int
    private var cache: [Key: Value] = [:]
    private var order: [Key] = []
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Key) -> Value? {
        guard let value = cache[key] else { return nil }
        updateOrder(for: key)
        return value
    }
    
    func set(_ key: Key, value: Value) {
        if cache[key] != nil {
            updateOrder(for: key)
        } else {
            // Remove oldest entry before inserting new one
            if cache.count >= capacity, let oldest = order.first {
                cache.removeValue(forKey: oldest)
                order.removeFirst()
            }
            order.append(key)
        }
        cache[key] = value
    }
    
    func invalidate() {
        cache.removeAll()
        order.removeAll()
    }
    
    private func updateOrder(for key: Key) {
        order.removeAll { $0 == key }
        order.append(key)
    }
}
