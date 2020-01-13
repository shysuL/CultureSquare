<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" /> 

<style>
.map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:104px;height:33	px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;     margin-top: 2%;
    margin-right: 2%;
}
.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
.custom_typecontrol .selected_btn:hover {color:#fff;}   
.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5; margin-top: 6%;
    margin-right: 2%;} 
.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}             
.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;}  
.title {font-weight:bold;display:block;}
.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#centerAddr {display:block;margin-top:2px;font-weight: normal;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>



<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script>
    window.onload = function(){
       ck = CKEDITOR.replace("contents");
    };
</script>

<script type="text/javascript">
var g_count =1;
$(document).ready(function() {
	
	// 지도모달창에서 추가 버튼 눌렀을 때
	$("#mapAddBtn").click(function(){
		
		var html = "";
		html += "공연 위치 정보";
		html += detailaddress;		
		$("#perLocIn").html(html)
		console.log(detailaddress);
		
		console.log("위도")
		console.log(latitude)
		console.log("경도")
		console.log(longitude)

	    // input tag에 넣어주기
	    $('#lat').val(latitude);
	    $('#lon').val(longitude);

	})
	
	// 공연 위치 정보 추가하기
	$('#addMap').on("click",function(){
		console.log(1);
		$("#mapModal").modal({backdrop: 'static', keyboard: false});
	});
	
	$("#mapModal").on('shown.bs.modal',function(){
		map.relayout();
	})
	
	
	$("#btnWrite").click(function() {

		console.log("작성작성");
		
		if($('#title').val() == ''){
			$("#writeTitleModal").modal({backdrop: 'static', keyboard: false});
		}

		
		else{
		//form submit
		$("form").submit();
		}
	});
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
	$("a[name='delete']").on("click",function(e){
		e.preventDefault();
		fn_fileDelete($(this));
	})
	$("#add").on("click",function(e){
		e.preventDefault();
		fn_fileAdd();
	})	

});

function fn_fileDelete(obj){
	obj.parent().remove();
}
function fn_fileAdd(){
	var str = "<p><input type='file' name='file_"+(g_count++)+"'/><button type='button' id='delete' name = 'delete'class='btn btn-danger'>삭제하기</button></p> ";
	$("#fileDiv").append(str);
	
	$("button[name='delete']").on("click",function(e){
		e.preventDefault();
		fn_fileDelete($(this));			
	})
}
</script>
<script>
    var editorConfig = {
        filebrowserUploadUrl : "/resources/ckeditor/imgUpload", //이미지 업로드
    };

    CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;

        switch (dialogName) {
            case 'image': //Image Properties dialog
            //dialogDefinition.removeContents('info');
            dialogDefinition.removeContents('Link');
            dialogDefinition.removeContents('advanced');
            break;
        }
    });
 window.onload = function(){
      ck = CKEDITOR.replace("editor", editorConfig);
 };
</script>

<style type="text/css">
#contents {
	width: 95%;
}
#write_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 100%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}

#contentsarea{
	width: 100%px;
	height:600px;
	border: 1px solid black;
}
#fileup{
	width: 800px;
	height:auto;
	border: 1px solid black;
}
</style>



<div class="container container-fluid" style="margin-bottom: 300px">
<br>
<h1>WRITE</h1>
<hr>

<div class="row">
	<div class="col-9">
		<div id = "write_head" class="col-xs-12 col-sm-6 col-md-8">
			<span>필수 입력 사항</span>
		</div>
		<form action="/artboard/write" method="post" enctype="multipart/form-data" name="writeSend">
		<br>
			<div>
				<label for="title"><b> 제목 </b></label><br>
				<input id="title" name="title" type="text" size="100%"  placeholder=" 제목을 입력하세요."/>
			</div>
			<br>
			<div>
				<label for="performdate"> <b>일시 </b></label><br>
				<input id="performdate" name="performdate" type="date" size="25%"  placeholder=" 입력 양식 : 20201221"/>
			</div>
			<br>
			<div>
				<label for="performname"> <b>게시물 카테고리 </b></label><br>
			</div>
		
			<div id = "performradio"> 
				<span class="radio">
			  		<label>
			   			<input type="radio" name="performname"  value="버스킹" checked>버스킹
			 		</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="전시회">전시회
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="연극">연극
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="뮤지컬">뮤지컬
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="콘서트">콘서트
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="행사">행사
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="축제">축제
					</label>
				</span>
		
			</div>
			<br>
			<label for="contents"> <b>상세내용 </b></label><br>
		
			<div id = "contentsarea">
				<textarea id="contents" name="contents"></textarea>
				<script type="text/javascript">
					 CKEDITOR.replace('contents', {height: 400,toolbar: 'Full'})
				</script>
			</div>
			<br>
			<div id="fileDiv" style="text-align: right;">
				<p>
					<input type="file" name="file_0" /><button type="button" id="delete" name = "delete" class="btn btn-danger">삭제하기</button>
				</p> 
			</div>
		
			<input type="hidden" id = "userno" name = "userno" value = "${userno.userno }"/>
			<input type="hidden" id = "lat" name="lat" />
			<input type="hidden" id = "lon" name="lon" />
 		</form>
	</div>

	<div class="col-3">
		<div class="list-group" >
	 		<a class="list-group-item" id="pfIntroduceContent">CALENDAR 글쓰기안내</a>
	 		<a class="list-group-item tit" style="font-size: 14px">
	 			타 사이트의 게시물을 옮겨오실 경우 저작권 보호를 위해 내용을 그대로 붙여넣지 마시고 내용 요약 및 원문링크(또는 출처)를 삽입해 주세요.</a>
	 		<a class="list-group-item tit" style="font-size: 14px">	
	 			CultureSquare는 이미지 개별 첨부 이미지 당 5MB 이하 총 10MB 이미지까지 업로드 가능합니다. 다만 글을 읽으시는 분들께서 페이지 로딩에 지장을 받지 않도록 가급적 이미지 갯수는 적절히 조절해 주세요.</a>
		</div>
	</div>
</div>
	
	<div class="row">
	<div class="col-9">
		<div style="text-align: right;">
			<div id="perLocIn"></div>
			<button type="button" id="add" class="btn btn-info">파일 추가하기</button>
			<button type="button" id="addMap" class="btn btn-info">공연 위치 정보 추가</button>			
			<button type="button" id="btnWrite" class="btn bbc" >작성완료</button>
			<button type="button" id="btnCancel" class="btn bbc">작성취소</button>
		</div>
	</div>
	</div>


</div> <!-- div_container -->



<!-- 제목 작성 여부 확인 모달-->
<div class="modal fade" id="writeTitleModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 작성</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
     	 제목을 입력하세요
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="pfWriteErrorModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 지도  모달창 -->
<div class="modal fade bd-example-modal-lg" id="mapModal">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">공연 위치 정보 추가</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      
      <div class="map_wrap">
   		<div id="map" style="width:100%	;height:400px;position:relative;overflow:hidden;z-index-0"></div>
	    <div class="hAddr">
	        <span class="title">지도중심기준 행정동 주소정보</span>
	        <span id="centerAddr"></span>
	    </div>
	    <div class="custom_typecontrol radius_border">
	        <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')" style="width: 104px;">지도</span>
	        <span id="btnSkyview" class="btn" onclick="setMapType('skyview')" style="width: 104px;">스카이뷰</span>
	    </div>
	    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
	    <div class="custom_zoomcontrol radius_border"> 
	        <span onclick="zoomIn()">+</span>  
	        <span onclick="zoomOut()">-</span>
	    </div>
	    
	  </div>
      		
	 </div>
		<p id="result"></p>
				
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=955e62645517faafe40085ecec08d0c1&libraries=services,clusterer,drawing"></script>
		<script>
		
			var detailaddress
			var latitude
			var longitude

			var container = document.getElementById('map');
			var options = {
			center : new kakao.maps.LatLng(37.499206, 127.032773),
			level : 3
			};
			var map = new kakao.maps.Map(container, options);
			
		
			function relayout() {    
	    
	  		  // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
	  		  // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
	   		 // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
	  		  map.relayout();
				}
			
			// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
			function setMapType(maptype) { 
			    var roadmapControl = document.getElementById('btnRoadmap');
			    var skyviewControl = document.getElementById('btnSkyview'); 
			    if (maptype === 'roadmap') {
			        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
			        roadmapControl.className = 'selected_btn';
			        skyviewControl.className = 'btn';
			    } else {
			        map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
			        skyviewControl.className = 'selected_btn';
			        roadmapControl.className = 'btn';
			    }
			}

			// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
			function zoomIn() {
			    map.setLevel(map.getLevel() - 1);
			}

			// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
			function zoomOut() {
			    map.setLevel(map.getLevel() + 1);
			}
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			    
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr">' +
			                            '<span class="title">법정동 주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';

			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);

			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			            detailaddress = detailAddr;
			            console.log(detailaddress);
			        }   
			    });
			});

			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});

			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}

			function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');

			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}

			
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng;
			    
// 			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
// 			    message += '경도는 ' + latlng.getLng() + ' 입니다' + detailaddress;
			    
			    
			    var message = detailaddress;

			    var resultDiv = document.getElementById('result'); 
			    resultDiv.innerHTML = message;
			    
			    //위도
			    latitude=latlng.getLat()
			    //경도
			    longitude=latlng.getLng()
				console.log(latitude);
				console.log(longitude);

			    
			});
			
			
			
		</script>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="mapAddBtn"class="btn btn-dark" data-dismiss="modal">추가</button>
        <button type="submit" id="mapAddBtn"class="btn btn-dark" data-dismiss="modal">삭제</button>
      </div>

    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

