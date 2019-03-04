//
//  Service.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/04.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(completion: @escaping ([Result], Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Faild tp fetch data", err)
                completion([], nil)
                return
            }

            guard let data = data else { return }

            do {
                let searchResult = try
                JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            }
            catch let jsonErr {
                print("Faild to decode json", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
    
}
