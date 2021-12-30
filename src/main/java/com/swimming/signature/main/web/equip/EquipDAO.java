package com.github.bestheroz.main.web.equip;

import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.main.web.tablevo.mbr_equip_lst.TableMbrEquipLstVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface EquipDAO {
    List<EquipVO> getEquipVOList(final MemberVO memberVO);

    @Options(useGeneratedKeys = true, keyProperty = "seq")
    void insert(final EquipVO equipVO);
    void insertEquipList(final List<TableMbrEquipLstVO> tableMbrEquipLstVOList);
}
