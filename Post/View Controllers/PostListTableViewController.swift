//
//  PostTableViewController.swift
//  Post
//
//  Created by winston salcedo on 5/13/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    let postController = PostController()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timestampDateLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 45
        
        PostController.fetchPosts {
            self.reloadDataView()
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.posts.count
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
//            cell.textLabel?.text = Post.text
//            cell.detailTextLabel?.text = "\(Post.timestamp)"
        
            return cell
            
        }
    func reloadDataView() {
        PostController.fetchPosts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func getPostButtonTapped(_ sender: Any) {
        
    }
    

}
extension PostListTableViewController {
    func presentNewPostAlert() {
        // Create the alert controller
        let alertController = UIAlertController(title: "New Post", message: "Add a new post", preferredStyle: .alert)
        alertController.addTextField { (usernameTextField) in
            usernameTextField.placeholder = "username:"
        }
        alertController.addTextField { (messageTextField) in
            messageTextField.placeholder = "message:"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let addAction = UIAlertAction(title: "Send", style: .default) { (_) in
            if let usernameTextField = alertController.textFields?.first, let messageTextField = alertController.textFields?.last {
                if usernameTextField.text != "" && messageTextField.text != "" {
                    if let username = usernameTextField.text, let message = messageTextField.text {
                        PostController.addNewPostWith(username: username, text: message, completion: { (_) in
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
    }
}
