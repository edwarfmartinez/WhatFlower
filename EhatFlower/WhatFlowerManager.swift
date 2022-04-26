//
//  WhatFlowerManager.swift
//  EhatFlower
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 18/03/22.
//

import Foundation

protocol WhatFlowerManagerDelegate {
    
    func didUpdateWhatFlower(_ whatFlowerManager: WhatFlowerManager, whatFlower: WhatFlowerModel)
    
    func didFailWithError(error: Error)
}


struct WhatFlowerManager {
    
    var delegate: WhatFlowerManagerDelegate?
    let wikiURL = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=rose&indexpageids&redirects=1"
    
    func getDescription() {
        
        performRequest(with: wikiURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let whatFlower = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWhatFlower(self, whatFlower: whatFlower)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ whatFlowerData: Data) -> WhatFlowerModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WhatFlowerData.self, from: whatFlowerData)

            //let pageId = decodedData.query.pages
          //  let extract = decodedData.query.pages.l26537.extract
//            let temp = decodedData.main.temp
//            let name = decodedData.name

            let whatFlower = WhatFlowerModel(extract: "")

          //  print(extract)
            return whatFlower



        } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}
