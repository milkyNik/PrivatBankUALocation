//
//  PBOffice.h
//  PrivatBankUALocation
//
//  Created by iMac on 18.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerObject.h"

@interface PBOffice : ServerObject

@property (strong, nonatomic) NSString* country;    //Страна, где расположено отделение
@property (strong, nonatomic) NSString* state;      //Область, где расположено отделение
@property (strong, nonatomic) NSString* index;      //Почтовый индекс отделения
@property (strong, nonatomic) NSString* address;    //Адрес отделения
@property (strong, nonatomic) NSString* phone;      //Телефон отделения
@property (strong, nonatomic) NSString* email;      //E-mail, по которому возможно связаться с отделением
@property (strong, nonatomic) NSString* name;       //Название отделения

@end
