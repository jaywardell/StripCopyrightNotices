## StripCopyrightNotices

This is a little tool that lets you choose a set of swift files and then strip the copyright notice from each of them, made in AppKit.

It's here as an example of how to select and operate on multiple files in a simple UI

You can use this as a template for other simple tools. Just change the code in the  operateOnFiles(_:) method and change the allowed types in ViewController.swift

![screenshot](https://github.com/jaywardell/StripCopyrightNotices/blob/master/Screenshots/screenshot2.png)

It came about because I wanted to strip the copyright notices from another project before posting it to github.  What should have been a 10 minute coding session to write the copyright-stripping code became more complex due to the sandbox and Catalina's permissions system.  The copyright-stripping code is trivial, but the scaffolding of the MultipleFileSelectionViewController may come in handy to someone else.

## Contact

twitter:  [@jaywardell](https://twitter.com/jaywardell)

