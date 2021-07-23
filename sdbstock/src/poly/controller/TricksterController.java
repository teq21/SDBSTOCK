package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TricksterController {

private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="trickster")
	public String trickster() {
		log.info(this.getClass());
		
		return "/trickster/trickster";
	}
	
}
