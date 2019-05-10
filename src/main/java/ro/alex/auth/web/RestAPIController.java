package ro.alex.auth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import ro.alex.auth.model.Messages;
import ro.alex.auth.service.WatsonAssistantService;

@RestController
@RequestMapping("/ws")
public class RestAPIController {

	@Autowired
	private WatsonAssistantService was;

	@RequestMapping(value="/sendMessage", method = RequestMethod.POST)
    public Messages sendMessage(@RequestBody Messages message) {
		Messages result = new Messages();
		System.out.println("Incomming message : " + message.getMessage());

		result.setMessage(was.SendMessage(message.getMessage()));

        return result;
    }

}
