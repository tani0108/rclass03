<수업필기>
  (기 진행내용 정리)
챕터 1-2 : ‘사용자 정의 함수’ 만들기
Atomic data/value, numeric, integer, logical
1. Scalar : 점 
2. Vector(동일 Atomic value)/ list(다른 데이터 집합) : 선 
3. matrix/ data.frame(다른 데이터 집합) : 면 (선이 모인 것)
4. array
Return은 반드시 스칼라 형태로 진행된다. 따라서 Return (…) 식으로
표현되는 것이다.
그 때 값이 아니라, 식으로 리턴되는 형태를 객체(object)라고 한다.
R에서는 결과를 객체로 반환한다. 혹은 객체로 처리한다라고 표현한다. 
기타. Dimension - 차원

데이터 구분 : 정형(DB, 엑셀 등)/ 비정형(웹 문서, 논문 등)  

챕터 3-4 : 
  챕터 5-6 : 비정형
챕터 7 : 텍스트 마이닝, 웹 크롤링

Cmd > sqlplus oracle/oracle

정형 데이터(테이블 구조)는 역할에 따라, 두 가지로 나뉜다.
1. 메타 데이터(필드값/구분값을 의미하는듯)/ 로우 데이터(실제 값)



SQL구문
Select * from tab;
(tab에 data.frame 넣어주면 된다.)


# 정형분석 파일의 종류
# Database (Oracle, MySQL, MariaDB)
# Excel (xls)
# CSV (Comma separated Vector)
# 외부 라이브러리는 타 개발자가 만들어 놓은 함수의 집합

install.packages("dplyr")
library(dplyr)
scores <- data.frame(read.csv("class_scores.csv"))
scores 
head(scores)
tail(scores)
summary(scores)
dim(scores)
# Data를 양식에 맞춰 Visualiztion
View(scores)

# grap all of sentences, and then ctrl+f > chage(temp > scores)
# 입력한 변수명의 일괄수정

# Stu_ID scores class gender 
# Math English Science Marketing Writing 
# select : 선택한 meta data(variable=변수)에 해당하는 instance를 출력 
# filter, distance, top_n, sample_n : 선택한 row(observation) -key value에 
# 해당하는 instance를 출력
# select는 열을 기준으로, Filter는 행을 기준으로 데이터를 추출 [핵심]
# mutate, transmutate, mutate_each : data 
# transform : 데이터 형태 변환
# group_by : group data
# summarise, summarise_each, count : summary
# arrange : data sorting
# inner_join, left_join, right_join, full_join : combination or join

head(scores)
a<-select(scores,"Math")
str(a)
head(select(scores,"Math"))
# mean, max, min
mean(a)
min(a)
max(a)
# math값 중 na(값없음)이 있어, 평균계산 오류
# na, null 
# na : Not Available (결측값 : 값이 있기는 한데, 정확히 몇인지는 모르는 상태 즉 속성값이 없는 상태를 의미한다.  
# null : 값이 없는 상태 , 0과는 다른 개념
# 예시] 600명 중 598명만 응시한 경우, 2명의 값은 Null값 
# 예시] 598명 응시는 했으나, math 값만 찾을 수 없는 경우 (기재오류 등)

####################################################################################

## select 예제 
## 1 영어, 수학, 과학 도메인(=컬럼)만 가져오기
# scores에서, 파이프라인 %>%을 통해, dplyr함수 중 select를 쓸거야란 의미이다. 
# %>% 를 and라고 봐도 무방
scores %>%
  dplyr::select(Math,English,Science) %>%
  head
## 2 상위값부터 10개 보기 slice = 순위와 상관 없음 
scores %>%
  dplyr::select(Math,English,Science) %>%
  slice(1:10)
## 3 성별 제외한 컬럼 보기
scores %>%
  dplyr::select(-gender) %>%
  slice(1:12)
## 4 수학부터 작문까지 컬럼 보기
scores %>%
  dplyr::select(Math:Writing) %>%
  slice(1:12)
## 5 모든 컬럼 조회 everything()
scores %>%
  dplyr::select(everything()) %>%
  slice(1:12)

## 6 E 로 시작하는 컬럼만 보기 starts_with('E')
scores %>%
  dplyr::select(starts_with('E')) %>%
  slice(1:12)
## 7 e 로 끝나는 컬럼만 보기 ends_with('e')
scores %>%
  dplyr::select(ends_with('E')) %>%
  slice(1:12)
## 8 e 가 들어가는 컬럼 다 가져오기 contains('e')
scores %>%
  dplyr::select(contains('e')) %>%
  slice(1:12)
## 9.  1, 3, 5번째 컬럼만 가져오기

#######################################################

## filter 예제
## 1. 1학년 학생들만 보기
scores %>%
  filter(grade==1) %>%
  slice(1:12)
## 2. 1학년 남학생만 보기
scores %>%
  filter(grade==1 & gender=='M') %>%
  slice(1:12)
## 3. 1학년이 아닌 학생들만 보기
scores %>%
  filter(!grade==1) %>%
  slice(1:12)
## 4. 1, 2학년 학생들만 보기
scores %>%
  filter(grade==1 | grade==2) %>%
  tail
## 5. 수학점수가 80이상인 학생들만 보기
scores %>%
  filter(Math >=80) %>%
  slice(1:3)
## 6. 수학점수가 80 이상이면서 영어점수가 70이상이 학생들만 보기
scores %>%
  filter(Math >=80 & English >= 70) %>%
  slice(1:3)
## 7. 학번이 10101 부터 10120인 학생들 중에서 여학생이면서 영어가 80점 이상인 학생만 보기
scores %>%
  filter(Stu_ID>=10101 & Stu_ID>=10120 & gender=='F' & English>=80) %>%
  slice(1:3)
## 8. 학번이 홀수인 학생들 중 남자이면서 수학과 과학이 모두 90점 이상인 학생들만 보기
str(scores)
scores %>%
  filter(Stu_ID %% 2=1 & gender=='M' & Math>=90 & Science>=90) %>%
  slice(1:3)
## 9. 학생들 중 한 과목이라도 100점이 있는 학생만 보기
scores %>%
  filter(Math==100 | English==100 | Science==100 | Marketing==100 | Writing==100) %>%
  slice(1:3)
## 10. 학생들 중 한 과목이라도 0점이 있는 학생만 보기
scores %>%
  filter(Math<=0 | English<=0 | Science<=0 | Marketing<=0 | Writing<=0) %>%
  slice(1:3)

## mutate 예제 : 기존에 없던 칼럼 추가 
## 1. scores에 Average 컬럼(학생 평균점수) 추가
scores<- scores %>%
  dplyr::mutate(Average=(Math+English+Science+Marketing+Writing)/5)
scores %>% slice(1:3)
## 2. 학생들 평균점수를 기준으로 Rank(순위) 추가 #힌트 : dense_rank(desc(Average))
scores %>%
  dplyr::arrange(Rank) %>%
  slice(1:3)

## ifelse 예제
## mutate를 통해 eval 생성하기 (A-F)
## 4. 평균점수가 90점 이상이면 A, 80/b, 70/c, 60/d, 50/e, F


:sleepy:
  scores<- scores %>%
  dplyr::mutate(Average=(Math+English+Science+Marketing+Writing)/5) %>%
  ifelse(Average>=90,'A',
         ifelse(Average>=80,'B',
                ifelse(Average>=70,'C',
                       ifelse(Average>=60,'D',
                              ifelse(Average>=50,'E','F')))))
View(scores)

?ifelse



## group_by 예제
## 학생 별 학생수 보기
scores %>%
  dplyr::group_by(grade) %>%
  dplyr::summarise(Count=length(grade))
hist(temp$temp)

## 평균점수를 성별로 보기
scores<- scores %>%
  mutate(temp_avg = (Math+English+Science+Marketing+Writing)/5) %>%
  group_by(gender) %>%
  summarise(성별평균점수 = mean(temp_avg))
# 히스토그램
hist(scores$성별평균점수,xlab="남",col="blue",border="red")
# 바차트
barplot(scores$성별평균점수)
# 파이차트
pie(c(scores$성별평균점수),c("남","여"),col=c("blue","red"))