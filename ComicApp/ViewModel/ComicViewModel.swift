//
//  ComicViewModel.swift
//  ComicApp
//
//  Created by Anitha Selvarajan on 9/11/22.
//

import Foundation
import CommonCrypto

class ComicViewModel {
    
    var comicArray = [Result]()
    
    static let publicKey = "4053b06896b8a2897910d6474d40e1dc"
    static let privateKey = "15e32fb05d6ee264c7ba5233c516fe2ad5d9f2ab"
    
    enum Endpoint {
        static let base = "https://gateway.marvel.com:443/v1/public/comics/200"
        static let apiKeyParam = "?apikey=\(publicKey)"
        
        case comicApi
        
        var stringValue:String {
            switch self {
            case .comicApi:
                return Endpoint.base + Endpoint.apiKeyParam + hashParam
            }
        }
        
        var hashParam: String {
            let timestamp = Date().currentTimeInMillis()
            return "&ts=\(timestamp)&hash=" + ("\(timestamp)\(privateKey)\(publicKey)".md5Value)
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    func getData(completion: @escaping () -> Void) {
        
        print("url: " + Endpoint.comicApi.stringValue)
        
        let task = URLSession.shared.dataTask(with: Endpoint.comicApi.url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Comic.self, from: data)
                let arr = res.data?.results
                self.comicArray = (res.data?.results)!
                DispatchQueue.main.async {
                    completion()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}

extension String {
    var md5Value: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                
                return ""
            }
        }
        
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}

