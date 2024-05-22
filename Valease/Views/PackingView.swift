//
//  PackingView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/15/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct PackingView: View {
    @EnvironmentObject var items : Items
    @Binding var currentTrip : Trip
    @State var showSheet = false
    
    func saveItem(name: String, quantity: String, id: UUID) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let tid = currentTrip.id
        
        let itemObject = [
            "name" : name,
            "quantity" : quantity,
            "id" : id.uuidString
        ] as [String: Any]
        
        let databaseRef = Database.database().reference().child("users/\(uid)/trips/\(tid)/items/\(id)")
        
        databaseRef.setValue(itemObject)
    }
    
    func addItem(item: Item) {
        currentTrip.items.itemList.append(item)
        showSheet.toggle()
        saveItem(name: item.name, quantity: item.quantity, id: item.id)
    }
    
    func deleteItem(at indexSet: IndexSet) {
        currentTrip.items.itemList.remove(atOffsets: indexSet)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        currentTrip.items.itemList.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        //NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Text("+ Add item")
                            .font(Constants.mediumFont)
                    }
                    .padding(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    EditButton()
                        .font(Constants.mediumFont)
                        .padding(20)
                }
                List {
                    ForEach(currentTrip.items.itemList) { item in
                        if item.name != "Default" {
                            NavigationLink(destination: ItemDetailView(item: item)) {
                                Text(item.name)
                            }
                        } else {
                            
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }.listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarTitle("Packing List")
        //}
        .sheet(isPresented: $showSheet) {
            ItemView(item: Item(), addItem: { item in
                self.addItem(item: item)
            }, showSheet: $showSheet, currentTrip: $currentTrip)
        }
    }
}

struct PackingView_Previews: PreviewProvider {
    static var previews: some View {
        PackingView(currentTrip: Binding.constant(Trip()))
            .environmentObject(Items())
    }
}
