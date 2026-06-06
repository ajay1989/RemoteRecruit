//
//  LRUCacheTests.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Testing
@testable import RemoteRecruit

struct LRUCacheTests {
    
    @Test func setAndGet() async {
        let cache = LRUCache<String, Int>(capacity: 3)
        await cache.set("a", value: 1)
        #expect(await cache.get("a") == 1)
    }
    
    @Test func cacheMissReturnsNil() async {
        let cache = LRUCache<String, Int>(capacity: 3)
        #expect(await cache.get("missing") == nil)
    }
    
    @Test func invalidateClearsCache() async {
        let cache = LRUCache<String, Int>(capacity: 3)
        await cache.set("a", value: 1)
        await cache.invalidate()
        #expect(await cache.get("a") == nil)
    }
    
    @Test func evictsLeastRecentlyUsed() async {
        let cache = LRUCache<String, Int>(capacity: 2)
        await cache.set("a", value: 1)
        await cache.set("b", value: 2)
        await cache.set("c", value: 3)
        #expect(await cache.get("a") == nil)
        #expect(await cache.get("b") == 2)
        #expect(await cache.get("c") == 3)
    }
}
