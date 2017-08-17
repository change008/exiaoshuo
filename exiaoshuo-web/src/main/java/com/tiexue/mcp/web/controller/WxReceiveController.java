package com.tiexue.mcp.web.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tiexue.mcp.base.util.SerializeTool;
import com.tiexue.mcp.core.dto.WxCollectBookDto;
import com.tiexue.mcp.core.dto.WxCollectChapterDto;
import com.tiexue.mcp.core.dto.WxReceiveBookDto;
import com.tiexue.mcp.core.entity.EnumType;
import com.tiexue.mcp.core.entity.WxBook;
import com.tiexue.mcp.core.entity.WxChapter;
import com.tiexue.mcp.core.entity.WxChapterSub;
import com.tiexue.mcp.core.service.IWxBookService;
import com.tiexue.mcp.core.service.IWxBookrackService;
import com.tiexue.mcp.core.service.IWxChapterService;
import com.tiexue.mcp.core.service.IWxChapterSubService;

@Controller
@RequestMapping("/wxreceive")
public class WxReceiveController {

	// 日志
	private Logger logger = Logger.getLogger(WxReceiveController.class);
	@Resource
	IWxBookService wxBookService;

	@Resource
	IWxBookrackService bookrackService;
	// 获取章节信息的服务
	@Resource
	IWxChapterService wxChapterService;

	@Resource
	IWxChapterSubService wxChapterSubService;

	@RequestMapping(value = "getbookinfox", method = RequestMethod.GET, produces = "text/json; charset=utf-8")
	@ResponseBody
	public String test(HttpServletRequest request, HttpServletResponse response) {
		return "booklist";
	}

	/**
	 * 传递图书采集id,获取图书信息
	 **/
	@RequestMapping(value = "getbookinfo", method = RequestMethod.GET, produces = "text/json; charset=utf-8")
	@ResponseBody
	public String getBookInfo(HttpServletRequest request, HttpServletResponse response) {
		try {

			String collectionId = request.getParameter("collectionid");
			WxBook oldBook = wxBookService.selectByCollectionId(Integer.parseInt(collectionId));

			WxReceiveBookDto dto = new WxReceiveBookDto();
			if (oldBook == null) {
				dto.setCollectionid(Integer.parseInt(collectionId));
				dto.setId(0);
			} else {
				dto.setCollectionid(Integer.parseInt(collectionId));
				dto.setId(oldBook.getId());
				dto.setName(oldBook.getName());
				dto.setStatus(oldBook.getStatus());

				// 再从章节表中查询当前最大章节数据
				WxChapter wxChapter = wxChapterService.getLastChapter(oldBook.getId(), EnumType.ChapterStatus_OnLine);
				if (wxChapter != null) {
					dto.setMaxchapterid(wxChapter.getUniqueflag());
				} else {
					dto.setMaxchapterid("");
				}
			}
			return SerializeTool.serialize(dto);
			// return "xyx";
		} catch (Exception ex) {
			logger.error(ex);
			return ex.getMessage();
		}
	}

	/**
	 * 接收采集的图书信息,定期检查的时候也根据这里判断当前采集到哪个最新章节
	 * 采集Id--图书name--intro--converimg--tag--collection
	 * 
	 * 返回图书信息 collectionid--bookid--maxChapterid
	 * 
	 * @throws Exception
	 **/
	@RequestMapping(value = "receivebook", method = RequestMethod.POST, produces = "text/json; charset=utf-8")
	@ResponseBody
	public String receiveBook(HttpServletRequest request, HttpServletResponse response, @RequestBody String param)
			throws Exception {
		try {

			//首先对param进行url解码操作
			String objectJson = java.net.URLDecoder.decode(param, "UTF-8");
			
			// 读取传送的图书信息数据
			WxCollectBookDto book = SerializeTool.deserialize(objectJson, WxCollectBookDto.class);
			if (book == null || book.getCollectionid() <= 0) {
				throw new Exception("Data Error!");
			}

			// 数据库查询图书信息是否存在,存在的话返回图书相关信息
			WxBook OldBook = wxBookService.selectByCollectionId(book.getCollectionid());

			if (OldBook != null) { // 如果图书信息已经存在,那么查询当前最大章节数据返回
				WxReceiveBookDto result = new WxReceiveBookDto();
				result.setCollectionid(OldBook.getCollectionid());
				result.setId(OldBook.getId());
				result.setName(OldBook.getName());
				result.setStatus(OldBook.getStatus());
				result.setMaxchapterid("");
				// 查询当前最大章节数据
				WxChapter wxChapter = wxChapterService.getLastChapter(OldBook.getId(), EnumType.ChapterStatus_OnLine);
				if (wxChapter != null) {
					result.setMaxchapterid(wxChapter.getUniqueflag());
				}

				return SerializeTool.serialize(result);
			}

			// 如果图书信息原来不存在,那么将图书数据插入数据库中
			// 原来不存在,那么就进行插入操作
			// 数据赋值给wxbook进行插入操作
			WxBook newBook = new WxBook();
			newBook.setCaicount(0);
			newBook.setCollectionid(book.getCollectionid());
			newBook.setCommentcount(0);
			newBook.setContentlen(book.getContentlen());
			newBook.setCoverimgs(book.getCoverimgs());
			newBook.setCreatetime(new Date());
			newBook.setDingcount(0);
			newBook.setIntr(book.getIntr());
			newBook.setMark(0);
			newBook.setName(book.getName());
			newBook.setPublisherid(0);
			newBook.setPublishername("");
			newBook.setSharecount(0);
			newBook.setSort(0);
			newBook.setStatus(book.getStatus());
			newBook.setTag("");
			newBook.setUniqueflag(book.getUniqueflag());
			newBook.setUpdatetime(new Date());
			newBook.setViewcount(0);
			wxBookService.insert(newBook);

			// 数据库查询图书信息是否存在,存在的话返回图书相关信息
			WxBook myOldBook = wxBookService.selectByCollectionId(book.getCollectionid());
			if (myOldBook != null) { // 如果图书信息已经存在,那么查询当前最大章节数据返回
				WxReceiveBookDto result = new WxReceiveBookDto();
				result.setCollectionid(myOldBook.getCollectionid());
				result.setId(myOldBook.getId());
				result.setName(myOldBook.getName());
				result.setStatus(myOldBook.getStatus());
				result.setMaxchapterid("");
				// 查询当前最大章节数据
				WxChapter wxChapter = wxChapterService.getLastChapter(myOldBook.getId(), EnumType.ChapterStatus_OnLine);
				if (wxChapter != null) {
					result.setMaxchapterid(wxChapter.getUniqueflag());
				}

				return SerializeTool.serialize(result);
			} else {
				throw new Exception("insert book failed");
			}
		} catch (Exception ex) {
			logger.error(ex);
			return ex.getMessage();
		}
	}

	/**
	 * 接收图书章节信息数据
	 * 
	 * 采集id--外部图书id--title--intro--chapterType--price--contentlen--showtype--
	 * 
	 * 返回数据：成功|失败 采集id--外部章节id--章节id
	 * 
	 * @throws Exception
	 **/
	@RequestMapping(value="receivechapter", method = RequestMethod.POST, produces = "text/json; charset=utf-8")
	@ResponseBody
	public String receiveChapter(HttpServletRequest request, HttpServletResponse response, @RequestBody String param)
			throws Exception {
		
		//首先对param进行url解码操作
		String objectJson = java.net.URLDecoder.decode(param, "UTF-8");
		
		// 读取传送的图书信息数据
		WxCollectChapterDto chapterTransfer = SerializeTool.deserialize(objectJson, WxCollectChapterDto.class);
		if (chapterTransfer == null || chapterTransfer.getCollectionid() <= 0) {
			throw new Exception("Data Error!");
		}

		// 走到这里说明前面已经判断过这里是最新的章节数据,直接插入最新章节后面即可
		// 首先我们查询最新章节数据,如果没有查询到,那么说明之前还没有章节数据,直接插入即可
		// 数据库查询图书信息是否存在,存在的话返回图书相关信息
		WxBook oldBook = wxBookService.selectByCollectionId(chapterTransfer.getCollectionid());
		// 图书信息必须已经存在
		if (oldBook == null) { // 如果图书信息已经存在,那么查询当前最大章节数据返回
			throw new Exception("Data Error!");
		}

		WxChapter newChapter = new WxChapter();
		newChapter.setBookid(oldBook.getId());
		newChapter.setChaptertype(1);
		newChapter.setContentlen(chapterTransfer.getContentlen());
		newChapter.setCreatetime(new Date());
		newChapter.setIntro(chapterTransfer.getIntro());
		newChapter.setPirce(chapterTransfer.getPirce());
		newChapter.setRemark("");
		newChapter.setShowtype(1);
		newChapter.setSortorder(1);
		newChapter.setStatus(1);
		newChapter.setTitle(chapterTransfer.getTitle());
		newChapter.setUniqueflag(chapterTransfer.getUniqueflag());
		newChapter.setUpdatetime(new Date());

		// 查询当前最大章节数据
		WxChapter wxChapter = wxChapterService.getLastChapter(oldBook.getId(), EnumType.ChapterStatus_OnLine);
		if (wxChapter != null) {
			newChapter.setSortorder(wxChapter.getSortorder() + 1);
		}

		wxChapterService.insert(newChapter);

		// 查询最新章节信息
		WxChapter wxChapterNow = wxChapterService.getLastChapter(oldBook.getId(), EnumType.ChapterStatus_OnLine);
		if (wxChapterNow != null) {
			WxChapterSub chapterSub = new WxChapterSub();
			chapterSub.setContent(chapterTransfer.getContent());
			chapterSub.setId(wxChapterNow.getId());
			wxChapterSubService.insert(chapterSub);
		}

		// 查询当前最大章节数据
		WxReceiveBookDto result = new WxReceiveBookDto();
		result.setCollectionid(oldBook.getCollectionid());
		result.setId(oldBook.getId());
		result.setName(oldBook.getName());
		result.setStatus(oldBook.getStatus());
		result.setMaxchapterid("");
		// 查询当前最大章节数据
		WxChapter wxChapterLast = wxChapterService.getLastChapter(oldBook.getId(), EnumType.ChapterStatus_OnLine);
		if (wxChapterLast != null) {
			result.setMaxchapterid(wxChapterLast.getUniqueflag());
		}
		return SerializeTool.serialize(result);
	}

}
