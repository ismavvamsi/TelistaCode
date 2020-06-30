//
//  ListModel.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import Foundation

class ListModel: Codable {
    let title: String?
    var rows: [RowData]?
    
    init(title: String?, rows: [RowData]?) {
        self.title = title
        self.rows = rows
    }
}

class RowData: Codable {
    let title, description, imageHref: String?
    
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}

// MARK: Convenience initializers and mutators

extension ListModel {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(ListModel.self, from: data)
        self.init(title: me.title, rows: me.rows)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    public func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension RowData {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(RowData.self, from: data)
        self.init(title: me.title, description: me.description, imageHref: me.imageHref)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    public func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
