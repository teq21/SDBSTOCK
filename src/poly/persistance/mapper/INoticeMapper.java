package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.NoticeDTO;

@Mapper("NoticeMapper") // Service�뿉�꽌 mapper瑜� 李얠쓣 �닔 �엳�룄濡�
public interface INoticeMapper {

	int doNoticeForm(NoticeDTO pDTO);
	
	List<NoticeDTO> getNoticeList(@Param("start")int start, @Param("end")int end) throws Exception;

	NoticeDTO getNoticeDetail(NoticeDTO pDTO);

	int updateNotice(NoticeDTO pDTO);

	int doDeleteNotice(NoticeDTO pDTO);

	int getNoticeListCnt();

}
