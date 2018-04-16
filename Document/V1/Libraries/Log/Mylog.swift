//
//  Mylog.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

func print_f(file: String = #file, text: String) {
    print("\(file.components(separatedBy: "/").last ?? ""): \(text)")
}
