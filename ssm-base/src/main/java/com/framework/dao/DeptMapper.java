package com.framework.dao;

import com.framework.bean.Dept;
import com.framework.bean.DeptCondition;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DeptMapper {
    long countByExample(DeptCondition example);

    int deleteByExample(DeptCondition example);

    int deleteByPrimaryKey(Integer id);

    int insert(Dept record);

    int insertSelective(Dept record);

    List<Dept> selectByExample(DeptCondition example);

    Dept selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Dept record, @Param("example") DeptCondition example);

    int updateByExample(@Param("record") Dept record, @Param("example") DeptCondition example);

    int updateByPrimaryKeySelective(Dept record);

    int updateByPrimaryKey(Dept record);
}