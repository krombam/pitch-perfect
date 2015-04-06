//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Krom Caparros on 4/4/15.
//  Copyright (c) 2015 ATT. All rights reserved.
//

import Foundation



class RecordedAudio: NSObject{
    
    
    var filePathUrl: NSURL!
    var title: String!
    
    
    init(filePathUrl:NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
        
        
    }
}
