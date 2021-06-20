//
//  NetworkManager.swift
//  TestesIOS
//
//  Created by paulo marinho on 20/06/21.
//  Copyright © 2021 Santander. All rights reserved.
//

import Foundation
final class NetworkManager {
    private let domainUrlString = "https://reqres.in/"

    func fetchUser(completionHandler: @escaping (UserModel) -> Void) {
    let url = URL(string: domainUrlString + "api/users/2")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching user: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        return
      }

      if let data = data,
        let userPerfil = try? JSONDecoder().decode(UserModel.self, from: data) {
        completionHandler(userPerfil )
      }
    })
    task.resume()
  }
}
