package com.name.proj1.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.name.proj1.vo.Friend;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller	// 이건 접수 창구
@RequestMapping("/api")	// 창구 전체 이름은 inho
public class InhoController {
	@ResponseBody	// 직접 바로 응답
	@GetMapping("/inhos")
	public String inhos() {
	//	resp.getWriter().write("inhos"); //responsebody -> 응답 객체에 출력을 직접 요청, jsp로 가는것이 아님!
		return "inhos";
	}
	@ResponseBody
	@PostMapping("/inhos")
	public Map<String , String> inhos(@RequestBody Map<String , String> revMap) {
		log.info("체크 : {}" , revMap);	// 항상 눈으로 넘어돈 데이터 직접 확인!
		return revMap;
	}
	@ResponseBody
	@PutMapping("/inhos")
	public List<String> inhos(@RequestBody List<String> revList) {
		log.warn("체크 : {} " , revList);
		return revList;
		// 자바에서 리스트를 받으려면 클라이언트에서 배열이어야 한다
	}
	@ResponseBody
	@DeleteMapping("/inhos")
	public List<Friend> inhos2(@RequestBody List<Friend> fList) {
		log.debug("체크 : {} " , fList);
		return fList;
	}
}
