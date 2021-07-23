package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.INoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService") // Controller�뿉�꽌 Service瑜� 李얠쓣 �닔 �엳�뒗 �씠由�.
public class NoticeService implements INoticeService {

	@Resource(name = "NoticeMapper")
	INoticeMapper noticeMapper;
	
	@Override
	public int doNoticeForm(NoticeDTO pDTO) {
		
		return noticeMapper.doNoticeForm(pDTO);
	}

	@Override
	public List<NoticeDTO> getNoticeList(int start, int end) throws Exception {
		
		return noticeMapper.getNoticeList(start, end);
	}

	@Override
	public NoticeDTO getNoticeDetail(NoticeDTO pDTO) {
		
		return noticeMapper.getNoticeDetail(pDTO);
	}

	@Override
	public int updateNotice(NoticeDTO pDTO) {
		
		return noticeMapper.updateNotice(pDTO);
	}

	@Override
	public int doDeleteNotice(NoticeDTO pDTO) {
		
		return noticeMapper.doDeleteNotice(pDTO);
	}

	@Override
	public int getNoticeListCnt() throws Exception {
		
		return noticeMapper.getNoticeListCnt();
	}

	

	
}
