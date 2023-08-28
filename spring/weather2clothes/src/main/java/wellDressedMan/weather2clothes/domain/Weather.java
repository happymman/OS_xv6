package wellDressedMan.weather2clothes.domain;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

public class Weather {
    @Data
    @AllArgsConstructor
    @Builder
    static public class UltraShort { //초단기실황, 초단기예보 담는 객체 - 강수확률 데이터X, 강수형태 데이터로 강수관련 정보를 더 분명하게 전달
        private short fcstDate; //예보날짜
        private short fcstTime; //예보시각

        private short temp; //기온
        private short rainAmount; //강수량
        private short windSpeed; //풍속
        private short humid; //습도
        private short sky; //강수형태+하늘
    }

    @Data
    @AllArgsConstructor
    @Builder
    static public class Short { //단기예보 담는 객체
        private short fcstDate; //예보날짜
        private short fcstTime; //예보시각

        private short temp; //기온
        private short rainAmount; //강수량
        private short windSpeed; //풍속
        private short humid; //습도
        private short sky; //강수형태+하늘
        private short rainPercentage; //강수확률
    }

    @Data
    @AllArgsConstructor
    public static class Mid { //중기육상조회, 중기기온조회 정보 담는 객체
        short fcstDate; //예보날짜

        short rainAM; //오전강수확률
        short rainPM; //오후강수확률
        short tempLowest; //최저기온
        short tempHighest; //최고기온

    }
}
