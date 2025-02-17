
import Foundation

enum UserRole {
    case admin, superadmin, doctor, patient
}

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

struct Doctor: Codable, Hashable {
    var doctorId: String
    var hospitalName: String
    var fullName: String
    var username: String
    var password: String
    var doctorName: String
    var hospitalId: String
    var speciality: String
    var medicalAcomplishment: String
}

struct Hospital: Codable, Hashable {
    var hospitalId: String
    var hospitalName: String
    var superadminId: String
    var location: String
    var speciality: String
}
