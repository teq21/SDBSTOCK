package poly.persistance.mapper;


import config.Mapper;
import poly.dto.UserInfoDTO;

@Mapper("UserInfoMapper")
public interface UserInfoMapper {

//회원가입하기(회원정보 등록하기)
	int InsertUserInfo(UserInfoDTO pDTO)throws Exception;
//회원가입전 중복 체크하기
	UserInfoDTO getUserExists(UserInfoDTO pDTO) throws Exception;
}
