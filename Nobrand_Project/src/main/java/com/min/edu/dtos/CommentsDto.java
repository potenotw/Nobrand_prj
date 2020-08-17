package com.min.edu.dtos;

import java.io.Serializable;

public class CommentsDto implements Serializable{
	
	private static final long serialVersionUID = -7931441752228623335L;
	private int seq      ;
	private String id       ;
	private String content  ;
	private String delflag  ;
	private String regdate  ;
	private int board_seq; 
	
	public CommentsDto() {
	}
	
	

	public CommentsDto(int seq, String id, String content, String delflag, String regdate, int board_seq) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.delflag = delflag;
		this.regdate = regdate;
		this.board_seq = board_seq;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	@Override
	public String toString() {
		return "CommentsDto [seq=" + seq + ", id=" + id + ", content=" + content + ", delflag=" + delflag + ", regdate="
				+ regdate + ", board_seq=" + board_seq + "]";
	}
	
	

}
