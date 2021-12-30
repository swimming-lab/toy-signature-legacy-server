package com.github.bestheroz.main.web.member;

import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MemberDAO {
    List<MemberVO> search(final MemberVO memberVO);
    void insert(final TableMbrInfoMstVO tableMbrInfoMstVO);
    String selectViewBizcoYn(final int customerId);
}