package com.github.bestheroz.main.web.tablevo.admin_mbr_mst;

import com.github.bestheroz.standard.common.tablevo.SqlForTableDAO;
import com.github.bestheroz.standard.common.tablevo.SqlForTableVO;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectProvider;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Mapper
@Repository
public interface TableAdminMbrMstDAO extends SqlForTableDAO {

    @SelectProvider(type = SqlForTableVO.class, method = SqlForTableVO.SELECT)
    List<TableAdminMbrMstVO> getList(final TableAdminMbrMstVO vo, final Set<String> whereKeys, final String orderByColumns);

    @SelectProvider(type = SqlForTableVO.class, method = SqlForTableVO.SELECT_ONE)
    TableAdminMbrMstVO getVO(final TableAdminMbrMstVO vo, final Set<String> whereKeys);

    @Override
    @InsertProvider(type = SqlForTableVO.class, method = SqlForTableVO.INSERT)
    <T> void insert(final T vo);
}
