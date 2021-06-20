//
//  PerfilController.swift
//  TestesIOS
//
//  Created by paulo marinho on 20/06/21.
//  Copyright © 2021 Santander. All rights reserved.
//

import Foundation
import UIKit

class PerfilViewController: UIViewController, UITextViewDelegate {
    private var user: UserModel?

    @IBOutlet weak var nomePerfil: UITextView!
    @IBOutlet weak var imagemPerfil: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager().fetchUser { [weak self] (user) in
            self?.user = user
            print(user)
            let url = URL(string: user.data.avatar)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self?.imagemPerfil.image = UIImage(data: data!)
                self?.nomePerfil.text =  "Ola"//  self?.user?.data.email
            }
          /*DispatchQueue.main.async {
            self?.tableView.reloadData()
          }*/
        }
      }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
