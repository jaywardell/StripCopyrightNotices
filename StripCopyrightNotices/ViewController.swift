//
//  ViewController.swift
//  StripCopyrightNotices
//
//  Created by Joseph A. Wardell on 5/15/20.
//

import Cocoa

class ViewController: MultipleFileSelectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Yes, we could probably add c and objective-c types here.
        // I just haven't tested it with them...
        self.filetypes = [String(kUTTypeSwiftSource)]
    }
    
    override func awakeFromNib() {
        view.window?.title = "Strip Copyright Notices"
    }
    
    @IBAction
    override func operateOnFiles(_ sender: Any) {
        chosenFiles.forEach {
            CopyrightNoticesStripper($0).stripCopyrightNotices()
        }
        operateOnFilesButton.isEnabled = false
    }

}
