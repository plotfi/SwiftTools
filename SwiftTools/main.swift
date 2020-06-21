//
//  main.swift
//  SwiftTools
//
//  Created by Puyan Lotfi on 6/16/20.
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//

import Foundation

print("Hello, World!")

let envTask = Process()
envTask.executableURL = URL(fileURLWithPath: "/usr/bin/env")
let envOutputPipe = Pipe()
let envErrorPipe = Pipe()
envTask.standardOutput = envOutputPipe
envTask.standardError = envErrorPipe
try envTask.run()

print("ENV:")
let envOutputData = envOutputPipe.fileHandleForReading.readDataToEndOfFile()
let envOutput = String(decoding: envOutputData, as: UTF8.self)
let envOutputByLine = envOutput.split(separator: "\n")
for line in envOutputByLine {
    if line.starts(with: "PATH") {
        print("PATHPATHPATH")
        print(line)
    }
}

while true {
    print("> ", terminator: "")
    let cmdOpt = readLine(strippingNewline: true)
    if cmdOpt == nil {
        continue;
    }
    
    var cmd = cmdOpt!
    cmd = cmd.trimmingCharacters(in: NSCharacterSet.whitespaces)

    switch cmd {
    case "":
        continue
    default:
        break
    }
    
    if cmd == "exit" {
        break
    }
    
    let task = Process()
    task.executableURL = URL(fileURLWithPath: cmd)
    
    do {
        try task.run()
    } catch CocoaError.fileNoSuchFile {
        print("Bad command or file name")
    }
    
    task.waitUntilExit()
}

print("Goodbye, World!")
