package com.tiexue.mcp.core.dto;

import java.util.Date;

/**
 * 接收到采集数据后返回的数据
 * 用于采集器判断接下来应该进行的操作
 * 要包括采集id, 目前最大章节id
 * **/
public class WxReceiveBookDto {
	
	private int collectionid;
	
    private Integer id;

    private String name;

    private String maxchapterid;
    
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

	public int getCollectionid() {
		return collectionid;
	}

	public void setCollectionid(int collectionid) {
		this.collectionid = collectionid;
	}
    
	public String getMaxchapterid() {
        return maxchapterid;
    }

    public void setMaxchapterid(String maxchapterid) {
        this.maxchapterid = maxchapterid;
    }
    
    /**
     * 图书状态信息,
     * **/
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    
    
}