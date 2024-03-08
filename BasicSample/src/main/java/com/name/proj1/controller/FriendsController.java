package com.name.proj1.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.name.proj1.vo.Friend;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@CrossOrigin	// 검색 & 사용법
@RestController
@RequestMapping("/api")
public class FriendsController {
	/*
	 기본메소드 CRUD 5개 만들고 시작 -> 전체 리스트 , 1개 select , insert , update , delete
	 list - get
	 one - get
	 insert - post
	 update - put
	 delete - delete
	 @RestController -> 이하 메소드에서 @ResponseBody 생략 가능
	 RequestParam과 PathVariable 구분 주의
	 */
	private static List<Friend> listFriend = new ArrayList<>();
	
	// 객체가 생성되고 D.I도 된 다음에 실행하는 메소드에 쓰는 어노테이션?
	@PostConstruct
	public void InitFriends() {
		Friend friend = null;
		for(int i = 1 ; i <= 3; i++) {
			friend = new Friend();
			friend.setName("merong" + i);
			friend.setAge(i+20);
			friend.setAlias("huk"+i);
			listFriend.add(friend);
		}
	}
	// 전체 List
	@GetMapping("/friends")	// friends -> VO의 복수형을 주로 사용
	public List<Friend> friends() {
		log.info("전체리스트");
		return listFriend;
	}
	// 1개 선택(검색)
	@GetMapping("/friends/{name}")
	// {} -> @PathVariable로 받는다 , 변수명은 같은 변수명으로 일치시킨다
	public Friend friend(@PathVariable String name) {
		
		for(Friend friend : listFriend) {
			if(friend.getName().equals(name)) {
				log.info("1개선택");
				return friend;
			}
		}
		return null;
	}
	// friend 데이터 넣기(insert)
	@PostMapping("/friends")
	public String friendIns(@RequestBody Friend newFriend) {
		listFriend.add(newFriend);
		log.info("데이터넣기");
		return "success";
	}
	// friend 데이터 수정하기(modify)
	@PutMapping("/friends")
	public String friendUp(@RequestBody Friend modFriend) {
		for(Friend friend : listFriend) {
			if(friend.getName().equals(modFriend.getName())) {
				friend.setAge(modFriend.getAge());
				friend.setAlias(modFriend.getAlias());
				break;
			};
		}
		log.info("업데이트");
		return "success";
	}
	// friend 데이터 삭제하기(delete)
	@DeleteMapping("/friends/{name}")
	public String friendDel(@PathVariable String name) {
		for(Friend friend : listFriend) {
			if(friend.getName().equals(name)) {
				listFriend.remove(friend);
				log.info("delete success");
				break;
			}
		}
		return "success";
	}
}
