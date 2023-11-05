//
//  NetworkService.swift
//  m18_home
//
//  Created by Михаил Ганин on 18.04.2023.
//


import UIKit

class NetworkService {
    func featchRequest(urlString: String,  complition: @escaping (Films?, Error?) -> Void) {
        let request = URLRequest(url: URL(string: urlString)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                    complition(nil, error)
                    return
                }
                guard let data = data else { return }
                do {
                    let json = try? JSONDecoder().decode(Films.self, from: data)
                    complition(json, nil)
                } catch let jsonError {
                    complition(nil, jsonError)
                }
            }
            
        }
        task.resume()
    }
    
    func loadImage(imageFromResult: String, complition: @escaping (UIImage) -> Void ){
            if let imageURL = URL(string: imageFromResult) {
                
                let task2 = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async { [weak self] in
                        let imageView = UIImageView(image: image)
                        complition(image)
                    }
                    
                }
                task2.resume()
            }
            
        }
}
