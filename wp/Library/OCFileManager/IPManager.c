//
//  IPManager.c
//  wp
//
//  Created by mu on 2017/5/13.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

#include "IPManager.h"


#include <stdio.h>
#include <netdb.h>
#include <string.h>

char *getDNSToIP(char*HOST, char*host_name)
{
    struct hostent *host_entry;
    /* 即要解析的域名或主机名 */
    host_entry=gethostbyname(host_name);
    if(host_entry!=0)
    {
        sprintf(HOST,"%d.%d.%d.%d",
                (host_entry->h_addr_list[0][0]&0x00ff),
                (host_entry->h_addr_list[0][1]&0x00ff),
                (host_entry->h_addr_list[0][2]&0x00ff),
                (host_entry->h_addr_list[0][3]&0x00ff));
    }
    return HOST;
}
