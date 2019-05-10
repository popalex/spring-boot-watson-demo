package ro.alex.auth.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ibm.cloud.sdk.core.service.exception.NotFoundException;
import com.ibm.cloud.sdk.core.service.exception.RequestTooLargeException;
import com.ibm.cloud.sdk.core.service.exception.ServiceResponseException;
import com.ibm.cloud.sdk.core.service.security.IamOptions;
import com.ibm.watson.assistant.v2.Assistant;
import com.ibm.watson.assistant.v2.model.CreateSessionOptions;
import com.ibm.watson.assistant.v2.model.DialogRuntimeResponseGeneric;
import com.ibm.watson.assistant.v2.model.MessageInput;
import com.ibm.watson.assistant.v2.model.MessageOptions;
import com.ibm.watson.assistant.v2.model.MessageResponse;
import com.ibm.watson.assistant.v2.model.SessionResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WatsonAssistantServiceImpl implements WatsonAssistantService {

	// UPDATE IT !!!
	private final String APIKEY = "";
	private final String ASSISTANTID = "";

	@Autowired
	private HttpSession ses;

	@Override
	public String SendMessage(String text) {

		String wSessionId;
		String responseMessage = "";

		try {

			IamOptions iamOptions = new IamOptions.Builder().apiKey(APIKEY).build();
			Assistant service = new Assistant("2019-02-28", iamOptions);
			service.setEndPoint("https://gateway-lon.watsonplatform.net/assistant/api");

			if (ses.getAttribute("wSessionId") == null) {
				CreateSessionOptions soptions = new CreateSessionOptions.Builder(ASSISTANTID).build();
				SessionResponse sresponse = service.createSession(soptions).execute().getResult();
				wSessionId = sresponse.getSessionId();
				ses.setAttribute("wSessionId", wSessionId);
			} else {
				wSessionId = (String) ses.getAttribute("wSessionId");
			}

			MessageInput input = new MessageInput.Builder().messageType("text").text(text).build();
			MessageOptions options = new MessageOptions.Builder(ASSISTANTID, wSessionId).input(input).build();
			MessageResponse response = service.message(options).execute().getResult();

			System.out.println(response);
			 List<DialogRuntimeResponseGeneric> genericR = response.getOutput().getGeneric(); //.get(0).getText();

			 for (DialogRuntimeResponseGeneric item : genericR) {
				 responseMessage = responseMessage + item.getText();
			}

			return responseMessage;

		} catch (NotFoundException e) {
			System.out.println("Service returned status code " + e.getStatusCode() + ": " + e.getMessage());
			// Handle Not Found (404) exception
		} catch (RequestTooLargeException e) {
			System.out.println("Service returned status code " + e.getStatusCode() + ": " + e.getMessage());
			// Handle Request Too Large (413) exception
		} catch (ServiceResponseException e) {

			// Base class for all exceptions caused by error responses from the service
			System.out.println("Service returned status code " + e.getStatusCode() + ": " + e.getMessage());
		}

		return null;
	}

}
