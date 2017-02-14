<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<fieldset class="m_article mb2">
      <div>
          <p class="am_number"></p>
          <input type="text" class="qw" placeholder="질문을 입력해주세요.">
      </div>
      <div class="clear">                
          <div class="sort">
              <p>설문 유형을 선택해주세요.</p>
              <div class="clear"></div>
              <button type="button" class="objective close sort_bt">
                  <p class="o_close"></p> 객관식 (단일) 
              </button>
              <button type="button" class="subjective open sort_bt">
                  <p class="s_open"></p> 주관식 (단일) 
              </button>
          </div>
          
          <!-- 객관식영역 -->
        <div class="addObDiv" style="display: none;">
           <div class="clear"></div>
           <ul class="w_radio">
               <li>
                   <input type="radio" class="m_radio" value="r_01" name="r_rardio1"> 
                   <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
               </li>
               <li>
                   <input type="radio" class="m_radio" value="r_02" name="r_rardio1"> 
                   <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
               </li>
               <li>
                   <input type="radio" class="m_radio" value="r_03" name="r_rardio1"> 
                   <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(선택)">
                   <button type="button" class="r_delete"></button>
               </li>
               <li>
                   <input type="radio" class="m_radio" value="r_04" name="r_rardio1"> 
                   <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(선택)">
                   <button type="button" class="r_delete"></button>
               </li>

               <li class="pl220">
                   <button type="button" class="r_add"></button>
               </li> 
           </ul>
           
       </div>
   </div>
   <div class="clear"></div>
   <!-- <button class="w_add"></button> -->
</fieldset>