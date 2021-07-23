package poly.persistance.mongo.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.IndexOptions;
import com.mongodb.client.model.Indexes;

import poly.dto.UserInfoDTO;
import poly.persistance.mongo.IUserInfoMapper;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Component("UserInfoMapper")
public class UserInfoMapper implements IUserInfoMapper {

	@Autowired
	private MongoTemplate mongodb;

	private Logger log = Logger.getLogger(this.getClass());
	
	final private String USER_INFO_COLLECTION = "UserInfo";
	
	// 회원 가입
	@Override
	public int insertUserInfo(UserInfoDTO pDTO) throws Exception {

		log.info(this.getClass().getName() + ".insertUserInfo Start!");

		// 등록 결과
		int res;

		// 서비스에서 값이 정상적으로 못 넘어오는 경우를 대비하기 위해 사용함
		if (pDTO == null) {
			pDTO = new UserInfoDTO();
		}

		// 저장할 컬렉션명
		String colNm = USER_INFO_COLLECTION;

		// 등록할 회원 아이디
		String user_id = CmmUtil.nvl(pDTO.getUser_id());

		log.info("회원정보 등록할 컬렉션 이름 : " + colNm);
		log.info("등록할 아이디 : " + user_id);

		// 기존에 등록된 컬렉션 이름이 존재하는지 체크하고, 컬렉션이 없는 경우 생성함
		if (!mongodb.collectionExists(colNm)) {

			mongodb.createCollection(colNm);

			// 컬렉션에 인덱스 생성(유니크)
			IndexOptions indexOptions = new IndexOptions().unique(true);
			mongodb.getCollection(colNm).createIndex(Indexes.ascending("user_id"), indexOptions);

		}

		// 저장할 컬렉션 객체 생성
		MongoCollection<Document> col = mongodb.getCollection(colNm);

		// 중복 아이디 확인할 쿼리
		Document query = new Document();

		query.append("user_id", user_id);

		// MongoDB에 등록된 아이디 없으면 실행
		// .first()를 쓰면 첫번째 Document 가져옴(형태 Document)
		if (col.find(query).first() == null) {

			// 등록할 나머지 회원 정보
			String user_name = CmmUtil.nvl(pDTO.getUser_name());
			String password = CmmUtil.nvl(pDTO.getPassword());
			String email = CmmUtil.nvl(pDTO.getEmail());
			String reg_id = CmmUtil.nvl(pDTO.getReg_id());
			String reg_dt = CmmUtil.nvl(pDTO.getReg_dt());
			String chg_id = CmmUtil.nvl(pDTO.getChg_id());
			String chg_dt = CmmUtil.nvl(pDTO.getChg_dt());

			Document insertDoc = new Document();

			insertDoc.append("user_id", user_id);
			insertDoc.append("user_name", user_name);
			insertDoc.append("password", password);
			insertDoc.append("email", email);
			insertDoc.append("reg_id", reg_id);
			insertDoc.append("reg_dt", reg_dt);
			insertDoc.append("chg_id", chg_id);
			insertDoc.append("chg_dt", chg_dt);

			col.insertOne(insertDoc);

			insertDoc = null;

			// MongoDB에 등록 성공
			res = 0;

			log.info("회원정보 등록 완료");

		} else {

			// MongoDB에 등록 실패 - 아이디 중복
			res = 1;

			log.info("회원정보 등록 실패");
		}

		// 메모리에서 강제로 비우기
		pDTO = null;
		col = null;
		query = null;

		log.info(this.getClass().getName() + ".insertUserInfo End!");

		return res;
	}
	
	// 로그인 체크
	@Override
	public int getUserLoginCheck(UserInfoDTO pDTO) throws Exception {

		log.info(this.getClass().getName() + ".getUserLoginCheck start!");
		
		if(pDTO == null) {
			pDTO = new UserInfoDTO();
		}
		
		// 조회 결과
		int res;
		
		// 저장할 컬렉션명
		String colNm = USER_INFO_COLLECTION;

		// 등록할 회원 아이디
		String user_id = CmmUtil.nvl(pDTO.getUser_id());
		String password = CmmUtil.nvl(pDTO.getPassword());

		log.info("회원정보 조회할 컬렉션 이름 : " + colNm);
		log.info("조회할 아이디 : " + user_id);

		// 조회할 컬렉션 객체 생성
		MongoCollection<Document> col = mongodb.getCollection(colNm);
		
		// 중복 아이디 확인할 쿼리
		Document query = new Document();

		query.append("user_id", user_id);
		
		
		// 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
		Document projection = new Document();
		
		// MongoDB는 무조건 ObjectID가 자동생성되며, ObjectID는 사용하지 않을 때, 조회할 필요가 없음
		// ObjectID를 가지고 오지 않을 때 사용함
		projection.append("_id", 0);		
		projection.append("user_id", "$user_id");
		projection.append("password", "$password");
		
		//.first()를 쓰면 첫번째 Document 가져옴(형태 Document)
		Document doc = col.find(query).projection(projection).first();
				
		// MongoDB에 등록된 아이디 있으면 실행
		if (doc != null) {
			
			String db_user_id = CmmUtil.nvl(doc.getString("user_id"));
			String db_password = CmmUtil.nvl(doc.getString("password"));
			
			if(user_id.equals(db_user_id) && password.equals(db_password)) {
				
				// 회원 아이디, 비밀번호 일치
				res = 0;
				
				log.info("로그인 아이디 조회 결과 : DB와 회원정보 일치");
				
			} else {
				
				// 회원 아이디, 비밀번호 불일치
				res = 1;
				
				log.info("로그인 아이디 조회 결과 : DB와 회원정보 불일치");
			}

		} else {

			// 가입되지 않은 회원 아이디
			res = 2;

			log.info("로그인 아이디 조회 결과 : DB에 회원정보 없음");
		}
		
		//메모리 정리
		col=null;
		query=null;
		projection=null;
		doc=null;

		log.info(this.getClass().getName() + ".getUserLoginCheck End!");
		
		return res;
	}

	// 업데이트할 회원정보 가져오기
	@Override
	public Map<String, String> getUserInfo(UserInfoDTO pDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getUserInfo start!");
		
		if(pDTO==null) {
			pDTO = new UserInfoDTO();
		}
		
		// 결과 담을 객체
		Map<String, String> rMap = new HashMap<String, String>();
		
		// 컬렉션명
		String colNm = USER_INFO_COLLECTION;

		// 확인할 회원정보
		String user_id = CmmUtil.nvl(pDTO.getUser_id());
		String password = CmmUtil.nvl(pDTO.getPassword());

		log.info("회원정보 조회할 컬렉션 이름 : " + colNm);
		log.info("조회할 아이디 : " + user_id);

		// 조회할 컬렉션 객체 생성
		MongoCollection<Document> col = mongodb.getCollection(colNm);
		
		// 회원정보 확인할 쿼리
		Document query = new Document();

		query.append("user_id", user_id);
		query.append("password", password);
		
		// 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
		Document projection = new Document();
		
		// MongoDB는 무조건 ObjectID가 자동생성되며, ObjectID는 사용하지 않을 때, 조회할 필요가 없음
		// ObjectID를 가지고 오지 않을 때 사용함
		projection.append("_id", 0);		
		projection.append("user_id", "$user_id");
		projection.append("user_name", "$user_name");
		projection.append("email", "$email");
		
		//.first()를 쓰면 첫번째 Document 가져옴(형태 Document)
		Document doc = col.find(query).projection(projection).first();
		
		// 회원 아이디, 비밀번호 일치
		if (doc != null) {
					
			// MongoDB에 등록된 아이디 있으면 실행
			String db_user_id = CmmUtil.nvl(doc.getString("user_id"));
			String db_user_name = CmmUtil.nvl(doc.getString("user_name"));
			// 이메일 복호화
			String db_email = CmmUtil.nvl(EncryptUtil.decAES128CBC(doc.getString("email")));
			
			rMap.put("result", "1");
			rMap.put("user_id", db_user_id);
			rMap.put("user_name", db_user_name);
			rMap.put("user_email", db_email);
			
			log.info("해당 회원정보 조회 결과 : 일치");
						
		} else {
			// 회원 아이디, 비밀번호 불일치
			rMap.put("result", "0");
						
			log.info("해당 회원정보 조회 결과 : 불일치");
		}		
		
		//메모리 정리
		pDTO = null;
		doc=null;
		col=null;
		query=null;
		projection=null;

		log.info(this.getClass().getName() + ".getUserInfo End!");
		
		return rMap;
	}
	
	// 회원정보 업데이트
	@Override
	public String userUpdate(UserInfoDTO pDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".userUpdate Start!");

		// 업데이트 결과(0 실패, 1 성공)
		String res = "0";

		// 서비스에서 값이 정상적으로 못 넘어오는 경우를 대비하기 위해 사용함
		if (pDTO == null) {
			pDTO = new UserInfoDTO();
		}

		// 저장할 컬렉션명
		String colNm = USER_INFO_COLLECTION;

		// 업데이트 정보
		String user_id = CmmUtil.nvl(pDTO.getUser_id());
		String user_name = CmmUtil.nvl(pDTO.getUser_name());
		String password = CmmUtil.nvl(pDTO.getPassword());
		String email = CmmUtil.nvl(pDTO.getEmail());
		String chg_id = CmmUtil.nvl(pDTO.getChg_id());
		String chg_dt = CmmUtil.nvl(pDTO.getChg_dt());

		log.info("회원정보 등록할 컬렉션 이름 : " + colNm);
		log.info("업데이트할 아이디 : " + user_id);
		
		// 저장할 컬렉션 객체 생성
		MongoCollection<Document> col = mongodb.getCollection(colNm);

		// 찾을 아이디 쿼리
		Document query = new Document();

		query.append("user_id", user_id);

		// 업데이트 정보
		Document setData = new Document();
		
		// 바꿀 비밀번호 있으면 
		if(!"".equals(password)) {
			setData.append("user_name", user_name)
						.append("password", password)
						.append("email", email)
						.append("chg_id", chg_id)
						.append("chg_dt", chg_dt);
		} else {
			// 바꿀 비밀번호 없으면
			setData.append("user_name", user_name)
						.append("email", email)
						.append("chg_id", chg_id)
						.append("chg_dt", chg_dt);
		}
		
		// 업데이트 쿼리
		Document updateQ = new Document();

		updateQ.append("$set", setData);
		
		// MongoDB 명령 실행
		col.updateOne(query, updateQ);
		
		log.info("회원정보 업데이트 완료");
		
		// 성공
		res = "1";

		// 메모리에서 강제로 비우기
		pDTO = null;
		setData = null;
		col = null;
		updateQ = null;
		query = null;

		log.info(this.getClass().getName() + ".userUpdate End!");

		return res;
	}

}
