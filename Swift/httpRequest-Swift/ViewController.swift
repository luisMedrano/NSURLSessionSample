//
//  ViewController.swift
//  httpRequest-Swift
//
//The MIT License (MIT)
//Copyright (c) 2017 Luis Medrano-Zaldivar
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeRequestcompletion { (jsonData, errorResponse) in
            
            if let dataResponse = jsonData{
                do{
                    let json:NSDictionary = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! NSDictionary
                    self.performSelector(onMainThread: #selector(self.updateUIwithJsonResponse(json:)), with: json, waitUntilDone: true)
                    
                }catch{
                    print("json error: \(error.localizedDescription)")
                
                }
            }
        }
    }
    
    func updateUIwithJsonResponse(json:NSDictionary) {
        
        print(json)
        
    }
    
    func makeRequestcompletion(completion: @escaping (_ response:Data?, _ error:Error?)->Void)
    {
        let urlString = URL(string: "http://itunes.apple.com/lookup?isbn=9780316069359")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, urlRequestResponse, error) in
                completion(data, error)
            })
            task.resume()
        }
    }
}

