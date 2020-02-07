# -------------------------------------- #
# Fast campus X 임경덕                   #
# 데이터 분석 입문 올인원 패키지 Online  #
    
# =======혼자 해보는 데이터 분석======== #
# -------------------------------------- #



  #### 주제 2
  #### 고속도로 통행량 데이터 요약하기
    
    ## 2018년 12월의 날짜, 시간대, 영업소, 입출구구분별 통행량
    ## 출처 : 고속도로 공공데이터 포털(http://data.ex.co.kr)



##0 데이터 불러오기

  # 데이터 불러오기 
  highway = read.csv('data/highway_1812.csv', fileEncoding='UTF-8')
  highway  
  attach(highway)
  
  # 집계일자를 날짜 형식으로 변환
  highway$집계일자 = strptime(highway$집계일자, format='%Y%m%d')

  
  # 요일 변수 추가하기 
  highway$요일 = weekdays(highway$집계일자)
  
  

#### 여기서부터 실습 입니다 ####
    
  
##1 변수이름, 관측치 샘플 확인하기
  names(highway)
  head(highway)
  tail(highway)
  
##2 subset( )으로 토요일 데이터만 모아서 
##  highway_sat 로 저장하기
  highway_sat=subset(highway,요일=='토요일')
  nrow(highway_sat) #94735개 데이터
  
##3 영업소명 기준 '통영' 혹은 '북통영' 이면서
##  요일 기준 '토요일', '일요일'인 데이터만 모아서
## ty_weekend 로 저장하기
  ty_tong=subset(highway,영업소명=='통영'|영업소명=='북통영')
  ty_weekend=subset(ty_tong,요일=='토요일'|요일=='일요일')
  ty_weekend1=subset(highway,영업소명== c('통영','북통영')&요일== c('토요일','일요일'))
    #통영-토요일, 북통영-일요일 세트만 추출
  ty_weekend2=subset(highway,영업소명== c('통영','북통영')&요일 %in% c('토요일','일요일'))
    #통영->북통영 순서로만 추출. 우선 통영데이터를 추출하면
    #그다음에 통영이 나와도 스킵하고 북통영을 찾음
  ty_weekend3=subset(highway,영업소명%in% c('통영','북통영')&요일 %in% c('토요일','일요일'))
    #이게 정답
  
  ## (예제) %in%의 활용
  subset(highway, 영업소명 %in% c('서울(특)', '동서울'))
  
  
  ## (예제) &를 활용한 조건 결합
  (1:5 >= 3) & (1:5 <= 3)
  

  
##4 aggregate( )로 요일별 통행량 합계 계산하기
  A=aggregate(통행량~요일,highway,sum)
  A[c(4,7,3,2,1,6,5),] #월화수목금토일 순으로 열순서 바꾸기
  
  
##5 3에서 만든 ty_weekend로 집계시간별 통행량 합계를 계산하기
  psum=aggregate(통행량~집계시간,ty_weekend3,sum)
  
# End of script