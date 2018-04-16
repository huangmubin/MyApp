//
//  Json_Protocol.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol Json_Protocol: class, Codable { }
extension Json_Protocol {
    func json() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
extension Json_Protocol {
    static func json<T: Json_Protocol>(_ json: Data?) -> T? {
        if let data = json {
            let decoder = JSONDecoder()
            let object = try? decoder.decode(T.self, from: data)
            return object
        }
        return nil
    }
}
