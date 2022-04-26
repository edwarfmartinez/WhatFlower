//
//  WhatFlowerData.swift
//  EhatFlower
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 18/03/22.
//

import Foundation


struct WhatFlowerData:Codable{
    
    let query: Query
//    let pageids: [PageIds]
//    let pages: Pages
}

struct Query:Codable {
    let pageids:[PageIds]
    let pages: Pages
}

struct PageIds:Codable{
    let pageid: String
}

struct Pages:Codable{
    let extract: String
}


