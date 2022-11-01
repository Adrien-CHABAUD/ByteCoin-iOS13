//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "API-KEY-HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        // Create URL
        if let url = URL(string: urlString){
            // Create Session
            let session = URLSession(configuration: .default)
            
            // Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    // Exit
                    return
                }
                
                if let safeData = data {
                    let bitCoinParse = self.parseJSON(safeData)
                }
                
            }
            // Start task
            task.resume()
            
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            // Try decoding the data using the coinData structure
            let decodedData = try decoder.decode(CoinData.self, from: data)
            
            // Get the last property of the decoded data
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            // Catch & print errors
            print(error)
            return nil
        }
    }
}
