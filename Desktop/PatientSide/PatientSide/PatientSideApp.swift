//
//  PatientSideApp.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 12/02/25.
//

import SwiftUI
import UIKit
import SwiftData
import Firebase


class AppStates: ObservableObject {
    
    
    
    @Published var showAddPage: Bool = false
    
    
    @Published var leaves: Array<Leave> = [
        .init(fromDoctorid: "doctor1",  fromDoctorName: "Dr. Uddeshya Singh",leaveDescription: "Need leave because of being sick to the core.", leaveStatus: .pending, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
        .init(fromDoctorid: "doctor2",  fromDoctorName: "Dr. Tanishq Biryani",leaveDescription: "Ghar ja rela hai apun, kyuki babuji ki zami batreli hai.", leaveStatus: .approved, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
        .init(fromDoctorid: "doctor3",  fromDoctorName: "Dr. Vanshika Garg",leaveDescription: "Had too much lassi, going into a overdose, want some quality time for myself.", leaveStatus: .rejected, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
    ]
    
    @Published var appointments: Array<Appointment> = [
        Appointment(
            appointmentDate: Date().addingTimeInterval(86400 * 4), // 2 days from now
            appointmentTime: Date().addingTimeInterval(2 * 24 * 60 * 60 + 8 * 60 * 60), // 2 days + 8 hours
            doctorId: "doctor1",
            doctorName: "Dr. Uddeshya Singh",
            patientId: "user1",
            patientName: "Tushar Saurav",
            appointmentType: .upcoming
        )
    ]
    
    @Published var requests: Array<Request> = [
        .init(
            fromUserId: "user123",
            fromUserName: "Alice Johnson",
            fromUserType: .patient,
            requestTitle: "Update Profile",
            requestDescription: "Change my address and phone number.",
            requestStatus: .pending,
            requestType: .update
        ),
        .init(
            fromUserId: "user456",
            fromUserName: "Dr. Smith",
            fromUserType: .doctor,
            requestTitle: "Delete Patient Record",
            requestDescription: "Remove patient John Doe's record.",
            requestStatus: .hold,
            requestType: .delete
        ),
        .init(
            fromUserId: "user789",
            fromUserName: "Admin User",
            fromUserType: .admin,
            requestTitle: "Create New User",
            requestDescription: "Create a new doctor account.",
            requestStatus: .accepted,
            requestType: .create
        ),
        .init(
            fromUserId: "user101",
            fromUserName: "Jane Doe",
            fromUserType: .patient,
            requestTitle: "Forgot Password",
            requestDescription: "I need to reset my password.",
            requestStatus: .pending,
            requestType: .forgotPassword
        )
    ]
    
    
    @Published var remarks: Array<Remarks> = [
        .init(fromUserId: "user1", fromUserName: "Tushar Sourav", title: "Bad Food", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: false),
    ]
    
    @Published var departments: Array<Department> = [
        .init(departmentId: "department1", departmentName: "Physiotherapy", hospitalId: "hospital1")
    ]
    
    
    @Published var doctors: Array<Doctor> = [
        .init(doctorId: "doctor1", hospitalName: "Neelam Hospital", fullName: "Uddeshya Singh", username: "doc#jettspanner123", password: "Saahil123s", height: 193, weight: 93, bloodGroup: .ap, doctorName: "Dr. Uddeshya Singh", hospitalId: "hospital1", speciality: "Gayology", medicalAcomplishment: "MBBS")
    ]
    
    @Published var users: Array<SendUser> = [
        .init(id: "user1", fullName: "Tushar Sourav", email: "tushar@gmail.com", location: "Mysuru, Karnataka", phoneNumber: "9875660105", userType: "")
    ]
    
    @Published var admins: Array<SendAdmin> = [
        .init(adminName: "Uddeshya Singh", hospitalId: "hospital1", asminUsername: "jettspanner123", password: "Saahil123s", isSuperAdmin: true, adminId: "healthfosys_gulam")
    ]
    
    @Published var hospitals: Array<Hospital> = [
        .init(hospitalId: "hospital1", hospitalName: "Neelam Hospital", superadminId: "healthfosys_gulam", location: "Mysurur, Karnataka", speciality: "Gayology")
    ]
    
    @Published var events: Array<Event> = [
        .init(
            eventName: "Blood Donation Drive",
            eventDescription: "Donate blood and help save lives. Join us in this noble cause and be a hero.",
            eventType: .bloodDonation,
            location: "City Hospital, New York",
            date: .now
        ),
        .init(
            eventName: "Free Health Check-Up Camp",
            eventDescription: "Free blood pressure, blood sugar, and general health check-ups. No appointment required.",
            eventType: .checkup,
            location: "Central Park, Los Angeles",
            date: Date().addingTimeInterval(86400) // One day from now
        ),
    
        .init(
            eventName: "Wellness Seminar: Mental Health Awareness",
            eventDescription: "Learn how to take care of your mental health and reduce stress. Speakers include top psychologists.",
            eventType: .seminar,
            location: "Health Center, San Francisco",
            date: Date().addingTimeInterval(86400 * 5) // 5 days from now
        ),
    
        .init(
            eventName: "Fitness Workshop: Get Fit in 30 Days",
            eventDescription: "Join our fitness workshop and kickstart your fitness journey with expert trainers. Focus on full-body workouts and nutrition.",
            eventType: .seminar,
            location: "Downtown Gym, Chicago",
            date: Date().addingTimeInterval(86400 * 10) // 10 days from now
        ),
    
        .init(
            eventName: "Yoga for Beginners",
            eventDescription: "A peaceful yoga session for beginners. Focus on relaxation, flexibility, and mindfulness.",
            eventType: .seminar,
            location: "Yoga Studio, Miami",
            date: Date().addingTimeInterval(86400 * 20) // 20 days from now
        )
    ]
}

@main
struct PatientSideApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var appStates = AppStates()
    @State var doctor: Doctor = .init(doctorId: "123", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "123", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    @State var admin: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: true, adminId: "")
    
    
    
    var body: some Scene {
        WindowGroup {
            AdminDashboard(admin: self.$admin)
        }
        .environmentObject(appStates)
        
    }
}
