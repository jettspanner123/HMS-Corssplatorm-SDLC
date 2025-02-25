
import Foundation







enum UserRelation: String {
    case father, mother , sister, brother, daughter, son, uncle, aunt, friend
}

enum UserGender {
    case male, female, bisexual, lesbian, gay, others
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
}

struct Appointment: Codable, Hashable {
    var appointmentDate: Date
    var appointmentTime: String
    var appointmentId: String
    var withDoctorId: String
    var withUserId: String
    var withDoctorName: String
    var withUserName: String
}

struct Hospital: Codable, Hashable {
    var hospitalId: String
    var hospitalName: String
    var superadminId: String
    var location: String
    var speciality: String
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


struct Request: Hashable {
    var fromUserId: String
    var fromUserName: String
    var fromUserType: UserRole
    var requestTitle: String
    var requestDescription: String
    var requestStatus: RequestOption
    var requestType: RequestType
}
