import SwiftUI
import Combine

enum BottomSheetOptions: String {
   case fullName = "Full Name", bloodGroup = "Blood Group", height = "Height", weight = "Weight", specialisation = "Specialisation"
}

struct EditDoctorPage: View {
    
    @Binding var doctor: Doctor
    
    @State var doctorHeight: String = ""
    @State var doctorWeight: String = ""
    
    @State var showBottomSheet: Bool = false
    @State var bottomSheetHeading: String = "Height"
    @State var selectedSheetOption: BottomSheetOptions = .height
    
    @State var bottomSheetTranslation: CGSize = .zero
    @State var isKeyboardShowing: Bool = false
    
    let bloodGroupOptions: Array<BloodGroup> = [.ap, .an, .bp, .bn, .abp, .abp, .op]
    
    
    
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
          .Merge(
            NotificationCenter
              .default
              .publisher(for: UIResponder.keyboardWillShowNotification)
              .map { _ in true },
            NotificationCenter
              .default
              .publisher(for: UIResponder.keyboardWillHideNotification)
              .map { _ in false })
          .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
          .eraseToAnyPublisher()
      }
    
    func setSheetOption(_ optino: BottomSheetOptions) {
        self.bottomSheetHeading = optino.rawValue
        self.selectedSheetOption = optino
        withAnimation(.spring(duration: 0.35)) {
            self.showBottomSheet = true
        }
    }
    
    func setBloodGroup(_ bloodGroup: BloodGroup) {
        self.doctor.bloodGroup = bloodGroup
        withAnimation(.spring(duration: 0.35)) {
            self.showBottomSheet = false
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Dark backdrop
            if self.showBottomSheet {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .zIndex(20)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.35)) {
                            self.showBottomSheet = false
                            
                        }
                        
                    }
            }
            
            // MARK: Bottom sheet
            if self.showBottomSheet {
                VStack {
                    VStack {
                        
                        Capsule()
                            .fill(.appOrange.opacity(0.25))
                            .stroke(.black.opacity(0.5), lineWidth: 0.5)
                            .frame(maxWidth: 50, maxHeight: 15)
                        
                        
                        // MARK: Bottom sheet headign
                        Text(self.bottomSheetHeading)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondaryAccent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        
                        
                        
                        
                        // MARK: For blood group
                        if self.selectedSheetOption == .bloodGroup {
                            
                            
                            // MARK: Blood group list
                            VStack(spacing: 0) {
                                
                                ForEach(self.bloodGroupOptions, id: \.self) { bloodGroup in
                                    InformationListItem(key: bloodGroup.rawValue, value: "")
                                        .onTapGesture {
                                            self.setBloodGroup(bloodGroup)
                                        }
                                    
                                    CustomDivider()
                                }
                                
                                InformationListItem(key: "O-", value: "")
                                    .onTapGesture {
                                        self.setBloodGroup(.on)
                                    }
                               
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.white.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                        } else if self.selectedSheetOption == .fullName {
                            CustomTextField(text: self.$doctor.doctorName, placeholder: "Doctor Name")
                                .overlay {
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 20)
                                }
                            
                            if self.isKeyboardShowing {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 400)
                            } else {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                            }
                            
                        } else if self.selectedSheetOption == .height {
                            CustomTextField(text: self.$doctorHeight, placeholder: "Measure in cm")
                                .overlay {
                                    HStack {
                                        Image(systemName: "lines.measurement.horizontal")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 15)
                                }
                            
                            if self.isKeyboardShowing {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 400)
                            } else {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                            }
                        } else if self.selectedSheetOption == .weight {
                            CustomTextField(text: self.$doctorWeight, placeholder: "Measure in kg")
                                .overlay {
                                    HStack {
                                        Image(systemName: "lines.measurement.horizontal")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 15)
                                }
                            
                            if self.isKeyboardShowing {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 400)
                            } else {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                            }
                        }
                        
                        
                        
                        
                       
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: 20)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .background(.appBackground)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, topTrailing: 15)))
                    .offset(y: self.bottomSheetTranslation.height)
                    .edgesIgnoringSafeArea(.bottom)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > .zero {
                                    withAnimation(.bouncy) {
                                        self.bottomSheetTranslation = value.translation
                                    }
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.showBottomSheet = false
                                        self.bottomSheetTranslation = .zero
                                    }
                                } else {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.bottomSheetTranslation = .zero
                                    }
                                }
                                
                            }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.bottom)
                .zIndex(21)
            }
            
            
            
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Edit")
                .offset(y: 25)
                .zIndex(12)
            
            
            
            // MARK: Content View
            ScrollView {
                
                VStack {
                  
                    SectionHeading(text: "Personal Information")
                    VStack {
                        
                        // MARK: Full name
                        InformationListItem(key: "Full Name", value: self.doctor.doctorName)
                            .onTapGesture {
                                self.setSheetOption(.fullName)
                            }
                        
                        CustomDivider()
                        
                        InformationListItem(key: "Blood Group", value: self.doctor.bloodGroup.rawValue)
                            .onTapGesture {
                                self.setSheetOption(.bloodGroup)
                            }
                        
                        CustomDivider()
                        
                        InformationListItem(key: "Height", value: "183cm")
                            .onTapGesture {
                                self.setSheetOption(.height)
                            }
                        
                        CustomDivider()

                        InformationListItem(key: "Weight", value: "85kg")
                            .onTapGesture {
                                self.setSheetOption(.weight)
                            }
                        
                        CustomDivider()
                        
                        InformationListItem(key: "Specialisation", value: self.doctor.speciality)
                            .onTapGesture {
                                self.setSheetOption(.specialisation)
                            }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(15)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    SectionHeading(text: "Shift & More")
                        .padding(.top, 20)
                    
                    VStack {
                        InformationListItem(key: "Other Expertise", value: "")
                        
                        CustomDivider()
                        
                        InformationListItem(key: "Shift & Schedule", value: "")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(15)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
        .onReceive(self.keyboardPublisher) { value in
            withAnimation(.spring(duration: 0.35)) {
                self.isKeyboardShowing = value
            }
        }
    }
}


struct InformationListItem: View {
    
    var key: String
    var value: String
    var image: String = "chevron.right"
    
    var body: some View {
        HStack {
            Text(self.key)
                .font(.system(size: 15))
            
            Spacer()
            
            Text(self.value)
                .font(.system(size: 15))
                .foregroundStyle(.gray)
            
            Image(systemName: self.image)
                .foregroundStyle(.gray)
                .scaleEffect(0.8)
        }
        .frame(maxWidth: .infinity, maxHeight: 35 ,alignment: .leading)
        
    }
}

#Preview {
    
    @Previewable @State var doctor: Doctor = .init(doctorId: "123", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "123", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    EditDoctorPage(doctor: $doctor)
}
