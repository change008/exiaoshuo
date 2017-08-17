package com.tiexue.mcp.core.dto;

import java.util.Date;

public class WxCollectChapterDto {
	
	//采集id
	private int collectionid;
    //简介
    private String intro;
    //章节号
    private Integer sortorder;
    //章节名称
    private String title;
    //章节类型
    private Integer chaptertype;
    //章节价格
    private Integer pirce;
    //章节字节		
    private Integer contentlen;
    
    //存放对方章节唯一标识
    private String uniqueflag;
    
    //内容数据
    private String content;
    

    public int getCollectionid() {
		return collectionid;
	}

	public void setCollectionid(int collectionid) {
		this.collectionid = collectionid;
	}

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro == null ? null : intro.trim();
    }

    public Integer getSortorder() {
        return sortorder;
    }

    public void setSortorder(Integer sortorder) {
        this.sortorder = sortorder;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getChaptertype() {
        return chaptertype;
    }

    public void setChaptertype(Integer chaptertype) {
        this.chaptertype = chaptertype;
    }

    public Integer getPirce() {
        return pirce;
    }

    public void setPirce(Integer pirce) {
        this.pirce = pirce;
    }

    public Integer getContentlen() {
        return contentlen;
    }

    public void setContentlen(Integer contentlen) {
        this.contentlen = contentlen;
    }

	public String getUniqueflag() {
		return uniqueflag;
	}

	public void setUniqueflag(String uniqueflag) {
		this.uniqueflag = uniqueflag;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}