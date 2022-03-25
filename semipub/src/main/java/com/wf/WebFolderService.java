package com.wf;

import java.io.*;

public class WebFolderService {

	public static final String USERS_HOME="D:\\김재율\\totalSemi\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semipub\\menu\\photos";
	private int totalSize,usedSize,freeSize;
	private String user;
	private String crpath;
	
	public WebFolderService() {
		totalSize=1024*1024*10;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

	public int getUsedSize() {
		return usedSize;
	}

	public void setUsedSize(int usedSize) {
		this.usedSize = usedSize;
	}

	public int getFreeSize() {
		return freeSize;
	}

	public void setFreeSize(int freeSize) {
		this.freeSize = freeSize;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;    
	}

	public String getCrpath() {
		return crpath;
	}

	public void setCrpath(String crpath) {
		this.crpath = crpath;
	}
	
	/**사용자 공간 세팅 관련 메서드*/
	public void settingUserFolder() {
		
		File f=new File(USERS_HOME+"/"+user);
		if(!f.exists()) {
			f.mkdir();
		}
		usedSize=0;
		settingUsedSize(f);
		freeSize=totalSize-usedSize;
		
	}
	/**Set size*/
	public void settingUsedSize(File f) {
		File files[]=f.listFiles();
		for(int i=0;i<files.length;i++) {
			if(files[i].isFile()) {
				usedSize+=files[i].length();
			}else {
				settingUsedSize(files[i]);
			}
		}
	}
	
	/**DELETE File*/
	public void delete(String d) {
		File f=new File(USERS_HOME+"/"+d);
		if(f.isDirectory()){
			File files[]=f.listFiles();
			for(int i=0;i<files.length;i++){
				if(files[i].isDirectory()){
					d=d+"/"+files[i].getName();
					delete(d);
				}
				files[i].delete();
			}
		}
		f.delete();
	}
}