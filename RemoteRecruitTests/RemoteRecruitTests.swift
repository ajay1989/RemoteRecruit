//
//  RemoteRecruitTests.swift
//  RemoteRecruitTests
//
//  Created by Ajay Vyas on 05/06/26.
//

import Testing
@testable import RemoteRecruit

struct RemoteRecruitTests {
    
    @Test func stripsHTMLTags() {
        let html = "<p>Hello <b>World</b></p>"
        #expect(html.strippedHTML == "Hello World")
    }
    
    @Test func plainTextUnchanged() {
        let text = "No HTML here"
        #expect(text.strippedHTML == "No HTML here")
    }
}
