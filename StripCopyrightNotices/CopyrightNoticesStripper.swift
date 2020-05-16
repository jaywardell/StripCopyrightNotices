//
//  CopyrightNoticesStripper.swift
//  StripCopyrightNotices
//
//  Created by Joseph A. Wardell on 5/15/20.
//  Copyright © 2020 Joseph A. Wardell. All rights reserved.
//

import Foundation


struct CopyrightNoticesStripper {
    
    let fileURL : URL
    
    init(_ fileURL:URL) {
        assert(fileURL.isFileURL)
        
        self.fileURL = fileURL
    }
    
    func stripCopyrightNotices() {
          
        stripCopyrightNotices(from: fileURL)
    }
    
    
    func stripCopyrightNotices(from file:URL) {
        print(#function)
        
        let contents = try! String(contentsOf: fileURL)
        
        let lines = contents.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false)
        let newLines = lines.filter { !$0.hasPrefix("//  Copyright")}
        let newSource = newLines.joined(separator: "\n")
        try! newSource.write(to: file, atomically: true, encoding: .utf8)
    }
}
