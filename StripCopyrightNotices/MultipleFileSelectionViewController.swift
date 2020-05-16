//
//  ViewController.swift
//  StripCopyrightNotices
//
//  Created by Joseph A. Wardell on 5/15/20.
//  Copyright © 2020 Joseph A. Wardell. All rights reserved.
//

import Cocoa

/// Use this view controller to choose many files that can then be operated on
/// by a single button action
class MultipleFileSelectionViewController: NSViewController {

    @IBOutlet var chosenFileLabel: NSTextField!
    @IBOutlet var operateOnFilesButton: NSButton! {
        didSet {
            operateOnFilesButton.action = #selector(operateOnFiles)
            operateOnFilesButton.target = self
        }
    }

    var filetypes : [String] = []
    
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
        }
        chosenFileLabel.stringValue = chosenString
        operateOnFilesButton.isEnabled = !chosenFiles.isEmpty
    }
}

extension MultipleFileSelectionViewController {
    
    @IBAction func operateOnFiles(_ sender: Any) {
        print(#function)
        print("override this method with your own implementation")
    }

    @IBAction func chooseFiles(_ sender: Any) {
        guard let window = view.window else { return }
        
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = true
        openPanel.allowedFileTypes = [String(kUTTypeSwiftSource)]
        
        openPanel.beginSheetModal(for: window) { [weak self] in
            if $0 == .OK {
                self?.chosenFiles = openPanel.urls
            }
        }
    }
}
