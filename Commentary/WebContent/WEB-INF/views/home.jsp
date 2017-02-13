<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title> MAP_TEST </title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<title>(예제)지오코더API 2.0(좌표조회)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<script type="text/javascript" src="http://map.vworld.kr/jquery/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="common/js/ui.js"></script>
		<!-- <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=2c62fd2aee5d82475cb6869adcc3b17f&libraries=services,clusterer"></script> -->
		<script type="text/javascript">
		/* function go_test() {
			$.ajax({ 
				   url: "mail_test.do", 
				   type: "POST", 
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   alert("succecss");
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
			
		} */
		
		var map = null;
		var x = "36.40467851138864";
		var y = "128.01654147490225";
		var marker = null;
		
/* 		$(document).ready(function() {
			
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			
			var len = "<c:out value="${fn:length(list)}"/>";
			
			if(len > 0) {
					var options = { //지도를 생성할 때 필요한 기본 옵션
						center: new daum.maps.LatLng(x, y), //지도의 중심좌표.
						level: 12 //지도의 레벨(확대, 축소 정도)
					};

					var map = new daum.maps.Map(container, options);
					
					// 마커를 표시할 위치와 title 객체 배열입니다 
					var positions = [
						<c:forEach items="${list}" var="c" varStatus="esgStatus">
								{ 
									"lat" : <c:out value="${c.lat}" />,
									"lng" : <c:out value="${c.lon}" />
								}
							<c:if test="${!esgStatus.last}">    
							  ,    
							</c:if>
						</c:forEach>             
					];
// 					var positions = [
//						<c:forEach items="${list}" var="c" varStatus="esgStatus">
//								{ 
//									title : '<c:out value="${c.name}" />', 
//									latlng : new daum.maps.LatLng(<c:out value="${c.lat}" />, <c:out value="${c.lon}" />) 
//								}
//							<c:if test="${!esgStatus.last}">    
//							  ,    
//							</c:if>
//						</c:forEach>             
//					]; 
					
					// 마커 클러스터러를 생성합니다 
				    var clusterer = new daum.maps.MarkerClusterer({
				        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
				        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
				        minLevel: 4 // 클러스터 할 최소 지도 레벨 
				    });

					// 마커 이미지의 이미지 주소입니다
					//var imageSrc = "http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
					
					var markers = $(positions).map(function(i, position) {
			            return new daum.maps.Marker({
			                position : new daum.maps.LatLng(position.lat, position.lng)
			            });
			        });
			
			        // 클러스터러에 마커들을 추가합니다
			        clusterer.addMarkers(markers);
					
					    
//					 for (var i = 0; i < positions.length; i ++) {
//					    
//					    // 마커 이미지의 이미지 크기 입니다
//					    var imageSize = new daum.maps.Size(24, 35); 
//					    
//					    // 마커 이미지를 생성합니다    
//					    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
//					    
//					    // 마커를 생성합니다
//					    var marker = new daum.maps.Marker({
//					        map: map, // 마커를 표시할 지도
//					        position: positions[i].latlng, // 마커를 표시할 위치
//					        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
//					        //image : markerImage // 마커 이미지 
//					    });
//					    
//					    clusterer.addMarkers(marker);
//					} 
			}
			
			else {
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new daum.maps.LatLng(x, y), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
				};
	
				var map = new daum.maps.Map(container, options);
				
				// 지도를 클릭한 위치에 표출할 마커입니다
				var marker = new daum.maps.Marker({ 
				    // 지도 중심좌표에 마커를 생성합니다 
				    position: map.getCenter() 
				}); 
				// 지도에 마커를 표시합니다
				marker.setMap(map);
	
				// 지도에 클릭 이벤트를 등록합니다
				// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
				daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
				    
				    // 클릭한 위도, 경도 정보를 가져옵니다 
				    var latlng = mouseEvent.latLng; 
				    
				    // 마커 위치를 클릭한 위치로 옮깁니다
				    marker.setPosition(latlng);
				    
				    $('#si_latitude').val(latlng.getLat());
				    $('#si_longitude').val(latlng.getLng());
				    
				});
			}
		}); */
		
		function addMarker(lat, lon) {
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new daum.maps.LatLng(lat, lon), //지도의 중심좌표.
				level: 3 //지도의 레벨(확대, 축소 정도)
			};
			var map = new daum.maps.Map(container, options);
			
			var markerPosition  = new daum.maps.LatLng(lat, lon); 

			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    $('#si_latitude').val(latlng.getLat());
			    $('#si_longitude').val(latlng.getLng());
			    
			   /*  var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    
			    var resultDiv = document.getElementById('clickLatlng'); 
			    resultDiv.innerHTML = message; */
			    
			});

		}

		function getAddress() {
			
			var latitude = parseFloat($("input[name='si_latitude']").val());
			var longitude = parseFloat($("input[name='si_longitude']").val());
			//var back_html = $("#searchAddr").html();
			if(isNaN(latitude)){
				alert("좌표(위도)를 정확히 입력해 주세요.");
				$("input[name='si_latitude']").focus();
				return;
			}
			else if(isNaN(longitude)) {
				alert("좌표를(경도) 정확히 입력해 주세요.");
				$("input[name='si_longitude']").focus();
				return;
			}
			$("input[name='si_latitude']").val(latitude);
			$("input[name='si_longitude']").val(longitude);
			
			var data ={};
		    data.apikey = '439404499a2080db883eaa942644b473';
		    data.y = latitude;
		    data.x = longitude;
		    data.inputCoordSystem = 'WGS84';
		    data.output = 'json';
		 
		    $.ajaxPrefilter('json', function(options, orig, jqXHR) {
		        return 'jsonp';
		    });
		  
		    $.ajax({
		        url: "https://apis.daum.net/local/geo/coord2detailaddr"
		        , crossDomain: true
		        , dataType: "json"
		        , type: "GET"
		        , data: data
		        , success: function(result)
		        {
		        	try {
						if(result != null) {
							address = result.old.name;
							road_addr =  result.new.name;
						}
						
						if(address == "" && road_addr == "") {
							alert("주소 정보를 찾을 수 없습니다.");
						} else {
							alert("지도위치와 주소를 확인해 주시고,\n세부주소가 맞지 않을 경우 수정해 주세요.");
						}
						$("input[name='si_addr']").val(address);
						$("input[name='si_addr_road']").val(road_addr);
						
						addMarker(latitude, longitude); //지도 위치 잡아 주기
					}
					catch (e) {
						alert("주소 정보를 찾을 수 없습니다. " + e);	
					}			
		        }
		        , error: function( jqXHR, textStatus, errorThrown )
		        {
		            alert( textStatus + ", " + errorThrown );
		        }
		    });
		}
		
		function getLat() {
			
			var addr = $("input[name='si_addr']").val();
			var road = $("input[name='si_addr_road']").val();
			
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

			// 지도를 생성합니다    
			var map = new daum.maps.Map(mapContainer, mapOption);
				
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			
			console.log("addr : " + addr);

			// 주소로 좌표를 검색합니다
			geocoder.addr2coord(addr, function(status, result) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === daum.maps.services.Status.OK) {
			    	 
			    	 var lat = result.addr[0].lat;
			    	 var lng = result.addr[0].lng;

			        //var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
			        $("input[name='si_latitude']").val(lat);
					$("input[name='si_longitude']").val(lng);

			        addMarker(lat, lng); 
			     }
			});
		}
		
		function readType(input) {
			var  str_dotlocation,str_ext,str_low;
			str_value  = $('#excel').val();
			
			str_low   = str_value.toLowerCase(str_value);
			str_dotlocation = str_low.lastIndexOf(".");
			str_ext   = str_low.substring(str_dotlocation+1);

			if (str_ext != "xls" && str_ext != "xlsx" ) {
			     alert("파일 형식이 맞지 않습니다.\n xls,xlsx 만\n 업로드가 가능합니다!");
		  	 	$('#excel').val('');
			     return;
			}
		}
		
		function excelUpload() {
			if( confirm("업로드 하시겠습니까?") ) {
				document.eupload.action = "excel_save.do";
				document.eupload.submit();
				
				/* var form = new FormData(document.getElementById('eupload'));
				$.ajax({
					url:"excel_save.do",
					type:"POST",
					data: form,
					dataType:'text',
					processData: false,
			        contentType: false,
					beforeSend :function() {
						$("#upfile_spinner").show();
						$("#btnDiv").hide();
					},
					success:function(data){
						if(data != '0' ){
							alert("data : " + data);
							$("#upfile_spinner").hide();
							$("#btnDiv").show();
						}
						else {
							alert("에러발생");
							$("#upfile_spinner").hide();
							$("#btnDiv").show();
						}
					},
					error:function(xhr,status,error){
						alert(xhr.responseText);
					}
				}); */
				
		     } 
		}
		
		
		function execute(){
		     
		    var hosturl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		    var proxyurl = hosturl +'/proxy.do?url=';
		    var url = 'http://apis.vworld.dev' + $("#url").val();
		    var requestStr = url;
		    var dataType = $.trim($("#format").val()).toLowerCase();
		    $("#request, #resultbody").empty();
		    $(".mandatory input[type=text]").each(function(){
		        var val = $.trim($(this).val());
		        var id = $(this).attr("id").toLowerCase();
		        if (id == 'query') {val = encodeURIComponent(val);}
		        if (id != "url" && val != ''){
		            requestStr  = requestStr + "&"+id + "=" + val;
		        }
		    });
		    $("#request").text(requestStr);
		    $.ajax({
		        type:'GET',
		        dataType : dataType,
		        url: proxyurl + encodeURIComponent(requestStr),//requestStr,
		        success:function(data) {
		            var result = data;
		            if (dataType == 'json' || dataType == 'jsonp'){
		                result = JSON.stringify(data);
		                $("#resultbody").text(result);
		            } else {        
		                var result = (new XMLSerializer()).serializeToString(data);
		                $("#resultbody").text(result);
		            }
		        }
		    });
		}
		function changeValue(id, value){
		    var targetid = id.split("_")[0];    
		    $("#" + targetid).val(value);
		}

		</script>
		<style type="text/css">
.context-body {
	font-family : 'Noto Sans', sans-serif;
}
.main-body {
    width:980px;
    padding:20px 0px;
    margin:auto;
    min-height:250px
}
.input-search2 {
	color: #000;
	border: solid 1px #80b0ca;
	padding: 5px;
	width: 150px;
	-webkit-border-radius: 0.5em;
	-moz-border-radius: 0.5em;
	border-radius: 0.5em;
	-webkit-transition: all .5s;
	-moz-transition: all .5s;
	transition: all .5s;
    font-size:12px;
}
.search-table th {
    background: #f0f8f9;
    font-size: 0.78em;
    font-weight: 600;
    padding:5px;
}
.search-table td {
    display:table-cell;
    text-align:left;
    vertical-align:middle;
    padding:5px;
    font-size: 0.72em;
    color:#467995;
    font-weight: 600;
}
.inside-table {
    margin-top: 5px;
    width: 100%;
}
.inside-table th {
    background: #f0f8f9;
    font-size: 12px;
    text-align:center;
    font-weight: 600;
}
.inside-table td {
    display:table-cell;
    text-align:left;
    vertical-align:middle;
    padding:5px;
    font-size: 12px;
    color:#467995;
    font-weight: 600;
}
.w3-btn{border:none;display:inline-block;outline:0;padding:6px 16px;vertical-align:middle;overflow:hidden;text-decoration:none!important;color:#fff;background-color:#000;text-align:center;cursor:pointer;white-space:nowrap}
.w3-btn:hover {box-shadow:0 8px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19)}
.w3-btn{-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}

*, body {font-family:NanumGothic, 돋움, Dotum, 나눔고딕;font-weight:normal;font-size:13px;}
input[type=button]{padding:2px 10px;line-height:24px;height:26px;min-width:100px;}
input[type=text],select{color:red;font-weight:bold;padding:2px 10px;line-height:22px;
height:24px;border:solid 1px #e3e3e3;min-width:400px;}
div.textarea {color:blue;font-weight:bold;padding:2px 10px;line-height:22px;
height:24px;border:solid 1px #e3e3e3;width:95%;height:150px;overflow-y:scroll;}
#request {color:black;font-weight:normal;width:95%;height:70px;}
input:read-only {color:blue;}
input[type=file] {padding:2px 8px;border:solid 1px #e3e3e3;width:300px;}
select {padding-right:0px;min-width:100px;color:black;}
#toolbar{line-height:30px;min-height:30px;top:0px;font-weight:bold;}
div.mandatory label {min-width:200px; margin-right:10px;}
div.temporary input[type=text] {color:black;}
div.temporary b {font-weight:bold;color:blue;}
div.maintitle {width:95%;height:40px;font-size:18px;line-height:40px;
background-color:green;color:white;font-weight:bold;padding-left:20px;}   
		</style>
		
	</head>
	<body>
		<!---start-wrap---->
		<!-- <div class="wrap">
			<p>테스트 중입니다.</p>
			<a href="javascript:go_test()">testTEST</a>				
		</div> -->
		<!---//End-wrap---->
		
		<div id="desc" >
        <div id="toolbar">    
            <div class="maintitle">(예제) 지오코더 API 2.0 (좌표조회)</div>
            <div class="mandatory">               
            <table class="board-write txt-left">
                <colgroup>
                <col width="200px" >
                <col />
                </colgroup>
                <tbody>
                <tr><th>요청URL</th><td><input type="text" id="url" value="/geocode?" readonly /></td></tr>
                <tr><th>인증키(apiKey)</th><td>
                <input type="text" id="apiKey" value="5E653474-8704-3C65-9BDB-4D6FF7A65E67"/></td></tr>
                <tr><th>검색종류(service)</th><td><input type="text" id="service" value="forward" readonly /></td></tr>
                <tr><th>주소종류(select)</th><td><input type="text" id="select" value="road" readonly/>
                    <select id="select_list" onchange="changeValue(this.id, this.value);">
                    <option value="road">도로명주소</option>
                    <option value="parcel">지번주소</option>
                    </select>
                </td></tr>
                <tr><th>좌표계(crs)</th><td><input type="text" id="crs" value="epsg:4326" readonly/>
                    <select id="crs_list" onchange="changeValue(this.id, this.value);">
                    <option value="epsg:4326">WGS84 경위도</option>
                    <option value="epsg:4019">GRS80</option>
                    <option value="epsg:3857">Google Mercator</option>
                    <option value="epsg:5181">중부원점(GRS80, 50만)</option>
                    <option value="epsg:5185">서부원점(GRS80)</option>
                    <option value="epsg:5186">중부원점(GRS80)</option>
                    <option value="epsg:5187">동부원점(GRS80)</option>
                    <option value="epsg:5188">동해(울릉)원점(GRS80)</option>
                    <option value="epsg:5179">UTM-K(GRS80)</option>
                    </select>
                </td></tr>
                <tr><th>검색어(query)</th><td><input type="text" id="query" value="시민대로 233"/>
                도로명주소 예) 시민대로 233, 지번주소 예)관양동 1590 
                </td></tr>
                <tr><th>결과포맷(format)</th><td><input type="text" id="format" value="xml" readonly/>
                    <select id="format_list" onchange="changeValue(this.id, this.value);">
                    <option value="xml">xml</option>
                    <option value="json">json</option>
                    </select>
                </td></tr>
                </tbody>
            </table>
            <p>
                요청구문은 다음과 같습니다 :
                <div class="textarea" id="request" class="textarea"></div>
            </p>
            <input type="button" value="테스트요청" onclick="javascript:execute();"/>
        </div>
        <div class="resultbox">
            <p>
                요청결과는 다음과 같습니다 :
                <div class="textarea" id="resultbody"  class="textarea"></div>
            </p>
        </div>
    </div>
    </div>
		
		
		
		<%-- <div class="context-body">
	
			<div class="main-body" style="padding-left:100px">
			    <table class="search-table">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tr>
						<th>위치정보</th>
						<td>
							<table class="inside-table" style="border:0px solid;width:100%">
								<tr>
                             		<td><span>*</span>위도 <input type="text" id="si_latitude" name="si_latitude" style="width:180px;" class="input-search2" /> &nbsp;&nbsp; 
                             			<span>*</span>경도  <input type="text" id="si_longitude" name="si_longitude" style="width:180px; " class="input-search2" />
                                	<a class="w3-btn" href="javascript:getAddress()">검색</a>
        			            	</td>
                      		    </tr>
                      		    <tr>
	                                <td>주소 <br/>
		                                <input type="text" name="si_addr" style="width:470px; " class="input-search2" />
		                                <a class="w3-btn" href="javascript:getLat()">검색</a>
									</td>
	                             </tr>
								<tr>
	                                <td>
	                                	<div id="map" style="width:700px;height:900px;"></div>	
	                                </td>
	                            </tr>
								<tr>
	                                <td>
	                                <form id="eupload" name="eupload" action="" method="POST" enctype="multipart/form-data">
	                                	<input type="file" id="excel" name="excel" onchange="readType(this)">
	                                	<a class="w3-btn" href="javascript:excelUpload()" id="btnDiv">업로드</a>
	                                	<div style="align:center;display:none;" id="upfile_spinner" ><img src="image/ajax-loader.gif" ></div>
                                	</form>
	                                </td>
	                            </tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>위치정보</th>
						<td>
							<table class="inside-table" style="border:0px solid;width:100%">
								<c:forEach items="${list}" var="c">
								<tr>
									<td>${c.name }</td>
									<td>${c.addr }</td>
									<td>${c.lat }</td>
									<td>${c.lon }</td>
	                            </tr>
	                            </c:forEach>
							</table>
						</td>
					</tr>
			    </table>
			</div>
			
			
		</div> --%>
		
	</body>
</html>


