//
//  RealmService.swift
//  VKsimulator
//
//  Created by Admin on 17.02.2021.
//

import Foundation
import RealmSwift


class RealmService{
    
    static let shared = RealmService()
    private let realm : Realm
    
    private init?() {
        let confgurator = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        guard let realm = try? Realm(configuration: confgurator) else { return nil }
        self.realm = realm
        #if DEBUG
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm error")
        #endif
    }
    
    func saveGroups(_ elements: [VKGroup]){
        do {
            try add(objects: elements)
        } catch {
            print(error)
        }
        #if DEBUG
            print("Groups saved to realm")
        #endif
    }
    
    func loadGroups()->[VKGroup]{
        let groups = Array(realm.objects(VKGroup.self))
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return groups
    }
    
    func savePhotos(_ elements: [VKPhoto]){
        do {
            try add(objects: elements)
        } catch {
            print(error)
        }
        #if DEBUG
        print("\(type(of: elements)) saved to realm")
        #endif
    }
    
    func loadPhotos()->[VKPhoto]{
        #if DEBUG
            print("Photos loaded from realm")
        #endif
        return Array(realm.objects(VKPhoto.self))
    }
    
    func saveUsers(_ elements: [VKUser]){
        do {
            try add(objects: elements)
        } catch {
            print(error)
        }
        #if DEBUG
        print("\(type(of: elements)) saved to realm")
        #endif
    }
    
    func loadUsers()->[VKUser]{
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return Array(realm.objects(VKUser.self))
    }
    
    
    func add<T: Object>(objects:[T]) throws{
        try realm.write{
            realm.add(objects)
        }
    }
    
    func getObjects<T: Object>() -> Results<T>{
        return realm.objects(T.self)
    }
    
    func delete<T: Object>(object: T) throws{
        try realm.write{
            realm.delete(object)
        }
    }
    
}
