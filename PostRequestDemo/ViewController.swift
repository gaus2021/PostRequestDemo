//
//  ViewController.swift
//  PostRequestDemo
//
//  Created by Apple on 15/10/21.
//

import UIKit
enum HttpMethods : String {
    case POST = "POST"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func registerUser(type: HttpMethods) {
       
        let parameters = UserModel(Name: "Gaus", Email: "Gaus@gmail.com", Password: "123")
        
        do {
           guard let values = try? JSONEncoder().encode(parameters) else {return}

            var request = URLRequest(url: URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser")!,timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = type.rawValue
            request.httpBody = values
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                
                return
              }
                print(String(data: data, encoding: .utf8)!)
            }
            task.resume()
            
        } catch  {
            print(error.localizedDescription)
        }
    }

    @IBAction func btnTapped(_ sender: Any) {
        registerUser(type: .POST)
    }
    
}

