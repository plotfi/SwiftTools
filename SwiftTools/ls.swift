//
//  ls.swift
//  SwiftTools
//
//  Created by Puyan Lotfi on 6/25/20.
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//

import Foundation

func lsCmdlet(dir: String, args: [Substring]) {
    let fm = FileManager.default

    do {
        let items = try fm.contentsOfDirectory(atPath: dir)

        for item in items {
            print("\(item)")
        }
    } catch {
        print("Bad directory or permissions")
    }
}
