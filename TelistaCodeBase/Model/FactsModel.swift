//
//  FactsModel.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import Foundation

class FactsModel: Codable {
    let title: String?
    var rows: [Row]?
    
    init(title: String?, rows: [Row]?) {
        self.title = title
        self.rows = rows
    }
}

class Row: Codable {
    let title, description, imageHref: String?
    
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}

// MARK: Convenience initializers and mutators

extension FactsModel {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(FactsModel.self, from: data)
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
    
    func with(
        title: String?? = nil,
        rows: [Row]?? = nil
        ) -> FactsModel {
        return FactsModel(
            title: title ?? self.title,
            rows: rows ?? self.rows
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Row {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Row.self, from: data)
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
    
    func with(
        title: String?? = nil,
        description: String?? = nil,
        imageHref: String?? = nil
        ) -> Row {
        return Row(
            title: title ?? self.title,
            description: description ?? self.description,
            imageHref: imageHref ?? self.imageHref
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
