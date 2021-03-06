package com.tiexue.mcp.core.mapper;

import com.tiexue.mcp.core.entity.McpBook;
import com.tiexue.mcp.core.entity.McpChapter;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface McpChapterMapper {
    @Delete({
        "delete from McpChapter",
        "where Id = #{id,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer id);

    @Insert({
        "insert into McpChapter (Id, Name, ",
        "Words, BookId, BookName, ",
        "AuditStatus, AuditInfo, ",
        "CPId, CPBookId, ",
        "CPChapterId, `Order`, ",
        "UpdateTime, CreateTime, ",
        "IsVip, Price, Md5, ",
        "Content)",
        "values (#{id,jdbcType=INTEGER}, #{name,jdbcType=VARCHAR}, ",
        "#{words,jdbcType=INTEGER}, #{bookid,jdbcType=INTEGER}, #{bookname,jdbcType=VARCHAR}, ",
        "#{auditstatus,jdbcType=INTEGER}, #{auditinfo,jdbcType=VARCHAR}, ",
        "#{cpid,jdbcType=INTEGER}, #{cpbookid,jdbcType=VARCHAR}, ",
        "#{cpchapterid,jdbcType=VARCHAR}, #{order,jdbcType=INTEGER}, ",
        "#{updatetime,jdbcType=TIMESTAMP}, #{createtime,jdbcType=TIMESTAMP}, ",
        "#{isvip,jdbcType=INTEGER}, #{price,jdbcType=INTEGER}, #{md5,jdbcType=VARCHAR}, ",
        "#{content,jdbcType=LONGVARCHAR})"
    })
    @Options(useGeneratedKeys = true, keyProperty = "Id")
    int insert(McpChapter record);

    int insertSelective(McpChapter record);

    @Select({
        "select",
        "Id, Name, Words, BookId, BookName, AuditStatus, AuditInfo, CPId, CPBookId, CPChapterId, ",
        "`Order`, UpdateTime, CreateTime, IsVip, Price, Md5, Content",
        "from McpChapter",
        "where Id = #{id,jdbcType=INTEGER}"
    })
    @ResultMap("ResultMapWithBLOBs")
    McpChapter selectByPrimaryKey(Integer id);
    
    @Select({"select",
        "Id, Name, Words, BookId, BookName, AuditStatus, AuditInfo, CPId, CPBookId, CPChapterId, ",
        "`Order`, UpdateTime, CreateTime, IsVip, Price, Md5, Content",
        "from McpChapter",
        "where BookId = #{bookId,jdbcType=INTEGER} limit ${pStart},${pSize}"})
    @ResultMap("BaseResultMap")
    List<McpChapter> selectList(@Param("bookId")Integer bookId,@Param("pStart")Integer pStart,@Param("pSize")Integer pSize);
    
    

    int updateByPrimaryKeySelective(McpChapter record);

    @Update({
        "update McpChapter",
        "set Name = #{name,jdbcType=VARCHAR},",
          "Words = #{words,jdbcType=INTEGER},",
          "BookId = #{bookid,jdbcType=INTEGER},",
          "BookName = #{bookname,jdbcType=VARCHAR},",
          "AuditStatus = #{auditstatus,jdbcType=INTEGER},",
          "AuditInfo = #{auditinfo,jdbcType=VARCHAR},",
          "CPId = #{cpid,jdbcType=INTEGER},",
          "CPBookId = #{cpbookid,jdbcType=VARCHAR},",
          "CPChapterId = #{cpchapterid,jdbcType=VARCHAR},",
          "`Order` = #{order,jdbcType=INTEGER},",
          "UpdateTime = #{updatetime,jdbcType=TIMESTAMP},",
          "CreateTime = #{createtime,jdbcType=TIMESTAMP},",
          "IsVip = #{isvip,jdbcType=INTEGER},",
          "Price = #{price,jdbcType=INTEGER},",
          "Md5 = #{md5,jdbcType=VARCHAR},",
          "Content = #{content,jdbcType=LONGVARCHAR}",
        "where Id = #{id,jdbcType=INTEGER}"
    })
    int updateByPrimaryKeyWithBLOBs(McpChapter record);

    @Update({
        "update McpChapter",
        "set Name = #{name,jdbcType=VARCHAR},",
          "Words = #{words,jdbcType=INTEGER},",
          "BookId = #{bookid,jdbcType=INTEGER},",
          "BookName = #{bookname,jdbcType=VARCHAR},",
          "AuditStatus = #{auditstatus,jdbcType=INTEGER},",
          "AuditInfo = #{auditinfo,jdbcType=VARCHAR},",
          "CPId = #{cpid,jdbcType=INTEGER},",
          "CPBookId = #{cpbookid,jdbcType=VARCHAR},",
          "CPChapterId = #{cpchapterid,jdbcType=VARCHAR},",
          "`Order` = #{order,jdbcType=INTEGER},",
          "UpdateTime = #{updatetime,jdbcType=TIMESTAMP},",
          "CreateTime = #{createtime,jdbcType=TIMESTAMP},",
          "IsVip = #{isvip,jdbcType=INTEGER},",
          "Price = #{price,jdbcType=INTEGER},",
          "Md5 = #{md5,jdbcType=VARCHAR}",
        "where Id = #{id,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(McpChapter record);
    
    @Select({"select count(1) from McpChapter where ${strWhere}"})
    int getCount(@Param("strWhere")String strWhere);
    
    
    @Select({"select",
        "Id, Name, Words, BookId, BookName, AuditStatus, AuditInfo, CPId, CPBookId, CPChapterId, ",
        "`Order`, UpdateTime, CreateTime, IsVip, Price, Md5, Content",
        "from McpChapter",
        " where CPId=#{cpId} and CPBookId = #{cpBId} and CPChapterId = #{cpCId}"})
    @ResultMap("BaseResultMap")
    McpChapter selectByCpBId(@Param("cpId")Integer cpId,@Param("cpBId")String cpBId,@Param("cpCId")String cpCId);
}