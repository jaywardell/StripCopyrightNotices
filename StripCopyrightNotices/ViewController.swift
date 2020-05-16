//
//  ViewController.swift
//  StripCopyrightNotices
//
//  Created by Joseph A. Wardell on 5/15/20.
//  Copyright © 2020 Joseph A. Wardell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var chosenFileLabel: NSTextField!
    @IBOutlet var stripNoticesButton: NSButton!
    
    var chosenFiles =  [URL]() {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear() {
        super.viewDidAppear()
                
        updateUI()
    }
    
    private func updateUI() {
        
        var chosenString = ""
        if !chosenFiles.isEmpty {
            let shortest = chosenFiles.sorted(by: {
                $0.pathComponents.count < $1.pathComponents.count
            }).first!
            
            chosenString = shortest.deletingLastPathComponent().path +
                "\n\n" +
                chosenFiles.map {
                    let pathCount = $0.pathComponents.count - shortest.pathComponents.count + 1
                    
                    return $0.pathComponents.suffix(pathCount).joined(separator: "/")
                    
                    }.sorted().joined(separator: "\n")
            
            print(chosenString)
        }
        chosenFileLabel.stringValue = chosenString
        stripNoticesButton.isEnabled = !chosenFiles.isEmpty
    }
}

extension ViewController {
    
    @IBAction func stripCopyrightNotices(_ sender: Any) {
        chosenFiles.forEach {
            CopyrightNoticesStripper($0).stripCopyrightNotices()
        }
        stripNoticesButton.isEnabled = false
    }

    @IBAction func chooseFiles(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = true
        openPanel.allowedFileTypes = [String(kUTTypeSwiftSource)]
        
        openPanel.beginSheetModal(for: view.window!) { [weak self] in
            if $0 == .OK {
                self?.chosenFiles = openPanel.urls
            }
        }
    }
}
