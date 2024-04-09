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
    @EnvironmentObject var itemList : Items
    @State var showSheet = false
    @State var items: [Item] = []
    
    func saveItem(name: String, quantity: String, id: UUID) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let databaseRef = Database.database().reference().child("users/\(uid)/items/\(id)")
        
        let itemObject = [
            "name" : name,
            "quantity" : quantity,
            "id" : id
        ] as [String: Any]
        
        databaseRef.setValue(itemObject)
    }
    
    func addItem(item: Item) {
        items.append(item)
        showSheet.toggle()
        saveItem(name: item.name, quantity: item.quantity, id: item.id)
    }
    
    func deleteItem(at indexSet: IndexSet) {
            items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
            items.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView {
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
                    ForEach(items) { item in
                        NavigationLink(destination: ItemDetailView(item: item)) {
                            Text(item.name)
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }.listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarTitle("Packing List")
        }
        .sheet(isPresented: $showSheet) {
            ItemView(item: Item(), addItem: { item in
                self.addItem(item: item)
                self.showSheet.toggle()
            })
        }
    }
}

struct PackingView_Previews: PreviewProvider {
    static var previews: some View {
        PackingView()
            .environmentObject(Items())
    }
}
