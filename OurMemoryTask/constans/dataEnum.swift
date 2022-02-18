//
//  dataEnum.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/04/17.
//

public protocol Navigation {}

enum NETPATH :String{
    case PATH_USER = "/v1/users"
    case PATH_FRIENDS = "/v1/friends"
    case PATH_ROOMS = "/v1/rooms"
    case PATH_MEMORIES = "/v1/memories"
    case PATH_NOTICE = "/v1/notices"
    case PATH_TODO = "/v1/todo"
    
    var path:String {
        return self.rawValue
    }
}

public enum NEXTVIEW:Navigation {
    case NEXTVIEW_POP
    case NEXTVIEW_LOGIN
    case NEXTVIEW_SIGNUP
    case NEXTVIEW_MAIN
    case NEXTVIEW_FRIENDSLIST
    case NEXTViEW_SHAREDLIST
    case NEXTVIEW_ADDSCHEDULE
    case NEXTVIEW_SELECTALRAMTIME
    case NEXTVIEW_SELECTCOLOR
    case NEXTVIEW_SELECTSHARED
    case NEXTVIEW_SELECTDATE
    case NEXTVIEW_TODOLIST
    case NEXTVIEW_ROOMLIST
    case NEXTVIEW_ROOMDETAIL
    case NEXTVIEW_SCHEDULE
    case NEXTVIEW_MYMEMORY
    case NEXTVIEW_OURMEMORY
    case NEXTVIEW_MYPROFILE
    case NEXTVIEW_BUTKITLIST
    case NEXTVIEW_NOTI
}

public enum SNSTYPE:Int8 {
    case UNOWNED
    case KAKAO = 1
    case GOOGLE = 2
    case NAVER = 3
}

enum NETRESULTCODE {
   static let SUCCESS = "S001"           // 성공
    
   static let INPUTDATA_ERROR = "C400" // 입력값이 잘못 되었습니다.
   static let URLDATA_ERROR = "C404"   // URL이 잘못되었습니다.
   static let UKNOWN_ERROR = "C500"     // 알 수 없는 오류가 발생하였습니다.
   static let DBDATA_ERROR = "C001"    // DB로부터 조회된 데이터 갯수가 잘못되었습니다.
   static let USERDATAREQUEST_ERROR = "U001" // 사용자 기능과 관련된 요청 변수 값이 잘못되었습니다. API 요청 프로토콜을 확인하시기 바랍니다.
   static let NOTFINDUSERDATA_ERROR = "U002" // 입력한 값에 해당하는 회원을 찾을 수 없습니다.
   static let USERREQUEST_ERROR = "U003"         // 회원에 대한 작업 중 알 수 없는 오류가 발생하였습니다.
   static let PROFILE_UPLOAD_ERROR = "U004"
   static let UNKNOWNSIGNEDUSER_ERROR = "U005" // 가입되지 않은 유저입니다.
   static let ROOMDATAREQUEST_ERROR = "R400" // 방 기능과 관련된 요청 변수 값이 잘못되었습니다. API 요청 프로토콜을 확인하시기 바랍니다.
    
   static let ROOMREQUESTPARAM_ERROR = "R001" // 방 기능 관련 요청 변수 값이 잘못되었스니다.
   static let NOTFINDROOMDATA_ERROR = "R002" // 입력한 값에 해당하는 방을 찾을 수 없습니다.
   static let ROOMREQUESTFAILE_ERROR = "R003" // 방에 대한 작업 중 알 수 없는 오류가 발생하였습니다.
   static let FAILEROOMADDUSER_ERROR = "R001" // 방에 참여자를 추가하는 도중 오류가 발생하였습니다.
   static let NOTFINDROOMUSERINFO_ERROR = "R005" // 방 참여자의 정보를 찾을 수 없습니다.
   static let CHANGEROOMOWNER_ERROR = "R003" // 방장 변경 에러.
    
   static let SCHEDULEREQUESTPARAM_ERROR = "M400" // 일정 기능과 관련된 요청 변수 값이 잘못되었습니다. API 요청 프로토콜을 확인하시기 바랍니다.
   static let NOTFINDSCHEDULE_ERROR = "M404" // 입력한 값에 해당하는 일정을 찾을 수 없습니다.
   static let SCHEDULEUNKNOWN_ERROR = "M500" // 일정에 대한 작업 중 알 수 없는 오류가 발생하였습니다.
   static let NOTFINDSCHEDULEOWNER_ERROR = "M001" // 일정 생성자의 정보를 찾을 수 없습니다. 생성자의 회원 번호를 확인해주시기 바랍니다.
    
   static let NOTFINDUSERINFO_ERROR = "F001" // 사용자의 회원 정보를 찾을 수 없습니다. 사용자의 회원 번호를 확인해주시기 바랍니다.
   static let NOTFINDFRIENDUSERINFO_ERROR = "F002" // 친구의 회원 정보를 찾을 수 없습니다. 친구의 회원번호를 확인해주시기 바랍니다.
   static let ALREADYAFRIEND_ERROR = "F003" // 이미 친구 요청을 수락한 사람입니다. 친구 추가를 진행해주시기 바랍니다.
   static let BLOCKFRIENDREQUEST_ERROR = "F004" // 상대방이 차단했기 때문에 친구 추가를 진행할 수 없습니다.
   static let NOTADDFRIENDREQUEST_ERROR = "F005" // 친구요청 없이 친구 추가할 수 없습니다.
   static let FRIENDSTATUS_ERROR = "F006" // 친구 상태값이 잘못되었습니다.
   static let FRIENDLISTREQUESTPARAM_ERROR = "F400" // 친구 목록 기능과 관련된 요청 변수 값이 잘못되었습니다. API 요청 프로토콜을 확인하시기 바랍니다.
   static let NOTFINDFRIEND_ERROR = "F404" // 입력한 값에 해당하는 친구를 찾을 수 없습니다.
   static let FRIENDUNKNOWN_ERROR = "F500" // 친구 목록에 대한 작업 중 알 수 없는 오류가 발생하였습니다.
    
   static let NOTIREQUESTPARAM_ERROR = "N400" // 알림 기능과 관련된 요청 변수 값이 잘못되었습니다.
   static let NOTIUNKNOWN_ERROR = "N500" // 알림에 대한 작업 중 알 수 없는 오류가 발생하였습니다.
   static let NOTFINDNOTIUSERINFO_ERROR = "N001" // 알림 사용자 정보를 찾을 수 없습니다.
}

enum LOGINNETCASE {
    case KNOWN_CASE
    case NOTCONNECTNET_CASE
    case REQUESTERROR_CASE
    case SIGNUP_CASE
    case SUCCESS_CASE
    case FAILE_CASE
}

enum HOMECASE {
    case KNOWN_CASE
    
}

enum COMPONENT_TYPE {
    case YEAR
    case MONTH
    case DAY
    case TIME
    case MINUTE
    case SECONDS
}

enum PICKER_MODE {
    case UNOWNED
    case YY_MM_DD_tt_mm_ss
    case YY_MM_DD_tt_mm
    case YY_MM_DD_tt
    case YY_MM_DD
    case YY_MM
    case MM_DD_tt_mm_ss
    case MM_DD_tt_mm
    case MM_DD_tt
    case MM_DD
    case DD_tt_mm_ss
    case DD_tt_mm
    case DD_tt
    case tt_mm_ss
    case tt_mm
    case mm_ss
    case YY
    case MM
    case DD
    case tt
    case mm
    case ss
}

enum WEEKDAYS:Int8 {
    case SUNDAY = 1
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
}

enum RESULT_DATE:UInt {
    case RESULT_YEAR
    case RESULT_MONTH
    case RESULT_DAY
    case RESULT_TIME
    case RESULT_MINUTE
    case RESULT_SECONDS
    case RESULT_WEEKS
    case RESULT_DATECOMPONENTS
}

enum ATTENDANCE_STATUS:String {
    case ATTEND = "ATTEND"
    case ABSENCE = "ABSENCE"
}


