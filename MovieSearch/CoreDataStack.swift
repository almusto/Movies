//
//  CoreDataStack.swift
//  Notes
//
//  Created by Alessandro Musto on 3/2/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataStack {

    static let store = CoreDataStack()
    private init() {}

    var fetchedNotes = [FavMovie]()

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MovieCore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func storeNote( withTitle title: String, imdbID: String, posterURL: String) {
        let movie = FavMovie(context: context)
        movie.title = title
        movie.imdbID = imdbID
        movie.posterURL = posterURL
        
        try! context.save()
    }


    func fetchNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        self.fetchedNotes = try! context.fetch(fetchRequest) as! [FavMovie]

    }

    func delete(movie: FavMovie) {
        context.delete(movie)
        try! context.save()
    }


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
