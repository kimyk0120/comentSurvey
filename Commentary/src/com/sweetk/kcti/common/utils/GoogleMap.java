package com.sweetk.kcti.common.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GoogleMap {
	    
	    @RequestMapping("/google_map.do")
	    public void google_map(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
	    	
	    	response.setContentType("application/json; charset=utf-8");
	        PrintWriter out = null;
	        out = new PrintWriter(response.getWriter());
	        
    		String latlng = (String)req.getParameter("latlng");

    		GpsToAddress gps = new GpsToAddress(latlng);
    		String str = gps.getAddress();
    		
    		out.print(str);
			out.flush();
			out.close();
	    	
	    }
	    
	    class GpsToAddress {
	    	String latlng;
	    	String regionAddress;

	    	public GpsToAddress(String latlng) throws Exception {
	    		this.latlng = latlng;
	    		this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
	    	}

	    	private String getApiAddress() {
	    		String apiURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
	    				+ latlng + "&language=ko";
	    		return apiURL;
	    	}

	    	private String getJSONData(String apiURL) throws Exception {
	    		String jsonString = new String();
	    		String buf;
	    		URL url = new URL(apiURL);
	    		URLConnection conn = url.openConnection();
	    		BufferedReader br = new BufferedReader(new InputStreamReader(
	    				conn.getInputStream(), "UTF-8"));
	    		while ((buf = br.readLine()) != null) {
	    			jsonString += buf;
	    		}
	    		return jsonString;
	    	}

	    	private String getRegionAddress(String jsonString) {
	    		
	    		return jsonString;
	    		
	    		/*System.out.println("jsonString : " + jsonString);
	    		
	    		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
	    		System.out.println("jObj : " + jObj);
	    		
	    		JSONArray jArray = (JSONArray) jObj.get("results");
	    		System.out.println("jArray : " + jArray);
	    		
	    		jObj = (JSONObject) jArray.get(0);
	    		System.out.println("jObj22 : " + jObj);
	    		
	    		return (String) jObj.get("formatted_address");*/
	    	}

	    	public String getAddress() {
	    		return regionAddress;
	    	}
	    }
	    
	    
	  
}