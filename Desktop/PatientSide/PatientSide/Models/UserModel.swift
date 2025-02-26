
import Foundation
import SwiftUICore




enum UserRelation: String {
    case father, mother , sister, brother, daughter, son, uncle, aunt, friend
}

enum UserGender {
    case male, female, bisexual, lesbian, gay, others
}


func getHumanRedableDate(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d/M/yyyy"
    return dateFormatter.string(from: date)
}

struct EmergencyContactUser {
    var id: String =  UUID().uuidString
    var relationWithUser: UserRelation
    var userId: String
    var name: String
    var phoneNumber: String
    var address: String
}

struct User: Identifiable {
    var id = UUID().uuidString
    var fullName: String
    var username: String
    var email: String
    var password: String
    var role: UserRole
    var phoneNumber: String
    var address: String
    var emergencyContactName: String
    var gender: UserGender
}

func getUserTypeFromString(someString: String) -> UserRole {
    if someString == "patient" {
        return .patient
    } else if someString == "doctor" {
        return .doctor
    }
    return .admin
}

struct SendUser {
    var id: String
    var fullName: String
    var email: String
    var location: String
    var phoneNumber: String
    var userType: String
    var password: String = ""
    var height: CGFloat = .zero
    var weight: CGFloat = .zero
    var bloodGroup: BloodGroup = .ap
}

struct SendAdmin {
    var adminName: String
    var hospitalId: String
    var asminUsername: String
    var password: String
    var isSuperAdmin: Bool
    var adminId: String
}

struct SendSuperAdmin: Codable, Hashable {
    var superadminId: String
    var superadminName: String
    var superadminUsername: String
    var superadminPassword: String
}

enum BloodGroup: String, Codable {
    case ap = "A+", an = "A-", bp = "B+", bn = "B-", abp = "AB+", abn = "AB-", op = "0+", on = "O-", select = "Blood Group"
}


enum EventType: String, Codable{
    case bloodDonation = "Blood Donation", fundRaiser = "Fund Raiser", volunteerWork = "Volunteer Work", charity = "Charity", seminar = "Seminar", checkup = "Check Up"
}

struct Doctor: Codable, Hashable {
    var doctorId: String
    var hospitalName: String
    var fullName: String
    var username: String
    var password: String
    var height: Double
    var weight: Double
    var bloodGroup: BloodGroup
    var doctorName: String
    var hospitalId: String
    var speciality: String
    var medicalAcomplishment: String
    var phoneNumber: String = ""
}

enum LeaveStatus: String, Codable, Hashable {
    case pending = "Pending", approved = "Approved", rejected = "Rejected"
}

struct Leave: Codable, Hashable {
    
    var leaveId = UUID().uuidString
    var fromDoctorid: String
    var fromDoctorName: String
    var leaveDescription: String
    var leaveStatus: LeaveStatus
    var from: Date
    var to: Date
    
    
}

struct Event: Codable, Hashable {
    var eventId: String = UUID().uuidString
    var eventName: String
    var eventDescription: String
    var eventType: EventType
    var location: String
    var date: Date
}


struct Hospital: Codable, Hashable {
    var hospitalId: String
    var hospitalName: String
    var superadminId: String
    var location: String
    var speciality: String
}

struct Department: Codable, Hashable {
    var departmentId = UUID().uuidString
    var departmentName: String
    var hospitalId: String
}

struct Remarks: Codable, Hashable {
    var fromUserId: String
    var fromUserName: String
    var title: String
    var description: String
    var markAsRead: Bool
}

enum UserRole: Codable {
    case admin, superadmin, doctor, patient
}

enum RequestType {
    case update, delete, create, forgotPassword
}

enum RequestOption: String, CaseIterable, Identifiable {
    case accepted , rejected , hold, pending
    var id: String { rawValue }
}



func getDateOnly(_ of: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd"
    
    return dateFormatter.string(from: of)
}

func getDayOnly(_ of: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    
    return String(dateFormatter.string(from: of))
}

enum AppointmentType: String, Codable, Hashable {
    case upcoming = "Upcoming", failed = "Failed", cancelled = "Cancelled", completed = "Completed"
}

struct Appointment: Codable, Hashable {
    var appointmentId: String = UUID().uuidString
    var appointmentDate: Date
    var appointmentTime: Date
    var doctorId: String
    var doctorName: String
    var patientId: String
    var patientName: String
    var appointmentType: AppointmentType
}


struct Request: Hashable {
    var fromUserId: String
    var fromUserName: String
    var fromUserType: UserRole
    var requestTitle: String
    var requestDescription: String
    var requestStatus: RequestOption
    var requestType: RequestType
}


func daysBetween(from: Date, to: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: from, to: to).day ?? -1
}
