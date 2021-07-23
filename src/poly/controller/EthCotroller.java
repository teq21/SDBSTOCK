package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EthCotroller {
private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="ethchart")
	public String ethCHART() {
		log.info(this.getClass());
		
		return "/btc/eth_chartjsp";
	}
	
	@RequestMapping(value="btcpredict")
	public String btcpredict() {
		log.info(this.getClass());
		
		return "/btc/btc_predict";
	}
	
	
}
