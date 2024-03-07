<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Restful Client</title>
    </head>
    <body>
        <h1>이거슨 시작페이징</h1>
        <div id="frList"></div>
        <form action="">
            name: <input type="text" name="name" id="name" value=""><br>
            age: <input type="number" name="age" id="age" value=""><br>
            alias: <input type="text" name="alias" id="alias" value=""><br>
            <button onclick="friendList()">조회(리스트)</button>
            <button type="button" onclick="getFriend()">조회(1명)</button>
            <button type="button" onclick="postFriend()">생성</button>
            <button type="button" onclick="putFriend()">수정</button>
            <button type="button" onclick="deleteFriend()">삭제</button>
        </form>
        <script>

            // 원래 ajax, jquery ajax, fetch 정리 할 것

            // 리스트 가져오깅
            const friendList = function () {
                let rslt;
                let xhr = new XMLHttpRequest();
                xhr.open("get", "/api/friends", true);  // 동기/비동기 답변 번개처럼 할 수 있도록!
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log(JSON.parse(xhr.responseText)); // 결과 확인
                       // rslt = xhr.responseText;
                       let frdList = JSON.parse(xhr.responseText);
                       
                       let tblStr = "<table border=1>";
                           tblStr += "<tr><th>인덱스</th><th>이름</th><th>나이</th><th>별명</th></tr>";
                       for(let i=0; i<frdList.length; i++){
                           let friend = frdList[i];
                           // spring el문법과 js template string 문법이 정확히 일치하는 문제
                           // jsp 안에서 쓸때만 javascript변수에만  \를 붙여준당. 
                           tblStr += `
                                 <tr>
                                   <td>\${i}</td> 
                                   <td>\${friend.name}</td> 
                                   <td>\${friend.age}</td> 
                                   <td>\${friend.alias}</td> 
                                </tr>   
                           `;
                       }
                       tblStr += "</table>";
                       document.querySelector("#frList").innerHTML = tblStr;
                    }
                }
                xhr.send();
               // console.log("체킁:", rslt); // ? 보인당? 안보인당?
            }
            friendList();

            // friend검색
            const getFriend = function () {
                let schName = document.forms[0].name.value;

                let xhr = new XMLHttpRequest();
                xhr.open("get", `/api/friends/\${schName}`, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("체킁1:",JSON.parse(xhr.responseText));
                        let frdInfo = JSON.parse(xhr.responseText);
                        document.forms[0].age.value = frdInfo.age;
                        document.forms[0].alias.value = frdInfo.alias;
                    }
                }
                xhr.send();
            }
//            getFriend();


            // friend 추가
            const postFriend = function () {
                let friend = {
                    name: document.forms[0].name.value ,
                    age: document.forms[0].age.value,
                    alias: document.forms[0].alias.value
                }

                let xhr = new XMLHttpRequest();
                xhr.open("post", "/api/friends", true);
                xhr.setRequestHeader("Content-Type","application/json;charset=utf-8");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("체킁2:", xhr.responseText);
                        friendList(); // 리스트 다시 뿌리깅!
                    }
                }
                xhr.send(JSON.stringify(friend));
            }
            //postFriend();
            //friendList();
            
            // friend 수정
            const putFriend = function () {
                let friend = {
                    name: document.forms[0].name.value,
                    age: document.forms[0].age.value,
                    alias: document.forms[0].alias.value
                }

                let xhr = new XMLHttpRequest();
                xhr.open("put","/api/friends", true);
                xhr.setRequestHeader("Content-Type","application/json;charset=utf-8");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("체킁3:", xhr.responseText);
                        friendList();
                    }
                }
                xhr.send(JSON.stringify(friend));
            }
            //putFriend();
            //setTimeout(()=>{
            //    friendList()   // 비동기라서 일부러 잠시 뒤에 호출
            //},500);


            // friend 삭제
            const deleteFriend = function () {
                let delName = document.forms[0].name.value;
                let xhr = new XMLHttpRequest();
                xhr.open("delete",`/api/friends/\${delName}`, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("체킁4:", xhr.responseText);
                        document.forms[0].name.value = "";
                        document.forms[0].age.value = "";
                        document.forms[0].alias.value = "";
                        document.forms[0].name.focus();
                        friendList(); // 리스트 다시 출력
                    }
                }
                xhr.send();
            }
            //deleteFriend();
            //setTimeout(()=>{
            //    friendList()   // 비동기라서 일부러 잠시 뒤에 호출
            //},500);


        </script>
    </body>

    </html>