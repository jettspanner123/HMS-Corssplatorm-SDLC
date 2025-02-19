
import SwiftUI
import FirebaseFirestore


struct ChooseHospitalPage: View {
    
    var admin: SendAdmin
    
    @State var hospitals: Array<Hospital> = []
    @State var selectedHospital: String = ""
    
    @State var showCreateHospitalPage: Bool = false
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = "Name Error!"
    @State var errorDescription: String = "Please insure the username is atleast 8 characters long."
    
    @Environment(\.presentationMode) var presentationMode
    
    func fetchHospitals() {
        let database = Firestore.firestore()
        
        database.collection("hospitals").getDocuments() { (snapshot, error) in
            
            if let _ = error {
                self.errorMessage = "Sever Timeout!"
                self.errorDescription = "Could not reach the servers. Pleaes try again later!"
                self.showErrorMessage = true
            }
            
            self.hospitals = snapshot!.documents.compactMap { doc in
                let data = doc.data()
                let hospitalId = doc.documentID
                let hospitalName = data["hospitalName"] as! String
                let hospitalLocation = data["location"] as! String
                let hospitalSpeciality = data["speciality"] as! String
//                let hospitalSuperAdminId = data["superadminId"] as! String
                
                return Hospital(hospitalId: hospitalId, hospitalName: hospitalName, superadminId: "", location: hospitalLocation, speciality: hospitalSpeciality)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Error Dialog Box
            if self.showErrorMessage {
                VStack {
                    VStack {
                        Text(self.errorMessage)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondary)
                        
                        Text(self.errorDescription)
                            .padding(.vertical, 20)
                        
                        HStack {
                            Text("I Understand")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.appOrange.gradient)
                        .clipShape(.rect(cornerRadius: 15))
                        .onTapGesture {
                            self.isSubmitButtonClicked = false
                            self.showErrorMessage = false
                        }
                        
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 14))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(25)
                .background(.black.opacity(0.5))
                .shadow(radius: 1)
                .zIndex(12)
                
            }
            
            
            
            // MARK: Blur background
            HStack {
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .background(
                AppBackgroundBlur(radius: 20, opaque: false)
            )
            .offset(y: -70)
            .zIndex(11)
            
            // MARK: Heading Text
            HStack(spacing: 15) {
                
                HStack {
                    Image(systemName: "arrow.left")
                }
                .frame(maxWidth: 45, maxHeight: 45)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                Text("Hospitals")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 50)
            .padding(.bottom, 20)
            .padding(30)
            .zIndex(12)
            
            
            
            // MARK: Submit button
            HStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Submit")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.appOrange.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
            .padding(.horizontal, 25)
            .offset(y: UIScreen.main.bounds.height - 180)
            .zIndex(10)
            .onTapGesture {
                
            }
            
            
            // MARK: Content View here
            ScrollView {
                VStack {
                    // MARK: If the array is empty then show a "array empty" message
                    if self.hospitals.isEmpty {
                        
                        VStack(spacing: 20) {
                            
                            
                            // MARK: No hospitals icon
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .opacity(0.6)
                            }
                            
                            // MARK: No hospitals description
                            VStack(spacing: 0) {
                                Text("No hospitals found 🥲")
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Text("Add hospitals using the plus button below.")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        .padding(.vertical, 30)
                    }
                    
                    
                    // MARK: Loop over the array to do something idk
                    ForEach(self.hospitals, id: \.hospitalId) { hospital in
                        HospitalViewCard(hospital: hospital, selectedHospital: self.$selectedHospital)
                            .onTapGesture {
                                self.selectedHospital = hospital.hospitalId
                                
                            }
                    }
                    
                    
                    
                    // TODO: Circle add button dalo
                    AddHospitalCard()
                        .onTapGesture {
                            self.showCreateHospitalPage = true
                        }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(25)
                .padding(.top, 140)
                
                
            }
            .frame(maxWidth: .infinity)
        }
        .background(.gray.opacity(0.2))
        .fullScreenCover(isPresented: self.$showCreateHospitalPage) {
            CreateHospitalPage()
        }
        .onAppear {
            self.fetchHospitals()
        }
    }
}



