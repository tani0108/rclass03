


















###ifelse 예제
 ##mutate를 통해eval생성하기 (A~F)
 ##ifelse(Average >= 90,'A',ifelse(   ))
 ##평균점수가 90점 이상이면 'A'
 ##           80점 이상이면 'B'
 ##           70점 이상이면 'C'
 ##           60점 이상이면 'D'
 ##           50점 이상     'E'
 ##           나머지는 'F'


ifelse(Average >= 90,'A',
 ifelse(Average >= 80,'B',
  ifelse(Average >= 70,'C',
    ifelse(Average >= 60,'D',
      ifelse(Average >= 50,'E',
        'F')))))


###group_by 예제
 ##학생별 학생수 보기
   scores %>%
     dplyr::group_by(grade) %>%
     dplyr::summarise(count = length(grade))
 ##평균점수를 성별로 보기
  temp<- scores %>%
     mutate(temp_avg=(Math+English+Science+Marketing+Writing)/5) %>%
     group_by(gender) %>%
     summarise(성별평균점수=mean(temp_avg)) 
   
 #히스토그램
  hist(temp$성별평균점수,
       xlab="남",
       col="yellow",
       border="blue")

 #바차트
  barplot(temp$성별평균점수)

 #파이차트
  pie(
    c(temp$성별평균점수),
    c("남","여"),
    col=c("blue","red"))
  
  #라인차트
  plot(c(temp$성별평균점수),type="o")
  
  
  )
   
