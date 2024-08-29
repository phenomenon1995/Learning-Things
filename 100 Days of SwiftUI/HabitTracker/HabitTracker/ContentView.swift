//
//  ContentView.swift
//  HabitTracker
//
//  Created by David Williams on 8/28/24.
//

import SwiftUI
struct Activity: Codable, Identifiable, Equatable{
    var id = UUID()
    let title: String
    let description: String
    var timesCompleted: Int
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}

@Observable
class Activities {
    var activities: Array<Activity> = [Activity]() {
        didSet {
            if let data = try? JSONEncoder().encode(self.activities) {
                UserDefaults.standard.set(data, forKey: "activities")
            }
        }
    }
    
    init(activies: Array<Activity> = [Activity]()) {
        if let savedItems = UserDefaults.standard.data(forKey: "activities"){
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems){
                self.activities = decodedItems
                return
            }
        }
        self.activities = [Activity]()
    }
    
    func saveActivities(){
        if let data = try? JSONEncoder().encode(self.activities) {
            UserDefaults.standard.set(data, forKey: "activities")
        }
    }
}

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = "Test Activity"
    @State private var description: String = "This is a placeholder for one activity to be created until I can add the code for saving and recalling this info from UserDefaults"
    var activities: Activities
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Title", text:$title)
                TextField("Description", text:$description)
                    .frame(maxHeight: .infinity)
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let newActivity = Activity(title: title, description: description, timesCompleted:0)
                        activities.activities.append(newActivity)
                        dismiss()
                    }
                }
            }
        }
        
    }
}

struct ActivityDetailView: View {
    @State var activity: Activity
    @State var activities: Activities
    @State private var timesCompleted: Int
    
    
    init(activity: Activity, activities: Activities){
        self.activity = activity
        self.activities = activities
        self.timesCompleted = activity.timesCompleted
    }
    
    var body: some View {
        NavigationStack {
            Text(activity.description)
                .font(.headline)
            Spacer()
            
            Stepper(value: $timesCompleted){
                Text("Times Completed \(timesCompleted)")
            }   onEditingChanged: { _ in
                guard let index = activities.activities.firstIndex(of: activity) else {
                    print("Activity ID not found")
                    return
                }
                activities.activities[index].timesCompleted = timesCompleted
                print("in array \(activities.activities[index].timesCompleted)")
            }
            
            Spacer()
                .navigationTitle(activity.title)
            
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var showingAddActivity: Bool = false
    @State private var activities = Activities()
    var body: some View {
        NavigationStack(path: $path){

                List{
                    ForEach(activities.activities){activity in
                        NavigationLink{
                            ActivityDetailView(activity: activity,activities: activities)
                        } label: {
                            Text(activity.title)
                        }
                    }.onDelete(perform: { indexSet in
                        activities.activities.remove(atOffsets: indexSet)
                    })
                }
            
            .navigationTitle("Habit Tracker")
            .toolbar{
                ToolbarItem(placement: .destructiveAction){
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction){
                    Button{
                        showingAddActivity = true
                    } label: {
                        HStack{
                            Text("Add Activity")
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showingAddActivity){
                AddActivityView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
