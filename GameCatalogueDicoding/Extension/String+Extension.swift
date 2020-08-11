//
//  NSAttributeString+Extension.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 11/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

extension String {
    
    public func convertHtmlToAttributedStringWithCSS(color: UIColor) -> NSAttributedString? {
        
        let modifiedString = "<style>body{color: \(color.toHexString());}</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
