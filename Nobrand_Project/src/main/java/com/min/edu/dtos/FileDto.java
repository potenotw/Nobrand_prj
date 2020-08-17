package com.min.edu.dtos;

public class FileDto {
	
	private int seq        ;
	private int board_seq  ;
	private String origin_name;
	private String stored_name;
	private int filesize   ;
	private String regdate    ;
	private String filepath   ;
	private String delflag;
	
	public FileDto() {
		// TODO Auto-generated constructor stub
	}

	public FileDto(int seq, int board_seq, String origin_name, String stored_name, int filesize, String regdate,
			String filepath,String delflag) {
		super();
		this.seq = seq;
		this.board_seq = board_seq;
		this.origin_name = origin_name;
		this.stored_name = stored_name;
		this.filesize = filesize;
		this.regdate = regdate;
		this.filepath = filepath;
		this.delflag = delflag;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getStored_name() {
		return stored_name;
	}

	public void setStored_name(String stored_name) {
		this.stored_name = stored_name;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public String getRegdate() {
		return regdate;
	}
	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	@Override
	public String toString() {
		return "FileDto [seq=" + seq + ", board_seq=" + board_seq + ", origin_name=" + origin_name + ", stored_name="
				+ stored_name + ", filesize=" + filesize + ", regdate=" + regdate + ", filepath=" + filepath
				+ ", delflag=" + delflag + "]";
	}
	
}
