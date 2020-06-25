//
//  cat.swift
//  SwiftTools
//
//  Created by Puyan Lotfi on 6/25/20.
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//

import Foundation

func catCmdlet(dir: String, args: [Substring]) {
    let fm = FileManager.default

    let path = dir + "/" + args[1]

    if !fm.isReadableFile(atPath: path) {
        print("Bad file or permissions")
        return
    }

    if !fm.fileExists(atPath: path) {
        print("File \(path) does not exist")
        return
    }

    do {
        let contents = try String(contentsOfFile: path)
        print(contents)
    } catch {
        print("Bad file or permissions")
    }
}
