package com.tiexue.mcp.core.dto;

public class WxCollectBookDto {

    private String name;

    private String intr;

    private String coverimgs;

    private String tag;

    private String uniqueflag;
    
    private int collectionid;

    private int contentlen;
    
    private int status;
   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIntr() {
        return intr;
    }

    public void setIntr(String intr) {
        this.intr = intr == null ? null : intr.trim();
    }

    public String getCoverimgs() {
        return coverimgs;
    }

    public void setCoverimgs(String coverimgs) {
        this.coverimgs = coverimgs == null ? null : coverimgs.trim();
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag == null ? null : tag.trim();
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

	public int getCollectionid() {
		return collectionid;
	}

	public void setCollectionid(int collectionid) {
		this.collectionid = collectionid;
	}
	
	public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    
}