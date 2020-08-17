package com.min.edu.dtos;

import java.io.Serializable;

public class BoardDto implements Serializable{
	
	private static final long serialVersionUID = 322896629013412223L;
	
	private int seq      ;
	private String id       ;
	private String title    ;
	private String content  ;
	private int file_seq;
	private String nbrimg    ;
	private String thumbimg     ;
	private String c_count    ;
    private String readcount;
    private String gubun    ;
    private String delflag  ;
    private String regdate  ;
    
    public BoardDto() {
	}
    

	public BoardDto(int seq, String id, String title, String content, int file_seq, String gubun, String regdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.file_seq = file_seq;
		this.gubun = gubun;
		this.regdate = regdate;
	}

	public BoardDto(int seq, String id, String title, String content, int file_seq, String nbrimg, String thumbimg,
			String c_count, String readcount, String gubun, String delflag, String regdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.file_seq = file_seq;
		this.nbrimg = nbrimg;
		this.thumbimg = thumbimg;
		this.c_count = c_count;
		this.readcount = readcount;
		this.gubun = gubun;
		this.delflag = delflag;
		this.regdate = regdate;
	}


	@Override
	public String toString() {
		return "BoardDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", file_seq="
				+ file_seq + ", nbrimg=" + nbrimg + ", thumbimg=" + thumbimg + ", c_count=" + c_count + ", readcount="
				+ readcount + ", gubun=" + gubun + ", delflag=" + delflag + ", regdate=" + regdate + "]";
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getFile_seq() {
		return file_seq;
	}


	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}


	public String getNbrimg() {
		return nbrimg;
	}


	public void setNbrimg(String nbrimg) {
		this.nbrimg = nbrimg;
	}


	public String getThumbimg() {
		return thumbimg;
	}


	public void setThumbimg(String thumbimg) {
		this.thumbimg = thumbimg;
	}


	public String getC_count() {
		return c_count;
	}


	public void setC_count(String c_count) {
		this.c_count = c_count;
	}


	public String getReadcount() {
		return readcount;
	}


	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}


	public String getGubun() {
		return gubun;
	}


	public void setGubun(String gubun) {
		this.gubun = gubun;
	}


	public String getDelflag() {
		return delflag;
	}


	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


}
