//
//  PostController.swift
//  Post
//
//  Created by winston salcedo on 5/13/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

class PostController {
    
    
    //MARK: Properties
    static let baseURL = URL(string: "http://devmtn-post.firebase.io/posts")
    
    static var posts: [Post] = []
    
    
    //Function unwraps the baseURL and sends the request for data.
    static func fetchPosts(completion: @escaping () -> Void) {
        // Unwraps baseURL
        guard let url = baseURL else { completion(); return }
        let getterEndpoint = url.appendingPathExtension("json")
        //the request instance sends the request for data parsing by sending an HTTPMethod GET request
        var request = URLRequest(url: getterEndpoint)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        print(request)
        
        // this is the dataTask method will get our json data and converts it into a format we can use.
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error retrieving your data \(error.localizedDescription)")
                completion()
                return
            }
            guard let data = data else {completion() ; return }
                do {
                    let postsDictionary = try JSONDecoder().decode([String: Post].self, from: data)
                    var posts = postsDictionary.compactMap({ $0.value })
                    posts.sort(by: { $0.timestamp > $1.timestamp })
                    posts = self.posts
                    completion(); return

                }catch {
                    print(error.localizedDescription)
                }
            }
            dataTask.resume()
        // func will get catch the data fetched from the API call
    }
    static func addNewPostWith(username: String, text: String, completion: @escaping ([Post?]) -> Void) {
        let newPost = Post(userName: username, text: text)
        var postData: Data
        
            do{
                let jsonEncoder = JSONEncoder()
               postData = try jsonEncoder.encode(newPost)
            }catch {
                print(error.localizedDescription)
                return
        }
        guard let url = baseURL else { completion([nil]) ; return }
        let postEndpoint = url.appendingPathExtension("json")
        var request = URLRequest(url: postEndpoint)
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error ) in
            if let error = error {
                print("There was a problem encoding the data \(error.localizedDescription)")
                completion([])
                return
            }
        }
        dataTask.resume()
  }
}
