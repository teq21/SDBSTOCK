package poly.service;

import java.util.Map;

import poly.dto.UserInfoDTO;

public interface IUserInfoService {
	
	/**
	 * 회원가입 데이터 저장하기
	 * @param pDTO 저장될 정보
	 * @return res = 0(데이터 등록 실패 - 아이디 중복)
	 * @return res = 1(데이터 등록 성공)
	 */
	int insertUserInfo(UserInfoDTO pDTO) throws Exception;
	
	/**
	 * 로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
	 * @param pDTO
	 */
	int getUserLoginCheck(UserInfoDTO pDTO) throws Exception;
	
	/**
	 * 업데이트할 회원정보 정보 가져오기
	 */
	Map<String, String> getUserInfo(UserInfoDTO pDTO) throws Exception;
	
	/**
	 * 회원정보 업데이트
	 */
	String userUpdate(UserInfoDTO pDTO) throws Exception;

}
