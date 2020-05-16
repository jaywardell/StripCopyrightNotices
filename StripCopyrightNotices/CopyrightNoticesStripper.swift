//
//  StripCopyrightNotices
//
//  Created by Joseph A. Wardell on 5/15/20.
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
        guard let contents = try? String(contentsOf: fileURL) else { return }
        
        let lines = contents.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false)
        let newLines = lines.filter { !$0.hasPrefix("//  Copyright")}
        let newSource = newLines.joined(separator: "\n")
        try! newSource.write(to: file, atomically: true, encoding: .utf8)
    }
}
