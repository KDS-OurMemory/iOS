//
//  dataEnum.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/04/17.
//

public protocol Navigation {}

public enum NEXTVIEW:Navigation {
    case NEXTVIEW_LOGIN
    case NEXTVIEW_MAIN
    case NEXTVIEW_FRIENDSLIST
    case NEXTVIEW_ROOMLIST
    case NEXTVIEW_ROOMDETAIL
    case NEXTVIEW_SCHEDULE
}
