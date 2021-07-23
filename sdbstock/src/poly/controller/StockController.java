package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StockController {
private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="stockindex")
	public String stockindex() {
		log.info(this.getClass());
		
		return "/stock/stock_index";
	}
	
	
	@RequestMapping(value="stockpredict")
	public String stockpredict() {
		log.info(this.getClass());
		
		return "/stock/stock_predict";
	}
}
