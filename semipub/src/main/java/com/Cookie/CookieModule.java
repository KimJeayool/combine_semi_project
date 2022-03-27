package com.Cookie;
import java.util.*;
import java.net.*;
import javax.servlet.http.*;

public class CookieModule {

	
	/**Set Cookie*/
	public static void setCookie(String key, String value, int time, HttpServletResponse resp) {
		Cookie ck = new Cookie(key, value);
		ck.setPath("/semipub");
		ck.setMaxAge(time);
		resp.addCookie(ck);
	}
	
	/**Get Cookies*/
	public static String getCookie(String key, HttpServletRequest req) {
		Cookie cks[] = req.getCookies();
		String value = null;
		if(cks!=null) {
			for(int i=0; i<cks.length; i++) {
				if(cks[i].getName().equals(key)) {
					value=cks[i].getValue();
				}
			}
		}
		return value;
	}
	
	/**Count Cookies*/
	public static int cookieCnt(HttpServletRequest req) {
		Cookie cks[] = req.getCookies();
		if(cks!=null&&cks.length!=0) {
			return cks.length;
		}else {
			return 0;
		}
		
	}
	
	
	
	/**Delete All Cookies*/
	public void deleteCookies(HttpServletRequest req,HttpServletResponse res) {
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null) { 
	        for (int i = 0; i < cookies.length; i++) {
	            cookies[i].setMaxAge(0); 
	            res.addCookie(cookies[i]);
	        }
	    }
	}

	
	
}