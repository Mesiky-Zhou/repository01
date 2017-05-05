package com.framework.dao;

import com.framework.bean.User;
import com.framework.bean.UserCondition;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    long countByExample(UserCondition example);

    int deleteByExample(UserCondition example);

    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserCondition example);

    User selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserCondition example);

    int updateByExample(@Param("record") User record, @Param("example") UserCondition example);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
}