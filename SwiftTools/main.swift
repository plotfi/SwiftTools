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

var ENV = [String: String]()
for line in envOutputByLine {
    let envEntry = line.split(separator: "=")
    let name = envEntry[0]
    let value = envEntry[1]
    ENV[String(name)] = String(value)
}

var PATH = [String: String]()

if let path = ENV["PATH"] {
    print("HAS PATH!!")
    for dir in path.split(separator: ":").reversed() {
        let fm = FileManager.default
        
        do {
            let items = try fm.contentsOfDirectory(atPath: String(dir))
            for item in items {
                PATH[item] = Substring(dir) + "/" + item
                // print("Entry: " + item + " : " + PATH[item]!)
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
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

    if !FileManager.default.fileExists(atPath: cmd) {
        if let pathCmd = PATH[cmd] {
            cmd = pathCmd
        }
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
