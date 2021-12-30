package com.github.bestheroz.main.web.admin;

import com.github.bestheroz.main.web.arrears.ArrearsVO;
import com.github.bestheroz.main.web.member.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface AdminDAO {
    List<MemberVO> getMemberVOList(final AdminVO adminVO);
    List<ArrearsVO> getArrearsVOList(final AdminVO adminVO);
}
