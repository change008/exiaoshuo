package com.tiexue.mcp.web.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.tiexue.mcp.base.util.CookieUtils;
import com.tiexue.mcp.core.dto.PageUserDto;
import com.tiexue.mcp.core.dto.ResultMsg;
import com.tiexue.mcp.core.dto.WxBookDto;
import com.tiexue.mcp.core.dto.WxChapterSubDto;
import com.tiexue.mcp.core.dto.bookrackCookieDto;
import com.tiexue.mcp.core.entity.EnumType;
import com.tiexue.mcp.core.entity.WxBook;
import com.tiexue.mcp.core.entity.WxBookrack;
import com.tiexue.mcp.core.entity.WxChapter;
import com.tiexue.mcp.core.entity.WxChapterSub;
import com.tiexue.mcp.core.service.IUserConsService;
import com.tiexue.mcp.core.service.IWxBookService;
import com.tiexue.mcp.core.service.IWxBookrackService;
import com.tiexue.mcp.core.service.IWxChapterService;
import com.tiexue.mcp.core.service.IWxChapterSubService;
import com.tiexue.mcp.core.service.IWxUserService;


@Controller
@RequestMapping("myzhangjiecontent")
public class WxChapterSubController {
	private static Logger logger=Logger.getLogger(WxChapterController.class);
	int pageSize=20;
	@Resource
	IWxChapterSubService chapterSubSer;
	@Resource
	IWxChapterService chapterService;
	@Resource
	IWxBookService bookService;
	@Resource
	IUserConsService userConsService;
	@Resource
	IWxUserService userSer;
	@Resource
	IWxBookrackService bookrackService;
	
	
	/**
	 * 获取免费章节的内容信息
	 * @param request
	 * @param attr
	 * @param rackCookie
	 * @param wx_gzh_token
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/index")
	public String getContent(HttpServletRequest request,HttpServletResponse response, RedirectAttributes attr,
			@CookieValue(value = "defaultbookrack", required = true, defaultValue = "") String rackCookie,
			@CookieValue(value = "wx_gzh_token", required = true, defaultValue = "") String wx_gzh_token
			,@CookieValue(value ="from_name",required = true, defaultValue = "")String from_name)
			throws UnsupportedEncodingException {
		String userIdStr = "";
		if (wx_gzh_token != "") {
			PageUserDto pageUser = userSer.getPageUserDto(wx_gzh_token);
			if (pageUser != null) {
				userIdStr = pageUser.getId();
			}
		}
		String bookIdStr = request.getParameter("bookId");
		String chapterIdStr = request.getParameter("chapterId");
		String fm = request.getParameter("ch");
		String bookName = "";
		String chapterTitle="";
		int userId = 0;
		int bookId = 0;
		int chapterId = 0;
		String tag="";
		if (chapterIdStr != null && !chapterIdStr.isEmpty()) {
		    chapterId = Integer.parseInt(chapterIdStr);
			if (bookIdStr != null && !bookIdStr.isEmpty()) {
				bookId = Integer.parseInt(bookIdStr);
			}
			if (userIdStr != null && !userIdStr.isEmpty()) {
				userId = Integer.parseInt(userIdStr);
			}
			// 获取图书信息
			WxBook book = bookService.selectByPrimaryKey(bookId);
			if (book != null) {
				bookName = book.getName();
				tag=book.getTag();
			}
			// 章节数据
			WxChapter chapterModel = chapterService.selectByPrimaryKey(chapterId, EnumType.ChapterStatus_OnLine);
			if (chapterModel == null)
				return "myzhangjiecontent/index";
			else
				chapterTitle=chapterModel.getTitle();
			// 付费章节操作
			if (chapterModel.getChaptertype() == 1) {
				ResultMsg resultMsg = userConsService.consDeal(userId, bookId, bookName, chapterModel);
				if (!resultMsg.getStatus()) {
					switch (resultMsg.getNum()) {
					case EnumType.ResultNum_Login:
						return "redirect:/myuser/login";
					case EnumType.ResultNum_Pay:
						attr.addAttribute("chapterId", chapterId);
						attr.addAttribute("bookId", bookId);
						attr.addAttribute("fm", fm);
						return "redirect:/myzhifu/pay";
					case EnumType.ResultNum_Cons:
						attr.addAttribute("chapterId", chapterId);
						attr.addAttribute("bookId", bookId);
						attr.addAttribute("ch", fm);
						return "redirect:/myxiaofei/dingyue";
					}
				}
				logger.error(resultMsg.getMsg());
			}
			// 获取章节信息
			WxChapterSubDto chapSubDto = getCahperDto(bookId, bookName, chapterId, chapterModel,tag);
			request.setAttribute("wxChapterSub", chapSubDto);
			if(chapterModel!=null)
			{
				int pageNo=0;
				if(chapterModel.getSortorder()%pageSize==0){
					if(chapterModel.getSortorder()>0)
						pageNo=chapterModel.getSortorder()-pageSize;
				}
				else
					pageNo=chapterModel.getSortorder()-(chapterModel.getSortorder()%pageSize);
				request.setAttribute("pageNo",pageNo);
			}
			request.setAttribute("fromurl", fm);
		}
		//保存书架
        if(bookId>0&&userId>0){
        	saveBookrack(bookId,userId,bookName,chapterId,chapterTitle);
        }
        //把小说来源公共号信息放到cookie中
		if((from_name==null||from_name.isEmpty())&&fm!=null&&!fm.isEmpty()){
			CookieUtils.addcookie("from_name", 1*365*24*60*60, response,fm);
		}
		return "myzhangjiecontent/index";
	}
	
	
	 /**
	  * 获取付费章节内容信息
	  * @param request
	  * @param attr
	  * @param rackCookie
	  * @param wx_gzh_token
	  * @return
	  * @throws UnsupportedEncodingException
	  */
	 @RequestMapping("/shoufei")
	 public String getVipContent(HttpServletRequest request, RedirectAttributes attr,HttpServletResponse response,
				@CookieValue(value = "defaultbookrack", required = true, defaultValue = "") String rackCookie,
				@CookieValue(value = "wx_gzh_token", required = true, defaultValue = "") String wx_gzh_token
				,@CookieValue(value ="from_name",required = true, defaultValue = "")String from_name)
				throws UnsupportedEncodingException {
			String userIdStr = "";
			if (wx_gzh_token != "") {
				PageUserDto pageUser = userSer.getPageUserDto(wx_gzh_token);
				if (pageUser != null) {
					userIdStr = pageUser.getId();
				}
			}
			String bookIdStr = request.getParameter("bookId");
			String chapterIdStr = request.getParameter("chapterId");
			String fm = request.getParameter("ch");
			String bookName = "";
			String chapterTitle="";
			int userId = 0;
			int bookId = 0;
			int chapterId = 0;
			String tag="";
			if (chapterIdStr != null && !chapterIdStr.isEmpty()) {
			    chapterId = Integer.parseInt(chapterIdStr);
				if (bookIdStr != null && !bookIdStr.isEmpty()) {
					bookId = Integer.parseInt(bookIdStr);
				}
				if (userIdStr != null && !userIdStr.isEmpty()) {
					userId = Integer.parseInt(userIdStr);
				}
				// 获取图书信息
				WxBook book = bookService.selectByPrimaryKey(bookId);
				if (book != null) {
					bookName = book.getName();
					tag=book.getTag();
				}
				
				// 章节数据
				WxChapter chapterModel = chapterService.selectByPrimaryKey(chapterId, EnumType.ChapterStatus_OnLine);
				if (chapterModel == null)
					return "myzhangjiecontent/index";
				else
					chapterTitle=chapterModel.getTitle();
				// 付费章节操作
				if (chapterModel.getChaptertype() == 1) {
					ResultMsg resultMsg = userConsService.consDeal(userId, bookId, bookName, chapterModel);
					if (!resultMsg.getStatus()) {
						switch (resultMsg.getNum()) {
						case EnumType.ResultNum_Login:
							return "redirect:/myuser/login";
						case EnumType.ResultNum_Pay:
							attr.addAttribute("chapterId", chapterId);
							attr.addAttribute("bookId", bookId);
							attr.addAttribute("fm", fm);
							return "redirect:/myzhifu/pay";
						case EnumType.ResultNum_Cons:
							attr.addAttribute("chapterId", chapterId);
							attr.addAttribute("bookId", bookId);
							attr.addAttribute("fm", fm);
							return "redirect:/myxiaofei/dingyue";
						}
					}
					logger.error(resultMsg.getMsg());
				}
				// 获取章节信息
				WxChapterSubDto chapSubDto = getCahperDto(bookId, bookName, chapterId, chapterModel,tag);
				if(chapterModel!=null)
				{
					int pageNo=0;
					if(chapterModel.getSortorder()%pageSize==0){
						if(chapterModel.getSortorder()>0)
							pageNo=chapterModel.getSortorder()-pageSize;
					}
					else
						pageNo=chapterModel.getSortorder()-(chapterModel.getSortorder()%pageSize);
					request.setAttribute("pageNo",pageNo);
				}
				request.setAttribute("wxChapterSub", chapSubDto);
				request.setAttribute("fromurl", fm);
			}
			//保存书架
	        if(bookId>0&&userId>0){
	        	saveBookrack(bookId,userId,bookName,chapterId,chapterTitle);
	        }
	        //把小说来源公共号信息放到cookie中
			if((from_name==null||from_name.isEmpty())&&fm!=null&&!fm.isEmpty()){
				CookieUtils.addcookie("from_name", 1*365*24*60*60, response,fm);
			}
			return "myzhangjiecontent/index";
		}
	

	/**
	 *  获取默认章节的内容信息
	 * @param request
	 * @param attr
	 * @param response
	 * @param wx_gzh_token
	 * @param from_name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/moren")
	public String getContentByBookId(HttpServletRequest request, RedirectAttributes attr,HttpServletResponse response,
			@CookieValue(value = "wx_gzh_token", required = true, defaultValue = "") String wx_gzh_token
			,@CookieValue(value ="from_name",required = true, defaultValue = "")String from_name)
			throws UnsupportedEncodingException {
		String userIdStr = "";
		if (wx_gzh_token != "") {
			PageUserDto pageUser = userSer.getPageUserDto(wx_gzh_token);
			if (pageUser != null) {
				userIdStr = pageUser.getId();
			}
		}
		String bookIdStr = request.getParameter("bookId");
		String fm = request.getParameter("ch");
		String bookName = "";
		int userId = 0;
		String tag="";
		if (bookIdStr != null && !bookIdStr.isEmpty()) {
			int bookId = Integer.parseInt(bookIdStr);
			int chapterId = 0;
			// 获取图书信息
			WxBook book = bookService.selectByPrimaryKey(bookId);
			if (book != null) {
				bookName = book.getName();
				tag=book.getTag();
			}
			if (userIdStr != null && !userIdStr.isEmpty()) {
				userId = Integer.parseInt(userIdStr);
			}

			// 获取第一章数据
			WxChapter chapterModel = chapterService.getFirstChapter(bookId, EnumType.ChapterStatus_OnLine);
			if (chapterModel != null) {
				chapterId = chapterModel.getId();
				// 付费章节操作
				if (chapterModel.getChaptertype() == 1) {
					ResultMsg resultMsg = userConsService.consDeal(userId, bookId, bookName, chapterModel);
					if (!resultMsg.getStatus()) {
						switch (resultMsg.getNum()) {
						case EnumType.ResultNum_Login:
							return "myuser/login";
						case EnumType.ResultNum_Pay:
							return "myzhifu/pay";
						case EnumType.ResultNum_Cons:
							return "myxiaofei/dingyue";
						}
					}
					logger.error(resultMsg.getMsg());
				}
			}
			// 获取章节信息
			WxChapterSubDto chapSubDto = getCahperDto(bookId, bookName, chapterId, chapterModel,tag);
			if(chapterModel!=null)
			{
				int pageNo=0;
				if(chapterModel.getSortorder()%pageSize==0){
					if(chapterModel.getSortorder()>0)
						pageNo=chapterModel.getSortorder()-pageSize;
				}
				else
					pageNo=chapterModel.getSortorder()-(chapterModel.getSortorder()%pageSize);
				request.setAttribute("pageNo",pageNo);
			}
			request.setAttribute("wxChapterSub", chapSubDto);
			request.setAttribute("fromurl", fm);
		}
		 //把小说来源公共号信息放到cookie中
		if((from_name==null||from_name.isEmpty())&&fm!=null&&!fm.isEmpty()){
			CookieUtils.addcookie("from_name", 1*365*24*60*60, response,fm);
		}
		return "myzhangjiecontent/index";
	}
	

	@RequestMapping("/dcontent")
	public String getContentUnlogin(HttpServletRequest request,HttpServletResponse response, RedirectAttributes attr,
			@CookieValue(value = "defaultbookrack", required = true, defaultValue = "") String rackCookie,
			@CookieValue(value = "wx_gzh_token", required = true, defaultValue = "") String wx_gzh_token
			,@CookieValue(value ="from_name",required = true, defaultValue = "")String from_name)
			throws UnsupportedEncodingException {
		String userIdStr = "";
		if (wx_gzh_token != "") {
			PageUserDto pageUser = userSer.getPageUserDto(wx_gzh_token);
			if (pageUser != null) {
				userIdStr = pageUser.getId();
			}
		}
		String bookIdStr = request.getParameter("bookId");
		String chapterIdStr = request.getParameter("chapterId");
		String fm = request.getParameter("ch");
		
		//判断显示哪个Qr
		String qrCode = request.getParameter("qr");
		if (qrCode == null || chapterIdStr.isEmpty()) {
			qrCode = "0";
		}
		
		String bookName = "";
		String chapterTitle="";
		int userId = 0;
		int bookId = 0;
		int chapterId = 0;
		String tag="";
		WxChapter chapterModel=null;
		WxChapterSubDto chapSubDto = null;
		if (chapterIdStr != null && !chapterIdStr.isEmpty()) {
		    chapterId = Integer.parseInt(chapterIdStr);
			if (bookIdStr != null && !bookIdStr.isEmpty()) {
				bookId = Integer.parseInt(bookIdStr);
			}
			if (userIdStr != null && !userIdStr.isEmpty()) {
				userId = Integer.parseInt(userIdStr);
			}
			
			// 获取图书信息
			WxBook book = bookService.selectByPrimaryKey(bookId);
			if (book != null) {
				bookName = book.getName();
				tag=book.getTag();
			}
			// 章节数据
		    chapterModel = chapterService.selectByPrimaryKey(chapterId, EnumType.ChapterStatus_OnLine);
			if (chapterModel == null)
				return "myzhangjiecontent/index";
			else
				chapterTitle=chapterModel.getTitle();
			// 付费章节操作
			if (chapterModel.getChaptertype() == 1) {
				ResultMsg resultMsg = userConsService.consDeal(userId, bookId, bookName, chapterModel);
				if (!resultMsg.getStatus()) {
					switch (resultMsg.getNum()) {
					case EnumType.ResultNum_Login:
						return "redirect:/myuser/login";
					case EnumType.ResultNum_Pay:
						attr.addAttribute("chapterId", chapterId);
						attr.addAttribute("bookId", bookId);
						attr.addAttribute("fm", fm);
						return "redirect:/myzhifu/pay";
					case EnumType.ResultNum_Cons:
						attr.addAttribute("chapterId", chapterId);
						attr.addAttribute("bookId", bookId);
						attr.addAttribute("fm", fm);
						return "redirect:/myxiaofei/dingyue";
					}
				}
				logger.error(resultMsg.getMsg());
			}
			// 获取章节信息
			chapSubDto = getCahperDto(bookId, bookName, chapterId, chapterModel,tag);
			request.setAttribute("wxChapterSub", chapSubDto);
			if(chapterModel!=null)
			{
				int pageNo=0;
				if(chapterModel.getSortorder()%pageSize==0){
					if(chapterModel.getSortorder()>0)
						pageNo=chapterModel.getSortorder()-pageSize;
				}
				else
					pageNo=chapterModel.getSortorder()-(chapterModel.getSortorder()%pageSize);
				request.setAttribute("pageNo",pageNo);
			}
			request.setAttribute("fromurl", fm);
			request.setAttribute("qr", qrCode);
		}
		//保存书架
        if(bookId>0&&userId>0){
        	saveBookrack(bookId,userId,bookName,chapterId,chapterTitle);
        }
        //把小说来源公共号信息放到cookie中
		if((from_name==null||from_name.isEmpty())&&fm!=null&&!fm.isEmpty()){
			CookieUtils.addcookie("from_name", 1*365*24*60*60, response,fm);
		}
		
		if(chapterModel!=null&&chapterModel.getShowtype()==1){
			String url="/myzhangjiecontent/index?bookId="+bookId+"&chapterId="+chapterId+"&ch="+fm;
			CookieUtils.addcookie("readMark_Show", 1*365*24*60*60, response,url);
			request.setAttribute("wxChapterSub", chapSubDto);
			request.setAttribute("wxChapterIntro",chapterModel.getIntro());
			
			//计算返回哪个加粉页面
			String qrStringFormat = "/myzhangjiecontent/focusQR%s";
			String qrString = String.format(qrStringFormat, qrCode);
			
			return qrString;
		}
		request.setAttribute("wxChapterSub", chapSubDto);
		return "myzhangjiecontent/dcontent";
	}
	
	/**
	 * 继续阅读逻辑 这里直接返回用户最后阅读的图书的章节,如果能够找到章节就直接到对应章节,否则就到图书默认页面
	 * **/
	@RequestMapping("/readgoon")
	public String readContinue(HttpServletRequest request,HttpServletResponse response, RedirectAttributes attr,
			@CookieValue(value = "defaultbookrack", required = true, defaultValue = "") String rackCookie,
			@CookieValue(value = "wx_gzh_token", required = true, defaultValue = "") String wx_gzh_token,
			@CookieValue(value ="readMark_Show",required = true, defaultValue = "")String readMark_Show,
			@CookieValue(value ="from_name",required = true, defaultValue = "")String from_name){
		
		//首先根据cookie数据获取最后读取的章节数据,拿不到的话再去专门的cookie中去查案
		
		try {
			WxBookrack bookrack=new WxBookrack();
			bookrack=getBookrackByCookie(rackCookie);
			String fm = "";
			if(from_name!=null&&!from_name.isEmpty()){
				//跳转到对应阅读页面
				fm = from_name;
			}
			if(bookrack.getBookid() != null && bookrack.getBookid() > 0 && bookrack.getChapterid() != null && bookrack.getChapterid() > 0){
				return "redirect:/myzhangjiecontent/index?bookId=" + bookrack.getBookid() + "&chapterId=" + bookrack.getChapterid() + "&ch=" + fm;
			}
			
			if(!readMark_Show.isEmpty()&&readMark_Show.contains("/myzhangjiecontent/index?bookId=")){
				return "redirect:"+readMark_Show;
			}
		} catch (Exception e) {
			
		}
		return "redirect:/myshujia/index";
	}
	
	/**
	 * 根据cookie获取收藏的书架
	 * @param rackCookie
	 * @return
	 */
	private WxBookrack getBookrackByCookie(String rackCookie){
		WxBookrack rack = new WxBookrack();
		
		try {
			 List<bookrackCookieDto> cookies=JSON.parseArray(rackCookie, bookrackCookieDto.class);
			 if(cookies!=null&&cookies.size()>0){
					 WxChapter curChap = null;
					 WxBook book= bookService.selectByPrimaryKey(cookies.get(cookies.size()-1).getBookid());
					 if(cookies.get(cookies.size()-1).getChapterid()>0){
						 curChap=chapterService.selectByPrimaryKey(cookies.get(cookies.size()-1).getChapterid(), EnumType.ChapterStatus_OnLine);
					 }
					 rack = bookrackDtoFill(book,curChap);
			 }
		} catch (Exception e) {
			
		}
		 return rack;
	}

	private WxBookrack bookrackDtoFill(WxBook book,WxChapter curChap){
		WxBookrack rack = new WxBookrack();
		if (book != null) {
			rack.setBookid(book.getId());
			rack.setBookname(book.getName());
			rack.setLocation(0);
			rack.setUserid(0);
		}
		if (curChap != null) {
			rack.setChapterid(curChap.getId());
			rack.setChaptertitle(curChap.getTitle());
		}

		return rack;
	}
	
	/**
	 * 获取章节内容信息
	 * @param bookName
	 * @param chapterId
	 * @param chapterModel
	 * @return
	 */
	private WxChapterSubDto getCahperDto(int bookId,String bookName, int chapterId,WxChapter chapterModel,String tag) {
		int preId = 0;
		int nextId = 0;
		int preType = 0;
		int nextType = 0;
        int sortOrder=0;
        if(chapterModel!=null)
        	sortOrder=chapterModel.getSortorder();
		// 章节内容数据
		WxChapterSub chapSub = chapterSubSer.selectByChapterId(chapterId);
		// 上一章数据
		WxChapter preChap = chapterService.getPreChapter(bookId,sortOrder, EnumType.ChapterStatus_OnLine);
		// 下一章数据
		WxChapter nextChap = chapterService.getNextChapter(bookId,sortOrder, EnumType.ChapterStatus_OnLine);
		if (preChap != null) {
			preId = preChap.getId();
			preType=preChap.getChaptertype();
		}
		if (nextChap != null) {
			nextId = nextChap.getId();
			nextType=nextChap.getChaptertype();
		}
		WxChapterSubDto chapSubDto = wxChapterSubDtoFill(chapSub, chapterModel, preId, nextId,preType,nextType,tag);
		chapSubDto.setBookName(bookName);
		return chapSubDto;
	}


	

	
	private WxChapterSubDto wxChapterSubDtoFill(WxChapterSub chapSub,WxChapter chapterModel,int preId,int nextId,int preType,int nextType,String tag){
		WxChapterSubDto chapSubDto=new WxChapterSubDto();
		if(chapterModel!=null){
			
		    chapSubDto.setTitle(chapterModel.getTitle());
			chapSubDto.setBookId(chapterModel.getBookid());
		}
		if(chapSub!=null){
			chapSubDto.setId(chapSub.getId());
			String content= chapSub.getContent();
			if(tag!=null&&tag.contains("军事")){
				content=addP(content);
			}
			chapSubDto.setContent(content);
		}
		chapSubDto.setPreId(preId);
		chapSubDto.setNextId(nextId);
		chapSubDto.setPreType(preType);
		chapSubDto.setNextType(nextType);
		return chapSubDto;
	}

	/**
	 * 格式化内容
	 */
	private static String addP(String str)
    {
        if (str==null||str.isEmpty())
        {
            return "";
        }
        else
        {
            str = str.replace("\r\n　　", "\r\n");
            str = str.replace("\r", "");
            return "<p style='text-indent: 2em;'>" + str.replace("\n", "</p>\n<p style='text-indent: 2em;'>") + "</p>";

        }
    }
	
	
	/**
	 * 用户阅读小说时直接加到书架中
	 * @param bookId
	 * @param userId
	 */
	private void saveBookrack(int bookId,int userId,String bookName,int chapterId,String chapterTitle){
		bookrackService.saveBookrack(userId, bookId, bookName, chapterId, chapterTitle);
	}

}
