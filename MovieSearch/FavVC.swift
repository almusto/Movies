//
//  FavVC.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class FavVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let coreStack = CoreDataStack.store
    var movies: [FavMovie] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.tabBarController?.tabBar.barTintColor = UIColor.gray
      
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreStack.fetchNotes()
        movies = coreStack.fetchedNotes
        tableView.reloadData()

    }

    //Mark:- TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavMovieCell
        cell.favMovie = movies[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = movies[indexPath.row]
            movies.remove(at: indexPath.row)
            coreStack.delete(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // Mark:- segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailFromPlot" {
            let dest = segue.destination as! MovieDetailVC
            let indexPath = tableView.indexPathForSelectedRow
            dest.favMovie = movies[indexPath!.row]
            dest.navigationItem.rightBarButtonItem?.isEnabled = false
            dest.navigationItem.rightBarButtonItem?.title = ""
        }
    }

}
